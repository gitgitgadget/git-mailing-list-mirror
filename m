Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C9F20899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbdHBTlX (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:41:23 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36897 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbdHBTlV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:41:21 -0400
Received: by mail-wr0-f193.google.com with SMTP id 12so86428wrb.4
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ndxHHMqYrYYgqyZuIKMkDHEtOGKkhco/X4E0yzYsniE=;
        b=qPu9LbgAcIbyz0q3uzqCyZFJ0BZ6qZTZV06lJhxOYj+9Ir0+1n8dVW5r5Qsi9cev6p
         GEX8yrOPkDw8vFrka9EFPZpbsota/20b3/5Ggtyyx7VXPmOSYdXYd85wM4cSp60exCzX
         ML7ErJXXe9wMAHHp1W2OZMox/ToFDN0VGPdrU7ogRKpJZYEbrxYdnQIzqNi+QS7bhYzv
         iM3eitFAYdg5dlfHA6DvhabBc49UHyMAY70SYl47Fhsx8mGGlxM57TXoII64OHMl12fu
         hAdCn5wfQPDQRUs79OL+Gj93LdVBSDjv0Yzx6szNq4J98VYSQfLA3qfJA6ds40dBxCT+
         vZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ndxHHMqYrYYgqyZuIKMkDHEtOGKkhco/X4E0yzYsniE=;
        b=fbJnewdAbACRsccDemIx9uLvh79P2Y8nzYL6Z6pqFls0bus8wVH/JSDHWIdMZGYBIc
         WGjNGPYp4HuZRTIa677EvdsYdPqBLHxs46RZH8xkjVT2JdyWWTTPTDK3aBou2t0Jft31
         s4tL0GZ/+uRobeD2VAu5NHEWmFBgXpZv3H/bK90ZD2mLFZiguUkPg9dObadJBSCKHKMQ
         /F8/lbbP/jkHrogCR/j9Ck8KEg1idZd61BpiOSD2OA9x/wcaIdNa7/S30/v8ctNG9GGQ
         lGJKuNXn0rfanvonyP/VCsnsSmQsRMGD3N0mffxew3RY4LynzKruiLw5mDuIEBbXMgc+
         d0Pg==
X-Gm-Message-State: AIVw110LYy/4nyCPHX4rI0hvwkG26dd14n31FR4Jp6QSNf9VzNsWXCEu
        vgDer/YG9TuwT3ZH
X-Received: by 10.223.135.218 with SMTP id c26mr16958014wrc.10.1501702879455;
        Wed, 02 Aug 2017 12:41:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id t13sm103576wra.22.2017.08.02.12.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:41:18 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 4/7] t7006: add tests for how git tag paginates
Date:   Wed,  2 Aug 2017 21:40:52 +0200
Message-Id: <b55ef829528e744e05510bb3671296d805d1e1d8.1501701128.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.12.ge2d9c4613
In-Reply-To: <cover.1501701128.git.martin.agren@gmail.com>
References: <cover.1500321657.git.martin.agren@gmail.com> <cover.1501701128.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using, e.g., `git -c pager.tag tag -a new-tag` results in errors such as
"Vim: Warning: Output is not to a terminal" and a garbled terminal.
Someone who makes use of both `git tag -a` and `git tag -l` will
probably not set `pager.tag`, so that `git tag -a` will actually work,
at the cost of not paging output of `git tag -l`.

Since we're about to change how `git tag` respects `pager.tag`, add tests
around this, including how the configuration is ignored if --no-pager or
--paginate are used.

Construct tests with a few different subcommands. First, use -l. Second,
use "no arguments" and --contains, since those imply -l. (There are
more arguments which imply -l, but using these two should be enough.)

Third, use -a as a representative for "not -l". Actually, the tests use
`git tag -am` so no editor is launched, but that is irrelevant, since we
just want to see whether the pager is used or not. Make one of the tests
demonstrate the broken behavior mentioned above, where `git tag -a`
respects `pager.tag`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
In one place, I now use test_expect_failure (thanks Peff).

 t/t7006-pager.sh | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 20b4d83c2..b56d4cdd4 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -134,6 +134,73 @@ test_expect_success TTY 'configuration can enable pager (from subdir)' '
 	}
 '
 
+test_expect_success TTY 'git tag -l defaults to not paging' '
+	rm -f paginated.out &&
+	test_terminal git tag -l &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -l respects pager.tag' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag tag -l &&
+	test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -l respects --no-pager' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag --no-pager tag -l &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag with no args defaults to not paging' '
+	# no args implies -l so this should page like -l
+	rm -f paginated.out &&
+	test_terminal git tag &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag with no args respects pager.tag' '
+	# no args implies -l so this should page like -l
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag tag &&
+	test -e paginated.out
+'
+
+test_expect_success TTY 'git tag --contains defaults to not paging' '
+	# --contains implies -l so this should page like -l
+	rm -f paginated.out &&
+	test_terminal git tag --contains &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag --contains respects pager.tag' '
+	# --contains implies -l so this should page like -l
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag tag --contains &&
+	test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -a defaults to not paging' '
+	test_when_finished "git tag -d newtag" &&
+	rm -f paginated.out &&
+	test_terminal git tag -am message newtag &&
+	! test -e paginated.out
+'
+
+test_expect_failure TTY 'git tag -a ignores pager.tag' '
+	test_when_finished "git tag -d newtag" &&
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag tag -am message newtag &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag -a respects --paginate' '
+	test_when_finished "git tag -d newtag" &&
+	rm -f paginated.out &&
+	test_terminal git --paginate tag -am message newtag &&
+	test -e paginated.out
+'
+
 # A colored commit log will begin with an appropriate ANSI escape
 # for the first color; the text "commit" comes later.
 colorful() {
-- 
2.14.0.rc1.12.ge2d9c4613

