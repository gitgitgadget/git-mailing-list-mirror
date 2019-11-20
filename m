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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28641C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F5B2245B
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkLBwhX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfKTAvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:51:31 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37728 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTAva (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:51:30 -0500
Received: by mail-pg1-f180.google.com with SMTP id b10so3907295pgd.4
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 16:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LlsVLsx65iwBko7A9nV7oC3Am9+dfmMbw0m8uaEQpkQ=;
        b=FkLBwhX9yyWRRLVH3eOFDc68dkRlSkgX7dplLfUyKF5/6DnmFjlE05Rys9nyW/kNOd
         Axwd+04Kq5+lkOn8XrDD2gQLpzOg5/6GuLEfVIP6qWqi63uVpo29C7dmF+OtuahBVZYg
         0MxSXhK+qKCnJPPb7OMz09B+VV+MzUZiYWtuVIP6oc8rSC2B9yUmlcNcVdVL1qqMkMW6
         uUCa2JP3/35C8DCj3HjYiklU/FzoqYuhcQYeVVzjajrkMzPAENvGx180bS9t/+n5ZaLa
         gleTqPP6z9F2o8sdpzMU18L1Z25JN6LLTPxvL5Yrpm/4F1RnY03t73mmk03UR1L9QTTd
         y6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LlsVLsx65iwBko7A9nV7oC3Am9+dfmMbw0m8uaEQpkQ=;
        b=c0+fp/X8+DZvtCgzUhgI0T0pOZeoI8zXBJHo/G0fm7s0ANGbErPD0TdkDTsRd/GwT2
         J///cVmSt0Ve041N636XPvto7n9Y1qinzeQyYMRqbEGJN35joYtUCPFYa1yty2k1GMYp
         30nXVu46YxpS8ZonKLlqIdMPX0AsLX+if2L2ut+S7CG2qIIFRSr9ksuXRgAMWZeni5dc
         dlQxQGNDOrTEdufnN/A6ajix4BcjXEaAa+7Sp3Jlqikdj8X8f5LQmqwLwBtUwtC7SsOR
         +/uXsNGQ8kqCfqYp9vxeZANeBTUpj0uPZkMr+Mi2naUlBA3Iobr9XOw4WC8Qcnt7bBhZ
         kQlw==
X-Gm-Message-State: APjAAAVDtL+p/rDmAeGcQpvUI4hH8LRBGwt+bv5C+mBObZrzvGTeJFNx
        yP2fZr9Hs2LVJmnkIVl4u4ZiBav+
X-Google-Smtp-Source: APXvYqyNZa71W2EWpvkyVXRehy1KGAmkfPcWUv39jyFQvdzCm2TVerDVDW2hKrlcEa5igFiAv/0XcA==
X-Received: by 2002:a62:3644:: with SMTP id d65mr571558pfa.225.1574211087960;
        Tue, 19 Nov 2019 16:51:27 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id 13sm25629436pgu.53.2019.11.19.16.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:51:27 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:51:25 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 10/11] pretty: implement 'reference' format
Message-ID: <5264c44fab5d64cdfea8ef9fe2c1088af3d41014.1574211027.git.liu.denton@gmail.com>
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

The standard format for referencing other commits within some projects
(such as git.git) is the reference format. This is described in
Documentation/SubmittingPatches as

	If you want to reference a previous commit in the history of a stable
	branch, use the format "abbreviated hash (subject, date)", like this:

	....
		Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
		noticed that ...
	....

Since this format is so commonly used, standardize it as a pretty
format.

The tests that are implemented essentially show that the format-string
does not change in response to various log options. This is useful
because, for future developers, it shows that we've considered the
limitations of the "canned format-string" approach and we are fine with
them.

Based-on-a-patch-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/pretty-formats.txt       | 11 +++++++
 Documentation/pretty-options.txt       |  2 +-
 Documentation/rev-list-options.txt     |  4 ++-
 contrib/completion/git-completion.bash |  2 +-
 pretty.c                               |  4 ++-
 t/t4205-log-pretty-formats.sh          | 43 ++++++++++++++++++++++++++
 6 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 34bbc39273..0df418e609 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -63,6 +63,17 @@ This is designed to be as compact as possible.
 
 	       <full commit message>
 
