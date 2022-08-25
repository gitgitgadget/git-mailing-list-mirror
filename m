Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F375C64990
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 13:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbiHYN7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 09:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbiHYN7M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 09:59:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18EA50DA
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 06:59:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sd33so18371513ejc.8
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=mJ8OFF1XYd//kdVImLa4GEHobvc39pn7vNu3ps4EGxw=;
        b=Mid5X430KoCNB8m/h8otIuIDzvHNlJXzcnaYNp1bDq4R3ZBcx92OZlkOSLICkHZcOs
         JpS/CDtkujiPBrzr2b9uSeHONbklXMO7vY00tOmYlz7m//ULMFhzLVRNOAs0Kh1oo/Vd
         gOipk2/ewTSYAzkxsfy8jMV9JhhLhP9EkdmpknNjbmSmzNAplajS7CEPB70+Iu0PJCQ9
         vvbbEUN0yDlsA5nGK+8TeVgh4WI7DMVl/8A02jAy9FaN+pdEsEUgOwDPbZVzG4UAJQn+
         qzUoPW59jiltP/or/Q/VZxl7HhaRXGF45zBbuy0BOFLGuNmIAF+pvlufWOtbo1nAEvOH
         c9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=mJ8OFF1XYd//kdVImLa4GEHobvc39pn7vNu3ps4EGxw=;
        b=4VGv/CgowiA/9rXjLThg7j41kIp0SK5Z/oxYOkVQamWFtDqhYYcCH0dNPK9RKGxgwd
         cbYk4q+Et4gqrNqnVGdChGXFhRL+YWCeM11svwJ7j/pY/kwfPVwbqj82SlvXm0uQo9BO
         IPJ9zIz8Y3f4ifEPekYxkhmTiuYNsCwdmmLtTQw65e9eSq1aeriGcrmxJXHiHTyfQwoZ
         62ZTTGyebtfkwQALu6feiG6Tp3A1IMlSj6feytWBPy3vomm75LpvpPh8KDUAycw6oHai
         9ZZ3HLu3CJ88hgh5n+kbB6vjtcNCelkzNm79B3v3ZiYR6aYobVt0gQap44Ds/8WT7Ddu
         sdCw==
X-Gm-Message-State: ACgBeo0ug/BckUFWVctZYdpmpId5ttusPYhbGXpgN48w1z1umLpgkXf2
        qYfw0MOikXqdvjx+q/QSk8s=
X-Google-Smtp-Source: AA6agR42ZGp0PolC7VDGePkGTYT6Tr2cnsIwGlq/ZfYLxR9meblub7LksMmoJD/bgRuMG4QL/MN0ww==
X-Received: by 2002:a17:907:1c06:b0:73d:ba76:9e63 with SMTP id nc6-20020a1709071c0600b0073dba769e63mr2598083ejc.384.1661435949583;
        Thu, 25 Aug 2022 06:59:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k13-20020a1709063e0d00b0073dcdf9b0bcsm1054283eji.17.2022.08.25.06.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 06:59:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oRDO0-001HpD-0q;
        Thu, 25 Aug 2022 15:59:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] promisor-remote: fix xcalloc() argument order
Date:   Thu, 25 Aug 2022 15:51:21 +0200
References: <20220822213408.662482-1-szeder.dev@gmail.com>
 <20220823095733.58685-1-szeder.dev@gmail.com>
 <YwXiKXONiTt+fIdi@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YwXiKXONiTt+fIdi@coredump.intra.peff.net>
Message-ID: <220825.86a67s4e6r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 24 2022, Jeff King wrote:

> On Tue, Aug 23, 2022 at 11:57:33AM +0200, SZEDER G=C3=A1bor wrote:
>
>> Pass the number of elements first and their size second, as expected
>> by xcalloc().
>>=20
>> Patch generated with:
>>=20
>>   make SPATCH_FLAGS=3D--recursive-includes contrib/coccinelle/xcalloc.co=
cci.patch
>
> Thanks for digging here. I think it probably explains a lot of "wait,
> why did this result change" head-scratching I did back when we started
> batching a few years ago.
>
> Is there any reason we wouldn't want --recursive-includes to be added to
> the default SPATCH_FLAGS?
>
> I suspect we'd still want to leave --all-includes there to get as much
> type information as possible. If I understand correctly, the two are
> orthogonal (one is "follow includes of includes" and the other is
> "follow system includes in angle brackets").
>
> Doing so doesn't seem to find any other missed entries in the current
> codebase, but I'm pretty sure there are some it would have caught in a
> less mysterious fashion over the years.

This feels to me like hacks around other issues we should fix the root
cause of.

So, first of all, I think this is a perfectly good fix, and something we
should do more of in general. It'll apply the wanted change *and* speed
up the run:
=09
	diff --git a/contrib/coccinelle/xcalloc.cocci b/contrib/coccinelle/xcalloc=
.cocci
	index c291011607e..bd51e33af83 100644
	--- a/contrib/coccinelle/xcalloc.cocci
	+++ b/contrib/coccinelle/xcalloc.cocci
	@@ -1,10 +1,8 @@
	 @@
	-type T;
	-T *ptr;
	 expression n;
	 @@
	   xcalloc(
	 + n,
	-  \( sizeof(T) \| sizeof(*ptr) \)
	+  sizeof(...)
	 - , n
	   )

But it's *not* functionally the same thing, pedantically speaking, but I
think it's fine. I pointed this out at the the time in [1].

Also, more generally we could avoid includes in headers, and use forward
decls. This would make e.g. the "iwyu" tool report the missing include.

Unfortunately it seems we added it in this case due to
"the_repository". I wonder if this hack would be better:

	diff --git a/Makefile b/Makefile
	index 9410a587fc0..92d5726b392 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -3119,6 +3119,7 @@ HCC =3D $(HCO:hco=3Dhcc)
=09=20
	 %.hcc: %.h
	 	@echo '#include "git-compat-util.h"' >$@
	+	@echo "extern struct repository *the_repository;" >>$@
	 	@echo '#include "$<"' >>$@
=09=20
	 $(HCO): %.hco: %.hcc FORCE
	diff --git a/promisor-remote.h b/promisor-remote.h
	index edc45ab0f5f..e864c093a44 100644
	--- a/promisor-remote.h
	+++ b/promisor-remote.h
	@@ -1,7 +1,7 @@
	 #ifndef PROMISOR_REMOTE_H
	 #define PROMISOR_REMOTE_H
=09=20
	-#include "repository.h"
	+struct repository;
=09=20
	 struct object_id;
=09=20
	@@ -23,6 +23,7 @@ static inline void promisor_remote_reinit(void)
	 	repo_promisor_remote_reinit(the_repository);
	 }
=09=20
	+struct promisor_remote_config;
	 void promisor_remote_clear(struct promisor_remote_config *config);
=09=20
	 struct promisor_remote *repo_promisor_remote_find(struct repository *r, c=
onst char *remote_name);

So yeah, one way to deal with this is --recursive-includes, but I think
we're better off heading in the direction of having the includes for a
given *.c file be what it actually needs, and not rely on includes by
proxy, or in this case to pollute the namespace of everyone using
promisor-remote.h with remote.h (probably doesn't matter in that case,
but in the general case...).

1. https://lore.kernel.org/git/87ft18tcog.fsf@evledraar.gmail.com/
