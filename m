Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BACEE1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 22:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeI0FOf (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 01:14:35 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42210 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0FOf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 01:14:35 -0400
Received: by mail-yw1-f67.google.com with SMTP id h134-v6so287819ywc.9
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmwudEwfun33sJ9hUuOVXka7HFV4dzd2vygZGLsGfVk=;
        b=rJHBoX4KelcX+xbf4dRozpPb1VzHjddIn5zzqp2zvn8hAXly4tF0GEkFJ2g4F9RvN2
         y9xL0b2JoB1iv9XL2WbEW+YefqKBZHPT1ffgp5cp3RhzSIuGP/jAtXe1pdOtrpx9nEvO
         zmtSu3aYMlUS6s45jwpzNh2yUa7MFGVPZ/5Ol0F8x5eyIuy03JqA3Nb2thm8a2OMcWr7
         +33Cq15mDXhKUtgiib0AcdhTdBehr+Zy+Ngykt8qXAfLezkGbUV8J1FZ5fCY2qNGl3un
         K+BpBiwqUYi9VZKK6jPWSv3JbD4eKyBPdjaU5ZmO9U4gQab2jPhpfPICbu175rzvnNYA
         NkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmwudEwfun33sJ9hUuOVXka7HFV4dzd2vygZGLsGfVk=;
        b=l/M3nuYjANkTlN32NSpUakn5mgk1p3+zXPRnoKZ1A1L+nBsOmfjuTYmxHtf8FQpYLO
         VkB8y1t2Z2zquQDjHkM4S7tzNQKDFc4f47AfcM8G6uuoI8unNc4Pb/4ImaX8KvaPg5CF
         y8XSgsUW3pWRDDgazx2iVnsdU4WCuKb67GppMCeUiwHPnJaBduJZ2POv9FjhhASTm+Y+
         wiOTurDx1pK4qvnl6vth5EV7PwxBr0OyNQuwiC5K8TUWIPmuOUiJRv7RrvfTHoB/lN0r
         sDyh3lZpexTATB0uXCLV/dDjTTlHM0oOgU0ldI+Z4sAQIN7C2W9gBKO8n6zOdvjyYcdo
         /sSw==
X-Gm-Message-State: ABuFfojBQ6RcDEV8gfrgaBxhlxgpuUu+NUOjcvFo0ffPh5YLQHqwhxc6
        WcXukuSl0WUSoTjp5+f5E/p5tPe5kqIhzfF8SjTvpw==
X-Google-Smtp-Source: ACcGV61HvZQcFL6h3qXu4PucEanDRmnCvDW9fGpN2BP3//vV8byeaCIa1lktJdGKqDDnVGJrtrwKcFO7UklCbQ5oXhc=
X-Received: by 2002:a81:a115:: with SMTP id y21-v6mr4344013ywg.178.1538002759797;
 Wed, 26 Sep 2018 15:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqin2sj6df.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqin2sj6df.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Sep 2018 15:59:08 -0700
Message-ID: <CAGZ79kamkLV7yHtCu_qSqNzj7bJm0=Uw1CKxss+zTKJWsYz3qw@mail.gmail.com>
Subject: Re: [PATCH] fetch: replace string-list used as a look-up table with a hashmap
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 2:28 PM Junio C Hamano <gitster@pobox.com> wrote:

>
> +struct refname_hash_entry {
> +       struct hashmap_entry ent; /* must be the first member */

$ git grep "struct hashmap_entry" reveals that we have another
convention that we follow but not document, which is to stress
the importance of putting the hashmap_entry first. ;-)

> +       struct object_id oid;
> +       char refname[FLEX_ARRAY];
> +};
> +
> +static int refname_hash_entry_cmp(const void *hashmap_cmp_fn_data,
> +                                 const struct refname_hash_entry *e1,
> +                                 const struct refname_hash_entry *e2,
> +                                 const void *keydata)
> +{
> +       return strcmp(e1->refname, keydata ? keydata : e2->refname);
> +}

and later

    hashmap_init(...  (hashmap_cmp_fn)refname_hash_entry_cmp, ...);

I wonder if we'd want to stick to this style, as that seems to be the easiest
to do, and drop the efforts started in 55c965f3a2 (Merge branch
'sb/hashmap-cleanup', 2017-08-11), that avoids the cast in the init,
but puts the (implicit) casts in the _cmp function as we'd take
void pointers as the function signature and recast to a local variable.

> +
> +static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
> +                                                  const char *refname,
> +                                                  const struct object_id *oid)
> +{
> +       struct refname_hash_entry *ent;
> +       size_t len = strlen(refname);
> +
> +       FLEX_ALLOC_MEM(ent, refname, refname, len);
> +       hashmap_entry_init(ent, memhash(refname, len));

memhash is preferred over strhash as we already know the length.
For a second I wondered why we use it instead of strhash

> +static int refname_hash_exists(struct hashmap *map, const char *refname)
> +{
> +       struct hashmap_entry key;
> +       size_t len = strlen(refname);
> +       hashmap_entry_init(&key, memhash(refname, len));

Here we could use strhash, but as they could change to
differing implementation, we keep using memhash.

>         /*
> -        * For all the tags in the remote_refs string list,
> +        * For all the tags in the remote_refs_list,
>          * add them to the list of refs to be fetched
>          */
> -       for_each_string_list_item(item, &remote_refs) {
> +       for_each_string_list_item(remote_ref_item, &remote_refs_list) {
> +               const char *refname = remote_ref_item->string;
> +               struct hashmap_entry key;
> +
> +               hashmap_entry_init(&key, memhash(refname, strlen(refname)));
> +               item = hashmap_get(&remote_refs, &key, refname);

> +               if (!item)
> +                       continue; /* can this happen??? */

I thought this could happen when we have hash collisions,
I convinced myself otherwise, as we pass the refname to hashmap_get
as the 'keydata', so when there is a hash collision we keep comparing
to the real value.

And as whenever we have an insert to remote_refs_list, we also
have a refname_hash_add to the remote_refs hashmap,
I think the return of NULL is not possible, and we could switch
it to BUG(...);


> All this code predates more modern in-core lookup API like hashmap;
> replace them with two hashmaps and one string list---the hashmaps
> are used for look-ups and the string list is to keep the order of
> items in the returned result stable (which is the only single thing
> hashmap does worse than lookups on string-list).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

I wonder if we want to add an API to the hashmap that allows for ordered
iteration (as hashmap_iter_* relies on the hashing function for its output)

I think it may be too early to do so, but there are 2 thoughts on how to do it:
* Each element keeps (prev/next) pointers to the previously inserted
  element and updates the next pointer when the next element is inserted.
  When removing elements we'd have to update the next and prev pointer
  of the adjacent elements.
  Then iteration can be done in insertion-order.
  Probably this would go into its own file ordered-hashmap.{c, h}
* provide an order function to hashmap_iter_init, which then
  orders according to that function before the first call of
  hashmap_iter_next returns.

>  * Just to remind ourselves that we talked about getting rid of
>    string-list used as look-up tables by replacing them with hashmap
>    but haven't seen much effort expended on it.  I think this is my
>    first semi-serious use of hashmap, and the code is expected to be
>    full of newbie mistakes, inefficiencies and ignorance of idioms;
>    pointing out any of which is much appreciated.

I could not find newbie mistakes, but gave my thoughts anyway.

Stefan
