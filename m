Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8992C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 08:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C19611C9
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 08:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhDKIRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 04:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhDKIRi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 04:17:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF913C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 01:17:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w8so7871837lfr.0
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 01:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsaJz93Dq15uFXFEETDuWQHfgPsuQXj/YwcrMTdDRfg=;
        b=YaMFnVM/Iq8c9Jjnx/t1kiExuHrdVk7kaG8MgpNNNZTI7WI18+Sqz+IsCvOHGKPZM5
         0ggmHyxc9RJdanpUYL35+dSw9rnQWRdKRMwx8ySG35U8VTrEKkTYOC2rrcMmTGLNLvbJ
         OmQSf4iwKcpKdtZ5F2EUwjBAy+vctaFoNoC1k03Ui11S68goQTjYVjUAD1UUHtp0UIOG
         lbefvo8NX43EvAMe1QT015xkS0sSqINzzVX5+zsWAuvWriZHJPh4w5QeFG1Spc0lguIa
         uaCSg5In0Zwvwhvy57yzIlucezwGCA6cUJ3fHQA6QUpMUaKPrjgvTnevVN7Ta1gxEeRb
         jRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsaJz93Dq15uFXFEETDuWQHfgPsuQXj/YwcrMTdDRfg=;
        b=K+Mq9bMqsFTYXqEqmGxid6sjBurMTwTh8NmaG3aDtonytto/smbCBmUwh4c9UWrjOj
         VscygooEMgDvTCCnmHWudfHxkRkpfhoU3ggijgC9GxG7mMPsLzSrOXKftcqZgCCkZIhE
         MUBWR9PxJIvBINmdQ+I9JCm3wu1h64i7h8UEzjv79EdLgoWlKxVGStWObQAGcCvafnol
         SDndWWyMbU5P5TqyELPA2w/MfVGPl0QXl4CtsRCzn6wmA0uSp9ThHz/xjxl40+nrJKmq
         e1C/Dj2U/IXjrKKDtA4L0uvoeIYV58e3o2ZjjyCZDQXqhxKsTxC7sde6ujiGKC0GkpxL
         id6A==
X-Gm-Message-State: AOAM532C+hq5vMxCK1VAcFOWfS5VSJJvGliTVKiL7kc2yZARyc9Lb+UI
        btyd0w107CC0XGtIEx1MbdGjZb3cJLDl6omb9aK1i11Z
X-Google-Smtp-Source: ABdhPJyanzBniSA7CgtBly5do/Xz/NL0jr+3VEbAj810y2KyP5Dd9uUAhErBNaLAs+MrMouk2V1pEPtdZ5iXJxcmFwg=
X-Received: by 2002:a05:6512:3e02:: with SMTP id i2mr15257227lfv.357.1618129041059;
 Sun, 11 Apr 2021 01:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net> <20210410152140.3525040-9-sandals@crustytoothpaste.net>
In-Reply-To: <20210410152140.3525040-9-sandals@crustytoothpaste.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 11 Apr 2021 01:17:10 -0700
Message-ID: <CAPx1GvfiG9AzYJi2PqhEW2d1n1ghn4Jnna4QR0cJSgNXvaEXQg@mail.gmail.com>
Subject: Re: [PATCH 08/15] cache: compare the entire buffer for struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just an observation here: comparing 256 bytes every time
would seem to have one nice bonus side effect and one
potentially bad, but vanishingly unlikely, side effect: a 160
byte null hash will now compare equal to a 256 byte null
hash (good), but a 160 byte hash extended to 256 bytes
will compare equal to a 256 byte hash that just happens to
end in 96 bytes of zero (bad, but I would guess, will never
actually happen).

Chris

