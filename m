Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF821F453
	for <e@80x24.org>; Thu, 14 Feb 2019 13:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438803AbfBNNXI (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 08:23:08 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:40084 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfBNNXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 08:23:08 -0500
Received: by mail-wr1-f46.google.com with SMTP id q1so6446911wrp.7
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 05:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=Ur/fYq+aYp/wSUE8f1nAB5TcZBEotZTv917C+S/LaR8=;
        b=amIJtLiMWXHKeUf5dYpcp9LML+f4s+IG3JjjfAMNwkErzsEsDZGpluGGVckVXDrY+Y
         cMuJMLZ6IurnUcLF5hNeGluAq/GgI1E/f/i/MzeLzKP/FJR2KaWMvB5fFeabyeIQg654
         Y3rtZGCkuBWA6sEPqYHbbmOGpzFydwYmzbzzxFNq0ftsVjUIEwsAGZ0R1OPVYDrv5xaF
         quA3ymED6Tam2qrAgNC95UEtLhpG1KldjTeVZimHfQ9/9JR7aLdNDIADixyxWRJE5mMC
         oGAs1n0vAmGlZA/5F0cKPVoQNLPZt4HJi3fbA8nH0YsAQmTJzagk7nL9+6wdX2MER0iJ
         Pfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=Ur/fYq+aYp/wSUE8f1nAB5TcZBEotZTv917C+S/LaR8=;
        b=cicQxoZbD/f+vbPOXUw7jl9h++e05BjlNCrq9AgVQxwx8LeCGvM6b9/yz/kmvimVCJ
         /P+UyzksVzmcBGjjfC+TVDcRMcN6o9L6zy5ukwBfYMyg2HOF4FQWxLLPl5m7N1qixNw0
         +Orqg4lsAcOnj7c8M87PugGveXUVaHDc4mzQdx16x5OagD34U8aP5vfZftcuJVPNErtP
         YHsEXEFbUlji7D5UfmSy3xrma7H96Rfahh/Swy1ZRYlhZKuH3uZfSt+Qwfncvs0QZGo4
         hyKMOJ15k5n+uduTb0KlaVPvcWIPC7ptVekNcBM6VSb17myikST9skgNpo9urbxVMJkW
         zKnQ==
X-Gm-Message-State: AHQUAuZO0qMvxVpI9Faauxhk4pG+Qwk3pgyaUcvLouRSaZjGOn0fkAy1
        ycXNLwbYAndkkK3Cdny+hRT0uClyPCE=
X-Google-Smtp-Source: AHgI3IbgPYZMEZmDws6DOtbkHn+EWStRH9428nNJWf4xsRO0ExxWZjoDmsFRAA02L9Ir5TDR8/8BWg==
X-Received: by 2002:a5d:5289:: with SMTP id c9mr2834015wrv.11.1550150585951;
        Thu, 14 Feb 2019 05:23:05 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id f196sm5695867wme.36.2019.02.14.05.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 05:23:05 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: BUG: 2.11-era rebase regression when @{upstream} is implicitly used
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
Date:   Thu, 14 Feb 2019 14:23:04 +0100
Message-ID: <877ee2jyh3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is not a 2.21 release issue, and pre-dates the built-in rebase.

When you clone any repository, e.g. git.git, and add one commit on top
of the cloned branch, then run "git rebase" you'll get e.g.:

    $ git rebase
    First, rewinding head to replay your work on top of it...
    Applying: foo

Before 4f21454b55 ("merge-base: handle --fork-point without reflog",
2016-10-12) you'd get:

    $ git rebase
    Current branch master is up to date.

The results are not the same for "git rebase @{u}" or "git rebase $(git
rev-parse @{u})":

    $ git rev-parse HEAD; ~/g/git/git --exec-path=/home/avar/g/git rebase; git rev-parse HEAD; ~/g/git/git --exec-path=/home/avar/g/git rebase @{u}; git rev-parse HEAD; ~/g/git/git --exec-path=/home/avar/g/git rebase $(git rev-parse @{u}); git rev-parse HEAD
    d0a1e49341cac6db3226eb0f76ec4a5912f18af8
    First, rewinding head to replay your work on top of it...
    Applying: foo
    3a9261d6e34d9f6d00c8e8411d7ddd8cffa02d97
    Current branch master is up to date.
    3a9261d6e34d9f6d00c8e8411d7ddd8cffa02d97
    Current branch master is up to date.
    3a9261d6e34d9f6d00c8e8411d7ddd8cffa02d97

With 4f21454b55^ checked-out the SHA-1 always stays the same, i.e. no
work is done for the same command:

    69bd93d9aa438c6d903b8e62c3bf1c6c5ab8ec0b
    Current branch master is up to date.
    69bd93d9aa438c6d903b8e62c3bf1c6c5ab8ec0b
    Current branch master is up to date.
    69bd93d9aa438c6d903b8e62c3bf1c6c5ab8ec0b
    Current branch master is up to date.
    69bd93d9aa438c6d903b8e62c3bf1c6c5ab8ec0b
