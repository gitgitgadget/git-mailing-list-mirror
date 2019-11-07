Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5154A1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 13:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389459AbfKGNwl (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 08:52:41 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42723 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389453AbfKGNwk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 08:52:40 -0500
Received: by mail-oi1-f175.google.com with SMTP id i185so1978256oif.9
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 05:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XMOoyuF67Xz1czmQmw4PuPeEA8j2YYLPo7sw7izTDso=;
        b=ITPj0g9iZkWZy7/Q6cmvYS/TWfYHyMFSmj/gauOo8XrWvokzQ6nP1FXkQ7JzlJK/MO
         f7mEp/kZRjC9xuvV1TFHvPebey6V/XLPYaA7K/Fev7VoiT3OMr3ipGnrSD5bCNvY6kJ/
         3ESM52Y3wFJCHpc08CQhTGWcrgYhS1ydjzAmiFX2LnH3YB+NZSUj+ACiniQzmLljq078
         guFwclryeClC/r63WntZGGOlI2Ci+qMKApnQHgAXkJoJlixLLsv9YhhLbu3QNOUP+t8H
         bVnS8tNo7wtJzpuuQTuj2+BXN6fnyP+4BGJg4qeqAzeTW6TV6d73jQ/eiAQPJ/E7qYGI
         LRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XMOoyuF67Xz1czmQmw4PuPeEA8j2YYLPo7sw7izTDso=;
        b=nh+uNwUxFRVynedcqN6V6Oncw6foKFAjRIgTuHDE2Q28PqzfzTh0SBBMSVCHORhfOn
         OeY5A7l60mier/rB/mLeDzDbYEPoWiBN0PsgS6Qjz1Tea5X+c/MyrSSqUf2J+5YmVg+f
         kqORBFHrxidJSl1t1V4Mu0/4vLpgAQW2nIoqdUhyp8QUUzLTk14ocfTeafNTATBD+eUI
         gPYJKxeCKMAv9aJOzXE/SddoOP20PEgXCBwOpES2VBryq4nJoAwlg4bTQ9Qx4xU0M3yH
         zm8QmWEkA9F7CYU/yXEEMXi+p9o9yDJpATD5SX0H7mKZUP55cVGagizAwwnxLEHU3YD+
         E5bw==
X-Gm-Message-State: APjAAAXXq1SUR1DCGIO7i9PsVEPUEMW5mla2XlKWar4u6g1/jyWsX6xj
        LwmQBU0KOZDvaSWzwWDc+twbqYrPu3PDl0IydHxeNEzo
X-Google-Smtp-Source: APXvYqzFNmNasMHYp+qNBTlyCQntZSEggye1bbi34GpkgQOYd92fn07iXgYF7t+owFU/yf0sUdCoSpEuaBMtvGeOIWw=
X-Received: by 2002:aca:bac5:: with SMTP id k188mr3468149oif.29.1573134759529;
 Thu, 07 Nov 2019 05:52:39 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Benedek_R=C3=A1cz?= <betontalpfa@gmail.com>
Date:   Thu, 7 Nov 2019 14:52:28 +0100
Message-ID: <CAAMvNNQyzMwAhizT-vBpbwfzAAHS6Ycx2tCLZ_eND3SK8WdTGg@mail.gmail.com>
Subject: [Improvement] Separate protocol and path in gitmodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

**The issue**
My problem is based on this post: https://stackoverflow.com/q/40841882/2506522

**Use-case:**
Git can be used with SSH or with HTTP. The usage of SSH is easier, due
to automatic authentication (ssh-key). But I have to use git from a
public PC, where I mustn't store my ssh-keys. On that PC I want to use
https's user/password authentication.

**Suggestion**
The root-cause of this issue is that the protocol (SSH or HTTP) and
the path of the remote repository is stored together (in the
.gitmodules file). If they were stored separately I would choose the
protocol easily.

Benedek
