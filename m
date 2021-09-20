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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783D3C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F34460F9D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347661AbhIUCVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbhIUBsj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:48:39 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10068C065F2B
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 14:39:16 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 194so22756328qkj.11
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 14:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8x234IHeMfepZ2yCWtp8Y1YT97xUXGxoFcDzA2eTFOk=;
        b=kvr22kAmBXHK6iHpejoaOc0rWqCemYXbdZtN4FjjX+4jD4Rb2iC44sH9byqOPhdwzz
         PzdbIn5jfu/ycB3s2TxNDzS66VucG09gCqbJBaqsAQz96M1Epdv9E3ZboYpKsnL6stWE
         0nwSeDDh5oJhqFPrF3TwauBVyaxVEnGJjeY4H9mMTVQBy8B1ZFxpx8l3OJkIjeFUCKCi
         Gmbst8xovD4/7BWTSzmLiiIT+AvI3eFRdJ/0abBAnBcpmkBUy0cRdPacTjBIk0uz0sCY
         DC2sOxDLiiRka6DFs65nSO0NdMqyn0ZUvr5TcIE3RagmFOH2moVQLMw2ZUpmnlUksz8D
         Dd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8x234IHeMfepZ2yCWtp8Y1YT97xUXGxoFcDzA2eTFOk=;
        b=k5e7yFjK0YTxnGGLuUTBebjXT+CO3A6w+ka1rvPoj6CXmU7hMJyLrTtrv6Wl+EV+YS
         RCo2tdAyQdBom2aMMP2sdwTEhLf+4CFjSq2zSiH9W25a7eEI0pMPQsBG123HI44CF4Uc
         ch1nNixApB4X7vJHw15wagNzxrMKfLSLO5omiQ0vE67tOfks0ItRpsQ8ysK5fgv/tJYe
         TciHm75YOMLpU+Youi70frb5v8mb575vd5mS84KqefOYUODQMBjie1JoIE5/XfOEzLso
         3HWwtEIBpAM3lwEiYeIz8Q7HIEnopYzRmFrz3ZUGx9DBfwnjhCYxasu9f6ADJ/fTWbcv
         kRvw==
X-Gm-Message-State: AOAM531EUsSq1cEMn8d3WNRFLfWme7SPu/ncF+u3u3C/E/XhB0/I3mzy
        AMDrB8+SqIW3RJoI41HI3Dn4/fBg9dY=
X-Google-Smtp-Source: ABdhPJzCX+M+kvleU6VfO3fc2DyP06/bBgPySBIwUIR40BugIFqKu5dIIask2NIB+rxsDmUa9d5rfA==
X-Received: by 2002:a05:620a:2298:: with SMTP id o24mr26997826qkh.235.1632173955126;
        Mon, 20 Sep 2021 14:39:15 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id t6sm4628358qta.68.2021.09.20.14.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 14:39:14 -0700 (PDT)
Date:   Mon, 20 Sep 2021 14:39:12 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] log: UNLEAK rev to silence a large number of leaks
Message-ID: <YUj/gFRh6pwrZalY@carlos-mbp.lan>
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
 <6d54bc264e2f9ce519f32c0673167a00bab55573.1631972978.git.gitgitgadget@gmail.com>
 <YUZG0D5ayEWd7MLP@carlos-mbp.lan>
 <87o88obkb1.fsf@evledraar.gmail.com>
 <YUes7yxKHKW7cXcl@carlos-mbp.lan>
 <CAPig+cT-ajKsoj19ChPnkNByf-6P-vX=SG0NmgYt8CXyNH8y-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cT-ajKsoj19ChPnkNByf-6P-vX=SG0NmgYt8CXyNH8y-w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 02:06:01AM -0400, Eric Sunshine wrote:
> On Sun, Sep 19, 2021 at 5:34 PM Carlo Marcelo Arenas Belón
> <carenas@gmail.com> wrote:
> > Subject: [PATCH] revision: remove dup() of name in add_rev_cmdline()
> >
> > df835d3a0c (add_rev_cmdline(): make a copy of the name argument,
> > 2013-05-25) adds it, probably introducing a leak.
> >
> > All names we will ever get will either come from the commandline
> > or be pointers to a static buffer in hex.c, so it is safe not to
> > xstrdup and clean them up (just like the struct object *item).
> 
> I haven't been following this thread closely, but the mention of the
> static buffer in hex.c invalidates the premise of this patch, as far
> as I can tell. The "static buffer" is actually a ring of four buffers
> which oid_to_hex() uses, one after another, into which it formats an
> OID as hex. This allows a caller to format up to -- and only up to --
> four OIDs without worrying about allocating its own memory for the hex
> result. Beyond four, the caller can't use oid_to_hex() without doing
> some sort of memory management itself, whether that be duplicating the
> result of oid_to_hex() or by allocating its own buffers and calling
> oid_to_hex_r() instead.

Thanks; this then explains why as I was suspecting add_rev_cmdline_list()
was indeed buggy, and might had even triggered the workaround of doing the
strdup.

> Therefore (if I'm reading this correctly), it is absolutely correct
> for add_rev_cmdline() to be duplicating that string to ensure that the
> hexified OID value remains valid, and incorrect for this patch to be
> removing the call to xstrdup().

Indeed, but the values that are being strdup were never used anyway, so
I suspect the original code might had just put it as a logical default.

We might do better instead as shown in the following patch (again, second
hunk not relevant for the current code); I suspect if we were to land this,
the last hunks probably should be done first in an independent patch, as
well.

Carlo
-------- >8 --------
Subject: [PATCH] revision: remove xstrdup() of name in add_rev_cmdline()

a765499a08 (revision.c: treat A...B merge bases as if manually
specified, 2013-05-13) adds calls to this function in a loop,
abusing oid_to_hex (at that time called sha1_to_hex).

df835d3a0c (add_rev_cmdline(): make a copy of the name argument,
2013-05-25) adds the strdup, introducing a leak.

All names we will ever get should come from the commandline or be
constant values, so it is safe not to xstrdup and clean them up.

Just like the struct object *item, that is referenced in the same
struct, name isn't owned or managed so correct both issues by making
sure all entries are indeed constant or valid global pointers (from
the real command line) and remove the leak.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 revision.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index ce62192dd8..829af28658 100644
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
@@ -1504,10 +1499,10 @@ static void add_rev_cmdline_list(struct rev_info *revs,
 				 int whence,
 				 unsigned flags)
 {
+	static const char *synthetic = ".synthetic";
 	while (commit_list) {
 		struct object *object = &commit_list->item->object;
-		add_rev_cmdline(revs, object, oid_to_hex(&object->oid),
-				whence, flags);
+		add_rev_cmdline(revs, object, synthetic, whence, flags);
 		commit_list = commit_list->next;
 	}
 }
@@ -1753,7 +1748,7 @@ struct add_alternate_refs_data {
 static void add_one_alternate_ref(const struct object_id *oid,
 				  void *vdata)
 {
-	const char *name = ".alternate";
+	static const char *name = ".alternate";
 	struct add_alternate_refs_data *data = vdata;
 	struct object *obj;
 
@@ -1940,7 +1935,7 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 			   struct object_context *a_oc,
 			   struct object_context *b_oc)
 {
-	const char *a_name, *b_name;
+	static const char *a_name, *b_name;
 	struct object_id a_oid, b_oid;
 	struct object *a_obj, *b_obj;
 	unsigned int a_flags, b_flags;
-- 
2.33.0.911.gbe391d4e11

