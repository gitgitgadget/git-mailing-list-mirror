Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73CBCE79DE
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 15:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjITPDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjITPC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 11:02:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05D091
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 08:02:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50306b2920dso1258776e87.0
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695222171; x=1695826971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhzmaETKvXjzEPkU0Kp5q/uwhG6GXQT7DswFdOE5NgQ=;
        b=eUMZZu7aIUfD9Z8QZuYWoTmDuuQO9Zsrt0f6SQCZTZKbNrh2ML5HgbfZjxGoNhbj2b
         A9IgYYUV8e4WqL44aVifXaUQY3fR+dwah9mpuP5hXv/KqGoqB14nTOmPPZCwUPf7c6RX
         jb71+y4ecZ3SZW8IWEAW41zasOx/jMia7ol61S13mmP/WydIkKishOXy+1HtR30yzprV
         Kfc2kpipUO4W5XfpnPrqKM9lPw1WJcEIHEaLRlD/QkvTHTOIU7h4eN3Sg67Zz7owLwcW
         Xnuvc1jquaUrjGcmQoMVIw+aaCF8KUHh1CyobNRdxGvXGAlTZMOrtsggST5g2CIqnK58
         Jevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695222171; x=1695826971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhzmaETKvXjzEPkU0Kp5q/uwhG6GXQT7DswFdOE5NgQ=;
        b=P73jjvSz7Ix/ZIGph4dkQlH+hpZCKZuvOsU8DzHUK8db90tTFFOhMOg0jPs+G81n8T
         T2ZI552sJDpg5Q4lLp/nAcuySoD6z5OcvtZfFqHMxA1i0YnGg/0Xhlsw1rq06g8LFiFh
         G6uSXD+pia/lyseVIy0XQkAocvx9LkzjbV7OSzwKthrxaxE8taa8JPwLw1KelJXPE4cZ
         kHIKqGnVPxZMJ2FFIOgSHoXW0OAFrdeU/Xjs/L1h1FJJDJGpj8WCV5qdgepMSuW7fFPd
         th3iQPCnphD/P4wOYEjtwAn0IpiDbeuSTDc6LW8LfcMo9p8kJHSKr4OhqJ3AibDewubX
         sZRA==
X-Gm-Message-State: AOJu0Yy+lT8U5VEpBie4lGf2K1PkvzCJ2DE+xu0iI2QHmXc32JbevDWJ
        4ATZnQiUmzCc9I7Z2Ru3Q4c=
X-Google-Smtp-Source: AGHT+IE94SuwHYh4EHRIWhYMhCiEmFzix1NwohbUexosKTsgZScMtHAVzFo/0dfD303lqDt1jkBoVg==
X-Received: by 2002:a05:6512:3b96:b0:500:7aba:4d07 with SMTP id g22-20020a0565123b9600b005007aba4d07mr1242881lfv.22.1695222169765;
        Wed, 20 Sep 2023 08:02:49 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q12-20020ac25a0c000000b004f37bd02a89sm2701741lfn.287.2023.09.20.08.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:02:49 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 0/2] diff-merges: introduce '-d' option
Date:   Wed, 20 Sep 2023 18:02:42 +0300
Message-Id: <20230920150244.171772-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230909125446.142715-1-sorganov@gmail.com>
References: <20230909125446.142715-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new convenience option requests full diff with respect to first
parent, so that

  git log -d

will output diff with respect to first parent for every commit,
universally, no matter how many parents the commit turns out to have.

It's implemented as pure synonym for

  --diff-merges=first-parent --patch

The first commit in the series tweaks diff-merges documentation a bit,
and is valuable by itself. It's put here as '-d' implementation commit
depends on it in its documentation part.

Note: the need for this new convenience option mostly emerged from
denial by the community of patches that modify '-m' behavior to imply
'-p' as the rest of similar options (such as --cc) do.

Updates in v2:

  * Reordered documentation for diff-merges formats in accordance with
    Junio recommendation.

  * Removed clarification of surprising -m behavior due to controversy
    with Junio on how exactly it should look like.

Sergey Organov (2):
  diff-merges: improve --diff-merges documentation
  diff-merges: introduce '-d' option

 Documentation/diff-options.txt | 102 ++++++++++++++++++---------------
 Documentation/git-log.txt      |   4 +-
 diff-merges.c                  |   3 +
 t/t4013-diff-various.sh        |   8 +++
 4 files changed, 70 insertions(+), 47 deletions(-)

Interdiff against v1:
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index d773dafcb10a..19bb78ff6652 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -47,9 +47,6 @@ ifdef::git-log[]
 	Show diffs for merge commits in the default format. This is
 	similar to '--diff-merges=on' (which see) except `-m` will
 	produce no output unless `-p` is given as well.
-+
-Note: This option not implying `-p` is legacy feature that is
-preserved for the sake of backward compatibility.
 
 -d::
 	Produce diff with respect to first parent.
@@ -96,16 +93,6 @@ separate::
 	Show full diff with respect to each of parents.
 	Separate log entry and diff is generated for each parent.
 +
-remerge, r::
-	Remerge two-parent merge commits to create a temporary tree
-	object--potentially containing files with conflict markers
-	and such.  A diff is then shown between that temporary tree
-	and the actual merge commit.
-+
-The output emitted when this option is used is subject to change, and
-so is its interaction with other options (unless explicitly
-documented).
-+
 combined, c::
 	Show differences from each of the parents to the merge
 	result simultaneously instead of showing pairwise diff between
@@ -117,6 +104,16 @@ dense-combined, cc::
 	by omitting uninteresting hunks whose contents in the parents
 	have only two variants and the merge result picks one of them
 	without modification.
++
+remerge, r::
+	Remerge two-parent merge commits to create a temporary tree
+	object--potentially containing files with conflict markers
+	and such.  A diff is then shown between that temporary tree
+	and the actual merge commit.
++
+The output emitted when this option is used is subject to change, and
+so is its interaction with other options (unless explicitly
+documented).
 --
 
 --combined-all-paths::
-- 
2.25.1

