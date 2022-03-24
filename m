Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5112DC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 11:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbiCXLpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 07:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346172AbiCXLpr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 07:45:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF6C6FA1E
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 04:44:14 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n18so4435426plg.5
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 04:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4xJlasU8cSTvD0oiZovKKxlXOFl3b8N6NDceYIFbxI=;
        b=LvZQ5P6npui9I6Fps14GbZzp+MN9q3y/fx+FtyXLeL2cAWLdj/8AUIppCqZWpEyVGy
         oftkI6+749g4xkxUrwukFwbHH8KShjSfsV+aFqoJk49qZfhhR5HYI5AD7vfWDqPQANU9
         Yapw6Nehz/tRlEZB0SRZPahUy2Kfiv9hy+dFF9z3jT8KX6hIxmWBnRlIF7JdKzwVHOzT
         14PEI47zhvzrWXNVgrDjBov2Zn7MuXjuNSK5JXTkq5IZ8J42f6MLvOQwLu2v+sbEZ4Ik
         IC63Y3XbK2whpVMaNrl2AaH7MbM3grFphfvqMZmjLcZ17LjnE94YBj7ovxLqzhkr4sY9
         h/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4xJlasU8cSTvD0oiZovKKxlXOFl3b8N6NDceYIFbxI=;
        b=rgObNZsGbBmI3xEGiJ/tEQCXiCbRn8z2hrofEqDAWivSvQj1QCG/eQkjWTBNS2OsaW
         t9XImcROTD5w5zFCm3QqGvqkwVSL0N/KTB15GodN6KCiPERuronzpQCxxfz1+AJmF4bW
         RC+rdlT3tk53kwl23+yPoZFfLzyXupuY+ktnTGyNi4lzDIo1qLE6c0QOSaKTGt9EDP3W
         MOwSOBh3VYGyM7WBuF3ZVNPhGRAZHwoF75AnOLmgV4KUJwb3CqRwo9Oh43JlK69SFJGc
         MifiJujafxbMh42zTwQ/3rwLPcNSMUNq9xa4MD6WSJDj/KIz39Ywo5GEwNqqkISzMRqb
         VDCA==
X-Gm-Message-State: AOAM532ENPe9gk7Bwh3l6Pr4Mv3DUK7ldaQ8rhfl5I0vxMYk/TM7sLG5
        uoNJcv/Z2ROeJHz0jflAveJXgO5tbmlmiTGc
X-Google-Smtp-Source: ABdhPJyjjqYyXaE/1Q9MKpslt9gIEbuMyUmXu4vz0e0Yl2J+/cZ4X+1I4Mlj13cACIJ/Zt0KgfS9Yw==
X-Received: by 2002:a17:90b:1805:b0:1c7:ba88:9550 with SMTP id lw5-20020a17090b180500b001c7ba889550mr3385730pjb.16.1648122253716;
        Thu, 24 Mar 2022 04:44:13 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.36])
        by smtp.gmail.com with ESMTPSA id oo17-20020a17090b1c9100b001bf0ccc59c2sm9717498pjb.16.2022.03.24.04.44.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2022 04:44:13 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, me@ttaylorr.com, derrickstolee@github.com,
        tenglong.tl@alibaba-inc.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v1 3/3] bitmap: add trace outputs during open "bitmap" file
Date:   Thu, 24 Mar 2022 19:44:01 +0800
Message-Id: <9912450fc11f869ad1b6409d7adcfe20f06c17ff.1648119652.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.579.g70500b6343.dirty
In-Reply-To: <cover.1648119652.git.dyroneteng@gmail.com>
References: <cover.1648119652.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's supported for a Git repo to use bitmap in both normal bitmap way
or a multi-pack-index bitmap.

Sometimes the debug path is not obvious, for example, when executing:

	  $git rev-list  --test-bitmap  HEAD
	  fatal: failed to load bitmap indexes

If we see the output like this, we are not sure about what's happened,
because the cause should be :

	  1. neither normal nor midx bitmap exists
	  2. only midx bitmap exists but core.multipackIndex="false"
          3. core.multipackIndex="true" but midx bitmap file is currupt
	  4. core.multipackIndex="true" and no midx bitmap exists but
	     normal bitmap file is currupt
	 ....

