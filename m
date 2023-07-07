Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7F7EB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 15:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjGGPEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 11:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjGGPEo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 11:04:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD9BAA
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 08:04:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fbbfaacfc1so3205633e87.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688742280; x=1691334280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FIIo2kL8jnkD9AwOP32JRli/gtZ8T6J+5HH5G8vT5zM=;
        b=CP2oauH+ceYr5qPdSIzy9MNozMQIv4u2B/RUkZzICeMngq/FzCHNlPKFBtX185RcUI
         0Sn7mGkMeG0Dkl/bUW8x2xt3FY3YoMlDizkgJrmjTbjJNwQgDsZ6SFwwBlnQcHhYvylb
         pt0SWd4lBgo332rJdRnp5hYuCZXxzZpwBRjkP91y0LfwBR+92uI1Bkkw5MXiEfxpdoWq
         S9hll/zDVX3a3Kz1b4fRMFvsP0nriwXNsFLXr42U6rWeWW+Nd4x95yfPQFuAqd+X9OkO
         k5Pfetbc+aQ2Dan+jAYSAxLmCph/Hzpk1T7B1bww0QnlmkpgNfAltTudYX3wFNqSetlZ
         9R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688742280; x=1691334280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIIo2kL8jnkD9AwOP32JRli/gtZ8T6J+5HH5G8vT5zM=;
        b=IF4tWY8I9TEXNsxkij1F9n4CXkpK66NdfB3wlvWjEi1/8D5smnqZl1J7ECOBwvyfrj
         uphYQQ7Q+CTRoEJ8x3U15AUaOew6Fw5m117dSxFWJVhdK/JSoVVRu3koZqtao3xhjVHn
         4hyoQm86Lhb05wBf5nYDmpFka72GyYr1IxQOeM8HnKnOzn72EP2HF5s9CjHTWPOaMVbV
         drobr2j1Skz9p+miryKWmhBjvup0/8h/3XMmqscPl5Y6pn/Q81d+fuKq9DwlYIdp/K1u
         uyowSNMlldYEX5K9Si2mFqyRHP1FCFwlo/bEI/iDkHlzxKHwtHyTmwpcWUkFWSZrUYmy
         FjSA==
X-Gm-Message-State: ABy/qLY52TZ8UaKRFX6CWAvpoLkVXFYYY3FDXTgaBcFq6ZVJt1Zms1by
        96U5GeltEcQeqoh6P2Dmq53Xzw==
X-Google-Smtp-Source: APBJJlF2F5wQ5ydt/804SHZlfn3jQjUaVmxwumDEe468eYEiqOSUdmlfVc4eVRrZ5LYe0pDFQSzNHQ==
X-Received: by 2002:a05:6512:114b:b0:4f6:1b9e:d2fb with SMTP id m11-20020a056512114b00b004f61b9ed2fbmr5273498lfg.11.1688742279563;
        Fri, 07 Jul 2023 08:04:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:9c:0:99fa:abf:291f:742e])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b003fbca942499sm2691726wmj.14.2023.07.07.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 08:04:39 -0700 (PDT)
Date:   Fri, 7 Jul 2023 17:04:34 +0200
From:   Siddharth Singh <siddhartth@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, nasamuffin@google.com
Subject: Re: [RFC PATCH v2] khash_test.c : add unit tests
Message-ID: <ZKgpgnU7WrMCTp/C@google.com>
References: <20230531155142.3359886-1-siddhartth@google.com>
 <20230627132026.3204186-1-siddhartth@google.com>
 <kl6l8rc1rcsj.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl6l8rc1rcsj.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2023 at 05:53:16PM -0700, Glen Choo wrote:
> Siddharth Singh <siddhartth@google.com> writes:
> 
> > - rewrote the code keeping coding style guidelines in mind.
> 
> I noticed several style issues in the patch. I'll avoid commenting on
> those here so that we can focus on the other, big questions.
> 
> > I'm also very new to writing unit tests in C and git codebase in general, so I'll appreciate constructive feedback and discussion..
> 
> Okay. I think this is a good chance for the ML to decide on what sorts
> of unit test practices we want too.
> 
> > What are the unit test cases to include in khash.h?
> > What are the other types of tests that would be useful for khash.h?
> 
> For a third party library, I mostly agree with upthread commenters that
> testing the correctness of the _library_ code isn't that valuable on its
> own, but unit tests are also useful for demonstrating how the code
> should be used. In a lot of projects, unit tests are a pseudo-official
> demonstration of how an interface should be used, and that's sometimes
> better than seeing the code in production, because unit tests are
> typically a lot simpler and easier to reason about.
> 
> As an aside, this is something that a unit test framework will do _much
> better_ than test-tool, because it makes it easy to read and write these
> idtiomatic demos without worrying about how the test-tool executable
> will be used.
> 
> I think that if we consider these two factors together (correctness and
> developer education), the fact that we don't have great documentation of
> khash.h in-tree, and that the external docs aren't that comprehensive
> either, I think it would be useful to exercise each of the khash
> 'functions' to show how they work.
> 
> As Taylor mentioned upthread, I think the most valuable thing to test is
> the way our code uses khash.h (not the library code itself). IOW:
> 
>   KHASH_INIT(oid_set, struct object_id, int, 0, oidhash_by_value, oideq_by_value)
>   KHASH_INIT(oid_map, struct object_id, void *, 1, oidhash_by_value, oideq_by_value)
>   KHASH_INIT(oid_pos, struct object_id, int, 1, oidhash_by_value, oideq_by_value)
> 
> So we would focus on oidhash_by_value and oideq_by_value in particular,
> since that's provided by us. It would be very useful to verify that
> these functions are doing exactly what we think they should be doing,
> and we could do this with _every_ khash function to really explore the
> API surface.
> 
> In fact... I suspect that they _not_ doing what we think they should,
> or at the very least, might be displaying some very unintuitive
> behavior. object_id contains both the hash value _and_ the hash
> algorithm that generated it. If we have the same hash value, but
> generated by different algorithms, are they considered the same equal or
> not? To me, the intuitive answer is "no", but oidhash_by_value() only
> considers the hash value and ignores the algorithm altogether! I think
> that testing collisions between SHA1 and SHA256 values would be very
> useful.
> 
> > +/*
> > +  These tests are for base assumptions; if they fails, library is broken
> > +*/
> > +int hash_string_succeeds() {
> > +  const char *str = "test_string";
> > +  khint_t value = __ac_X31_hash_string(str);
> > +  return value == 0xf1a6305e;
> > +}
> > +
> > +int hash_string_with_non_alphabets_succeeds() {
> > +  const char *str = "test_string #2";
> > +  khint_t value = __ac_X31_hash_string(str);
> > +  return value == 0xfa970771;
> > +}
> 
> For a unit test, it is a best practice to test the external interface
> that callers are depending on, and to avoid implementation
> details/internals. If we do the latter, we end up with brittle tests
> that break on non-important changes. E.g. we definitely should not be
> testing the exact value of the hash function. The khash library
> maintainer could decide to change the hash function, and we should not
> be broken by that.
> 
> For khash.h, it appears that that anything prepended with "__" is meant
> to be internal, and everything else is external. E.g.
> __ac_X31_hash_string is certainly not meant to be used directly by end
> users., especially since there's a human-friendly macro for it:
> 
>   #define kh_str_hash_func(key) __ac_X31_hash_string(key)
> 
> However, because something is external, doesn't mean we need to be
> testing its implementation - we still shouldn't be testing the
> return value of kh_str_hash_func(). We may want to test certain
> _properties_ of the external function (e.g. does it provide good
> collision resistance?), but in this case, I think we can trust that what
> the library author wrote is a good default.
> 
> > +KHASH_INIT(str, const char *, int *, 1, kh_str_hash_func, kh_str_hash_equal);
> 
> As mentioned earlier, I think testing oid_[set|map|pos] would be much
> more useful, and we should try to demonstrate each of the
> macros/functions and how they interact, e.g. if I kh_put_*, I should
> expect to be able to kh_get_* afterwards.
> 
> > +
> > +int initialized_hashmap_pointer_not_null() {
> > +  kh_str_t *hashmap = kh_init_str();
> > +
> > +  if(hashmap != NULL){
> > +    free(hashmap);
> > +    return 1;
> > +  }
> > +  return 0;
> > +}
> 
> I don't think this is a useful test. It would be extremely weird for the
> return value to be NULL in regular usage.

While it is indeed uncommon for the return value of kh_init_str() to be null in
regular usage, there could be certain cases where the hashmap pointer might be
null. One possible scenario is if there is an error during memory allocation for
the hashmap. This can happen if the system runs out of memory or if there are
other memory-related issues. In such cases, the kh_init_str() function might
return a null pointer to indicate the failure to allocate memory for the hashmap.

