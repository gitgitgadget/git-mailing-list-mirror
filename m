Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325471F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 21:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755634AbcHXVRV (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 17:17:21 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35159 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754488AbcHXVRT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 17:17:19 -0400
Received: by mail-yw0-f194.google.com with SMTP id r9so1453936ywg.2
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 14:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=mCXKtylRKbJmt41Tf0IATHiUwcauU5WJZP8Jz+smX6Y=;
        b=brKQkGy8+lBikk+LShPJTn5tq9T3c6+zvq/DzfvjXQKwgiZhlRm5O4x9wC4AikzXJ6
         HowibAMErgjv7uyCzZrtbesWtc+k3sINGNjMhJEULa+KqqvfSwRs1vFcpB7lSbMm5V8d
         Thcd/mw50lEFm5YOh3ccoyrm4oqQjv5GpOYbbf0Kq4BSrcXZrFaDl3gaAkWzKIhIXXB0
         EshG74exhwTAz4Szajxva2iWow4y/4udPBAk1FCZ/am8atzhwEJXESs6XRxszzNmV6pq
         HGK6ca2tIBfPsZeykbiR1ITkjF5BxOpXrWOv0fUkTQv/YQ/JzmbIBC40NLVDMQFOneWA
         bUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=mCXKtylRKbJmt41Tf0IATHiUwcauU5WJZP8Jz+smX6Y=;
        b=hf/Q8ran3CWjPXKlpVZiKtWaHaQ+8KVV6OqBOKRAe4hx5dIx6Ys9+JRqkpGJJNAXkL
         DNir0cZ8gVduRAStJOIkNBOT105Yg8KZnxrPVOGnWJfL4zwwx7IXalIed9rA+iCIOqnG
         1F2m6NIZno9+K0Lydzr9GBI+QBOHfVtJnyWJZ4CMyt+XGMk+yeks++/yGWZKt5Hs6EN9
         jrekMv/251Yeew8dyaFSaWJwQw/eKXc8rFFnwUaCBG+MQcQ1EDkA4iRKkllLXPNdJzFA
         t/as2+y+UnKwDKNz3ZLdBxzDm3DzDT8dS533b4FLVtRvZ8Q3nP/20EbBk+SQOWFpRi0K
         CCZw==
X-Gm-Message-State: AE9vXwOoJh4hGGvqaBKQk+M+m0kwyAxtb8bys5otlF7V+bYsAAS6iY5pRfGBsFJEJW1ODg==
X-Received: by 10.13.218.65 with SMTP id c62mr4679208ywe.134.1472073433346;
        Wed, 24 Aug 2016 14:17:13 -0700 (PDT)
Received: from BenPeartHP ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id l1sm6367655ywc.41.2016.08.24.14.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 14:17:12 -0700 (PDT)
From:   "Ben Peart" <peartben@gmail.com>
To:     "'Duy Nguyen'" <pclouds@gmail.com>,
        "'Git Mailing List'" <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20160711181532.20682-1-pclouds@gmail.com> <CACsJy8AQwRYJZNjXjXr-ioFY-dR9zeeSUk1kxpVwuHDMwB9wLg@mail.gmail.com>
In-Reply-To: <CACsJy8AQwRYJZNjXjXr-ioFY-dR9zeeSUk1kxpVwuHDMwB9wLg@mail.gmail.com>
Subject: RE: [PATCH] Speed up sparse checkout when $GIT_DIR/info/sparse-checkout is unchanged
Date:   Wed, 24 Aug 2016 17:17:11 -0400
Message-ID: <004801d1fe4c$e146d3e0$a3d47ba0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGXjKF3I72kV2ByXWUgDJl+jpDQlwFLLTH2oMMWelA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I didn't apply the patch and test it out but from just a code review, =
the logic behind and the design of this patch makes sense and it's a =
relatively small patch for the gain.  It's also a great example of the =
minimal amount of work required to add a new extension into the index.  =
Thank you for that.

For more extreme cases where there are large numbers of entries in the =
sparse-checkout file, another approach may be more helpful.  Our =
virtualization solution uses sparse checkout extensively.  The =
sparse-checkout file starts out empty and as files are hydrated locally, =
they are added to the sparse-checkout file.  This results in thousands =
of entries in the sparse-checkout file.  =20

To make that fast enough, we ended up creating a hashmap in =
mark_new_skip_worktree and then in clear_ce_flags_1 we use that hashmap =
to implement the pattern matching logic.  The hashmap lookup is =
dramatically faster than the current recursive and complex pattern =
matching via the excludes mechanism so easily supports very large =
numbers of entries. =20

Note, these are extreme test cases that caused the unmodified git.exe to =
crash so I can't really give before/after comparisons:

With 35,000 entries in the sparse-checkout file, "git checkout -b xxx" =
took 42.5 seconds
With 100,000 entries in the sparse-checkout file, "git checkout -b xxx" =
took 42.5 seconds
With 3,279,254 entries in the sparse-checkout file, "git checkout -b =
xxx" took 1 min 38 seconds

Note the first two numbers are the same because the hashmap based =
pattern matching is so fast, 95% of the time is now spent in =
merge_working_tree.  Since the tip commit doesn=E2=80=99t change between =
the new and old branch and because a merge is done, the files in the =
working directory don=E2=80=99t change either so I believe there must be =
an optimization there but I haven't been able to figure one out that =
doesn't break a lot of other things. =20

Ben

p.s.  Yes, I actually ran "git ls-files > .git/info/sparse-checkout" to =
test the extreme case. :)

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On =
Behalf Of Duy Nguyen
Sent: Saturday, August 13, 2016 4:37 AM
To: Git Mailing List <git@vger.kernel.org>; Junio C Hamano =
<gitster@pobox.com>
Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Speed up sparse checkout when =
$GIT_DIR/info/sparse-checkout is unchanged

