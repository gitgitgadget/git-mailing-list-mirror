Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0DCC47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABDE613BD
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhEZXfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 19:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhEZXff (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 19:35:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC937C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:34:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j10so3514206edw.8
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=GCrJE90FqRTrlTQKtMqRg1k0s9kYnVxd8BspSxNWxXg=;
        b=bYO2gqxyJgox9DK1NRNc6foZVwC/LL+MUV739Vn9s5xV2gn8RSKvrCuiHgT6mbn+AR
         1kLx4uLw6/FBOqXzGH10Q4Htg/qnW+dj3Nm7A3fU5rFwvp5FS4K2aY6bfS7JabQ88Goq
         Fe+bewIYxgym51Q40gYSgycOGCIqLH+kLNOOAkyHDW//he+9Q0HlPc7Fh4H5Ut5Rxd19
         MG7aQqDC4xzaXAcOlo4mfUhwcYdvd7NtBFngZq3A2A9QqWeQ4BwR/nfK9MwQqocRCM5z
         SyHz2f9WuwBL8ltblO+LpfMpwn+MkcSHiZqAJFx46Aw/YuDu8lR2MvO9WlJFGP7pnQFa
         YPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=GCrJE90FqRTrlTQKtMqRg1k0s9kYnVxd8BspSxNWxXg=;
        b=sSVFKs/F7f8JxIigRGAOdTwwOeMEf3FMq05e24qDV3Vy1Oy8br0Nj1Kgs9B6t5mI8l
         PVQvHimm3b43WPomlnc2jf54p01OETH6qhRmkjHkerFq+QDbgr3Mtu8uDSDQ7tWiTnKS
         9brqH7VsFt+u2FsQbnP+yDBTYcTuPNIf78j68CgnjqANVO6DL2vydrdSDImx7wupPhw9
         jv8xEULnMyN3ELDFWg8emtrGAfA+i4hzqeuNIyHBjiiYt6fU7DbFnLW5LiNoSdP8ll/w
         dYCfnK5T5Cy/8pUg6GqzDRa26O0MV+33m+0bojtfxxJlEvCP849VLa1UDALvHE8sSiFj
         bVcw==
X-Gm-Message-State: AOAM533X/FC9ChKFeCRcki/u6BgK2Bi5/BbXZC435zs1OWgBvcbJhY5E
        zXTS2kklgUGSIOEQ248GOO4=
X-Google-Smtp-Source: ABdhPJy+t53QmFpOQkHS8p2re7oPFQOllFmUzD27HvjTLx6T3cFsw5I23d9zB48xJFqBvX24KQmbpg==
X-Received: by 2002:a05:6402:1ac7:: with SMTP id ba7mr749314edb.299.1622072041404;
        Wed, 26 May 2021 16:34:01 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d11sm147490ede.74.2021.05.26.16.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 16:34:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: SunCC doesn't compile v2.32.0-rc* anymore (was "Re: [PATCH 2/3]
 t/helper/test-bitmap.c: initial commit")
Date:   Wed, 26 May 2021 23:10:23 +0200
References: <cover.1617240723.git.me@ttaylorr.com>
 <ec974bb0c85bcde00d45e983d701c538488550a6.1617240723.git.me@ttaylorr.com>
 <87h7ipmjkw.fsf@evledraar.gmail.com> <YK6W+q1BhC1ZiB6H@nand.local>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YK6W+q1BhC1ZiB6H@nand.local>
Message-ID: <878s41m5nc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 26 2021, Taylor Blau wrote:

> On Wed, May 26, 2021 at 08:30:49PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Wed, Mar 31 2021, Taylor Blau wrote:
>>
>> > Add a new 'bitmap' test-tool which can be used to list the commits that
>> > have received bitmaps.
>> > [...]
>> > @@ -0,0 +1,24 @@
>> > +#include "test-tool.h"
>> > +#include "cache.h"
>> > +#include "pack-bitmap.h"
>>
>> Since this commit SunCC (on Solaris) refuses to compile git, a new bug
>> in v2.32.0-rc*.
>>
>> It's because it can't find the oe_get_size_slow symbol, you include
>> pack-bitmap.h, which in turn includes pack-objects.h. That file
>> references oe_get_size_slow, but it's only defined in
>> builtin/pack-objects.c.
>
> I'm not sure I understand. pack-objects.h has a declaration of that
> method, but the implementation is in builtin/pack-objects.c. That should
> be fine, but I don't know about how SunCC works.
>
> What needs to be changed here?

I think that oe_get_size_slow needs to be in libgit as long as
pack-objects.h defines other (inline) functions that reference it, or
maybe most of that stuff can just be moved to builtin/pack-objects.h?

This obviously not OK patch makes things "ok" again under SunCC:
=20=20=20=20
    diff --git a/Makefile b/Makefile
    index c3565fc0f8f..c2b05aeddac 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -1186,7 +1186,7 @@ THIRD_PARTY_SOURCES +=3D compat/regex/%
     THIRD_PARTY_SOURCES +=3D sha1collisiondetection/%
     THIRD_PARTY_SOURCES +=3D sha1dc/%
=20=20=20=20
    -GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB)
    +GITLIBS =3D builtin/pack-objects.o common-main.o $(LIB_FILE) $(XDIFF_L=
IB)
     EXTLIBS =3D