These are some of the scenarios I briefly tested, but maybe there are
others (some scenarios is produced manually like "currupt bitmap file",
but it's not represent it's an existed bug.).

Therefore, we added some TRACE2 code so that when we read the bitmap
we can be more clear about the decision path, such as whether it is
working on midx bitmap or normal bitmap, or is it simply because the
related configuration is disabled. This may help with logging, user
troubleshooting, and development debugging.

Here are some of the outputs of

     "$GIT_TRACE2_PERF=1 git rev-list --test-bitmap HEAD"

based on this commit:

      1. core.multipackindex="true" and midx bitmap exists

	17:12:50.496112 common-main.c:49             | d0 | main                     | version      |     |           |           |              | 2.35.1.579.g70500b6343.dirty
	17:12:50.496141 common-main.c:50             | d0 | main                     | start        |     |  0.000306 |           |              | /opt/git/master/bin/git rev-list --test-bitmap HEAD
	17:12:50.496208 compat/linux/procinfo.c:170  | d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
	17:12:50.496333 git.c:460                    | d0 | main                     | cmd_name     |     |           |           |              | rev-list (rev-list)
	17:12:50.496536 midx.c:395                   | d0 | main                     | data         | r0  |  0.000706 |  0.000706 | midx         | core.multipackIndex:true
	17:12:50.496563 midx.c:185                   | d0 | main                     | data         | r0  |  0.000733 |  0.000733 | midx         | load/num_packs:1
	17:12:50.496571 midx.c:186                   | d0 | main                     | data         | r0  |  0.000741 |  0.000741 | midx         | load/num_objects:15
	17:12:50.496677 pack-revindex.c:315          | d0 | main                     | data         | r0  |  0.000847 |  0.000847 | load_midx_re | source:midx
	17:12:50.496685 pack-bitmap.c:512            | d0 | main                     | data         | r0  |  0.000856 |  0.000856 | midx         | open bitmap (midx):ok
	Bitmap v1 test (4 entries loaded)
	Found bitmap for 9a0a2928a280d91f5c8ded46e952add4c4296979. 64 bits / f15de25e checksum
	17:12:50.497016 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001186 |           | progress     | label:Verifying bitmap entries
	Verifying bitmap entries: 100% (15/15), done.
	17:12:50.497179 progress.c:339               | d0 | main                     | data         | r0  |  0.001350 |  0.000164 | progress     | ..total_objects:15
	17:12:50.497188 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001358 |  0.000172 | progress     | label:Verifying bitmap entries
	OK!
	17:12:50.497204 git.c:718                    | d0 | main                     | exit         |     |  0.001374 |           |              | code:0
	17:12:50.497213 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001384 |           |              | code:0

      2. core.multipackindex="false" and only midx bitmap exists

	17:18:38.423328 common-main.c:49             | d0 | main                     | version      |     |           |           |              | 2.35.1.579.g70500b6343.dirty
	17:18:38.423357 common-main.c:50             | d0 | main                     | start        |     |  0.000263 |           |              | /opt/git/master/bin/git rev-list --test-bitmap HEAD
	17:18:38.423443 compat/linux/procinfo.c:170  | d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
	17:18:38.423587 git.c:460                    | d0 | main                     | cmd_name     |     |           |           |              | rev-list (rev-list)
	17:18:38.423809 midx.c:395                   | d0 | main                     | data         | r0  |  0.000720 |  0.000720 | midx         | core.multipackIndex:false
	17:18:38.423933 pack-bitmap.c:512            | d0 | main                     | data         | r0  |  0.000845 |  0.000845 | midx         | open bitmap (midx):failed
	17:18:38.423947 pack-bitmap.c:493            | d0 | main                     | data         | r0  |  0.000858 |  0.000858 | bitmap       | open bitmap (non-midx):failed
	17:18:38.423956 usage.c:60                   | d0 | main                     | error        |     |           |           |              | failed to load bitmap indexes
	fatal: failed to load bitmap indexes
	17:18:38.423967 usage.c:74                   | d0 | main                     | exit         |     |  0.000879 |           |              | code:128
	17:18:38.423976 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.000888 |           |              | code:128

      3. core.multipackindex="false" and only normal bitmap exists

	17:21:25.519233 common-main.c:49             | d0 | main                     | version      |     |           |           |              | 2.35.1.579.g70500b6343.dirty
	17:21:25.519261 common-main.c:50             | d0 | main                     | start        |     |  0.000284 |           |              | /opt/git/master/bin/git rev-list --test-bitmap HEAD
	17:21:25.519335 compat/linux/procinfo.c:170  | d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
	17:21:25.519468 git.c:460                    | d0 | main                     | cmd_name     |     |           |           |              | rev-list (rev-list)
	17:21:25.519673 midx.c:395                   | d0 | main                     | data         | r0  |  0.000701 |  0.000701 | midx         | core.multipackIndex:false
	17:21:25.520051 pack-bitmap.c:512            | d0 | main                     | data         | r0  |  0.001080 |  0.001080 | midx         | open bitmap (midx):failed
	17:21:25.520070 pack-bitmap.c:493            | d0 | main                     | data         | r0  |  0.001099 |  0.001099 | bitmap       | open bitmap (non-midx):ok
	Bitmap v1 test (4 entries loaded)
	Found bitmap for 9a0a2928a280d91f5c8ded46e952add4c4296979. 64 bits / f15de25e checksum
	17:21:25.520395 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001423 |           | progress     | label:Verifying bitmap entries
	Verifying bitmap entries: 100% (15/15), done.
	17:21:25.520526 progress.c:339               | d0 | main                     | data         | r0  |  0.001555 |  0.000132 | progress     | ..total_objects:15
	17:21:25.520533 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001562 |  0.000139 | progress     | label:Verifying bitmap entries
	OK!
	17:21:25.520549 git.c:718                    | d0 | main                     | exit         |     |  0.001578 |           |              | code:0
	17:21:25.520557 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001586 |           |              | code:0

      4. core.multipackindex="false" and both midx and normal bitmaps do not exists

	17:22:27.680275 common-main.c:49             | d0 | main                     | version      |     |           |           |              | 2.35.1.579.g70500b6343.dirty
	17:22:27.680298 common-main.c:50             | d0 | main                     | start        |     |  0.000284 |           |              | /opt/git/master/bin/git rev-list --test-bitmap HEAD
	17:22:27.680375 compat/linux/procinfo.c:170  | d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
	17:22:27.680511 git.c:460                    | d0 | main                     | cmd_name     |     |           |           |              | rev-list (rev-list)
	17:22:27.680718 midx.c:395                   | d0 | main                     | data         | r0  |  0.000709 |  0.000709 | midx         | core.multipackIndex:false
	17:22:27.681085 pack-bitmap.c:512            | d0 | main                     | data         | r0  |  0.001075 |  0.001075 | midx         | open bitmap (midx):failed
	17:22:27.681102 pack-bitmap.c:493            | d0 | main                     | data         | r0  |  0.001093 |  0.001093 | bitmap       | open bitmap (non-midx):failed
	17:22:27.681110 usage.c:60                   | d0 | main                     | error        |     |           |           |              | failed to load bitmap indexes
	fatal: failed to load bitmap indexes
	17:22:27.681120 usage.c:74                   | d0 | main                     | exit         |     |  0.001112 |           |              | code:128
	17:22:27.681129 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001120 |           |              | code:128

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 midx.c        | 2 ++
 pack-bitmap.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/midx.c b/midx.c
index 865170bad0..fda9644028 100644
--- a/midx.c
+++ b/midx.c
@@ -392,6 +392,8 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 	struct multi_pack_index *m_search;
 
 	prepare_repo_settings(r);
+	trace2_data_string("midx", r, "core.multipackIndex",
+					   r->settings.core_multi_pack_index ? "true" : "false");
 	if (!r->settings.core_multi_pack_index)
 		return 0;
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index b1357137bf..14cf8abebd 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -490,6 +490,8 @@ static int open_pack_bitmap(struct repository *r,
 		}
 	}
 
+	trace2_data_string("bitmap", the_repository, "open bitmap (non-midx)",
+					   ret ? "failed" : "ok");
 	return ret;
 }
 
@@ -507,6 +509,8 @@ static int open_midx_bitmap(struct repository *r,
 			break;
 		}
 	}
+	trace2_data_string("midx", the_repository, "open bitmap (midx)",
+					   ret ? "failed" : "ok");
 	return ret;
 }
 
-- 
2.35.1.579.g70500b6343.dirty