Ping..

On Tue, Jul 12, 2016 at 1:15 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> When a "tree unpacking" operation is needed, which is part of=20
> switching branches using "git checkout", the following happens in a=20
> sparse checkout:
>
> 1) Run all existing entries through $GIT_DIR/info/sparse-checkout,
>    mark entries that are to-be-excluded or to-be-included.
>
> 2) Do n-way merge stuff to add, modify and delete entries.
>
> 3) Run all new entries added at step 2 through
>    $GIT_DIR/info/sparse-checkout, mark entries that are to-be-excluded
>    or to-be-included.
>
> 4) Compare the current excluded/include status with the to-be-status
>    from steps 1 and 3, delete newly excluded entries from worktree and
>    add newly included ones to worktree.
>
> The "all existing entries" number in step 1 does not scale well. As=20
> worktree gets bigger (or more sparse patterns are added), step 1 runs=20
> slower. Which does not help because large worktrees are the reason=20
> sparse-checkout is used, to keep the real worktree small again.
>
> If we know that $GIT_DIR/info/sparse-checkout has not changed, we know =

> that running checking again would result in the exact same=20
> included/excluded as recorded in the current index because=20
> "sparse-checkout" is the only input to the exclude machinery. In this=20
> case, marking the to-be-status is simply copying the current status=20
> over, which is a lot faster.
>
> The time breakdown of "git checkout" (no arguments) on webkit.git=20
> (100k files) with a sparse checkout file of 4 negative patterns is=20
> like this, where "sparse checkout loop #1" takes about 10% execution=20
> time, which is the time saved after this patch.
>
> read-cache.c:1661       performance: 0.057816104 s: read cache =
.git/index
> files-backend.c:1097    performance: 0.000023980 s: read packed refs
> preload-index.c:104     performance: 0.039178367 s: preload index
> read-cache.c:1260       performance: 0.002700730 s: refresh index
> name-hash.c:128         performance: 0.030409968 s: initialize name =
hash
>
> unpack-trees.c:1173     performance: 0.100353572 s: sparse checkout =
loop #1
>
> cache-tree.c:431        performance: 0.137213472 s: cache_tree_update
> unpack-trees.c:1305     performance: 0.648923590 s: unpack_trees
> read-cache.c:2139       performance: 0.074800165 s: write index, =
changed mask =3D 28
> unpack-trees.c:1305     performance: 0.137108835 s: unpack_trees
> diff-lib.c:506          performance: 0.137152238 s: diff-index
> trace.c:420             performance: 0.972682413 s: git command: 'git' =
'checkout'
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com>
> ---
>  I mentioned about this some time ago and finally got curious enough =20
> to try out. The saving is in the signficant range in my opinion, but =20
> real world effect is probably lower (or much higher if you have so =20
> many patterns in $GIT_DIR/info/sparse-checkout)
>
>  Note that both cache_tree_update and sparse checkout loop #1 are part =
=20
> of unpack_trees() so actual time spent on this function is more like =20
> 0.4s. It's still a lot, but then this function is very scary to =20
> optimize.
>
>  Documentation/technical/index-format.txt |  6 +++++
>  cache.h                                  |  2 ++
>  read-cache.c                             | 22 ++++++++++++++++-
>  unpack-trees.c                           | 42 =
++++++++++++++++++++++++++++++--
>  4 files changed, 69 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/technical/index-format.txt=20
> b/Documentation/technical/index-format.txt
> index ade0b0c..3b0770a 100644
> --- a/Documentation/technical/index-format.txt
> +++ b/Documentation/technical/index-format.txt
> @@ -295,3 +295,9 @@ The remaining data of each directory block is =
grouped by type:
>      in the previous ewah bitmap.
>
>    - One NUL.
> +
> +=3D=3D Sparse checkout cache
> +
> +  Sparse checkout extension saves the 20 bytes SHA-1 hash of =20
> + $GIT_DIR/info/sparse-checkout at the time it is applied to the =20
> + index.
> diff --git a/cache.h b/cache.h
> index f1dc289..cc4c2b1 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -320,6 +320,7 @@ static inline unsigned int canon_mode(unsigned int =
mode)
>  #define CACHE_TREE_CHANGED     (1 << 5)
>  #define SPLIT_INDEX_ORDERED    (1 << 6)
>  #define UNTRACKED_CHANGED      (1 << 7)
> +#define SPARSE_CHECKOUT_CHANGED        (1 << 8)
>
>  struct split_index;
>  struct untracked_cache;
> @@ -338,6 +339,7 @@ struct index_state {
>         struct hashmap dir_hash;
>         unsigned char sha1[20];
>         struct untracked_cache *untracked;
> +       unsigned char sparse_checkout[20];
>  };
>
>  extern struct index_state the_index;
> diff --git a/read-cache.c b/read-cache.c index db27766..371d2c7 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -40,11 +40,13 @@ static struct cache_entry=20
> *refresh_cache_entry(struct cache_entry *ce,  #define =
CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
>  #define CACHE_EXT_LINK 0x6c696e6b        /* "link" */
>  #define CACHE_EXT_UNTRACKED 0x554E5452   /* "UNTR" */
> +#define CACHE_EXT_SPARSE 0x5350434F      /* "SPCO" */
>
>  /* changes that can be kept in $GIT_DIR/index (basically all=20
> extensions) */  #define EXTMASK (RESOLVE_UNDO_CHANGED | =
CACHE_TREE_CHANGED | \
>                  CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED =
| \
> -                SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED)
> +                SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED | \
> +                SPARSE_CHECKOUT_CHANGED)
>
>  struct index_state the_index;
>  static const char *alternate_index_output; @@ -1384,6 +1386,11 @@=20
> static int read_index_extension(struct index_state *istate,
>         case CACHE_EXT_UNTRACKED:
>                 istate->untracked =3D read_untracked_extension(data, =
sz);
>                 break;
> +       case CACHE_EXT_SPARSE:
> +               if (sz !=3D sizeof(istate->sparse_checkout))
> +                       return error("bad %.4s extension", ext);
> +               hashcpy(istate->sparse_checkout, data);
> +               break;
>         default:
>                 if (*ext < 'A' || 'Z' < *ext)
>                         return error("index uses %.4s extension, which =

> we do not understand", @@ -1704,6 +1711,7 @@ int discard_index(struct =
index_state *istate)
>         discard_split_index(istate);
>         free_untracked_cache(istate->untracked);
>         istate->untracked =3D NULL;
> +       hashclr(&istate->sparse_checkout);
>         return 0;
>  }
>
> @@ -2101,6 +2109,18 @@ static int do_write_index(struct index_state =
*istate, int newfd,
>                 if (err)
>                         return -1;
>         }
> +       if (!strip_extensions && =
!is_null_sha1(istate->sparse_checkout)) {
> +               struct strbuf sb =3D STRBUF_INIT;
> +
> +               strbuf_add(&sb, istate->sparse_checkout,
> +                          sizeof(istate->sparse_checkout));
> +               err =3D write_index_ext_header(&c, newfd, =
CACHE_EXT_SPARSE,
> +                                            sb.len) < 0 ||
> +                       ce_write(&c, newfd, sb.buf, sb.len) < 0;
> +               strbuf_release(&sb);
> +               if (err)
> +                       return -1;
> +       }
>
>         if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
>                 return -1;
> diff --git a/unpack-trees.c b/unpack-trees.c index 6bc9512..f3916a9=20
> 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1080,6 +1080,25 @@ static void mark_new_skip_worktree(struct =
exclude_list *el,
>                        select_flag, skip_wt_flag, el);  }
>
> +static void get_sparse_checkout_hash(unsigned char *sha1) {
> +       struct stat st;
> +       int fd;
> +
> +       hashclr(sha1);
> +       fd =3D open(git_path("info/sparse-checkout"), O_RDONLY);
> +       if (fd =3D=3D -1)
> +               return;
> +       if (fstat(fd, &st)) {
> +               close(fd);
> +               return;
> +       }
> +       if (index_fd(sha1, fd, &st, OBJ_BLOB,
> +                    git_path("info/sparse-checkout"), 0) < 0)
> +               hashclr(sha1);
> +       close(fd);
> +}
> +
>  static int verify_absent(const struct cache_entry *,
>                          enum unpack_trees_error_types,
>                          struct unpack_trees_options *); @@ -1094,6=20
> +1113,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct =
unpack_trees_options
>         int i, ret;
>         static struct cache_entry *dfc;
>         struct exclude_list el;
> +       unsigned char sparse_checkout_hash[20];
>
>         if (len > MAX_UNPACK_TREES)
>                 die("unpack_trees takes at most %d trees",=20
> MAX_UNPACK_TREES); @@ -1131,8 +1151,21 @@ int unpack_trees(unsigned =
len, struct tree_desc *t, struct unpack_trees_options
>         /*
>          * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing =
entries
>          */
> -       if (!o->skip_sparse_checkout)
> -               mark_new_skip_worktree(o->el, o->src_index, 0, =
CE_NEW_SKIP_WORKTREE);
> +       if (!o->skip_sparse_checkout) {
> +               get_sparse_checkout_hash(sparse_checkout_hash);
> +
> +               if (!is_null_sha1(sparse_checkout_hash) &&
> +                   !hashcmp(o->src_index->sparse_checkout, =
sparse_checkout_hash)) {
> +                       struct index_state *istate =3D o->src_index;
> +                       for (i =3D 0; i < istate->cache_nr; i++) {
> +                               struct cache_entry *ce =3D =
istate->cache[i];
> +                               if (ce_skip_worktree(ce))
> +                                       ce->ce_flags |=3D =
CE_NEW_SKIP_WORKTREE;
> +                       }
> +               } else
> +                       mark_new_skip_worktree(o->el, o->src_index,
> +                                              0, =
CE_NEW_SKIP_WORKTREE);
> +       }
>
>         if (!dfc)
>                 dfc =3D xcalloc(1, cache_entry_size(0)); @@ -1236,6=20
> +1269,11 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct =
unpack_trees_options
>                         ret =3D unpack_failed(o, "Sparse checkout =
leaves no entry on working directory");
>                         goto done;
>                 }
> +
> +               if (o->dst_index && =
!is_null_sha1(sparse_checkout_hash)) {
> +                       hashcpy(o->result.sparse_checkout, =
sparse_checkout_hash);
> +                       o->result.cache_changed |=3D =
SPARSE_CHECKOUT_CHANGED;
> +               }
>         }
>
>         o->src_index =3D NULL;
> --
> 2.8.2.537.g0965dd9
>



--
Duy
--
To unsubscribe from this list: send the line "unsubscribe git" in the =
body of a message to majordomo@vger.kernel.org More majordomo info at  =
http://vger.kernel.org/majordomo-info.html