+* 'reference'
+
+	  <abbrev hash> (<title line>, <short author date>)
++
+This format is used to refer to another commit in a commit message and
+is the same as `--pretty='format:%C(auto)%h (%s, %ad)'`.  By default,
+the date is formatted with `--date=short` unless another `--date` option
+is explicitly specified.  As with any `format:` with format
+placeholders, its output is not affected by other options like
+`--decorate` and `--walk-reflogs`.
+
 * 'email'
 
 	  From <hash> <date>
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index e44fc8f738..a59426eefd 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -3,7 +3,7 @@
 
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
-	'full', 'fuller', 'email', 'raw', 'format:<string>'
+	'full', 'fuller', 'reference', 'email', 'raw', 'format:<string>'
 	and 'tformat:<string>'.  When '<format>' is none of the above,
 	and has '%placeholder' in it, it acts as if
 	'--pretty=tformat:<format>' were given.
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index bb1251c036..b94ed85c7a 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -269,7 +269,7 @@ list.
 	exclude (that is, '{caret}commit', 'commit1..commit2',
 	and 'commit1\...commit2' notations cannot be used).
 +
-With `--pretty` format other than `oneline` (for obvious reasons),
+With `--pretty` format other than `oneline` and `reference` (for obvious reasons),
 this causes the output to have two extra lines of information
 taken from the reflog.  The reflog designator in the output may be shown
 as `ref@{Nth}` (where `Nth` is the reverse-chronological index in the
@@ -293,6 +293,8 @@ Under `--pretty=oneline`, the commit message is
 prefixed with this information on the same line.
 This option cannot be combined with `--reverse`.
 See also linkgit:git-reflog[1].
++
+Under `--pretty=reference`, this information will not be shown at all.
 
 --merge::
 	After a failed merge, show refs that touch files having a
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6bf91ab154..889e707a05 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1737,7 +1737,7 @@ __git_log_shortlog_options="
 	--all-match --invert-grep
 "
 
-__git_log_pretty_formats="oneline short medium full fuller email raw format: tformat: mboxrd"
+__git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
 __git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default raw unix format:"
 
 _git_log ()
diff --git a/pretty.c b/pretty.c
index 63fa600276..5fc8b730d8 100644
--- a/pretty.c
+++ b/pretty.c
@@ -98,7 +98,9 @@ static void setup_commit_formats(void)
 		{ "mboxrd",	CMIT_FMT_MBOXRD,	0,	0 },
 		{ "fuller",	CMIT_FMT_FULLER,	0,	8 },
 		{ "full",	CMIT_FMT_FULL,		0,	8 },
-		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 }
+		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 },
+		{ "reference",	CMIT_FMT_USERFORMAT,	1,	0,
+			0, DATE_SHORT, "%C(auto)%h (%s, %ad)" },
 		/*
 		 * Please update $__git_log_pretty_formats in
 		 * git-completion.bash when you add new formats.
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index da9cacffea..a8ef3784cf 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -824,4 +824,47 @@ test_expect_success '%S in git log --format works with other placeholders (part
 	test_cmp expect actual
 '
 
+test_expect_success 'log --pretty=reference' '
+	git log --pretty="tformat:%h (%s, %as)" >expect &&
+	git log --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=reference with log.date is overridden by short date' '
+	git log --pretty="tformat:%h (%s, %as)" >expect &&
+	test_config log.date rfc &&
+	git log --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=reference with explicit date overrides short date' '
+	git log --date=rfc --pretty="tformat:%h (%s, %ad)" >expect &&
+	git log --date=rfc --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=reference is never unabbreviated' '
+	git log --pretty="tformat:%h (%s, %as)" >expect &&
+	git log --no-abbrev-commit --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=reference is never decorated' '
+	git log --pretty="tformat:%h (%s, %as)" >expect &&
+	git log --decorate=short --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=reference does not output reflog info' '
+	git log --walk-reflogs --pretty="tformat:%h (%s, %as)" >expect &&
+	git log --walk-reflogs --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=reference is colored appropriately' '
+	git log --color=always --pretty="tformat:%C(auto)%h (%s, %as)" >expect &&
+	git log --color=always --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.24.0.420.g9ac4901264

