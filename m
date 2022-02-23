Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311F0C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbiBWSlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbiBWSlO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:41:14 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6297249C81
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:40:46 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id w7so786820qvr.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ulwcvWkdZGm6ZldEKLpDHd6h6Jh57mbgzkpInkbV3Q=;
        b=GPMoZSWQKGhy2XJ7eS/wIct9+flIhOTy4M6nPiYopfpmtRtBW1PlHCdoiaBpZp0Pvp
         dU8Ozn9a08hjXvfHQXEhoGQwWLN5El5ultrjxV8JwzBSALsHKuoai2/mmxZ7yBHjZZ2p
         SpliX4aJjvte82bukHqROG/gkI8tO/9VctqPyX8W3F6RBKBurG/bqm9b/qhaXAUpwFLu
         O2k6J812NFiEcL1NgCikHn6dn6GUy6ihfcIPcknRG8MOEZenJds5i/UYUIUSA/BQ9I5L
         83z0x8EOX36MBzP/G236mzBkUyaa04us4GrzNqfggK4eIHsQkNMHtHr20JgaBbKJnc6S
         v0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ulwcvWkdZGm6ZldEKLpDHd6h6Jh57mbgzkpInkbV3Q=;
        b=ocjc0/X6l9axzLnTxUvSUKoFktL8N3+FWwmqcWfxJb7nUemSALTowpWkRYn2NUEET2
         Yl6x0Fnp9NTq3/cA3OPwbAN2/FXB/4X1G053iUh8TPU5sTyuZJ29dV0V9y/Gh3Jdshny
         wxcxwZYwAdAYe8RF5ShYrk9wiaxdteSltSQrskjk7OtPckZ+T/BUn/DausR4zsM8J6yi
         mlaPISI043qDOAuarvcCKFRKAthCxogBVRNeWMaue9aYXe9kl9Qh1qrU/joZSO9BD/PP
         sObk4E6aiCjkg38824Op/1dZUqi2u1mUzY5mf5LR3cRbUbEHyNW56nbGQ1bc26YrxoGr
         +keQ==
X-Gm-Message-State: AOAM531NFWW6Xh9OwzOHQJnEo0UFfjQVxWTW3iSfDJLI92kpU9h+fhFF
        Aeu9flxdE5c+kXGrHlKupVHXALmfcYM=
X-Google-Smtp-Source: ABdhPJyW/j874Qxj26g3a25akEQG6qAG0/7EK5xOFaV+q3pKppOYo8s8BeunpJCSOIyub/GbWyflzA==
X-Received: by 2002:a05:6214:f22:b0:42c:b927:61d0 with SMTP id iw2-20020a0562140f2200b0042cb92761d0mr641275qvb.20.1645641645404;
        Wed, 23 Feb 2022 10:40:45 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id k11sm158743qkk.83.2022.02.23.10.40.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Feb 2022 10:40:44 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/3] reflog: libify delete reflog function and helpers
Date:   Wed, 23 Feb 2022 13:40:44 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <252AF60B-0B06-4AE0-B717-8024030673F2@gmail.com>
In-Reply-To: <220223.86zgmi54q6.gmgdl@evledraar.gmail.com>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <e7c950218b1b6b91a3cecedf3d2339230522e2e0.1645554652.git.gitgitgadget@gmail.com>
 <220223.86zgmi54q6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Thanks for the review!

