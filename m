Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7CDC433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbiBBHfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiBBHeu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:34:50 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B642EC061749
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:49 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v13so36493682wrv.10
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CCJu1qRgU+efLvJ/97QHm+4PR5UCSFt0TFjS1CluVM4=;
        b=DSj/kmkMdH89j+WKFJACQ4qfdoS5X5a9rfT8T/NPgnRTUScPHChoQCfkhxlyqEAd9k
         0Ya4/1Fh/MW5mweLx/YPqblP53jBFR0vLihev9ldOMRPylpk8lWVq5ACMxoPNgimaTwo
         sAcvHh89TTBSItMx8/Jpeem6nd55lxEpNGdpkx87bAm9m6+yxeXskGvoVw+jr3lGIOjX
         ZdNmzgmW4LQ+Y7Rrnx7AcBTiLpaE7gH4HzWwxUQyhFcRXebsEgylBLm6xZzUDg9z1PBb
         mYrDQaBPf/Ohr7cTSKcqirjfXvs0+T6VVhYTKa2YhMSTQLK3mjfXTdwKNk0B4ewDScpR
         +hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CCJu1qRgU+efLvJ/97QHm+4PR5UCSFt0TFjS1CluVM4=;
        b=Z/eKy6hcfHwCjF7NiXeaR7ZiFfUtxTxw45y65czYRgcpQRDUhV2HN6U+kr8ApMkdwd
         GVJBYaeEz87yXbmNPIWj+h++9J4qzoDywOKZI+GLZwRROCdh5It4EZk0xLWW0DSRd/Wh
         BafIFi5heqcc9K3C2H/Ipf9+VTeEopSW8Cwlj01uVJVL8je55A2T1i9bnh5kZrWBeEju
         iUiLtnRIf83iUY2I0kTcLoH5TFoJId4V6fwgIyAk5pVq5rZ9hzsxx20XXaMgRkesIM5E
         YSSsbxmdjPEpCr+lIOfpA93HzPnqlagptm7gO1XU/9i6slpo6ViX8APH4LtLliddNhWC
         4Ycw==
X-Gm-Message-State: AOAM533kFuAww/0Sj8p59ByeFHqFhLBOsTN/jZHhc2KBZPd/uGfOZXsu
        o5iny2gk4PvMJHVdDfwWZ00TWmeOkzU=
X-Google-Smtp-Source: ABdhPJxlSK7f9dMBm6FGGRPbHWN6QeDe8ErMz/FUYpS9bj5xZ2Qaxt1Ygc9vYIBmABZaSnoYJrVXBw==
X-Received: by 2002:adf:dc44:: with SMTP id m4mr24559929wrj.355.1643787288221;
        Tue, 01 Feb 2022 23:34:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14sm20596793wrp.4.2022.02.01.23.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:47 -0800 (PST)
Message-Id: <2083fbe9b2e3e1deb94c9903fd0fa2dddd619b3c.1643787281.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:32 +0000
Subject: [PATCH v3 06/15] diff: allow diff_warn_rename_limit to write
 somewhere besides stderr
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

diff_warn_rename_limit() is hardcoded to write to stderr.  Make it
accept a file stream parameter to make it more flexible.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c            | 13 ++++++++-----
 diff.h            |  3 ++-
 merge-ort.c       |  2 +-
 merge-recursive.c |  3 ++-
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 1bfb01c18ec..28368110147 100644
--- a/diff.c
+++ b/diff.c
@@ -6377,17 +6377,20 @@ static const char rename_limit_advice[] =
 N_("you may want to set your %s variable to at least "
    "%d and retry the command.");
 
-void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
+void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc,
+			    FILE *out)
 {
 	fflush(stdout);
 	if (degraded_cc)
-		warning(_(degrade_cc_to_c_warning));
+		warning_fp(out, _(degrade_cc_to_c_warning));
 	else if (needed)
-		warning(_(rename_limit_warning));
+		warning_fp(out, _(rename_limit_warning));
 	else
 		return;
+
+
 	if (0 < needed)
-		warning(_(rename_limit_advice), varname, needed);
+		warning_fp(out, _(rename_limit_advice), varname, needed);
 }
 
 static void create_filepairs_for_header_only_notifications(struct diff_options *o)
@@ -6870,7 +6873,7 @@ int diff_result_code(struct diff_options *opt, int status)
 
 	diff_warn_rename_limit("diff.renameLimit",
 			       opt->needed_rename_limit,
-			       opt->degraded_cc_to_c);
+			       opt->degraded_cc_to_c, stderr);
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
index 9bf15a01db8..46e72b62880 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4305,7 +4305,7 @@ void merge_switch_to_result(struct merge_options *opt,
 
 		/* Also include needed rename limit adjustment now */
 		diff_warn_rename_limit("merge.renamelimit",
-				       opti->renames.needed_limit, 0);
+				       opti->renames.needed_limit, 0, stderr);
 
 		trace2_region_leave("merge", "display messages", opt->repo);
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index 9ec1e6d043a..01ca82773cc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3738,7 +3738,8 @@ static void merge_finalize(struct merge_options *opt)
 		strbuf_release(&opt->obuf);
 	if (show(opt, 2))
 		diff_warn_rename_limit("merge.renamelimit",
-				       opt->priv->needed_rename_limit, 0);
+				       opt->priv->needed_rename_limit, 0,
+				       stderr);
 	FREE_AND_NULL(opt->priv);
 }
 
-- 
gitgitgadget

