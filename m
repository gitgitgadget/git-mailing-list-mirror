Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A0EC54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjAJFpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjAJFob (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:31 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDFA40850
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:44:06 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id fy8so25713926ejc.13
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5u8BbA1My5DYqFkW8qtbOm6T0TIpfWVD3SpGq+b5Bw=;
        b=B92KBNo1kqZqJjfosmgKFmNqKZO3lQSpas5ROjoO/ih7XwAN7qMJPF5artExN+mnCT
         cDNC16K3mYkzyDggjMBvpxqR20Co/ey6LWhdDXOGbbSZcdSQ6N5E6p50b9WSLSVCkqGH
         EGqJAAdoy2Bx5jTOPW2WWz8XY0/jUbRFmWiFkFQmCAITUQ134P5A5QMVc2yiwfH9E2Jn
         mU8cPbPUGcnSStMPwAeqlcym7sR2oQvha2xja773sZ0L4NcM4jVeziNMVd0JUBQ4FYVQ
         sEcZHlAyvRzmrqikg/BWGbzV2xr9r4PteWbLMxszF9Pu62inmIOemjiDlxPn5MtSOfki
         voyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5u8BbA1My5DYqFkW8qtbOm6T0TIpfWVD3SpGq+b5Bw=;
        b=zzogb/qQkwKZ2IqKUY5YjR7fpxtZ5DUKBvGz2Hwgdv5TVDl8VGpphpDZDvfP1iuhrO
         TRkPvXzrtiUPS4+a6J+tUhpTbNkfB5vryrpRW92mMBjS7LKo8hNrVoaJK0RgM/KRZvhq
         btfEADpPMTJKZZdZHuZaB63nR7mXuCkWdI6RrWGw1nc9rjahnemCLm7WNTTp4Tk1VL/Y
         IED2TSJiqnskn/S7PNa0Yo9bD52UfhieJuEMuEO/yACtCLqNIShwOfXjb/1VXjrj6UUu
         p2ZhXkSbOLjDVcVUhTb29TutbLnhsjYg37p95Z99GIanJ3uGpTp9rQu9uX31jG0dupw3
         Rong==
X-Gm-Message-State: AFqh2kodxCmbXRC60iHwRCmj/5hDKDVJmPqelO+FrP3bxt3AooQYVu01
        3Tg2JiHNLiNU5Eg5+VhP0VEUpTMNM+2eCQ==
X-Google-Smtp-Source: AMrXdXvHA9ca0jsJdGIvMtQ+h6Pt1W0nXVdbCO5hnpnjb21D9t0ZGGveRqlqtWr3G39wJqLKONrw6Q==
X-Received: by 2002:a17:906:3993:b0:844:de87:8684 with SMTP id h19-20020a170906399300b00844de878684mr66339420eje.46.1673329445453;
        Mon, 09 Jan 2023 21:44:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:44:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 16/19] grep.c: refactor free_grep_patterns()
Date:   Tue, 10 Jan 2023 06:43:36 +0100
Message-Id: <patch-v3-16.19-17537e1393e-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the free_grep_patterns() function to split out the freeing of
the "struct grep_pat" it contains, right now we're only freeing the
"pattern_list", but we should be freeing another member of the same
type, which we'll do in the subsequent commit.

Let's also replace the "return" if we don't have an
"opt->pattern_expression" with a conditional call of
free_pattern_expr().

Before db84376f981 (grep.c: remove "extended" in favor of
"pattern_expression", fix segfault, 2022-10-11) the pattern here was:

	if (!x)
		return;
	free(y);

But after the cleanup in db84376f981 (which was a narrow segfault fix,
and thus avoided refactoring this) we ended up with:

	if (!x)
		return;
	free(x);

Let's instead do:

	if (x)
		free(x);

This doesn't matter for the subsequent change, but as we're
refactoring this function let's make it easier to reason about, and to
extend in the future, i.e. if we start to free free() members that
come after "pattern_expression" in the "struct grep_opt".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index 06eed694936..a4450df4559 100644
--- a/grep.c
+++ b/grep.c
@@ -769,11 +769,11 @@ static void free_pattern_expr(struct grep_expr *x)
 	free(x);
 }
 
-void free_grep_patterns(struct grep_opt *opt)
+static void free_grep_pat(struct grep_pat *pattern)
 {
 	struct grep_pat *p, *n;
 
-	for (p = opt->pattern_list; p; p = n) {
+	for (p = pattern; p; p = n) {
 		n = p->next;
 		switch (p->token) {
 		case GREP_PATTERN: /* atom */
@@ -790,10 +790,14 @@ void free_grep_patterns(struct grep_opt *opt)
 		}
 		free(p);
 	}
+}
 
-	if (!opt->pattern_expression)
-		return;
-	free_pattern_expr(opt->pattern_expression);
+void free_grep_patterns(struct grep_opt *opt)
+{
+	free_grep_pat(opt->pattern_list);
+
+	if (opt->pattern_expression)
+		free_pattern_expr(opt->pattern_expression);
 }
 
 static const char *end_of_line(const char *cp, unsigned long *left)
-- 
2.39.0.1195.gabc92c078c4

