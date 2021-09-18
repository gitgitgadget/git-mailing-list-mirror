Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36608C433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 20:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08871604DA
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 20:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhIRUIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 16:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhIRUIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 16:08:09 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87E3C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 13:06:45 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id e16so1008652qte.13
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 13:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XJS3fENGFvMlxN/1wN711zDleS2+EerzkwfzIPkaAX8=;
        b=BCrlWw/GDhQ4YQInZLsxsZpAkbweL6x3fTuoqmdyxOHeM2f8GZveTGXAFvzGu/QmxF
         DULye82rv7L23DzO2OhRCWv3u887Dedys0P4hNPIX8LlvBbcYo4QMilDsWHoZ4+Y180z
         8ZlFci3o5j4AYAzsybKTvS/EeNW23/P7Te73EiN0Uth7OiozkW/87fqxc7//9n89xfL1
         LUPZW4O8+38YSy2vAiQbVrq8tp37jGFFmlk9JXgxWvsAVP31EcLcWPakBFF5dVOG1fjl
         oczlpxeW4lDCEWCvE7zzNoVQb1Rqs7p4k5aGM5rWRrdaLaxk91AGGA/uM12p5ZsVqRfT
         z+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XJS3fENGFvMlxN/1wN711zDleS2+EerzkwfzIPkaAX8=;
        b=fLYtZWtavM/88lHad54h1OhfjsTr/EQh4dJK0ELhB91bsukW7Tz9mywbAhr1TQWuVx
         CQhu1XzlcAjrI8oLCNFlm1HjiT+MNxe1GB+Ycgd2rYZj6fR5anZJ3KYkGef7A1//I/5f
         W+qbIjgtr71Asy2yRK076/2UkvQ4g4eMnQ2C+upYoksWZhrQJv0tPzJ2LD9bhEUEf1bZ
         2UnbzKu+qBo9AKs+5xoldEmx7NsUlxEnSY1245Ix58aRt2MwmplVYR3F/P06KiN1oa1q
         uDNDW1qvCSryx9M5YItsG3rAwCQL3/UFkvQmYviJxHSe6gf7P9hQj5BWwASLsAhgWiBv
         5blQ==
X-Gm-Message-State: AOAM531O3b7Npcq7LgKSnQbvMUVkCWtTN3tDqBnLJm90g1RNyhAzuD/L
        W1JSMUqb/sZHU6AeZT4hReA=
X-Google-Smtp-Source: ABdhPJway/WsH7FJ5dOY28zgaT0biLkBI5rLaAtO0G5r+3fEK2tt7K/Ut/Wph8AmW9JKLGd4w0evKw==
X-Received: by 2002:ac8:4717:: with SMTP id f23mr16461259qtp.253.1631995603402;
        Sat, 18 Sep 2021 13:06:43 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id x83sm7681439qkb.118.2021.09.18.13.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 13:06:43 -0700 (PDT)
Date:   Sat, 18 Sep 2021 13:06:40 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH 1/2] log: UNLEAK rev to silence a large number of leaks
Message-ID: <YUZG0D5ayEWd7MLP@carlos-mbp.lan>
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
 <6d54bc264e2f9ce519f32c0673167a00bab55573.1631972978.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d54bc264e2f9ce519f32c0673167a00bab55573.1631972978.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My equivalent version for these fixes is obviously more verbose but IMHO
not that ugly (and as safe)

It avoids the need to UNLEAK early by changing the program flow also for
the early return so the cleanup could be centralized in one single
function.

Both, the cmdline and mailmap arrays (and the objects they accumulate)
are cleaned in a "reusable" way.

Note that the cleaning of the "name" in the cmdline item throws a warning
as shown below which I intentionally didn't fix, as it would seem that
either the use of const there or the need to strdup is wrong.  So hope
someone that knows this code better could chime in.

Carlo
------ >8 ------
Subject: [PATCH] builtin/log: leaks from `git show` in t0000

obviously not ready, since the following will need to be corrected:

  revision.c:1496:8: warning: passing 'const char *' to parameter of type 'void *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
                  free(info->rev[i].name);
                       ^~~~~~~~~~~~~~~~~

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/log.c |  8 ++++++--
 revision.c    | 20 ++++++++++++++++++++
 revision.h    |  5 +++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f75d87e8d7..1b1c1f53f4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -645,8 +645,10 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	opt.tweak = show_setup_revisions_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 
-	if (!rev.no_walk)
-		return cmd_log_walk(&rev);
+	if (!rev.no_walk) {
+		ret = cmd_log_walk(&rev);
+		goto done;
+	}
 
 	count = rev.pending.nr;
 	objects = rev.pending.objects;
@@ -702,6 +704,8 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		}
 	}
 	free(objects);
+done:
+	repo_clear_revisions(&rev);
 	return ret;
 }
 
diff --git a/revision.c b/revision.c
index 0dabb5a0bc..ce62192dd8 100644
--- a/revision.c
+++ b/revision.c
@@ -1487,6 +1487,18 @@ static void add_rev_cmdline(struct rev_info *revs,
 	info->nr++;
 }
 
+static void clear_rev_cmdline(struct rev_info *revs)
+{
+	struct rev_cmdline_info *info = &revs->cmdline;
+	size_t i, nr = info->nr;
+
+	for (i = 0; i < nr; i++)
+		free(info->rev[i].name);
+
+	FREE_AND_NULL(info->rev);
+	info->nr = info->alloc = 0;
+}
+
 static void add_rev_cmdline_list(struct rev_info *revs,
 				 struct commit_list *commit_list,
 				 int whence,
@@ -1845,6 +1857,14 @@ void repo_init_revisions(struct repository *r,
 	init_display_notes(&revs->notes_opt);
 }
 
+void repo_clear_revisions(struct rev_info *revs)
+{
+	if (revs->mailmap)
+		clear_mailmap(revs->mailmap);
+	FREE_AND_NULL(revs->mailmap);
+	clear_rev_cmdline(revs);
+}
+
 static void add_pending_commit_list(struct rev_info *revs,
 				    struct commit_list *commit_list,
 				    unsigned int flags)
diff --git a/revision.h b/revision.h
index 0c65a760ee..f695c41cee 100644
--- a/revision.h
+++ b/revision.h
@@ -358,6 +358,11 @@ void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
 			 const char *prefix);
 
+/*
+ * Free all structures dynamically allocated for the provided rev_info
+ */
+void repo_clear_revisions(struct rev_info *revs);
+
 /**
  * Parse revision information, filling in the `rev_info` structure, and
  * removing the used arguments from the argument list. Returns the number
-- 
2.33.0.911.gbe391d4e11

