Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2137C001B0
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 21:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjGGVNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 17:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGGVNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 17:13:16 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC70926BA
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 14:12:57 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-666e3dad70aso3719022b3a.0
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 14:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688764377; x=1691356377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mk2/J4usnW46vkdZhnEI99wj+gCXEVbXenxK3SmDqX0=;
        b=ZZkeRPj7sm4wjZ11YjLQaPhDPU5S6tmnusvGl7wreQvTRd5ZhhDmHk4oniN1+VK81g
         x9v0r7HQEkZddudDvW/4EWuqobsI+eA14SaNlHr0ESakPTsRntlIM9GF8RSpQ3fC60p+
         F1QL7PI8M5YJ7Ay2xAjxxLbPc8doX2TT8/1m0uKuadByyXsU5MiLN0Paa8ZaCAnfea9G
         u43A8klHrFXEbdUx8+p6eH3jlEIrZmytwVW9fOcK673UYddTr3LXKgXK3hRDN3FTJqx3
         Bk7gEltFuZ/l28ulYmJRK/LujjTFUYhkLAP5l8FL5PT+bL5xhltTgrMgUDV+xylXbgpT
         WsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764377; x=1691356377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mk2/J4usnW46vkdZhnEI99wj+gCXEVbXenxK3SmDqX0=;
        b=VWIAH0oNwNd/GHW9QhEeIugNAGKDbpg/c2/xG2j3NBNlgNnJEjFwUWI6xXIVYo43LG
         b1oftGRELK10Tl96htts8G47P+VYodIqoVncB5nMdMxtOhKKzPA2+bztemv2JBYUQMuu
         FJdeaoqs/6p4T90ykOq/1kepHCEdyWpzJLGi42rKkDfEmy6Q/nQNPAY6Sez+l2TiYWF2
         ONtkXN+pMld4enSMMbvQHkx4DZtXnVhmmksz6cbLshDL62Y8fAYpITmyHLOmZEjqkH5C
         y5iSGlzugmN+RzRN1bkfNoI2CvgHbHiFOOrQ5MkeKQrgw5VfRCoVYxHE3dJtT4GvhKn9
         yqIA==
X-Gm-Message-State: ABy/qLbCMbJGZsGlK8xOsezP7kSChjwSrtYunH7alOVAPSZEkXGg6XSm
        /CvBJIyvfWCm9P8oSADPFmqm1ZRVKnMxmA==
X-Google-Smtp-Source: APBJJlGfOWP9hIwAgPrYzvRNMYpv9+eUYccDMvyxq0Ko1wUpb5lXcOTQUdE28ECs/Iqg9HAV3xfwffqfEYakeg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:13a3:b0:668:68ac:489b with SMTP
 id t35-20020a056a0013a300b0066868ac489bmr8078610pfg.2.1688764377153; Fri, 07
 Jul 2023 14:12:57 -0700 (PDT)
Date:   Fri, 07 Jul 2023 14:12:47 -0700
In-Reply-To: <ZKgpgnU7WrMCTp/C@google.com>
Mime-Version: 1.0
References: <20230531155142.3359886-1-siddhartth@google.com>
 <20230627132026.3204186-1-siddhartth@google.com> <kl6l8rc1rcsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <ZKgpgnU7WrMCTp/C@google.com>
Message-ID: <kl6lv8evpgs0.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH v2] khash_test.c : add unit tests
From:   Glen Choo <chooglen@google.com>
To:     Siddharth Singh <siddhartth@google.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Singh <siddhartth@google.com> writes:

>> > +int initialized_hashmap_pointer_not_null() {
>> > +  kh_str_t *hashmap = kh_init_str();
>> > +
>> > +  if(hashmap != NULL){
>> > +    free(hashmap);
>> > +    return 1;
>> > +  }
>> > +  return 0;
>> > +}
>> 
>> I don't think this is a useful test. It would be extremely weird for the
>> return value to be NULL in regular usage.
>
> While it is indeed uncommon for the return value of kh_init_str() to be null in
> regular usage, there could be certain cases where the hashmap pointer might be
> null. One possible scenario is if there is an error during memory allocation for
> the hashmap. This can happen if the system runs out of memory or if there are
> other memory-related issues. In such cases, the kh_init_str() function might
> return a null pointer to indicate the failure to allocate memory for the hashmap.

Ah, yes, that is what I expected. By "regular usage", I meant the case
where the allocation succeeds. Nevertheless, I don't think this test
demonstrates or asserts anything that isn't easily observed in other
tests, though I am open to be proven wrong.

>> > +int put_value_into_hashmap_once_succeeds() {
>> > +  int ret, value = 14;
>> > +  khint_t pos;
>> > +  kh_str_t *hashmap = kh_init_str();
>> > +  pos = kh_put_str(hashmap, "test_key", &ret);
>> > +  if (!ret)
>> > +    return 0;
>> > +  kh_key(hashmap, pos) = xstrdup("test_key");
>> > +  kh_value(hashmap, pos) = &value;
>> > +  return *kh_value(hashmap, pos) == value;
>> > +}
>> Also, do we have to kh_put_str("some_key") and then immediately set it
>> again with kh_key(pos)? That seems odd, and I don't see other callers
>> doing that all the time.
>
> Regarding the usage of kh_value(), I saw this part of code[1] This suggests
> that it may be the recommended approach in this context.

What 'context' were you thinking of when you say "recommended approach
in this context"? (Did you mean kh_put_str() vs kh_put_oid_*()?) I
didn't see such an approach in most kh_put_*() call sites. I couldn't
find the link you're referencing, but I assume it is the following lines
in delta-islands.c:

	int hash_ret;
	khiter_t pos = kh_put_str(remote_islands, island_name, &hash_ret);

	if (hash_ret) {
		kh_key(remote_islands, pos) = xstrdup(island_name);
		kh_value(remote_islands, pos) = xcalloc(1, sizeof(struct remote_island));
	}

In which case, the use case (as I understand it at least) seems quite
different:

- When kh_put_str() 'returns' hash_ret = 0, it means there's already a
  matching entry and we should do nothing.

- Otherwise, kh_put_str() actually creates a new matching entry, and now
  we want to allocate memory to store the entry, so we overwrite the key
  with "kh_key() = xstrdup()". We could have avoided this by doing
  something like:

    char *key = xstrdup(island_name)
    khiter_t pos = kh_put_str(remote_islands, key, &hash_ret);

    if (hash_ret) {
      kh_value(remote_islands, pos) = xcalloc(1, sizeof(struct remote_island));
    } else {
      free(key);
    }

  but allocations are expensive, so we should avoid allocating before we
  know it's needed.

>> > +int put_same_value_into_hashmap_twice_fails() {
>> > +  int first_return_value, second_return_value, value = 14;
>> > +  khint_t pos;
>> > +  kh_str_t *hashmap = kh_init_str();
>> > +  pos = kh_put_str(hashmap, "test_key", &first_return_value);
>> > +  if (!first_return_value)
>> > +    return 0;
>> > +  kh_key(hashmap, pos) = xstrdup("test_key");
>> > +  kh_value(hashmap, pos) = &value;
>> > +  kh_put_str(hashmap, "test_key", &second_return_value);
>> > +  return !second_return_value;
>> > +}
>> 
>> I don't see how this is different from the previous test that tested for
>> collisions.
>
> I also attempt to assign a value to the hashmap here, but this will not be
> successful due to a collision. The intent of this test was different, however

Hm, what was the different intent? Is it to test this slightly different
case where the value is assigned?

My reasoning is:

- Would assigning a value result in different behavior?
- Would a reasonable user expect that it would result in different
  behavior?

If the answer to both of those is 'no' (which I believe it is), then it
is not worth testing.
