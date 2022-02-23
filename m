Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5119FC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 09:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbiBWJKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 04:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbiBWJKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 04:10:09 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50B08021F
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 01:09:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lw4so50978977ejb.12
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 01:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=31pBm1oA8s3SJfUY/rJOyeO53GkjvWh2hkqn5NsOA4M=;
        b=RS9XlZUKSW0AAWEMu2ATP27EITJ9om6iOXTpqBXBR7LGs31TqECdKgZ8dDkofo4pSO
         76HEgHh4MZGY1DSbCwzQNnLbBMOUzim+pbQjBvIMLW2+OAzAXJJrt7X9RPi0Y+DM+PP2
         84iGr20Zk4Ip1jSjTlNJQYjpOLs9iPd4G87tZiKKWK/7+/g/9WGN0+AbMpHHp78jMXQY
         FTMO0DReVlC3UysJOcCoqShTrNd2vyP5uPwMhNKmTRbJu97Jt1DyOhNFcxEIG6eHrlIc
         UkGf6FGIDwXTae4CWzVY4F446gbCV/8dRNdZVtryV/JRLzn5m21DL666hd3yskaRQcpL
         awew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=31pBm1oA8s3SJfUY/rJOyeO53GkjvWh2hkqn5NsOA4M=;
        b=JuCWvqgdBGrwdrafYl+GCgTljVlkNvkGfLgkDLdhPDvd+uvezYRIWpq9PKPgflmYvm
         Xhz5B1jHSpCrqktwZOeNhpUOuN1kz17XvK+VgQjvkEGhqnHqaLBRXZcsK6cf6JXn+02w
         O+v9vSj05fmMx/cuVhH0Z0Hy1qx/xFK+72Ow4+3saLcrpdlbs5R4B47wd5b66QGX/163
         OV4pNxjcZ2ssbSv/IuOiTm3CY932vH8co+YGMwAXJtkxAGcSNGLOpoX1yAgtwUMBV3nh
         ZOoX8bu09K8lkfCouSKXM5WmKWBe5rSwSg0GTIKr8vM+FgoZI+/jseJ2SFzgmpFCYhdl
         /cIQ==
X-Gm-Message-State: AOAM530C4yJ6mVo3I/3hsCWSQ2DpDgbr31Q2MEMJNlIJOMdwBVJxEykO
        qQNWNle/Crqrtp9HGT9XUv7Myya4HEg=
X-Google-Smtp-Source: ABdhPJzAaukHBAILd5ZDrMlB6QANOKlQWr1mL1qZ0zJmzvtA5ytRnBDj1fOYGy6bvBzdgj+pZtHzCw==
X-Received: by 2002:a17:906:c59:b0:6b9:59d8:263e with SMTP id t25-20020a1709060c5900b006b959d8263emr23028652ejf.770.1645607378757;
        Wed, 23 Feb 2022 01:09:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t12sm7061166ejd.27.2022.02.23.01.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 01:09:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMneT-006DNi-VT;
        Wed, 23 Feb 2022 10:09:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 2/3] reflog: libify delete reflog function and helpers