=20=20=20=20
     GIT_USER_AGENT =3D git/$(GIT_VERSION)

I.e. the problem is that in the final program we're linking there's
references to this function we can't find:
=20=20=20=20
    Undefined                       first referenced
     symbol                             in file
    oe_get_size_slow                    t/helper/test-bitmap.o
    ld: fatal: symbol referencing errors. No output written to t/helper/tes=
t-tool

I think e.g. the GNU toolchain and others are probably OK with it
because they do some analysis to figure out that none of those inline
functions that need oe_get_size_slow are themselves needed. SunCC (or
Solaris's) linker seems to be more eager.

It seems to me that the best way to solve this is something like the
below code-move-only patch of just moving this stuff only used by
builtin/pack-objects.c to that file. This also fixes the build on
Solaris.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6ded130e45b..70072b07b6b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -37,6 +37,100 @@
 #include "shallow.h"
 #include "promisor-remote.h"
=20
+/*
+ * Objects we are going to pack are collected in the `to_pack` structure.
+ * It contains an array (dynamically expanded) of the object data, and a m=
ap
+ * that can resolve SHA1s to their position in the array.
+ */
+static struct packing_data to_pack;
+
+/*
+ * Return the size of the object without doing any delta
+ * reconstruction (so non-deltas are true object sizes, but deltas
+ * return the size of the delta data).
+ */
+unsigned long oe_get_size_slow(struct packing_data *pack,
+			       const struct object_entry *e);
+unsigned long oe_get_size_slow(struct packing_data *pack,
+			       const struct object_entry *e)
+{
+	struct packed_git *p;
+	struct pack_window *w_curs;
+	unsigned char *buf;
+	enum object_type type;
+	unsigned long used, avail, size;
+
+	if (e->type_ !=3D OBJ_OFS_DELTA && e->type_ !=3D OBJ_REF_DELTA) {
+		packing_data_lock(&to_pack);
+		if (oid_object_info(the_repository, &e->idx.oid, &size) < 0)
+			die(_("unable to get size of %s"),
+			    oid_to_hex(&e->idx.oid));
+		packing_data_unlock(&to_pack);
+		return size;
+	}
+
+	p =3D oe_in_pack(pack, e);
+	if (!p)
+		BUG("when e->type is a delta, it must belong to a pack");
+
+	packing_data_lock(&to_pack);
+	w_curs =3D NULL;
+	buf =3D use_pack(p, &w_curs, e->in_pack_offset, &avail);
+	used =3D unpack_object_header_buffer(buf, avail, &type, &size);
+	if (used =3D=3D 0)
+		die(_("unable to parse object header of %s"),
+		    oid_to_hex(&e->idx.oid));
+
+	unuse_pack(&w_curs);
+	packing_data_unlock(&to_pack);
+	return size;
+}
+
+static inline unsigned long oe_size(struct packing_data *pack,
+				    const struct object_entry *e)
+{
+	if (e->size_valid)
+		return e->size_;
+
+	return oe_get_size_slow(pack, e);
+}
+
+static inline int oe_size_less_than(struct packing_data *pack,
+				    const struct object_entry *lhs,
+				    unsigned long rhs)
+{
+	if (lhs->size_valid)
+		return lhs->size_ < rhs;
+	if (rhs < pack->oe_size_limit) /* rhs < 2^x <=3D lhs ? */
+		return 0;
+	return oe_get_size_slow(pack, lhs) < rhs;
+}
+
+static inline int oe_size_greater_than(struct packing_data *pack,
+				       const struct object_entry *lhs,
+				       unsigned long rhs)
+{
+	if (lhs->size_valid)
+		return lhs->size_ > rhs;
+	if (rhs < pack->oe_size_limit) /* rhs < 2^x <=3D lhs ? */
+		return 1;
+	return oe_get_size_slow(pack, lhs) > rhs;
+}
+
+static inline void oe_set_size(struct packing_data *pack,
+			       struct object_entry *e,
+			       unsigned long size)
+{
+	if (size < pack->oe_size_limit) {
+		e->size_ =3D size;
+		e->size_valid =3D 1;
+	} else {
+		e->size_valid =3D 0;
+		if (oe_get_size_slow(pack, e) !=3D size)
+			BUG("'size' is supposed to be the object size!");
+	}
+}
+
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
 #define SET_SIZE(obj,size) oe_set_size(&to_pack, obj, size)
@@ -56,13 +150,6 @@ static const char *pack_usage[] =3D {
 	NULL
 };
=20
-/*
- * Objects we are going to pack are collected in the `to_pack` structure.
- * It contains an array (dynamically expanded) of the object data, and a m=
ap
- * that can resolve SHA1s to their position in the array.
- */
-static struct packing_data to_pack;
-
 static struct pack_idx_entry **written_list;
 static uint32_t nr_result, nr_written, nr_seen;
 static struct bitmap_index *bitmap_git;
@@ -2231,46 +2318,6 @@ static pthread_mutex_t progress_mutex;
  * progress_mutex for protection.
  */
=20
-/*
- * Return the size of the object without doing any delta
- * reconstruction (so non-deltas are true object sizes, but deltas
- * return the size of the delta data).
- */
-unsigned long oe_get_size_slow(struct packing_data *pack,
-			       const struct object_entry *e)
-{
-	struct packed_git *p;
-	struct pack_window *w_curs;
-	unsigned char *buf;
-	enum object_type type;
-	unsigned long used, avail, size;
-
-	if (e->type_ !=3D OBJ_OFS_DELTA && e->type_ !=3D OBJ_REF_DELTA) {
-		packing_data_lock(&to_pack);
-		if (oid_object_info(the_repository, &e->idx.oid, &size) < 0)
-			die(_("unable to get size of %s"),
-			    oid_to_hex(&e->idx.oid));
-		packing_data_unlock(&to_pack);
-		return size;
-	}
-
-	p =3D oe_in_pack(pack, e);
-	if (!p)
-		BUG("when e->type is a delta, it must belong to a pack");
-
-	packing_data_lock(&to_pack);
-	w_curs =3D NULL;
-	buf =3D use_pack(p, &w_curs, e->in_pack_offset, &avail);
-	used =3D unpack_object_header_buffer(buf, avail, &type, &size);
-	if (used =3D=3D 0)
-		die(_("unable to parse object header of %s"),
-		    oid_to_hex(&e->idx.oid));
-
-	unuse_pack(&w_curs);
-	packing_data_unlock(&to_pack);
-	return size;
-}
-
 static int try_delta(struct unpacked *trg, struct unpacked *src,
 		     unsigned max_depth, unsigned long *mem_usage)
 {
diff --git a/pack-objects.h b/pack-objects.h
index 9d88e3e518f..0c4d5d475f6 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -332,52 +332,6 @@ static inline void oe_set_delta_sibling(struct packing=
_data *pack,
 		e->delta_sibling_idx =3D 0;
 }
=20
-unsigned long oe_get_size_slow(struct packing_data *pack,
-			       const struct object_entry *e);
-static inline unsigned long oe_size(struct packing_data *pack,
-				    const struct object_entry *e)
-{
-	if (e->size_valid)
-		return e->size_;
-
-	return oe_get_size_slow(pack, e);
-}
-
-static inline int oe_size_less_than(struct packing_data *pack,
-				    const struct object_entry *lhs,
-				    unsigned long rhs)
-{
-	if (lhs->size_valid)
-		return lhs->size_ < rhs;
-	if (rhs < pack->oe_size_limit) /* rhs < 2^x <=3D lhs ? */
-		return 0;
-	return oe_get_size_slow(pack, lhs) < rhs;
-}
-
-static inline int oe_size_greater_than(struct packing_data *pack,
-				       const struct object_entry *lhs,
-				       unsigned long rhs)
-{
-	if (lhs->size_valid)
-		return lhs->size_ > rhs;
-	if (rhs < pack->oe_size_limit) /* rhs < 2^x <=3D lhs ? */
-		return 1;
-	return oe_get_size_slow(pack, lhs) > rhs;
-}
-
-static inline void oe_set_size(struct packing_data *pack,
-			       struct object_entry *e,
-			       unsigned long size)
-{
-	if (size < pack->oe_size_limit) {
-		e->size_ =3D size;
-		e->size_valid =3D 1;
-	} else {
-		e->size_valid =3D 0;
-		if (oe_get_size_slow(pack, e) !=3D size)
-			BUG("'size' is supposed to be the object size!");
-	}
-}
=20
 static inline unsigned long oe_delta_size(struct packing_data *pack,
 					  const struct object_entry *e)