On Sat, Apr 10, 2021 at 8:23 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Currently, when we compare two object IDs, we have to take a branch to
> determine what the hash size is supposed to be.  The compiler can
> optimize well for a single length, but has trouble when there are two
> possible lengths.
>
> There is, however, an alternative: we can ensure that we always compare
> the full length of the hash buffer, but in turn we must zero the
> remainder of the buffer when using SHA-1; otherwise, we'll end up with
> incompatible junk at the end of otherwise equivalent object IDs that
> will prevent them from matching.  This is an acceptable tradeoff,
> because we generally read an object ID in once, but then compare it
> against others multiple times.
>
> This latter approach also has some benefits as well: since we will have
> annotated every location in which we load an object ID into an instance
> of struct object_id, if we want to set the hash algorithm for the object
> ID, we can do so at the same time.
>
> Adopt this latter approach, since it provides us greater flexibility and
> lets us read and store object IDs for multiple algorithms at once.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  hash.h        | 13 ++++++++++---
>  hex.c         |  9 ++++++---
>  notes.c       |  3 +++
>  object-file.c |  1 +
>  4 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/hash.h b/hash.h
> index c8f03d8aee..04eba5c56b 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -205,7 +205,7 @@ static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>
>  static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
>  {
> -       return hashcmp(oid1->hash, oid2->hash);
> +       return memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
>  }
>
>  static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
> @@ -221,7 +221,7 @@ static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
>
>  static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
>  {
> -       return hasheq(oid1->hash, oid2->hash);
> +       return !memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
>  }
>
>  static inline int is_null_oid(const struct object_id *oid)
> @@ -258,7 +258,9 @@ static inline void oidclr(struct object_id *oid)
>
>  static inline void oidread(struct object_id *oid, const unsigned char *hash)
>  {
> -       memcpy(oid->hash, hash, the_hash_algo->rawsz);
> +       size_t rawsz = the_hash_algo->rawsz;
> +       memcpy(oid->hash, hash, rawsz);
> +       memset(oid->hash + rawsz, 0, GIT_MAX_RAWSZ - rawsz);
>  }
>
>  static inline int is_empty_blob_sha1(const unsigned char *sha1)
> @@ -281,6 +283,11 @@ static inline int is_empty_tree_oid(const struct object_id *oid)
>         return oideq(oid, the_hash_algo->empty_tree);
>  }
>
> +static inline void oid_pad_buffer(struct object_id *oid, const struct git_hash_algo *algop)
> +{
> +       memset(oid->hash + algop->rawsz, 0, GIT_MAX_RAWSZ - algop->rawsz);
> +}
> +
>  const char *empty_tree_oid_hex(void);
>  const char *empty_blob_oid_hex(void);
>
> diff --git a/hex.c b/hex.c
> index da51e64929..5fa3e71cb9 100644
> --- a/hex.c
> +++ b/hex.c
> @@ -69,7 +69,10 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
>  int get_oid_hex_algop(const char *hex, struct object_id *oid,
>                       const struct git_hash_algo *algop)
>  {
> -       return get_hash_hex_algop(hex, oid->hash, algop);
> +       int ret = get_hash_hex_algop(hex, oid->hash, algop);
> +       if (!ret)
> +               oid_pad_buffer(oid, algop);
> +       return ret;
>  }
>
>  /*
> @@ -80,7 +83,7 @@ int get_oid_hex_any(const char *hex, struct object_id *oid)
>  {
>         int i;
>         for (i = GIT_HASH_NALGOS - 1; i > 0; i--) {
> -               if (!get_hash_hex_algop(hex, oid->hash, &hash_algos[i]))
> +               if (!get_oid_hex_algop(hex, oid, &hash_algos[i]))
>                         return i;
>         }
>         return GIT_HASH_UNKNOWN;
> @@ -95,7 +98,7 @@ int parse_oid_hex_algop(const char *hex, struct object_id *oid,
>                         const char **end,
>                         const struct git_hash_algo *algop)
>  {
> -       int ret = get_hash_hex_algop(hex, oid->hash, algop);
> +       int ret = get_oid_hex_algop(hex, oid, algop);
>         if (!ret)
>                 *end = hex + algop->hexsz;
>         return ret;
> diff --git a/notes.c b/notes.c
> index a44b25858f..1dfe9e2b9f 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -455,6 +455,8 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
>                 CALLOC_ARRAY(l, 1);
>                 oidcpy(&l->key_oid, &object_oid);
>                 oidcpy(&l->val_oid, &entry.oid);
> +               oid_pad_buffer(&l->key_oid, the_hash_algo);
> +               oid_pad_buffer(&l->val_oid, the_hash_algo);
>                 if (note_tree_insert(t, node, n, l, type,
>                                      combine_notes_concatenate))
>                         die("Failed to load %s %s into notes tree "
> @@ -484,6 +486,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
>                                 strbuf_addch(&non_note_path, '/');
>                         }
>                         strbuf_addstr(&non_note_path, entry.path);
> +                       oid_pad_buffer(&entry.oid, the_hash_algo);
>                         add_non_note(t, strbuf_detach(&non_note_path, NULL),
>                                      entry.mode, entry.oid.hash);
>                 }
> diff --git a/object-file.c b/object-file.c
> index 3f43c376e7..8e338247cc 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2352,6 +2352,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
>                 if (namelen == the_hash_algo->hexsz - 2 &&
>                     !hex_to_bytes(oid.hash + 1, de->d_name,
>                                   the_hash_algo->rawsz - 1)) {
> +                       oid_pad_buffer(&oid, the_hash_algo);
>                         if (obj_cb) {
>                                 r = obj_cb(&oid, path->buf, data);
>                                 if (r)
