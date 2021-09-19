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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16083C433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 21:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E3E60F48
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 21:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhISVgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 17:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhISVgI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 17:36:08 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4168C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 14:34:42 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id a10so36032082qka.12
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 14:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gKiO7GHbNBjcMmSKVRexNYIZlethot03QJcJgwUciOo=;
        b=EL7L88abRL7kqI1cE5hjPo0a5nUVVHTCJE67p8Y8z+whFeJGPMEkFG1JqvGqfC5/nV
         vo3dFyvRLkUXjaeinpXwE5ebuzbhea4bvITvac3A5vnL9OC9UsIkTK1nzRo6UuZJt0iH
         O07jt8wyM0d1kzEW3Al2VnQSvCSzfuqEi47n/f6q1SSZeZYoFWxljh2CONOSAb8NSyCL
         LDAHvxqieVh8QnOxIvS184pcWoQgp4a2KtcnXlBj1LVcYYRu+GxLN4L5nr/T5zbfLYIv
         9IUM54uQrYyWEzv38T/qWI46cizJ8bBuY34FHGDuwG7fDLz4LzRJDp3yvNsqZ7fnIRqA
         seSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gKiO7GHbNBjcMmSKVRexNYIZlethot03QJcJgwUciOo=;
        b=qU5xXtTqg0PWRJVSsnzPPEjdUcsJ1LmZ/S8a4HF7CrRGjfsJ+EDg3M2e00Bpc/Ei3q
         qzCvO7xs7saPjDuVyRqT243/SHrYwt46CyA1NOIDbuYh3DnlQODIKOSPYMtU9QthA3mf
         WcGTDwbL5Q2jgV42oXUga2b5pmqlJk+kHLlmjE+LaMVHNyiubgKRkQalQLNRgLW0Tbw+
         nEJY4P4JDYXKY/9VrLrFfocSFngI3ADxrJiAnABBIWqtpN0KvOx5jqu0bWpWr4FB3a+q
         4Yrtkpmgdl9bn1niGtGPlCYhiGqWXAxITiBUc8wnGJLlJ1cKfiHyHPz4Dy08IBmv+x50
         AM6Q==
X-Gm-Message-State: AOAM53282F6gB8NAy6WQ+LwB2NVbLB2RCuNQ3To/fEyUA/bdlIAUKyuC
        jHcckmRa2LdNSwHCIGuRfd0=
X-Google-Smtp-Source: ABdhPJxF8FbwzFn5gqXk/LFfJ4nM+KM2HF6MIPWP6rYmmsxMH5tQ1VYn0xI3dsPm8zpo2FrtnbRjFA==
X-Received: by 2002:a37:aa8f:: with SMTP id t137mr4135744qke.381.1632087281785;
        Sun, 19 Sep 2021 14:34:41 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id h68sm10189484qkf.126.2021.09.19.14.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 14:34:41 -0700 (PDT)
Date:   Sun, 19 Sep 2021 14:34:39 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] log: UNLEAK rev to silence a large number of leaks
Message-ID: <YUes7yxKHKW7cXcl@carlos-mbp.lan>
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
 <6d54bc264e2f9ce519f32c0673167a00bab55573.1631972978.git.gitgitgadget@gmail.com>
 <YUZG0D5ayEWd7MLP@carlos-mbp.lan>
 <87o88obkb1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o88obkb1.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 19, 2021 at 06:13:43PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Sep 18 2021, Carlo Marcelo Arenas Belón wrote:
> 
> > Note that the cleaning of the "name" in the cmdline item throws a warning
> > as shown below which I intentionally didn't fix, as it would seem that
> > either the use of const there or the need to strdup is wrong.  So hope
> > someone that knows this code better could chime in.
> 
> It should just be a "char *", I got that wrong in my version posted in
> the side-thread[1] & mentioned in the side-reply[2].

I was instead leaning towards keeping it as a "const char *" and removing
the strdup as shown in the patch below (obviously the last hunk not relevant
to your series).

This object doesn't hold or even manipulate, the objects it contains, so
it might be also a cleaner API to ensure it only keeps references and
doesn't own any in the more CS sense (note I am not a CS guy, so maybe I
get the concept here wrong).

Ironically the original patch that added the strdup was because of leak
related work, but I think that in this case might had gotten it backwards.

Even if we start holding pointers to names that are not static, I would
expect whoever created those buffers to own the data anyway.

Carlo

CC Michael for advise as the original author
------ >8 ------
Subject: [PATCH] revision: remove dup() of name in add_rev_cmdline()

df835d3a0c (add_rev_cmdline(): make a copy of the name argument,
2013-05-25) adds it, probably introducing a leak.

All names we will ever get will either come from the commandline
or be pointers to a static buffer in hex.c, so it is safe not to
xstrdup and clean them up (just like the struct object *item).

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 revision.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index ce62192dd8..b20bc58ccd 100644
--- a/revision.c
+++ b/revision.c
@@ -1468,7 +1468,6 @@ static int limit_list(struct rev_info *revs)
 
 /*
  * Add an entry to refs->cmdline with the specified information.
- * *name is copied.
  */
 static void add_rev_cmdline(struct rev_info *revs,
 			    struct object *item,
@@ -1481,7 +1480,7 @@ static void add_rev_cmdline(struct rev_info *revs,
 
 	ALLOC_GROW(info->rev, nr + 1, info->alloc);
 	info->rev[nr].item = item;
-	info->rev[nr].name = xstrdup(name);
+	info->rev[nr].name = name;
 	info->rev[nr].whence = whence;
 	info->rev[nr].flags = flags;
 	info->nr++;
@@ -1490,10 +1489,6 @@ static void add_rev_cmdline(struct rev_info *revs,
 static void clear_rev_cmdline(struct rev_info *revs)
 {
 	struct rev_cmdline_info *info = &revs->cmdline;
-	size_t i, nr = info->nr;
-
-	for (i = 0; i < nr; i++)
-		free(info->rev[i].name);
 
 	FREE_AND_NULL(info->rev);
 	info->nr = info->alloc = 0;
-- 
2.33.0.911.gbe391d4e11