On 23 Feb 2022, at 4:02, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Feb 22 2022, John Cai via GitGitGadget wrote:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> Currently stash shells out to reflog in order to delete refs. In an
>> effort to reduce how much we shell out to a subprocess, libify the
>> functionality that stash needs into reflog.c.
>>
>> Add a reflog_delete function that is pretty much the logic in the while
>> loop in builtin/reflog.c cmd_reflog_delete(). This is a function that
>> builtin/reflog.c and builtin/stash.c can both call.
>>
>> Also move functions needed by reflog_delete and export them.
>>
>> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>  Makefile         |   1 +
>>  builtin/reflog.c | 451 +----------------------------------------------
>>  object.h         |   2 +-
>>  reflog.c         | 435 +++++++++++++++++++++++++++++++++++++++++++++
>>  reflog.h         |  49 +++++
>>  5 files changed, 490 insertions(+), 448 deletions(-)
>>  create mode 100644 reflog.c
>>  create mode 100644 reflog.h
>>
>> diff --git a/Makefile b/Makefile
>> index 6f0b4b775fe..876d4dfd6cb 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -989,6 +989,7 @@ LIB_OBJS += rebase-interactive.o
>>  LIB_OBJS += rebase.o
>>  LIB_OBJS += ref-filter.o
>>  LIB_OBJS += reflog-walk.o
>> +LIB_OBJS += reflog.o
>>  LIB_OBJS += refs.o
>>  LIB_OBJS += refs/debug.o
>>  LIB_OBJS += refs/files-backend.o
>> diff --git a/builtin/reflog.c b/builtin/reflog.c
>> index 85b838720c3..03d347e5832 100644
>> --- a/builtin/reflog.c
>> +++ b/builtin/reflog.c
>> @@ -1,16 +1,13 @@
>>  #include "builtin.h"
>>  #include "config.h"
>>  #include "lockfile.h"
>> -#include "object-store.h"
>>  #include "repository.h"
>> -#include "commit.h"
>> -#include "refs.h"
>>  #include "dir.h"
>> -#include "tree-walk.h"
>>  #include "diff.h"
>>  #include "revision.h"
>>  #include "reachable.h"
>>  #include "worktree.h"
>> +#include "reflog.h"
>> [...]
>> diff --git a/reflog.c b/reflog.c
>> new file mode 100644
>> index 00000000000..8d57dc43503
>> --- /dev/null
>> +++ b/reflog.c
>> @@ -0,0 +1,435 @@
>> +#include "cache.h"
>> +#include "commit.h"
>> +#include "object-store.h"
>> +#include "reachable.h"
>> +#include "reflog.h"
>> +#include "refs.h"
>> +#include "revision.h"
>> +#include "tree-walk.h"
>> +#include "worktree.h"
>
> I think you missed some now-redundant headers, and copied over others we
> didn't need. This compiles for me with this on top:

Ah yeah, looks I left these in by mistake. Thanks for catching this.

>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 03d347e5832..940db196f62 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -1,9 +1,5 @@
>  #include "builtin.h"
>  #include "config.h"
> -#include "lockfile.h"
> -#include "repository.h"
> -#include "dir.h"
> -#include "diff.h"
>  #include "revision.h"
>  #include "reachable.h"
>  #include "worktree.h"
> diff --git a/reflog.c b/reflog.c
> index 8d57dc43503..333fd8708fe 100644
> --- a/reflog.c
> +++ b/reflog.c
> @@ -1,11 +1,8 @@
>  #include "cache.h"
> -#include "commit.h"
>  #include "object-store.h"
> -#include "reachable.h"
>  #include "reflog.h"
>  #include "refs.h"
>  #include "revision.h"
> -#include "tree-walk.h"
>  #include "worktree.h"
>
> But perhaps some of those are really "needed" but brought in implicitly?
>
>> [...]
>> diff --git a/reflog.h b/reflog.h
>> new file mode 100644
>> index 00000000000..3427021cdc2
>> --- /dev/null
>> +++ b/reflog.h
>> @@ -0,0 +1,49 @@
>> +#ifndef REFLOG_H
>> +#define REFLOG_H
>> +
>> +#include "refs.h"
>
> Just a nit but I think the reflog_delete() should be wrapped (ends up at
> 80 cols), and the usual style in this project is to not whitespace-pad
> so much, i.e. this on top:

sounds good!

>
> diff --git a/reflog.h b/reflog.h
> index 3427021cdc2..d2906fb9f8d 100644
> --- a/reflog.h
> +++ b/reflog.h
> @@ -1,6 +1,5 @@
>  #ifndef REFLOG_H
>  #define REFLOG_H
> -
>  #include "refs.h"
>
>  struct cmd_reflog_expire_cb {
> @@ -25,25 +24,20 @@ struct expire_reflog_policy_cb {
>  	unsigned int dry_run:1;
>  };
>
> -int reflog_delete(const char *rev, enum expire_reflog_flags flags, int verbose);
> -
> +int reflog_delete(const char *rev, enum expire_reflog_flags flags,
> +		  int verbose);
>  void reflog_expiry_cleanup(void *cb_data);
> -
>  void reflog_expiry_prepare(const char *refname, const struct object_id *oid,
>  			   void *cb_data);
> -
>  int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
>  			     const char *email, timestamp_t timestamp, int tz,
>  			     const char *message, void *cb_data);
> -
>  int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
>  		     const char *email, timestamp_t timestamp, int tz,
>  		     const char *message, void *cb_data);
> -
>  int should_expire_reflog_ent_verbose(struct object_id *ooid,
>  				     struct object_id *noid,
>  				     const char *email,
>  				     timestamp_t timestamp, int tz,
>  				     const char *message, void *cb_data);
> -
>  #endif /* REFLOG_H */
>
>
> Other than all that I really can't find anything at all to comment on,
> and I see that all the points raised in previous rounds by others were
> addressed.