>
> > +int put_key_into_hashmap_once_succeeds() {
> > +  int ret, value;
> > +  khint_t pos;
> > +  kh_str_t *hashmap = kh_init_str();
> > +  pos = kh_put_str(hashmap, "test_key", &ret);
> > +  if(!ret)
> > +    return 0;
> > +  return pos != 0;
> > +}
> 
> I don't think it makes sense to only check the return value, we should
> check that it had the intended effect - that we can read back the value.
> There is a later test that does this, so I'd prefer we remove this.
> 
> Comment on the test framework, not the test: I think it makes sense to
> assert that "ret" is nonzero, but this "if..return" way of asserting
> makes it impossible to tell what has broken. It also adds a lot of
> cognitive overhead when trying to parse the assertion. I'll echo Phillip
> Wood's comments and say that I think this is definitely not a framework
> I want to use.
> 
> > +int put_same_key_into_hashmap_twice_fails() {
> > +  int first_return_value, second_return_value, value;
> > +  khint_t pos;
> > +  kh_str_t *hashmap = kh_init_str();
> > +  kh_put_str(hashmap, "test_key", &first_return_value);
> > +  kh_put_str(hashmap, "test_key", &second_return_value);
> > +  return !second_return_value;
> > +}
> 
> This test seems reasonable.
> 
> > +int put_value_into_hashmap_once_succeeds() {
> > +  int ret, value = 14;
> > +  khint_t pos;
> > +  kh_str_t *hashmap = kh_init_str();
> > +  pos = kh_put_str(hashmap, "test_key", &ret);
> > +  if (!ret)
> > +    return 0;
> > +  kh_key(hashmap, pos) = xstrdup("test_key");
> > +  kh_value(hashmap, pos) = &value;
> > +  return *kh_value(hashmap, pos) == value;
> > +}
> 
> Checking the inserted value makes sense to me I don't really understand
> khash.h, but is this the recommended way to get values back? kh_value()
> looks like just a small macro around an internal array, so we are just
> checking that *&value == value. I would have expected that we would call
> kh_get to get "pos", then call kh_value on that.
> 
> Also, do we have to kh_put_str("some_key") and then immediately set it
> again with kh_key(pos)? That seems odd, and I don't see other callers
> doing that all the time.
> 
> Since this is the second time I see "if (!ret)", I should ask whether
> this is meant as an assertion (checking the correctness of the code), or
> for flow control (the code might return either 0 or 1, and I need to
> handle both). If it is the former, I think it's unnecessary to
> assert on it multiple times. The latter does not belong in a unit test -
> we should already _know_ what we want to be returned. Btw, it is a huge
> flaw in the test framework that both look exactly the same, so I'll say
> again that I really don't like it.
> 

Regarding the usage of kh_value(), I saw this part of code[1] This suggests
that it may be the recommended approach in this context.

For kh_put_str, if i understand correctly, we first allocate a bucket then
then set it using kh_key, here's a use case[2] that does it similarly.

Regarding the usage of if (!ret), it seems to serve as an assertion or error
checking mechanism. If the return value ret is 0, it likely indicates an
error condition. It's worth mentioning that the similarity between the
assertion and flow control statements could be a flaw in the test framework,
as you pointed out.

> > +int put_same_value_into_hashmap_twice_fails() {
> > +  int first_return_value, second_return_value, value = 14;
> > +  khint_t pos;
> > +  kh_str_t *hashmap = kh_init_str();
> > +  pos = kh_put_str(hashmap, "test_key", &first_return_value);
> > +  if (!first_return_value)
> > +    return 0;
> > +  kh_key(hashmap, pos) = xstrdup("test_key");
> > +  kh_value(hashmap, pos) = &value;
> > +  kh_put_str(hashmap, "test_key", &second_return_value);
> > +  return !second_return_value;
> > +}
> 
> I don't see how this is different from the previous test that tested for
> collisions.

I also attempt to assign a value to the hashmap here, but this will not be
successful due to a collision. The intent of this test was different, however
 
> > +int get_existing_kv_from_hashmap_succeeds() {
> > +  int ret, value =14;
> > +  int expected = value;
> > +  khint_t pos;
> > +  kh_str_t *hashmap = kh_init_str();
> > +  pos = kh_put_str(hashmap, "test_key", &ret);
> > +  if (!ret)
> > +    return 0;
> > +  kh_key(hashmap, pos) = xstrdup("test_key");
> > +  kh_value(hashmap, pos) = &value;
> > +  return *kh_value(hashmap, kh_get_str(hashmap, "test_key")) == expected;
> > +}
> 
> Isn't this identical to put_value_into_hashmap_once_succeeds()?
> 
> Also, this assertion is harder to read than necessary because we have
> both "expected" and "value" - the different names suggest that they are
> different, but they're really the same. Let's just use one of them.
> 

I agree they both end up same implementation wise.

