Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E02220988
	for <e@80x24.org>; Tue, 18 Oct 2016 19:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbcJRTfu (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 15:35:50 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33831 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbcJRTfs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 15:35:48 -0400
Received: by mail-vk0-f51.google.com with SMTP id b186so5641580vkb.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 12:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=wMBsRL1eQ+AzFPNYCQvqamFrAez65P4BLqtyjf6AnuM=;
        b=Jvqv+9Bep0EOQucAGVRpBFBuWOF0clM8MIVvHlTjz9nc0ditxPddZPoq1bLEUCASS8
         fB1nINycDgFfX/0nPvdmlVphCREGBTBAViQ88lMmow5xSkF8LeLPztKkNGsZBlznE7MF
         Wyfu0MCT8CC2g9V/bjhnE2U3VTiAIwCDWl621Jou8QqxyuI9gMIEKYmYfz3FcqYfZCPE
         RYld9RCQhZNYzo6SultVSMC6s46UzJ3yfG0q0XlyO7rkhtqhbaRTUau4gqI06aPCjtGK
         8clj5Uy09MNK6GgFldb4vxqE2IKDmEyjgBg1YBJDIv2VQZdwhrV+ZJLfG2CGVoM/lH4s
         tjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=wMBsRL1eQ+AzFPNYCQvqamFrAez65P4BLqtyjf6AnuM=;
        b=FVJsPMYWlX7rGEz1xvfweMdbnxCQHzqP2wYbHj7WwOJVAoJaHM882jJfRyqZAXP0LK
         sLULN7El/EgapXoZ1JXfJRw6j+p5R/6BHu0P7NQcCXl8OciXScTapSEPzNYkqgwMDjrS
         7EpEV/IzP9JGeNBkq7k8cJ+9wutsRAeOXiyA3wKA7l6m4n9ZEgyKEB7bTyx/y+rR5qMz
         qje8T2E9Kn6aGC3h59kyGNNE7Qddr69QxcDWqD1LFCOQ9I9n5MydFmrFyotUjJMGG8BK
         1G+RfSo3pSwiTdP/2sxlD2K0mPMt++qDNeLvbkTK0yWnLXUBnv6DPsQGBAULpTD63g5l
         oHmA==
X-Gm-Message-State: AA6/9RkA3ivjKdP1KolxAcCci+AzYdBcIXGMcT4dOzPIThy32k0/l440QiYVRQUQQ4wR2hsDTmSiO4vmJq27dg==
X-Received: by 10.31.6.207 with SMTP id 198mr1949306vkg.19.1476819347380; Tue,
 18 Oct 2016 12:35:47 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.68.97 with HTTP; Tue, 18 Oct 2016 12:35:47 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 18 Oct 2016 14:35:47 -0500
X-Google-Sender-Auth: 5hZm9xbtenf9dE85nU2cSLyw9VM
Message-ID: <CAHd499AN2VHL66c6JWxHqS-1bQ6y4PrGjZJiR_ad6HJsCGpeDQ@mail.gmail.com>
Subject: Integrating submodules with no side effects
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git experts,

I have in the past attempted to integrate submodules into my primary
repository using the same directory name. However, this has always
caused headache when going to and from branches that take you between
when this integration occurred and when it didn't. It's a bit hard to
explain. Basically, if I have a submodule "foo", and I delete that
submodule and physically add its files under the same directory "foo",
when I do a pull to get this change from another clone, it fails
saying:

error: The following untracked working tree files would be overwritten
by checkout:
        foo/somefile.txt
Please move or remove them before you switch branches.
Aborting
could not detach HEAD


Obviously, git can't delete the submodule because the files have also
been added directly. I don't think it is built to handle this
scenario. Here is the series of commands I ran to "integrate" the
submodule (replace the submodule with a directory containing the exact
contents of the submodule itself):

#!/usr/bin/env bash
mv "$1" "${1}_"
git submodule deinit "$1"
git rm "$1"
mv "${1}_" "$1"
git add "$1/**"

The above script is named git-integrate-submodule, I run it like so:

$ git integrate-submodule foo

Then I do:

$ git commit -m 'Integrated foo submodule'

Is there any way to make this work nicely? The only solution I've
found is to obviously rename the directory before adding the physical
files, for example name it foo1. Because they're different, they never
"clash".
