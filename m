Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DF4C432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 13:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D408C20714
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 13:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqE1rBLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfKVNOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:14:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37797 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKVNOo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 08:14:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so6208609wmf.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 05:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n7SPSGDZQZ+uifOW+qr9Bk2vvQcGZmKCn/GBQU4DEDA=;
        b=GqE1rBLLxoiNYLh+Httnc3TttbwXMcDKz4FtB5pX89yIHRMn2CWZWoJ8UKs+N95ath
         huOZmMWcwgF/bBCrSm9ujB6bwJ9XyS2YFqhPJyY0D6EWANgcumrgm4tgzHdxmbAf994r
         i16BX/rv8bSQFoYzFP1R5Eh/0KcRGB20JH6Ji/Ww2GEfgI9kuUHSX4gi9XmPA6ajePiT
         egGKo8CvQY+0O1Qf14cI/PFMI7v56JRmUz96uT1bpRKWv/D9kPpEN68eA5m8P3fLPR2e
         Z6Uhf3CTAATws8hLaqZwHMVtGFCs3n9Uf+CsNIqc5FQMGqsQOVjrnXEggPE8eIIGBz+/
         qRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n7SPSGDZQZ+uifOW+qr9Bk2vvQcGZmKCn/GBQU4DEDA=;
        b=rEYxCpjkpZ0Y1QgMTb0zDxCy/Sb9Yf9OyK104CMRxJZhsFLYK47yDZLZ9O7nRNm3Nd
         F3wydz2SuubwExQ0NW11iySvxp+9xC0l2sr+ZybX7zhZvWJ+LjP2NgnKqQvpR0xbxQO5
         4qchCPMFoAfk4zuSA7yz25ldA6Ta4A57JHr4jiAJKIRvagCFf3ceeyt89bpT8h8uUzSN
         TWGlAzsElqzc6a82rcNDK9VAr+dwXUiAfghO39PNcIBlg0vJUxO1WObtbPhEloZttoTs
         GPzTAeeiK7+CZ8EUPWuoLc98+PqZZKsMeYwDKf3ho3J6YS2e4S/sdzYxxqa38fo/HqPW
         InTg==
X-Gm-Message-State: APjAAAW1FyDd7IT7p70m24JZfR7wgp7r4SFz2ZVf0j3GFP3rp2MOxkxa
        r7KPaE8Lsop5e9rJxgCO2Bk=
X-Google-Smtp-Source: APXvYqwJnNFeZxkPXj2ZvVZSirqXw7TTjuAWlMjKw8n0c9Tf51e1KF11pRggVP/uV3kE4KyPCPmyhg==
X-Received: by 2002:a1c:4606:: with SMTP id t6mr15834538wma.73.1574428480475;
        Fri, 22 Nov 2019 05:14:40 -0800 (PST)
Received: from localhost.localdomain (x4db9604a.dyn.telefonica.de. [77.185.96.74])
        by smtp.gmail.com with ESMTPSA id u4sm7407934wrq.22.2019.11.22.05.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Nov 2019 05:14:39 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Wong <e@80x24.org>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/2] tests: catch non-bool GIT_TEST_* values
Date:   Fri, 22 Nov 2019 14:14:35 +0100
Message-Id: <20191122131437.25849-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.532.ge18579ded8
In-Reply-To: <20190907101637.GE32087@szeder.dev>
References: <20190907101637.GE32087@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 07, 2019 at 12:16:37PM +0200, SZEDER Gábor wrote:
> On Fri, Sep 06, 2019 at 03:13:01PM -0400, Jeff King wrote:
> > I wonder if it would be possible for the test suite to catch this.

[i.e. to catch a non-boolean value of a supposedly boolean GIT_TEST_*
environment variable]

> > Not sure if it's worth it.

[...]

> Anyway, this is just a long-winded way to say that I think we should
> validate those bools properly and error loudly on an invalid value
> even if it doesn't seem to worth it.

I was playing with a new GIT_TEST boolean environment variable,
mistyped it's value, and then it took me surprisingly long to figure
out why the damn tests were not doing what I thought they should.

So now I'm fairly convinced that it's definitely worth doing.  And the
callsites look much nicer, too.

These patches should apply cleanly both on current 'master' or on
'sg/git-test-boolean' (i.e. the email thread I'm replying to).  We
haven't introduced any new 'git env--helper' invocations in the test
suite/framework since then.


SZEDER Gábor (2):
  tests: add 'test_bool_env' to catch non-bool GIT_TEST_* values
  t5608-clone-2gb.sh: turn GIT_TEST_CLONE_2GB into a bool

 ci/lib.sh               |  2 +-
 t/README                |  9 +++++++++
 t/lib-git-daemon.sh     |  2 +-
 t/lib-git-svn.sh        |  4 ++--
 t/lib-httpd.sh          |  2 +-
 t/t0000-basic.sh        | 34 ++++++++++++++++++++++++++++++++++
 t/t5512-ls-remote.sh    |  2 +-
 t/t5608-clone-2gb.sh    |  2 +-
 t/test-lib-functions.sh | 30 +++++++++++++++++++++++++++++-
 t/test-lib.sh           | 10 +++++-----
 10 files changed, 84 insertions(+), 13 deletions(-)

-- 
2.24.0.532.ge18579ded8