> > +int get_nonexisting_kv_from_hashmap_fails() {
> > +  int value = 14;
> > +  khint_t pos;
> > +  kh_str_t *hashmap = kh_init_str();
> > +  return !kh_get_str(hashmap, "test_key");
> > +}
> 
> Looks reasonable.
> 
> > +int deletion_from_hashmap_sets_flag() {
> > +  int ret, value = 14;
> > +  khint_t pos;
> > +  kh_str_t *hashmap = kh_init_str();
> > +  pos = kh_put_str(hashmap, "test_key", &ret);
> > +  if (!ret)
> > +    return 0;
> > +  if(!kh_exist(hashmap, pos))
> > +    return 0;
> > +  kh_key(hashmap, pos) = xstrdup("test_key");
> > +  kh_value(hashmap, pos) = &value;
> > +  kh_del_str(hashmap, pos);
> > +  return !kh_exist(hashmap, pos);
> > +}
> 
> What is the "flag" being set? If it is the khash-internal flag that
> marks that an entry is deleted, that's an unimportant implementation
> detail - the important thing is that the value is deleted. Let's just
> rename this to "deletion_works" or something.
> 
Oka, sounds good.
> > +
> > +int deletion_from_hashmap_updates_size() {
> > +  int ret, value = 14, current_size;
> > +  khint_t pos;
> > +  kh_str_t *hashmap = kh_init_str();
> > +  pos = kh_put_str(hashmap, "test_key", &ret);
> > +  if (!ret)
> > +    return 0;
> > +  kh_key(hashmap, pos) = xstrdup("test_key");
> > +  kh_value(hashmap, pos) = &value;
> > +  current_size = hashmap->size;
> > +  kh_del_str(hashmap, pos);
> > +  return hashmap->size + 1 == current_size;
> > +}
> 
> The interface is kh_size(), so let's use that instead of referencing the
> .size member correctly.

Okay.

> > +int deletion_from_hashmap_does_not_update_kv() {
> > +  int ret, value = 14, current_size;
> > +  khint_t pos;
> > +  kh_str_t *hashmap = kh_init_str();
> > +  pos = kh_put_str(hashmap, "test_key", &ret);
> > +  if (!ret)
> > +    return 0;
> > +  kh_key(hashmap, pos) = xstrdup("test_key");
> > +  kh_value(hashmap, pos) = &value;
> > +  kh_del_str(hashmap, pos);
> > +  return !strcmp(kh_key(hashmap, pos),"test_key");
> > +}
> 
> Interesting! If we kh_del_(pos) but read it back with kh_key(), we can
> still read it back. This has some implications on how khash should be
> used - we should be extremely careful if we pass around a returned value
> from kh_get_ or kh_put_ because we don't know if it's deleted or not.
> Instead, we should prefer kh_get_(). Very useful demonstration.
> 
Yes, we are still able to get the value but to truly know if something
was deleted or not, we need to use kh_exist.

> > +int update_value_after_deletion_succeeds() {
> > +  int ret, value1 = 14, value2 = 15;
> > +  khint_t pos1, pos2;
> > +  kh_str_t *hashmap = kh_init_str();
> > +  // adding the kv to the hashmap
> > +  pos1 = kh_put_str(hashmap, "test_key", &ret);
> > +  if (!ret)
> > +    return 0;
> > +  kh_key(hashmap, pos1) = xstrdup("test_key");
> > +  kh_value(hashmap, pos1) = &value1;
> > +  // delete the kv from the hashmap
> > +  kh_del_str(hashmap, pos1);
> > +  // adding the same key with different value
> > +  pos2 = kh_put_str(hashmap, "test_key", &ret);
> > +  if (!ret)
> > +    return 0;
> > +  kh_key(hashmap, pos2) = xstrdup("test_key");
> > +  kh_value(hashmap, pos2) = &value2;
> > +  // check if the value is different
> > +  return *kh_value(hashmap, kh_get_str(hashmap, "test_key")) == value2;
> > +}
> 
> Looks reasonable.
> 
> > +int hashmap_size_matches_number_of_added_elements() {
> > +  int ret, value1 = 14, value2 = 15, value3 = 16;
> > +  khint_t pos1, pos2, pos3;
> > +  kh_str_t *hashmap = kh_init_str();
> > +  pos1 = kh_put_str(hashmap, "test_key1", &ret);
> > +  if (!ret)
> > +    return 0;
> > +  kh_key(hashmap, pos1) = xstrdup("test_key1");
> > +  kh_value(hashmap, pos1) = &value1;
> > +  pos2 = kh_put_str(hashmap, "test_key2", &ret);
> > +  if (!ret)
> > +    return 0;
> > +  kh_key(hashmap, pos2) = xstrdup("test_key2");
> > +  kh_value(hashmap, pos2) = &value2;
> > +  pos3 = kh_put_str(hashmap, "test_key3", &ret);
> > +  if (!ret)
> > +    return 0;
> > +  kh_key(hashmap, pos3) = xstrdup("test_key3");
> > +  kh_value(hashmap, pos3) = &value3;
> > +  return kh_size(hashmap) == 3;
> > +}
> 
> Looks reasonable.
> 
> I would also exercise kh_end, kh_begin, kh_clear, kh_foreach and
> kh_foreach_value
> 
> kh_destroy might be useful to test too, in case there are oddities
> there, but it's probably not that interesting
> 
> kh_n_buckets doesn't seem useful to test - it looks too specific to the
> impkementation. kh_resize looks like an implementation detail that we
> shouldn't test either.
>

