Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBB531FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 19:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932131AbdBJTVB (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 14:21:01 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35473 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932076AbdBJTVA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 14:21:00 -0500
Received: by mail-oi0-f52.google.com with SMTP id j15so26391051oih.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 11:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pec1kUgNGdjaN2SloHfklOMmZM04BE1n1rMMxN+PttM=;
        b=hU/tDDmP7bhv54l1P7kPybORUaD1GWOoqxvnbil1dkQiloLtPoa866T/4sxnptbYzr
         2FevxJT+OpnXdoJ0wSACkvW4zeszkQr7yZmyIQNxIQgntPMI99XTK8gpWsvbnyX5cjxp
         Abrt4FZoEhsOC4RVH1c4as855EzhIf7TmBX+Fwo+ekFzvKYOiWQ+RNcRyvITUPDd3pbP
         /JvdU5LeDCrGELo19jiLkE+CUrd9fwsZ6CflKu9McguSz4qEt/zrqzOFMbIWe5wny58U
         aV6xUIm8rN3+qX/UL294IkSq0j+V6vQAF9Z50SXeQh2pXEodEC2+CXu7upNfQQJkouIu
         E8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pec1kUgNGdjaN2SloHfklOMmZM04BE1n1rMMxN+PttM=;
        b=dGq4Mtn8L6DlVIXwcknm+S79gRb4vfJg6CoBn1/8Hdlw2K5Ez5YZmpewopAkKx6d92
         dXt4v2+VoRtzgwPtaWmYIbWWHhI3W1lCHwyLhkmpzQ9/TYEKPMQb2eni86kViZ/fmldZ
         zbQtT3BOpo1m9j9lYoveJimxgHg7fXzgza7vjIDj5FW7orG2RbJC9gehsJ5CslKLN2FK
         AA1v/gTASdPqhk9S63dxJLx3Xz6FtFn6Qq1UFKPNURoWJ7OlJfFWAynpbf0A+kS0I1NC
         awq2H0ATXS0dF7uSS7OXGX4rCiTQsrhE0005AZY9XTkCO2Jl/+TKmN1U8WAGj8d9Fg7g
         Kxfw==
X-Gm-Message-State: AMke39lyqOWD1xiMY6qfH9gHJuqG3l2mwJldPm4wcu0bl5aZXLDCWYQTiRSzlz6SerF8uk0YPOZEYK5nrRqo3hQj
X-Received: by 10.202.67.195 with SMTP id q186mr5369841oia.192.1486754459629;
 Fri, 10 Feb 2017 11:20:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.39.79 with HTTP; Fri, 10 Feb 2017 11:20:59 -0800 (PST)
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Feb 2017 11:20:59 -0800
Message-ID: <CAKwvOdn9j=_Ob=xq4ucN6Ar1G537zNiU9ox4iF6o1qO7kPY41A@mail.gmail.com>
Subject: fuzzy patch application
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I frequently need to backport patches from the Linux kernel to older
kernel versions (Android Security).  My usual workflow for simple
patches is:

1. try `git am patch.txt`.
2. if that fails try `git apply -v patch.txt` then add commit message
manually.
3. if that fails try `patch -p1 < patch.txt` then add commit message
manually.
4. if that fails, manually fix bug based on patch.

My question is, why does `patch` seem to do a better job at applying
patches than `git am`?  It's almost like the `git` tools don't try to fuzz
the offsets.  Is there a way to tell git to try fuzzing offsets when
applying patches?

From the output of `patch` I ran recently (for a patch that
`git apply` would not apply):

patching file <filename.c>
Hunk #1 succeeded at 113 (offset -1 lines).
Hunk #2 succeeded at 435 (offset -3 lines).
Hunk #3 succeeded at 693 (offset 2 lines).
Hunk #4 succeeded at 1535 (offset -41 lines).
Hunk #5 succeeded at 1551 (offset -41 lines).
Hunk #6 succeeded at 1574 with fuzz 2 (offset -42 lines).
Hunk #7 succeeded at 1614 (offset -42 lines).

In fact, `git apply -v` errors for hunk #6.

I would guess maybe that there's an upper limit on the offset searched?
Also, I'm not sure what the `fuzz 2` part means exactly, but it seems like
`git apply` chokes when fuzzing is needed to properly apply a patch.

http://stackoverflow.com/q/6336440/1027966

-- 
Thanks,
~Nick Desaulniers