Date:   Wed, 23 Feb 2022 10:02:54 +0100
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <e7c950218b1b6b91a3cecedf3d2339230522e2e0.1645554652.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <e7c950218b1b6b91a3cecedf3d2339230522e2e0.1645554652.git.gitgitgadget@gmail.com>
Message-ID: <220223.86zgmi54q6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> Currently stash shells out to reflog in order to delete refs. In an
> effort to reduce how much we shell out to a subprocess, libify the
> functionality that stash needs into reflog.c.
>
> Add a reflog_delete function that is pretty much the logic in the while
> loop in builtin/reflog.c cmd_reflog_delete(). This is a function that
> builtin/reflog.c and builtin/stash.c can both call.
>
> Also move functions needed by reflog_delete and export them.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  Makefile         |   1 +
>  builtin/reflog.c | 451 +----------------------------------------------
>  object.h         |   2 +-
>  reflog.c         | 435 +++++++++++++++++++++++++++++++++++++++++++++
>  reflog.h         |  49 +++++
>  5 files changed, 490 insertions(+), 448 deletions(-)
>  create mode 100644 reflog.c
>  create mode 100644 reflog.h
>
> diff --git a/Makefile b/Makefile
> index 6f0b4b775fe..876d4dfd6cb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -989,6 +989,7 @@ LIB_OBJS +=3D rebase-interactive.o
>  LIB_OBJS +=3D rebase.o
>  LIB_OBJS +=3D ref-filter.o
>  LIB_OBJS +=3D reflog-walk.o
> +LIB_OBJS +=3D reflog.o
>  LIB_OBJS +=3D refs.o
>  LIB_OBJS +=3D refs/debug.o
>  LIB_OBJS +=3D refs/files-backend.o
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 85b838720c3..03d347e5832 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -1,16 +1,13 @@
>  #include "builtin.h"
>  #include "config.h"
>  #include "lockfile.h"
> -#include "object-store.h"
>  #include "repository.h"
> -#include "commit.h"
> -#include "refs.h"
>  #include "dir.h"
> -#include "tree-walk.h"
>  #include "diff.h"
>  #include "revision.h"
>  #include "reachable.h"
>  #include "worktree.h"
> +#include "reflog.h"
> [...]
> diff --git a/reflog.c b/reflog.c
> new file mode 100644
> index 00000000000..8d57dc43503
> --- /dev/null
> +++ b/reflog.c
> @@ -0,0 +1,435 @@
> +#include "cache.h"
> +#include "commit.h"
> +#include "object-store.h"
> +#include "reachable.h"
> +#include "reflog.h"
> +#include "refs.h"
> +#include "revision.h"
> +#include "tree-walk.h"
> +#include "worktree.h"

I think you missed some now-redundant headers, and copied over others we
didn't need. This compiles for me with this on top:

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 03d347e5832..940db196f62 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,9 +1,5 @@
 #include "builtin.h"
 #include "config.h"
-#include "lockfile.h"
-#include "repository.h"
-#include "dir.h"
-#include "diff.h"
 #include "revision.h"
 #include "reachable.h"
 #include "worktree.h"
diff --git a/reflog.c b/reflog.c
index 8d57dc43503..333fd8708fe 100644
--- a/reflog.c
+++ b/reflog.c
@@ -1,11 +1,8 @@
 #include "cache.h"
-#include "commit.h"
 #include "object-store.h"
-#include "reachable.h"
 #include "reflog.h"
 #include "refs.h"
 #include "revision.h"
-#include "tree-walk.h"
 #include "worktree.h"

But perhaps some of those are really "needed" but brought in implicitly?

> [...]
> diff --git a/reflog.h b/reflog.h
> new file mode 100644
> index 00000000000..3427021cdc2
> --- /dev/null
> +++ b/reflog.h
> @@ -0,0 +1,49 @@
> +#ifndef REFLOG_H
> +#define REFLOG_H
> +
> +#include "refs.h"

Just a nit but I think the reflog_delete() should be wrapped (ends up at
80 cols), and the usual style in this project is to not whitespace-pad
so much, i.e. this on top:

diff --git a/reflog.h b/reflog.h
index 3427021cdc2..d2906fb9f8d 100644
--- a/reflog.h
+++ b/reflog.h
@@ -1,6 +1,5 @@
 #ifndef REFLOG_H
 #define REFLOG_H
-
 #include "refs.h"
=20
 struct cmd_reflog_expire_cb {
@@ -25,25 +24,20 @@ struct expire_reflog_policy_cb {
 	unsigned int dry_run:1;
 };
=20
-int reflog_delete(const char *rev, enum expire_reflog_flags flags, int ver=
bose);
-
+int reflog_delete(const char *rev, enum expire_reflog_flags flags,
+		  int verbose);
 void reflog_expiry_cleanup(void *cb_data);
-
 void reflog_expiry_prepare(const char *refname, const struct object_id *oi=
d,
 			   void *cb_data);
-
 int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noi=
d,
 			     const char *email, timestamp_t timestamp, int tz,
 			     const char *message, void *cb_data);
-
 int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
 		     const char *email, timestamp_t timestamp, int tz,
 		     const char *message, void *cb_data);
-
 int should_expire_reflog_ent_verbose(struct object_id *ooid,
 				     struct object_id *noid,
 				     const char *email,
 				     timestamp_t timestamp, int tz,
 				     const char *message, void *cb_data);
-
 #endif /* REFLOG_H */


Other than all that I really can't find anything at all to comment on,
and I see that all the points raised in previous rounds by others were
addressed.
