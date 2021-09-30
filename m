Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7813BC433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5725960EFD
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351846AbhI3OS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351840AbhI3OS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 10:18:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18E2C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:16:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dj4so23423865edb.5
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=e0UGh2vI+UNc9aZAlQ2o1RkFquXuLjPrBwpLe1BGOsM=;
        b=a7DpPNOszrWeJk0R/KJCn2ysTXHUDJUGfhWeWLlwOSZgUaIodqjGdiDa/c+eLBP/Jz
         v6ibEc2LjVkjLKeMGrTkkHQYCvrugFkWBnlbrUWAZ4by7w6iTQ1gic2vGsl4nSJVE6ka
         0KxVPZhn0RJH4vpXE4rQYG3gbRWAAw+tCBbclR36tRewS4PArP5mySHc2D4RrzwlzG7b
         0psGypQWJIJvn7sAnxTn0jlDWbP+6uFUs6hdvnVY7RT6sTFT55PYweJpEBJRbEZypMaX
         zeIcqdizpK1x09+gCACcQ9YtQaLjk1n3bWu+Y+FHpzSNlEAIFSawTyaJO5/aGw4DJEkS
         ufRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=e0UGh2vI+UNc9aZAlQ2o1RkFquXuLjPrBwpLe1BGOsM=;
        b=ucXXdgGKQ2EHvUzGTHFz/MRZmpJYd9UcTEJbRO7VA3tkNhK5wtqISSLobnfEVlRkWf
         pdBEG+yBttquqpBBjEqXSCRIH0r4yM+tmNzUVg0r15r4WotXBxSt+XAG5Ess6fhAyRZ/
         z2mWNnwHpfTiUbfUladeUZxP0s4n+9zPBeHUPOuKlhcfBrGW0TflBxqpbSARXwvW9Wgx
         dawuNBcv/w9EVp6rdh4JcAfV7lBLz9HTfjJVgNNoyOPOOZnOUIgw0Y+eQbZYluA2n6HM
         4CXUcozg+Dsk9N0gUSoPN7X9GaEhY5uNqUy8YyH9cUkqp7WFixzsnUiZO09XMW295a1s
         sRLg==
X-Gm-Message-State: AOAM531f5qy6og/JIY9OTSZLmuZRMGNQT70avE0t6aGkXWmh0M+UPXWn
        ZAPd3ca+v6ktV2ej789fxhVFeKRyaATBIyk6
X-Google-Smtp-Source: ABdhPJzsh33vyrWi6Q4z2/+xl9JurWGQJzcZGCETJ75mBlGJgOzD712EHYXPkG7BGe3p5te1Jjx28g==
X-Received: by 2002:a17:906:e82:: with SMTP id p2mr6915709ejf.50.1633011335742;
        Thu, 30 Sep 2021 07:15:35 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p21sm1454364ejm.88.2021.09.30.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:15:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 04/11] unpack-trees: introduce preserve_ignored to
 unpack_trees_options
Date:   Thu, 30 Sep 2021 16:04:58 +0200
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
 <f1a0700e598e52d6cdb507fe8a09c4fa9291c982.1632760428.git.gitgitgadget@gmail.com>
 <87ilyjviiy.fsf@evledraar.gmail.com>
 <CABPp-BEnGfxqKpqXGKopXFBBshY0tuimQLtwt58wKf9CJS8n5g@mail.gmail.com>
 <87ee97utaq.fsf@evledraar.gmail.com>
 <CABPp-BEEWPF6oBN69PH_GtmqqvAj1HMtDX5ipQxa2bLzyCCu0g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BEEWPF6oBN69PH_GtmqqvAj1HMtDX5ipQxa2bLzyCCu0g@mail.gmail.com>
Message-ID: <87lf3etaih.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 29 2021, Elijah Newren wrote:

> On Wed, Sep 29, 2021 at 11:32 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Wed, Sep 29 2021, Elijah Newren wrote:
>>
>> > On Wed, Sep 29, 2021 at 2:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> > <avarab@gmail.com> wrote:
>> >>
> ...
>> >>
>> >> I think getting rid of the boilerplate makes sense, but it doesn't so=
und
>> >> from the commit message like you've considered just making that "stru=
ct
>> >> dir*" member a "struct dir" instead.
>> >>
>> >> That simplifies things a lot, i.e. we can just DIR_INIT it, and don't
>> >> need every caller to malloc/free it.
>> >
>> > See the next patch in the series.  :-)
>>
>> Ah!
>>
>> >> Sometimes a pointer makes sense, but in this case the "struct
>> >> unpack_trees_options" can just own it.
>> >
>> > I did make it internal to unpack_trees_options in the next patch, but
>> > kept it as a pointer just because that let me know whether it was used
>> > or not.  I guess I could have added a boolean as well.  But I don't
>> > actually allocate anything, because it's either a NULL pointer, or a
>> > pointer to something on the stack.  So, I do get to just use DIR_INIT.
>>
>> I think I'm probably missing something. I just made it allocated on the
>> stack by the caller using "struct unpack_trees_options", but then you
>> end up having a dir* in the struct, but that's only filled in as a
>> pointer to the stack variable? Maybe there's some subtlety I'm missing
>> here...
>
> As per the next patch:
>
> int unpack_trees(..., struct unpack_trees_options *o)
> {
>     struct dir_struct dir =3D DIR_INIT;
>     ...
>     if (!o->preserve_ignored) {
>         /* Setup 'dir', make o->dir point to it */
>         ....
>         o->dir =3D &dir;
>     }
>     ...
>     if (o->dir)
>         /* cleanup */
>     ....
> }
>
> The caller doesn't touch o->dir (other than initializing it to zeros);
> unpack_trees() is wholly responsible for it.  I'd kind of like to
> entirely remove dir from unpack_trees_options(), but I need a way of
> passing it down through all the other functions in unpack-trees.c, and
> leaving it in unpack_trees_options seems the easiest way to do so.  So
> I just marked it as "for internal use only".

