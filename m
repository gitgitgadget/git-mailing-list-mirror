Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2395420C11
	for <e@80x24.org>; Sun,  3 Dec 2017 17:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbdLCREa (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 12:04:30 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42946 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbdLCRE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 12:04:29 -0500
Received: by mail-wr0-f196.google.com with SMTP id s66so14783977wrc.9
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 09:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GHqnFUtvKNgyX0FSzg3goZaeYEtO3Juq9Ii8590JnYE=;
        b=uxYYO/OHx4kzWBWC48XHS5YIQWV6OH9ybOegwtzDIF0lfC9875WEJMaF0qQgowQ95B
         u4iPO/lGsVsWhq4hCRURfojIfvo300qWFMrxSAiH+JTh1y6WqFURGPgsZe7TTk2OkGip
         KiLhyhbdlWqy1SZkX2kIMVDbFco/Um4+V7colDRYL3zTXIY+1FuD4LyC4hscOduUQzYe
         JSDg/zHDwCJi0bO3A8hRraP3shozdZATiAyc7Eq/6v4ze6Rwo6u0IueTCu5w17MGzfXr
         Hn0euWGxI1OV9B7xyAjCXS2NjBT8WRSXXJ8/uWJ83pcKIAmLQ214qOz1EtCv6L+sD2D5
         57vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GHqnFUtvKNgyX0FSzg3goZaeYEtO3Juq9Ii8590JnYE=;
        b=ND9JYF63Qyt/2Prrgjug8Uf+qcXoScKn3Awo5aOIwoBHhV+XOfubokWS132mOg8ltM
         0aUGYpW6gohUMpecSTw6J4UKzVvYhTRQdGHVZEHEf98gCFp01bRURwsH81pE587Xo01H
         TphkThDprf5AoK9dD2qJVoJG/idTIZaUrUiGTwV3px6/QbJa1/OCrB0YsV4hiK59J5Uc
         Kx3mjFCywwbKF7AlebicRohrvKrEk3x4VUttBg7m5SwsmnzpLYit++BrF0k4fai3Jkes
         jNcTHUgnEoUq0AgysV1D5tJOqWQ9TbGyVPy2rGJR/Qp2C1sWMP04isechsxqdjLK/LWt
         Qllg==
X-Gm-Message-State: AJaThX4dMaEyllZyoQkckJYGWQM1wSrTdNtCcXjQ8ZR/GR8HZhoKJB/i
        lWT8iArftS9TKRPaZFCrzrHW9pt5
X-Google-Smtp-Source: AGs4zMYC+QjIl9HCq7GAc7six/QHFw0o0mdb9LeW56oNqLIhNXAyVR4Q5t6ksNnG7qyX6TkLo28tAA==
X-Received: by 10.223.199.70 with SMTP id b6mr10913763wrh.25.1512320668314;
        Sun, 03 Dec 2017 09:04:28 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id v192sm2340134wme.1.2017.12.03.09.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 09:04:27 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] git-compat-util: introduce skip_to_opt_val()
Date:   Sun,  3 Dec 2017 18:04:13 +0100
Message-Id: <20171203170415.15939-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.271.g1a4e40aa5d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

We often accept both a "--key" option and a "--key=<val>" option.

These options currently are parsed using something like:

if (!strcmp(arg, "--key")) {
	/* do something */
} else if (skip_prefix(arg, "--key=", &arg)) {
	/* do something with arg */
}

which is a bit cumbersome compared to just:

if (skip_to_opt_val(arg, "--key", &arg)) {
	/* do something with arg */
}

Note that, when using skip_to_opt_val(), it is not possible any more
to do something different when the first argument is exactly "--key"
than when it is exactly "--key=", but in most cases we already don't
make any difference, which is a good thing.

Note that "opt" in the function name actually means "optional" as
the function can be used to parse any "key=value" string where "key"
is also considered as valid, not just command line options.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

Another possibility would be to add a "const char *default"
argument to the function, and to do: 

	if (!*p) {
		*val = default;
		return 1;
	}

This could make the function more useful in some cases.

I also wonder if the function is too big to be inlined, and
in that case, in which file it should be added. 

diff --git a/git-compat-util.h b/git-compat-util.h
index cedad4d581..7ee040388f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -534,6 +534,41 @@ static inline int ends_with(const char *str, const char *suffix)
 	return strip_suffix(str, suffix, &len);
 }
 
+/*
+ * If the string "str" is the same as the string in "prefix", then the "val"
+ * parameter is set to the empty string and 1 is returned.
+ * If the string "str" begins with the string found in "prefix" and then a
+ * "=" sign, then the "val" parameter is set to "str + strlen(prefix) + 1"
+ * (i.e., to the point in the string right after the prefix and the "=" sign),
+ * and 1 is returned.
+ *
+ * Otherwise, return 0 and leave "val" untouched.
+ *
+ * When we accept both a "--key" and a "--key=<val>" option, this function
+ * can be used instead of !strcmp(arg, "--key") and then
+ * skip_prefix(arg, "--key=", &arg) to parse such an option.
+ */
+static inline int skip_to_opt_val(const char *str, const char *prefix,
+				  const char **val)
+{
+	const char *p;
+
+	if (!skip_prefix(str, prefix, &p))
+		return 0;
+
+	if (!*p) {
+		*val = "";
+		return 1;
+	}
+
+	if (*p == '=') {
+		*val = p + 1;
+		return 1;
+	}
+
+	return 0;
+}
+
 #define SWAP(a, b) do {						\
 	void *_swap_a_ptr = &(a);				\
 	void *_swap_b_ptr = &(b);				\
-- 
2.15.1.271.g1a4e40aa5d.dirty

