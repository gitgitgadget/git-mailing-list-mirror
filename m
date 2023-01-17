Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588C2C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 10:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbjAQKwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 05:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbjAQKvz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 05:51:55 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAC3302A5
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 02:51:51 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o13so28463475pjg.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 02:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PuIX8jgHHsB5Ow7gqt2wKe0VficpRFRf/L2NXrEZY8=;
        b=MGs+jA8mB5KcElQEueMk82HeXu0U0WZvQJsjKmJIcwvOCQ8bm25c7uIBxPFFxY05zb
         8fwOUTYyqOzhyK8f1rDT5lyeUmy1ayO21P4E8o00EEcz7BGSobijrwgDP0aMQU/Wu3Oa
         2iIaIXAtv+lL43EauCs+Opgw5WOGaZsOJXBqwJBg2IGF/YV6roYnmwVLVkzcDg1ukZkq
         3p0mH5OVkHLzdE5MgcMxHsQ6LPQR0yUo8C5eub2gIONFVWE5N2WSRB5zz2nvqZv4o1Y9
         kI+G8b1/ECb/7rBbW9sIPnFfUwzPc7lvEAJBONj8j4VVTFdMn6pCkSk2OSDBrTPyng90
         +QVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PuIX8jgHHsB5Ow7gqt2wKe0VficpRFRf/L2NXrEZY8=;
        b=BrpL6FaN7WxmzVIM4MIoyI0jKNIC97NR8LRQLT+2Giofqz18pr2FbdleVwtv6hZSpF
         pzqgl42biGt/mV/jntSe7+Yjf/Q8C8x6/Yc8FRlhcLnBl9VbieJ1uF3sKQ47pjuj3x4D
         s3vY9krB4AjAGFYfNH7GAY7IbLn3QmKJzGqnR6xD2DATwtYZxMMNPhtNGfCohUloXGFV
         G9f7/4L9nXMXL8n2PIO9+1gtZ2EkvN9aQSLpg+MA/nDqPLL0K/sOFk0hkLXNleQ4Pjln
         BGIibFrtz6yHhS2vpCpO4CNzpUMiG/zNd/LBNti64T+IcNbH9QcaroxT8DQBlQ+sqTkb
         EU5Q==
X-Gm-Message-State: AFqh2kpDfKmwD8l3p+d4YYfnV8Ghc4cVhyKc4Tm3F9cszDOcXw3PvMCC
        X/x6aWdRdKpvDDZAqOc7zTtnSs4fnxQ=
X-Google-Smtp-Source: AMrXdXu4MtwvSfh84Ms7QfPFHniim2zZlGT5JXxEmG/spE6NyCJRCG/C8qqQhtpk82okl4fC6J56sg==
X-Received: by 2002:a17:90a:f593:b0:226:2124:ef67 with SMTP id ct19-20020a17090af59300b002262124ef67mr2751820pjb.38.1673952711137;
        Tue, 17 Jan 2023 02:51:51 -0800 (PST)
Received: from localhost.localdomain (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id nv2-20020a17090b1b4200b002296bffb667sm3605684pjb.45.2023.01.17.02.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 02:51:50 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3] grep: correctly identify utf-8 characters with \{b,w} in -P
Date:   Tue, 17 Jan 2023 02:51:23 -0800
Message-Id: <20230117105123.58328-1-carenas@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230108155217.2817-1-carenas@gmail.com>
References: <20230108155217.2817-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When UTF is enabled for a PCRE match, the PCRE2_UTF flag is used
by the pcre2_compile() call, but that would only allow for the
use of Unicode character properties when caseless is required
but not to include the additional UTF characters for all other
class matches.

This would result in failed matches for expressions that rely
on those properties, for ex:

  $ git grep -P '\bÆvar'

Add a configuration that could be used to enable the PCRE2_UCP
flag to correctly match those cases, when required.

The use of this has an impact on performance that has been estimated
to be significant.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Changes since v2:
* make setting UCP and opt-in as suggested by Ævar
* remove performance test and instead add a test

 Documentation/config/grep.txt |  6 ++++++
 grep.c                        | 11 ++++++++++-
 grep.h                        |  1 +
 t/t7810-grep.sh               | 13 +++++++++++++
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index e521f20390..8848db7311 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -26,3 +26,9 @@ grep.fullName::
 grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
 	is executed outside of a git repository.  Defaults to false.
+
+pcre.ucp::
+	If set to true, will use all Unicode Character Properties when matching
+	`\w`, `\b`, `\d` or the POSIX classes (ex: `[:alnum:]`) and PCRE is used
+	as the underlying engine. If PCRE is not being used it is ignored.
+	Defaults to false
diff --git a/grep.c b/grep.c
index 06eed69493..ceafb8937d 100644
--- a/grep.c
+++ b/grep.c
@@ -102,6 +102,12 @@ int grep_config(const char *var, const char *value, void *cb)
 			return config_error_nonbool(var);
 		return color_parse(value, color);
 	}
+
+	if (!strcmp(var, "pcre.ucp")) {
+		opt->pcre_ucp = git_config_bool(var, value);
+		return 0;
+	}
+
 	return 0;
 }
 
@@ -292,8 +298,11 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		}
 		options |= PCRE2_CASELESS;
 	}
-	if (!opt->ignore_locale && is_utf8_locale() && !literal)
+	if (!opt->ignore_locale && is_utf8_locale() && !literal) {
 		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
+		if (opt->pcre_ucp)
+			options |= PCRE2_UCP;
+	}
 
 #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
 	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
diff --git a/grep.h b/grep.h
index 6075f997e6..082bd3a0c7 100644
--- a/grep.h
+++ b/grep.h
@@ -171,6 +171,7 @@ struct grep_opt {
 	int file_break;
 	int heading;
 	int max_count;
+	int pcre_ucp;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 8eded6ab27..a99a967060 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -95,6 +95,7 @@ test_expect_success setup '
 	then
 		echo "¿" >reverse-question-mark
 	fi &&
+	echo "émotion" >ucp &&
 	git add . &&
 	test_tick &&
 	git commit -m initial
@@ -1474,6 +1475,18 @@ test_expect_success PCRE 'grep -P backreferences work (the PCRE NO_AUTO_CAPTURE
 	test_cmp hello_world actual
 '
 
+test_expect_success PCRE 'grep -c pcre.ucp -P fixes \b' '
+	cat >expected <<-\EOF &&
+	ucp:émotion
+	EOF
+	cat >pattern <<-\EOF &&
+	\bémotion
+	EOF
+	LC_ALL=en_US.UTF-8 git -c pcre.ucp=true grep -P -f pattern >actual &&
+	test_cmp expected actual &&
+	LC_ALL=en_US.UTF-8 test_must_fail git grep -P -f pattern
+'
+
 test_expect_success 'grep -G invalidpattern properly dies ' '
 	test_must_fail git grep -G "a["
 '
-- 
2.37.1 (Apple Git-137.1)

