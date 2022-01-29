Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D1EC433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353020AbiA2SH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353002AbiA2SHU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:20 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ED9C06173B
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w11so17153434wra.4
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8ff3SKll/6mLNI1wP/QCcJvSviK5GLe8GjbN22wIpSY=;
        b=qG0lXCBYE2xzFtGZZo0KnH97nAGhF7ALZhrlK5UifvPvqmeOhEQ85PGHu7WBZ61ARW
         kE2XCx8rxVjw1KW19dADDLFUhZ69z9csENbwfyk9q9i1exTx8aWp7/O9qOv++OQ9LRdv
         XC+S/R4jzEmDjGyFnPKWSIurN0HL4Ac7mmnYZuFPRE+6816R4JuPgOj1kSEQAdSdcjFo
         R+oJvawQomtThNTqVPU/sjXv013GMa6wFhVWmpOaQFqGhYG/oChSSJu1JG5cAxZ5vYKA
         PNGVatbo2fjYbfTIIwb/N0I74MjbUH/GaqUatgMrr4LDOS/DSYcIY5qW0waJ6O1P+zfm
         roIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8ff3SKll/6mLNI1wP/QCcJvSviK5GLe8GjbN22wIpSY=;
        b=10tBXC90W3C/1vBno7uEQ123LXMlop0nKW4NfgQt0nOo4BQsdGOT7/fzD2TobxnhCq
         j7C8pGcnF8A2/WkFgqwcQy/t38QjrnjzhQyiOAgaChGXsh+YpWK0N9S99uWQbapkHyE6
         dR//zJ2z6F4FucUaim7hKKYAgkBCXF6/g//xsCsjz7lRcfw356LVZ/ZXm2cVTOeJMOBX
         FFE9pBIIZuDaVNIoGiSbKuwMneQexCI5IKr3Qj3FiVckqcYkHJXNeiCtnA7UzMFLKevA
         4WXFyuhjSrx9VdfKjZBJFUyl/f9Gn1Ib2xK4qNsLwO29/hNKUzP7P1o7nb42dU68i6hU
         OJNQ==
X-Gm-Message-State: AOAM531FrSDLA+tggJ4l7krmgSBRO/iCUUA0w6SHf1j/3nNgHIlHu9ea
        2be7jtbpn5/IiqE36U3IlVk1UJYr6cs=
X-Google-Smtp-Source: ABdhPJyDxJ6zPYDotLoH5T+Zq/n0HnDGxfqzVolaQbonPKShYg3N2JVOgfGjkUufJVwC0URWmQYi3Q==
X-Received: by 2002:a05:6000:1acc:: with SMTP id i12mr10941493wry.413.1643479638989;
        Sat, 29 Jan 2022 10:07:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm3743837wmg.28.2022.01.29.10.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:18 -0800 (PST)
Message-Id: <6fb4f4580a581b2e43bc4b8deaa3d2d2bf4a8756.1643479633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:05 +0000
Subject: [PATCH v2 05/13] diff: allow diff_warn_rename_limit to write
 somewhere besides stdout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

diff_warn_rename_limit() is hardcoded to write to stdout.  Make it
accept an output location parameter to make it more flexible.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c            | 20 ++++++++++++++------
 diff.h            |  3 ++-
 merge-ort.c       |  2 +-
 merge-recursive.c |  3 ++-
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 1bfb01c18ec..6952035046f 100644
--- a/diff.c
+++ b/diff.c
@@ -6377,17 +6377,25 @@ static const char rename_limit_advice[] =
 N_("you may want to set your %s variable to at least "
    "%d and retry the command.");
 
-void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
+void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc,
+			    FILE *out)
 {
-	fflush(stdout);
+	const char *fmt = NULL;
+
 	if (degraded_cc)
-		warning(_(degrade_cc_to_c_warning));
+		fmt = _(degrade_cc_to_c_warning);
 	else if (needed)
-		warning(_(rename_limit_warning));
+		fmt = _(rename_limit_warning);
 	else
 		return;
 	if (0 < needed)
-		warning(_(rename_limit_advice), varname, needed);
+		fmt = _(rename_limit_advice);
+
+	fflush(out);
+	if (out == stdout)
+		warning(fmt, varname, needed);
+	else
+		fprintf(out, fmt, varname, needed);
 }
 
 static void create_filepairs_for_header_only_notifications(struct diff_options *o)
@@ -6870,7 +6878,7 @@ int diff_result_code(struct diff_options *opt, int status)
 
 	diff_warn_rename_limit("diff.renameLimit",
 			       opt->needed_rename_limit,
-			       opt->degraded_cc_to_c);
+			       opt->degraded_cc_to_c, stdout);
 	if (!opt->flags.exit_with_status &&
 	    !(opt->output_format & DIFF_FORMAT_CHECKDIFF))
 		return status;
diff --git a/diff.h b/diff.h
index ce9e2cf2e4f..40c5b78fb0a 100644
--- a/diff.h
+++ b/diff.h
@@ -597,7 +597,8 @@ void diffcore_fix_diff_index(void);
 int diff_queue_is_empty(struct diff_options *o);
 void diff_flush(struct diff_options*);
 void diff_free(struct diff_options*);
-void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
+void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc,
+			    FILE *out);
 
 /* diff-raw status letters */
 #define DIFF_STATUS_ADDED		'A'
diff --git a/merge-ort.c b/merge-ort.c
index 9bf15a01db8..65618048b59 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4305,7 +4305,7 @@ void merge_switch_to_result(struct merge_options *opt,
 
 		/* Also include needed rename limit adjustment now */
 		diff_warn_rename_limit("merge.renamelimit",
-				       opti->renames.needed_limit, 0);
+				       opti->renames.needed_limit, 0, stdout);
 
 		trace2_region_leave("merge", "display messages", opt->repo);
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index 9ec1e6d043a..d2eeca9fa20 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3738,7 +3738,8 @@ static void merge_finalize(struct merge_options *opt)
 		strbuf_release(&opt->obuf);
 	if (show(opt, 2))
 		diff_warn_rename_limit("merge.renamelimit",
-				       opt->priv->needed_rename_limit, 0);
+				       opt->priv->needed_rename_limit, 0,
+				       stdout);
 	FREE_AND_NULL(opt->priv);
 }
 
-- 
gitgitgadget

