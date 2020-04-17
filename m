Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86667C2BB1D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 06:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D925221F4
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 06:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="IIpHPtn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgDQGE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 02:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726610AbgDQGE1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Apr 2020 02:04:27 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79D0C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 23:04:26 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id t3so1369780qkg.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 23:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7CYYycfTNd/Eg4DQs87z668RK7eAEcSuxI3ic17KgTk=;
        b=IIpHPtn1B0kGLzQtJ+XV2klp/xPNL3vu+ImoCqew66Rbm8b0e0sS0h8zRcupdmrz4G
         chsnssDlRwktnUf5JwapRAYSOY3bxCzUssmhcWewy4PhRzL9biE1atNXpEOcQCFm0gZa
         8GjQ+1aybAY/CupAwX27e780ESTCfOBWpAWTiYJQnj1WNP5OxlagCBFDTBtoXe3sIdtJ
         zsu0Pa2+j3kKX/RRtcAbURG2CXQ/9hWZm7fPKHzXImyRL7oGoAQY0xGyPEGnulymRCZu
         W0yNTVOmA/M0c/JXB5lFF7El+s113TswR3tgamJ3Ud/yGl7elRgMmFny5GLPhVq5B7II
         mmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7CYYycfTNd/Eg4DQs87z668RK7eAEcSuxI3ic17KgTk=;
        b=BYrSNfgvVFXJ6+G02rV+3fIsDSwX554c5WdhyYBVDsMCQ55N5st4MzmoyBEmJsmneb
         vcROridzIJEhVAywZ29iyfsG7Q5ZYPNAbq5wfOEGAKM3vR924ODNzZuUokyvde7Cmhg1
         7Q4Aww6Z/iwE9G1J8QSi12YIFklmOdS0wB6tPLVqVLdNee/ec8vxcZF8+ty4Jx1T6BkG
         ASsQ5IZaLh2ElEwxKc0fPq8IYV3TcdqJ+59XTsWuBcEfT6LBTCVsgZoz7NXc36AhOgL5
         HydbvlakNBsvyp2jvY5gF5mmBVvAuRCFcCfmInCAX+FkhTRvvuD9zkTLY+ZNsL3WNCxi
         qhtg==
X-Gm-Message-State: AGi0PuYHoj/E3ckRGpEztXuDIH+ctFyEVTDamwtAEc306WbtYnzvTwxY
        RBr0qltjTHEflODZKGDQxBvPzA==
X-Google-Smtp-Source: APiQypJMTC0RCQ2mF9kL4SPdBSe86oAwEuMNiuizfC6fifuld7aNkLhh6y+2CxN+ORpQQ7++cojKsw==
X-Received: by 2002:ae9:f70a:: with SMTP id s10mr1560233qkg.313.1587103465731;
        Thu, 16 Apr 2020 23:04:25 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::3])
        by smtp.gmail.com with ESMTPSA id 202sm704133qko.135.2020.04.16.23.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 23:04:25 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     asheiduk@gmail.com, git@vger.kernel.org, greg@hurrell.net,
        l.s.r@web.de
Subject: [PATCH] grep: follow conventions for printing paths w/ unusual chars
Date:   Fri, 17 Apr 2020 03:04:03 -0300
Message-Id: <eaae7214925189f562056b1ee6972c05dcf76a32.1587103366.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <xmqq1ronyz1s.fsf@gitster.c.googlers.com>
References: <xmqq1ronyz1s.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

grep does not follow the conventions used by other Git commands when
printing paths that contain unusual characters (as double-quotes or
newlines). Commands such as ls-files, commit, status and diff will:

- Quote and escape unusual pathnames, by default.
- Print names verbatim and unquoted when "-z" is used.

But grep *never* quotes/escapes absolute paths with unusual chars and
*always* quotes/escapes relative ones, even with "-z". Besides being
inconsistent in its own output, the deviation from other Git commands
can be confusing. So let's make it follow the two rules above and add
some tests for this new behavior. Note that, making grep quote/escape
all unusual paths by default, also make it fully compliant with the
core.quotePath configuration, which is currently ignored for absolute
paths.

Reported-by: Greg Hurrell <greg@hurrell.net>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/git-grep.txt |  6 +++--
 builtin/grep.c             | 46 ++++++++++++++++++++++++++++----------
 t/t7810-grep.sh            | 44 ++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index ddb6acc025..3109ce8fbe 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -206,8 +206,10 @@ providing this option will cause it to die.
 
 -z::
 --null::
