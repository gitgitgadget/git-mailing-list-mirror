Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF76C1B08C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A60AF6109E
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhGNUCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243695AbhGNUBR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:01:17 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE5C0613E0
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:52:28 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id w1so2758935ilg.10
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yEOmlHVAh/dR1u4oLtYRu4YR6z+zE+VChpVsz7YeIVs=;
        b=DVlG9vqYDls0hzj4wvPFlVEIY/5kWZSp+Lmsug172I7NOt58lbrupiY38wPh71ol1X
         cpTGjr8p47IP7MrTHhNAcrxRDCjUwURDmKExVrlJoUCkR55x7gjCsT5LGQ+bbGr61pUC
         kKDkAPg75tsVuiRYnFznr1uIjtZaKnO3bjZAtPSFa4mzah9KBWs3z6ce7bE90934x9Sx
         ylJipskvdk7b3ftf4VSMHZqCJzNLvuJotoK+ouCWu0ifVkQduLIRcNa/njfpdE4DEopS
         lgoRSgpYH+linHpy44wsN1E85H8o49NZkC/YSMuD8R7+csSr+tE79cbeDhJtAGGUqmYW
         pU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yEOmlHVAh/dR1u4oLtYRu4YR6z+zE+VChpVsz7YeIVs=;
        b=scXefYp9r4RGQb12F9S7jYtUcKqyWwLuo4GbW8QI4fuesMLKhoXN34GUo3hfRvG39u
         dnWrR2prFJeYMXS7E1UyzMVPQEubakt9x/LP6GC6t6GyNZjAyNwgfsThyBvirpSRCpmU
         b9nkTyMi34oNMrJAA0/lKhdnHCzXQHr0NaG2zAnLKdYaqy+BafaTr6srN1wEwJMJP9KS
         S/RnWDrh0IZxI06NJQrFxnHiq3qRmd8wqUmxHfMoPhPzffzx5vmkdpt5nORqQZTrfHKD
         kpgiM25cXPnSGIofiUEqtwy2CslAd2+WaOJXmYf9htT92ZGg8wM314B4tQ0ihHWn+tPZ
         p+pw==
X-Gm-Message-State: AOAM532GT4UozIK1gmv5Y2W4iPwKmYcdiw3RHOsPIDb9+ImMCNg/anCy
        Hg+sQupIezq+xDyXFrImrhWxtA==
X-Google-Smtp-Source: ABdhPJz4MF9oslhWu6Ftr0Mg64ykcqhHxV8euOWJsOCRf3/AmZ8y6FppPF3cdsSYVt6ZUFVXKji//Q==
X-Received: by 2002:a92:a00e:: with SMTP id e14mr7769725ili.126.1626292347665;
        Wed, 14 Jul 2021 12:52:27 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3f15:e25d:cd63:d019])
        by smtp.gmail.com with ESMTPSA id l4sm1653115ilh.41.2021.07.14.12.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:52:27 -0700 (PDT)
Date:   Wed, 14 Jul 2021 15:52:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <ttaylorr@github.com>, Sun Chao <16657101987@163.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
Message-ID: <YO9AeudYPmWRnRNb@nand.local>
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <87wnpt1wwc.fsf@evledraar.gmail.com>
 <YO5RZ0Wix/K5q53Z@nand.local>
 <ACE7ECBE-0D7A-4FB8-B4F9-F9E32BE2234C@163.com>
 <YO8XrOChAtxhpuxS@nand.local>
 <877dhs20x3.fsf@evledraar.gmail.com>
 <YO87ax2JpLndc5Ly@nand.local>
 <87y2a8zntw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2a8zntw.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 09:32:26PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > But if that isn't possible, then I find introducing a new file to
> > redefine the pack's mtime just to accommodate a backup system that
> > doesn't know better to be a poor justification for adding this
> > complexity. Especially since we agree that rsync-ing live Git
> > repositories is a bad idea in the first place ;).
> >
> > If it were me, I would probably stop here and avoid pursuing this
> > further. But an OK middle ground might be core.freshenPackfiles=<bool>
> > to indicate whether or not packs can be freshened, or the objects
> > contained within them should just be rewritten loose.
> >
> > Sun could then set this configuration to "false", implying:
> >
> >   - That they would have more random loose objects, leading to some
> >     redundant work by their backup system.
> >   - But they wouldn't have to resync their huge packfiles.
> >
> > ...and we wouldn't have to introduce any new formats/file types to do
> > it. To me, that seems like a net-positive outcome.
>
> This approach is getting quite close to my core.checkCollisions patch,
> to the point of perhaps being indistinguishable in practice:
> https://lore.kernel.org/git/20181028225023.26427-5-avarab@gmail.com/

Hmm, I'm not sure if I understand. That collision check is only done
during index-pack, and reading builtin/index-pack.c:check_collision(),
it looks like we only do it for large blobs anyway.

> I.e. if you're happy to re-write out duplicate objects then you're going
> to be ignoring the collision check and don't need to do it. It's not the
> same in that you might skip writing objects you know are reachable, and
> with the collisions check off and not-so-thin packs you will/might get
> more redundancy than you asked for.

We may be talking about different things, but if users are concerned
about SHA-1 collisions, then they should still be able to build with
DC_SHA1=YesPlease to catch shattered-style collisions.

Anyway, I think we may be a little in the weeds for what we are trying
to accomplish here. I'm thinking something along the lines of the
following (sans documentation and tests, of course ;)).

--- >8 ---

diff --git a/object-file.c b/object-file.c
index f233b440b2..87c9238365 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1971,9 +1971,22 @@ static int freshen_loose_object(const struct object_id *oid)
 	return check_and_freshen(oid, 1);
 }

+static int can_freshen_packs = -1;
+static int get_can_freshen_packs(void)
+{
+	 if (can_freshen_packs < 0) {
+		if (git_config_get_bool("core.freshenpackfiles",
+					&can_freshen_packs))
+			can_freshen_packs = 1;
+	 }
+	 return can_freshen_packs;
+}
+
 static int freshen_packed_object(const struct object_id *oid)
 {
 	struct pack_entry e;
+	if (!get_can_freshen_packs())
+		return 0;
 	if (!find_pack_entry(the_repository, oid, &e))
 		return 0;
 	if (e.p->freshened)
