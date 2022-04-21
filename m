Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598CAC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 14:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389789AbiDUPAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389750AbiDUPAo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 11:00:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B54543EF0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 07:57:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h25so1045349wrc.13
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0+QHon3pu/abWGcCTSu1HZXk7OetzVMGxKkfNlP+AWo=;
        b=ZpGITeXq4R+i00SNj8Upxqsclp6o8/ufyFlO61r8OgPlHiEQq1eaIPoQ5TeW0JkOtG
         VnBMKorSm3u1pRQfWeKEijArOEzkAvQdsgYMFqFaJzGKRmY1GoiwIB53eJ2KRuqrednO
         9nwHe0o3o01nUTsY5rzQDERV8Ikhb4e3pXggRIWgqWb+iK+s33x2lHIuNnDk/FT+f86G
         4u7KUyYdXpUqn7DU6EPEVjKO8y53sxP7286IpPX7ADqnOF7sFveNuwCdWaovIbyFLa2b
         OiQq307N3OnglVs8fMgJxejlCK2D0+NJkjT3rs6bSTFHf2vVWCoD73IU1uXsFJaNbvkL
         2nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0+QHon3pu/abWGcCTSu1HZXk7OetzVMGxKkfNlP+AWo=;
        b=r5nuFehgmc+4lZgc5siwnblewos7kF8z/YT6vkdU+QeXVbUdbGgWcHdQ5w4UzNZrpQ
         Ql8fpM4Zq1bTCmrtwB/xgmFi/9kYaJB0J5Bg0cAJkvNssrLNPXwvjIYa6WEQJ4j3p045
         OI7cOSZRT8YgCfhHIstUbbCSlE4xvmAk07ExSgtWLFnIDIHYe7biFX2eGWni3ElYdKnO
         fa+BqTy3G70MiRmBAmf0NWP93OlepkBNhyDdHW400cc169V9rDAqp9b/E5EkLyf0nO2K
         3HxiJ4++j3tH5rMU/DKwFf1HpBfbG7ySKa4Q5uZy8i7vDulBr+0pm3uCkawNb1xbuhNm
         5Q8g==
X-Gm-Message-State: AOAM533HGwQOWS1nFSwvxVG0rpsSm1tcROIduVTGvBT0acnTKw66k4f+
        6MP4fwhczebVO7eCldBRZRiMs8P/EQA=
X-Google-Smtp-Source: ABdhPJztPmZTIahj39cE+1f745DE3qFEXIQhDeuhQdw/ZBoxpr2i1CPAwTVPt2a+aIRTgjIOMv3M2g==
X-Received: by 2002:adf:e9d1:0:b0:207:b80e:dc22 with SMTP id l17-20020adfe9d1000000b00207b80edc22mr85778wrn.405.1650553073318;
        Thu, 21 Apr 2022 07:57:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d6482000000b0020a96536fcdsm2657144wri.57.2022.04.21.07.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:57:52 -0700 (PDT)
Message-Id: <0435406e2db6c5977928a2b0b0b79e66c0a078ee.1650553069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
References: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Apr 2022 14:57:49 +0000
Subject: [PATCH 2/2] multi-pack-index: use --object-dir real path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The --object-dir argument to 'git multi-pack-index' allows a user to
specify an alternate to use instead of the local $GITDIR. This is used
by third-party tools like VFS for Git to maintain the pack-files in a
"shared object cache" used by multiple clones.

On Windows, the user can specify a path using a Windows-style file path
with backslashes such as "C:\Path\To\ObjectDir". This same path style is
used in the .git/objects/info/alternates file, so it already matches the
path of that alternate. However, find_odb() converts these paths to
real-paths for the comparison, which use forward slashes. As of the
previous change, lookup_multi_pack_index() uses real-paths, so it
correctly finds the target multi-pack-index when given these paths.

Some commands such as 'git multi-pack-index repack' call child processes
using the object_dir value, so it can be helpful to convert the path to
the real-path before sending it to those locations.

Adding the normalization in builtin/multi-pack-index.c is a little
complicated because of how the sub-commands were split in 60ca94769
(builtin/multi-pack-index.c: split sub-commands, 2021-03-30). The
--object-dir argument could be parsed before the sub-command name _or_
after it. Thus, create a normalize_object_dir() helper to call after all
arguments are parsed, but before any logic is run on that object dir.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/multi-pack-index.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 4480ba39827..3853960f9ba 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -90,6 +90,14 @@ static void read_packs_from_stdin(struct string_list *to)
 	strbuf_release(&buf);
 }
 
+static void normalize_object_dir(void)
+{
+	if (!opts.object_dir)
+		opts.object_dir = get_object_directory();
+	else
+		opts.object_dir = real_pathdup(opts.object_dir, 1);
+}
+
 static int cmd_multi_pack_index_write(int argc, const char **argv)
 {
 	struct option *options;
@@ -127,6 +135,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 
 	FREE_AND_NULL(options);
 
+	normalize_object_dir();
+
 	if (opts.stdin_packs) {
 		struct string_list packs = STRING_LIST_INIT_DUP;
 		int ret;
@@ -169,6 +179,8 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv)
 
 	FREE_AND_NULL(options);
 
+	normalize_object_dir();
+
 	return verify_midx_file(the_repository, opts.object_dir, opts.flags);
 }
 
@@ -195,6 +207,8 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv)
 
 	FREE_AND_NULL(options);
 
+	normalize_object_dir();
+
 	return expire_midx_packs(the_repository, opts.object_dir, opts.flags);
 }
 
@@ -225,6 +239,8 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)
 
 	FREE_AND_NULL(options);
 
+	normalize_object_dir();
+
 	return midx_repack(the_repository, opts.object_dir,
 			   (size_t)opts.batch_size, opts.flags);
 }
@@ -241,9 +257,6 @@ int cmd_multi_pack_index(int argc, const char **argv,
 			     builtin_multi_pack_index_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (!opts.object_dir)
-		opts.object_dir = get_object_directory();
-
 	if (!argc)
 		goto usage;
 
-- 
gitgitgadget