I think I understand *how* it works, I'm puzzled by why you went for
this whole level of indirection when you're using a struct on the stack
in the end anyway, just ... put that in "struct unpack_trees_options"?

Anyway, I see I have only myself to blame here, as you added these leak
fixes in the v2 in response to some of my offhand comments.

FWIW I then went on to do some deeper fixes not just on these leaks but
the surrounding leaks, which will be blocked by 2/11 & 05/11 of this
topic for a while. I suppose I only have myself to blame :)

Below is a patch-on-top that I think makes this whole thing much simpler
by doing away with the pointer entirely.

I suppose this is also a partial reply to
https://lore.kernel.org/git/CABPp-BG_qigBoirMGR-Yk9Niyxt0UmYCEqojsYxbSEarLA=
mraA@mail.gmail.com/;
but I quite dislike this pattern of including a pointer like this where
it's not needed just for the practicalities of memory management.

I.e. here you use DIR_INIT. In my local patches to fix up the wider
memory leaks in this area I've got DIR_INIT also using a STRBUF_INIT,
and DIR_INIT will in turn be referenced by a
UNPACK_TREES_OPTIONS_INIT. It's quite nice if you're having to
initialize with "UNPACK_TREES_OPTIONS_INIT" have that initialization
work all the way down the chain, and not need e.g. a manual
strbuf_init(), dir_init() etc.

I removed the dir_init() in ce93a4c6127 (dir.[ch]: replace dir_init()
with DIR_INIT, 2021-07-01), but would probably need to bring it back, of
course you need some "release()" method for the
UNPACK_TREES_OPTIONS_INIT, which in turn needs to call the dir_release()
(well, "dir_clear()" in that case), and it needs to call
"strbuf_release()". It's just nicer if that boilerplate is all on
destruction, but not also on struct/object setup.

We do need that setup in some cases (although a lot could just be
replaced by lazy initialization), but if we don't....

diff --git a/unpack-trees.c b/unpack-trees.c
index a7e1712d236..de5cc6cd025 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1694,15 +1694,12 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
 	int free_pattern_list =3D 0;
-	struct dir_struct dir =3D DIR_INIT;
=20
 	if (o->reset =3D=3D UNPACK_RESET_INVALID)
 		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
=20
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
-	if (o->dir)
-		BUG("o->dir is for internal use only");
=20
 	trace_performance_enter();
 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
@@ -1718,9 +1715,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, s=
truct unpack_trees_options
 		BUG("UNPACK_RESET_OVERWRITE_UNTRACKED incompatible with preserved ignore=
d files");
=20
 	if (!o->preserve_ignored) {
-		o->dir =3D &dir;
-		o->dir->flags |=3D DIR_SHOW_IGNORED;
-		setup_standard_excludes(o->dir);
+		o->dir.flags |=3D DIR_SHOW_IGNORED;
+		setup_standard_excludes(&o->dir);
 	}
=20
 	if (!core_apply_sparse_checkout || !o->update)
@@ -1884,10 +1880,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, =
struct unpack_trees_options
 done:
 	if (free_pattern_list)
 		clear_pattern_list(&pl);
-	if (o->dir) {
-		dir_clear(o->dir);
-		o->dir =3D NULL;
-	}
+	dir_clear(&o->dir);
 	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
 	trace_performance_leave("unpack_trees");
 	return ret;
@@ -2153,8 +2146,7 @@ static int verify_clean_subdirectory(const struct cac=
he_entry *ce,
 	pathbuf =3D xstrfmt("%.*s/", namelen, ce->name);
=20
 	memset(&d, 0, sizeof(d));
-	if (o->dir)
-		d.exclude_per_dir =3D o->dir->exclude_per_dir;
+	d.exclude_per_dir =3D o->dir.exclude_per_dir;
 	i =3D read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
 	if (i)
 		return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
@@ -2201,8 +2193,7 @@ static int check_ok_to_remove(const char *name, int l=
en, int dtype,
 	if (ignore_case && icase_exists(o, name, len, st))
 		return 0;
=20
-	if (o->dir &&
-	    is_excluded(o->dir, o->src_index, name, &dtype))
+	if (is_excluded(&o->dir, o->src_index, name, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
diff --git a/unpack-trees.h b/unpack-trees.h
index 71ffb7eeb0c..a8afbb20170 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -5,6 +5,7 @@
 #include "strvec.h"
 #include "string-list.h"
 #include "tree-walk.h"
+#include "dir.h"
=20
 #define MAX_UNPACK_TREES MAX_TRAVERSE_TREES
=20
@@ -95,7 +96,7 @@ struct unpack_trees_options {
 	struct index_state result;
=20
 	struct pattern_list *pl; /* for internal use */
-	struct dir_struct *dir; /* for internal use only */
+	struct dir_struct dir; /* for internal use only */
 	struct checkout_metadata meta;
 };
=20
