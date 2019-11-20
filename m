Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55234C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB862245B
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXL4+Kfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfKTAvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:51:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35636 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfKTAvY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:51:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so12946326plp.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 16:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UNPCq9nywWZfp/LoVS3nKBl284n/UuqaOfwQyZMKPmQ=;
        b=jXL4+Kfw4YX9YRz/FeU6uzZMv9Nof3NuI3Dq96EE2llwhBAxAj1R+sQ1CWBkXrBEMT
         qx9QPN3JoliaDDKXx8vHhs/R83Pprj3zjn0vJUliG9JAJE9Vsgg1Ij20JT81SAtqHGeL
         iMaVly2w0tsDHzcimEaSJDS9YkDD8ItbtverGEtcUUfME1yAvELRvVjQWXn0tE6o6zfA
         bWtUVIVwFQbYCseJQYQFaRUdNtmnsjjgs8trJoBz5QRb+Wm5Y5Ye7nZUCX37nslrOs41
         QGg+srB7kCC3cWe6GvdKG6PY0wILGdZl9s5+MrUiNX4MFrgUSfonKnQ3i6C1ViVIFOj9
         UWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UNPCq9nywWZfp/LoVS3nKBl284n/UuqaOfwQyZMKPmQ=;
        b=o0bUBa6iZY1nAdx9r/r8WCEdOo7bkmz73fXkds9vlI4OvmThVMRhSIMJ1tPDsKwZdo
         itkORhECowsjvOzcM+Z7viHt5gPA3VMRDbLcsX0cp2g7ebr7/YdDolcP6BtNhj4rtsub
         sPGOB72sjbbuExIx2PQPx3eeOYrUQtjLnlTKXO0nT/zI4buC2ZhnpV1VHZFQv/oqfFu6
         NdEoVyMmqiRtemk1JpIzvqx4xWRTvWuujTzrDLSZdHZVsab8A0CG+dxPtVTlB4Vl7iNc
         1ou54BDbim4ACpvIfeCmycMe1IbEjC55L7ovEJJykWIoHi6PJVkNc1kqZKNss+3wLyLR
         T4fA==
X-Gm-Message-State: APjAAAU0yEFAYctZp2W0SZ3NpPXLgmEMeyMOwV8c5RNd0Nnhj/obLfSi
        wWLMaqtwd+lONjZtgJgr7zQnylQi
X-Google-Smtp-Source: APXvYqyJl2NHi535JMxCLEOFe1gBt0SvWzknelO6NZnmG+GACExPJIY8TGc+gyPagRutYTWC9Gx7PA==
X-Received: by 2002:a17:90a:c2:: with SMTP id v2mr500257pjd.19.1574211083186;
        Tue, 19 Nov 2019 16:51:23 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id b21sm25531651pgs.35.2019.11.19.16.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:51:22 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:51:21 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 08/11] pretty: provide short date format
Message-ID: <6c41491c3ebb822a2f0a9744f7994709862a66b9.1574211027.git.liu.denton@gmail.com>
References: <cover.1574122784.git.liu.denton@gmail.com>
 <cover.1574211027.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1574211027.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

Add the placeholders %as and %cs to format author date and committer
date, respectively, without the time part, like --date=short does, i.e.
like YYYY-MM-DD.

Signed-off-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pretty-formats.txt | 2 ++
 pretty.c                         | 3 +++
 t/t4205-log-pretty-formats.sh    | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index fdccfe5b03..34bbc39273 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -169,6 +169,7 @@ The placeholders are:
 '%at':: author date, UNIX timestamp
 '%ai':: author date, ISO 8601-like format
 '%aI':: author date, strict ISO 8601 format
+'%as':: author date, short format (`YYYY-MM-DD`)
 '%cn':: committer name
 '%cN':: committer name (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
@@ -181,6 +182,7 @@ The placeholders are:
 '%ct':: committer date, UNIX timestamp
 '%ci':: committer date, ISO 8601-like format
 '%cI':: committer date, strict ISO 8601 format
+'%cs':: committer date, short format (`YYYY-MM-DD`)
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
 '%S':: ref name given on the command line by which the commit was reached
diff --git a/pretty.c b/pretty.c
index da154affd4..61014cc25a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -731,6 +731,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	case 'I':	/* date, ISO 8601 strict */
 		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_STRICT)));
 		return placeholder_len;
+	case 's':
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
+		return placeholder_len;
 	}
 
 skip:
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 0335b428b1..da9cacffea 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -533,6 +533,12 @@ test_expect_success 'ISO and ISO-strict date formats display the same values' '
 	test_cmp expected actual
 '
 
+test_expect_success 'short date' '
+	git log --format=%ad%n%cd --date=short >expected &&
+	git log --format=%as%n%cs >actual &&
+	test_cmp expected actual
+'
+
 # get new digests (with no abbreviations)
 test_expect_success 'set up log decoration tests' '
 	head1=$(git rev-parse --verify HEAD~0) &&
-- 
2.24.0.420.g9ac4901264