-	Output \0 instead of the character that normally follows a
-	file name.
+	Use \0 as the delimiter for pathnames in the output, and print
+	them verbatim. Without this option, pathnames with "unusual"
+	characters are quoted as explained for the configuration
+	variable core.quotePath (see git-config(1)).
 
 -o::
 --only-matching::
diff --git a/builtin/grep.c b/builtin/grep.c
index 99e2685090..bdf1a4bbc9 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -295,6 +295,38 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 	return st;
 }
 
+static void grep_source_name(struct grep_opt *opt, const char *filename,
+			     int tree_name_len, struct strbuf *out)
+{
+	strbuf_reset(out);
+
+	if (opt->null_following_name) {
+		if (opt->relative && opt->prefix_length) {
+			struct strbuf rel_buf = STRBUF_INIT;
+			const char *rel_name =
+				relative_path(filename + tree_name_len,
+					      opt->prefix, &rel_buf);
+
+			if (tree_name_len)
+				strbuf_add(out, filename, tree_name_len);
+
+			strbuf_addstr(out, rel_name);
+			strbuf_release(&rel_buf);
+		} else {
+			strbuf_addstr(out, filename);
+		}
+		return;
+	}
+
+	if (opt->relative && opt->prefix_length)
+		quote_path_relative(filename + tree_name_len, opt->prefix, out);
+	else
+		quote_c_style(filename + tree_name_len, out, NULL, 0);
+
+	if (tree_name_len)
+		strbuf_insert(out, 0, filename, tree_name_len);
+}
+
 static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 		     const char *filename, int tree_name_len,
 		     const char *path)
@@ -302,13 +334,7 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	struct strbuf pathbuf = STRBUF_INIT;
 	struct grep_source gs;
 
-	if (opt->relative && opt->prefix_length) {
-		quote_path_relative(filename + tree_name_len, opt->prefix, &pathbuf);
-		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
-	} else {
-		strbuf_addstr(&pathbuf, filename);
-	}
-
+	grep_source_name(opt, filename, tree_name_len, &pathbuf);
 	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
 	strbuf_release(&pathbuf);
 
@@ -334,11 +360,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	struct strbuf buf = STRBUF_INIT;
 	struct grep_source gs;
 
-	if (opt->relative && opt->prefix_length)
-		quote_path_relative(filename, opt->prefix, &buf);
-	else
-		strbuf_addstr(&buf, filename);
-
+	grep_source_name(opt, filename, 0, &buf);
 	grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
 	strbuf_release(&buf);
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 7d7b396c23..ab495dba28 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -72,6 +72,8 @@ test_expect_success setup '
 	# Still a no-op.
 	function dummy() {}
 	EOF
+	echo unusual >"\"unusual\" pathname" &&
+	echo unusual >"t/nested \"unusual\" pathname" &&
 	git add . &&
 	test_tick &&
 	git commit -m initial
@@ -481,6 +483,48 @@ do
 		git grep --count -h -e b $H -- ab >actual &&
 		test_cmp expected actual
 	'
+
+	test_expect_success "grep $L should quote unusual pathnames" '
+		cat >expected <<-EOF &&
+		${HC}"\"unusual\" pathname":unusual
+		${HC}"t/nested \"unusual\" pathname":unusual
+		EOF
+		git grep unusual $H >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L in subdir should quote unusual relative pathnames" '
+		cat >expected <<-EOF &&
+		${HC}"nested \"unusual\" pathname":unusual
+		EOF
+		(
+			cd t &&
+			git grep unusual $H
+		) >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep -z $L with unusual pathnames" '
+		cat >expected <<-EOF &&
+		${HC}"unusual" pathname:unusual
+		${HC}t/nested "unusual" pathname:unusual
+		EOF
+		git grep -z unusual $H >actual &&
+		tr "\0" ":" <actual >actual-replace-null &&
+		test_cmp expected actual-replace-null
+	'
+
+	test_expect_success "grep -z $L in subdir with unusual relative pathnames" '
+		cat >expected <<-EOF &&
+		${HC}nested "unusual" pathname:unusual
+		EOF
+		(
+			cd t &&
+			git grep -z unusual $H
+		) >actual &&
+		tr "\0" ":" <actual >actual-replace-null &&
+		test_cmp expected actual-replace-null
+	'
 done
 
 cat >expected <<EOF
-- 
2.26.0

