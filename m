Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897C01EB25
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8Ik8LMb"
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C450C19A
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:10:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso11188419a12.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697717428; x=1698322228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDm1auDfmGx4HkBJwVFbslTYF6XPIquDZa+4+9gH2n8=;
        b=m8Ik8LMbg2rWpJAOZqdo9yr37ocykG2R8vEzmu9bttGFC5q7KkHm0gpUAbNz7kRdE0
         XZVLHkO6TgtTe4AhThtNyZbl7awcTBmig5tkNNn2U9hdQ/V9mLtdnmFtOEUY7SFF/5z6
         6P46Dy/iz+uW6aPPuMqfCuM8N+IPKu5ILzdezpfLF3fII5qHRu/gzK4SHmYykFmg8Q6A
         dvRptS0WYamNyt84j4I1L581M069zfy4cNw1wTDSGvW/Cz5dCNiRV2eu64GJWcZvAsk3
         f2QOP05BYX7OFg0mdJAMpLqj3Ve9NHcsQOU13FylJ1eTfcCouhFa3vWYJxY8emUjYj9w
         rP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697717428; x=1698322228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDm1auDfmGx4HkBJwVFbslTYF6XPIquDZa+4+9gH2n8=;
        b=W3QUCYC/Y5q5lbtJ5Qq/4C8BQI9h8gGo1HjDuw6ef2xwF+Sa02yhvgDg8HiHo1kONq
         FkXNhvJQ//pmCGuJhqTst2wtZV8qYZA8M/0i5g88Vk1WnZsg4foXv6H0HsgAJElBU2kc
         BZvJT7SAJaWsve4vNBqQdo3Myp0qrE6GMY18QUePINhGA+CICgrtCJ0s68fcWpacAu7U
         flXRvN4MzlsMR4lBATtB9A9Zwt7vEZAk+IlT258HxiG6bRFKneHgYxrlfRIEfbU+AX/L
         ArpCAMJr7DxHl5qr0W5uyqMx+Cku3JzbCnDzSeFE2s7QsqfiMlPQSejTH6rq8VADsZAR
         XM6g==
X-Gm-Message-State: AOJu0Yyb5W3f5pbVelxk8+Ej32+oz12WOFXrP1haUODDJ9y41TltYe2m
	Q9A6SwtJOOu2D3D6zflu8VK2tbYHYoDLbg==
X-Google-Smtp-Source: AGHT+IGOMK0DydnBXn2VU9Hg02p6SiPjyUcUXIoFCHMjLMddbiEXXuFr3HAyagWj42lZgMCh46HxWw==
X-Received: by 2002:a17:907:2d0f:b0:9be:6050:7f1b with SMTP id gs15-20020a1709072d0f00b009be60507f1bmr1702458ejc.0.1697717427787;
        Thu, 19 Oct 2023 05:10:27 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2454:56d:f00:d5ee:6231:6f45:fa9b])
        by smtp.gmail.com with ESMTPSA id oz6-20020a170906cd0600b0099ddc81903asm3469212ejb.221.2023.10.19.05.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:10:27 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 0/3] rev-list: add support for commits in `--missing`
Date: Thu, 19 Oct 2023 14:10:21 +0200
Message-ID: <20231019121024.194317-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016103830.56486-1-karthik.188@gmail.com>
References: <20231016103830.56486-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--missing` option in git-rev-list(1) was introduced intitally
to deal with missing blobs in the context of promissory notes.
Eventually the option was extended to also support tree objects in
7c0fe330d5 (rev-list: handle missing tree objects properly,2018-10-05).

This patch series extends the `--missing` option to also add support for
commit objects. We do this by introducing a new flag `MISSING` which is
added whenever we encounter a missing commit during traversal. Then in
`builtin/rev-list` we check for this flag and take the appropriate
action based on the `--missing=*` option used.

This series is an alternate to the patch series I had posted earlier:
https://lore.kernel.org/git/20230908174208.249184-1-karthik.188@gmail.com/.
In that patch, we introduced an option `--ignore-missing-links` which
was added to expose the `ignore_missing_links` bit to the user. The
issue in that patch was that, the option `--ignore-missing-links` didn't
play well the pre-existing `--missing` option. This series avoids that
route and just extends the `--missing` option for commits to solve the
same problem.

V2 of the series can be found here: http://public-inbox.org/git/ZSkCGS3JPEQ71dOF@tanuki/T/#m10b562ec02834d0b222835a24a18e6ca725f99d1

Changes from v2: 

* Change the flag MISSING's bit number to avoid collision with NEEDS_BITMAP
  which was causing t5310 and t532 to fail.

Range diff from v2:

1:  a7018a319a = 1:  fa35cd21e6 revision: rename bit to `do_not_die_on_missing_objects`
2:  b186a679d4 = 2:  31074df376 rev-list: move `show_commit()` to the bottom
3:  0c8c140c27 ! 3:  d9b0d6da0c rev-list: add commit object support in `--missing` option
    @@ object.h: void object_array_init(struct object_array *array);
      /*
       * object flag allocation:
     - * revision.h:               0---------10         15             23------27
    -+ * revision.h:               0---------10         15             22------27
    ++ * revision.h:               0---------10         15             22------28
       * fetch-pack.c:             01    67
       * negotiator/default.c:       2--5
       * walker.c:                 0-2
    +@@ object.h: void object_array_init(struct object_array *array);
    +  * builtin/show-branch.c:    0-------------------------------------------26
    +  * builtin/unpack-objects.c:                                 2021
    +  */
    +-#define FLAG_BITS  28
    ++#define FLAG_BITS  29
    + 
    + #define TYPE_BITS 3
    + 
     
      ## revision.c ##
     @@ revision.c: static int process_parents(struct rev_info *revs, struct commit *commit,
    @@ revision.c: static int process_parents(struct rev_info *revs, struct commit *com
      	unsigned pass_flags;
      
     -	if (commit->object.flags & ADDED)
    -+	if (commit->object.flags & ADDED || commit->object.flags & MISSING)
    ++	if (commit->object.flags & (ADDED | MISSING))
      		return 0;
      	commit->object.flags |= ADDED;
      
    @@ revision.c: static int process_parents(struct rev_info *revs, struct commit *com
     
      ## revision.h ##
     @@
    - /* WARNING: This is also used as REACHABLE in commit-graph.c. */
    - #define PULL_MERGE	(1u<<15)
    + #define ANCESTRY_PATH	(1u<<27)
    + #define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR | PULL_MERGE)
      
    -+/* WARNING: This is also used as NEEDS_BITMAP in pack-bitmap.c. */
    -+#define MISSING         (1u<<22)
    ++#define MISSING (1u<<28)
     +
    - #define TOPO_WALK_EXPLORED	(1u<<23)
    - #define TOPO_WALK_INDEGREE	(1u<<24)
    + #define DECORATE_SHORT_REFS	1
    + #define DECORATE_FULL_REFS	2
      
     
      ## t/t6022-rev-list-missing.sh (new) ##


Karthik Nayak (3):
  revision: rename bit to `do_not_die_on_missing_objects`
  rev-list: move `show_commit()` to the bottom
  rev-list: add commit object support in `--missing` option

 builtin/reflog.c            |  2 +-
 builtin/rev-list.c          | 93 +++++++++++++++++++------------------
 list-objects.c              |  4 +-
 object.h                    |  4 +-
 revision.c                  | 11 +++--
 revision.h                  | 19 ++++----
 t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++
 7 files changed, 147 insertions(+), 60 deletions(-)
 create mode 100755 t/t6022-rev-list-missing.sh

-- 
2.42.0

