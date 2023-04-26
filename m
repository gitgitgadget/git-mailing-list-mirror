Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864C8C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 10:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbjDZKxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 06:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbjDZKx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 06:53:28 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5450E49F2
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 03:52:56 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-555c8a12b26so79928517b3.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 03:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682506348; x=1685098348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=noaA3OUktjZhC/CKvPTUJIoyQ0Ee/Gcwdo/im8A5Wes=;
        b=YYiLqscTouYTfk9MXeYnVmlk6I3YcPImEoBQC6UO5pFEqiYgdRnHrnsQVFsP0yLY1w
         zRXU0JFo9AmeBkO6aQN9nZ4tHYFyfQfVJM2z7X7a1cIXNfLe+rWJNzG9rLeb7M2aH18I
         fPtZKp5GB+zyyMOwzCM0WoxMfSYc6YlwAuewpZzODEkcNX3plEvQeJgvCJQ2ZuYAtOTE
         Prm9gSuCfc7EyiZarlC7rHmGi4WUmNKV0MLpiP7NnEk0MWRUfVPJfwRP9UugpIXc4Yug
         HZJ4ceGWlzLdAG5xeQRxlDZd3Xzk1Vad+Y3zVCF6OKTvxMc/PKRN0NK6J7PWLBs6Bgua
         CtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682506348; x=1685098348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noaA3OUktjZhC/CKvPTUJIoyQ0Ee/Gcwdo/im8A5Wes=;
        b=KJRFRYnJz3Dcw90MvKBGaHuhknwIRjsCc8wJO9eGJScdnO9bidnjtcQGfvNzm2g2P6
         IYvyGnKsRObSO6vWosW92nwg4J/ySJrbDYsCqUpu+R26xMH5zuAsasnBxBSGiGBZ1cVG
         jUhmB5WqMi3DaqMe/o98f7/M5w0/gg5a91bbX/dfRDBUj+73ELKf27vTKUu1vtDu5FmW
         zF4TG/BUH8tDQ9+Dy6GWH7d+U+1g4MMkgV53iQMR3xnHXgLb+IH1hS+aSufoasQT4ZDS
         Cwp7ITPzCervVpERae2eHsCSC9LR0O3iLM44JuBGL7jMKJKJyHOPmDT0xZsVK2Bgpf4b
         k9Aw==
X-Gm-Message-State: AAQBX9d5pLx6ijl65dQjXFTjQ97Hm4KLryXExMBEach18bW2VIkpF+e8
        ZfwzDau7Sz5aEWCPTqud4BbW
X-Google-Smtp-Source: AKy350YP3mO7Bga1v64LnZmgGZvNo7r+gegnP65FlKmZzkPfCKmIKAVJRaf67Md48BfyDXFVPOAmAA==
X-Received: by 2002:a81:5294:0:b0:54f:b957:b5f8 with SMTP id g142-20020a815294000000b0054fb957b5f8mr13945033ywb.18.1682506347708;
        Wed, 26 Apr 2023 03:52:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8842:abce:33e9:20d2? ([2600:1700:e72:80a0:8842:abce:33e9:20d2])
        by smtp.gmail.com with ESMTPSA id r2-20020a815d02000000b0054f97b52934sm4151492ywb.54.2023.04.26.03.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 03:52:27 -0700 (PDT)
Message-ID: <97d84abc-9b25-9d43-503e-264b33c223d4@github.com>
Date:   Wed, 26 Apr 2023 06:52:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] builtin/pack-objects.c: introduce `pack.extraCruftTips`
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <4ba5eec2-dfbb-b918-147a-d6e03c2748b2@github.com>
 <ZEhFScCoAgGGM/th@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZEhFScCoAgGGM/th@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/2023 5:25 PM, Taylor Blau wrote:
> On Tue, Apr 25, 2023 at 03:42:51PM -0400, Derrick Stolee wrote:
>> On 4/20/2023 1:27 PM, Taylor Blau wrote:

>>> The implementation is straightforward: after determining the set of
>>> objects to pack into the cruft pack (either by calling
>>> `enumerate_cruft_objects()` or `enumerate_and_traverse_cruft_objects()`)
>>> we figure out if there are any program(s) we need to consult in order to
>>> determine if there are any objects which we need to "rescue". We then
>>> add those as tips to another reachability traversal, marking every
>>> object along the way as cruft (and thus retaining it in the cruft pack).
>>
>> I initially wondered why we would need a second walk, and I _think_
>> one reason is that we don't want to update the mtimes for these
>> objects as if they were reachable. The next point about the reachable
>> pack is also critical.
> 
> Their mtimes might be updated during that second walk, but the key point
> is that we want to rescue any objects that the extra tips might reach
> (but aren't listed themselves in the output of one of the hooks).
> 
> The idea there is similar to the rescuing pass we do for pruning GC's,
> where we'll save any objects which would have been pruned, but are
> reachable from another object which won't yet be pruned.
> 
>>> Instead, keep these unreachable objects in the cruft pack instead, to
>>> ensure that we can continue to have a pack containing just reachable
>>> objects, which is always safe to write a bitmap over.
>>
>> Makes sense. Also: don't update their mtime so they could be removed
>> immediately if the external pointers change.
> 
> I don't think I'm quite following why we would want to leave their
> mtimes alone here. I think we'd want their mtimes to be accurate as of
> the last time we updated the *.mtimes file so that if they (a) no longer
> appear in the output of one of the extra-cruft hooks, and (b) they have
> been written recently, that they would not be pruned immediately.

You corrected me that we _are_ updating mtimes, so my understanding was
incorrect and this follow-up is incorrect. Thanks.

Is it possible to demonstrate this mtime-updating in a test?

>>> +	if (progress)
>>> +		progress_state = start_progress(_("Enumerating extra cruft tips"), 0);
>>
>> Should we be including two progress counts? or would it be sufficient
>> to say "traversing extra cruft objects" and include both of these steps
>> in that one progress mode?
> 
> I may be missing something, but there are already two progress meters
> here: one (above) for enumerating the list of extra cruft tips, which
> increments each time we read a new line that refers to an extant object,
> and another (below) for the number of objects that we visit along the
> second walk.

I meant: why two counts? Should we instead only have one?

>>> +	if (prepare_revision_walk(&revs))
>>> +		die(_("revision walk setup failed"));
>>> +	if (progress)
>>> +		progress_state = start_progress(_("Traversing extra cruft objects"), 0);
>>> +	nr_seen = 0;
>>> +	traverse_commit_list(&revs, show_cruft_commit, show_cruft_object, NULL);
>>
>> Hm. I'm trying to look at these helpers and figure out what they
>> are doing to prevent these objects from being pruned. This could
>> use a comment or something, as I'm unable to grok it at present.
> 
> Very fair, the show_cruft_object() callback calls
> add_cruft_object_entry(), which adds the visited object to the cruft
> pack regardless of its mtime with respect to pruning.

Ah, thanks. That helps a lot.
 
> A comment here might look like:
> 
>     /* retain all objects reachable from extra tips via show_cruft_object() */
> 
> or something.

Sounds good.

>> Could we store this commit to make sure it is removed from the
>> repository later?
> 
> Possibly, though I think we already have good coverage of this in other
> tests. So I'd be equally happy to assert on the exact contents of the
> cruft pack (which wouldn't include the above commit), but I'm happy to
> assert on it more directly if you feel strongly.

This is a case of me thinking "can we test the test?" to make sure
the test is doing everything we think it is doing...

>>> +		git checkout --orphan old &&
>>> +		git rm -fr . &&
>>> +		test_commit --no-tag cruft.old &&
>>> +		cruft_old="$(git rev-parse HEAD)" &&
>>> +
>>> +		git checkout --orphan new &&
>>> +		git rm -fr . &&
>>> +		test_commit --no-tag cruft.new &&
>>> +		cruft_new="$(git rev-parse HEAD)" &&
>>> +
>>> +		git checkout main &&
>>> +		git branch -D old new &&
>>
>> Do you need to delete the 'discard' branch here?
> 
> Great catch. I didn't notice it here because even though it was
> reachable (and not mentioned as an extra tip), so didn't appear in the
> cruft pack.

...so we catch things like this automatically.

>>> +		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
>>> +		git show-index <${mtimes%.mtimes}.idx >cruft &&
>>> +		cut -d" " -f2 cruft | sort >cruft.actual &&
>>> +		test_cmp cruft.expect cruft.actual
>>
>> One thing that would be good, as a safety check, is to remove
>> the pack.extraCruftTips config and re-run the repack and be
>> sure that we are pruning the objects previously saved by the
>> hook.
> 
> Good call. I think this amounts to:
> 
> --- 8< ---
> diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
> index 1260e11d41..44852e6925 100755
> --- a/t/t5329-pack-objects-cruft.sh
> +++ b/t/t5329-pack-objects-cruft.sh
> @@ -773,7 +773,7 @@ test_expect_success 'additional cruft tips may be specified via pack.extraCruftT
>  		cruft_new="$(git rev-parse HEAD)" &&
> 
>  		git checkout main &&
> -		git branch -D old new &&
> +		git branch -D discard old new &&
>  		git reflog expire --all --expire=all &&
> 
>  		# mark cruft.old with an mtime that is many minutes
> @@ -802,6 +802,19 @@ test_expect_success 'additional cruft tips may be specified via pack.extraCruftT
>  		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
>  		git show-index <${mtimes%.mtimes}.idx >cruft &&
>  		cut -d" " -f2 cruft | sort >cruft.actual &&
> +		test_cmp cruft.expect cruft.actual &&

If we store "discard=$(git rev-parse discard)" earlier, we can also
check

		test_must_fail git show $discard &&

> +		# Ensure that the "old" objects are removed after
> +		# dropping the pack.extraCruftTips hook.
> +		git config --unset pack.extraCruftTips &&
> +		git repack --cruft --cruft-expiration=now -d &&
> +
> +		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
> +		git show-index <${mtimes%.mtimes}.idx >cruft &&
> +		cut -d" " -f2 cruft | sort >cruft.actual &&
> +
> +		git rev-list --objects --no-object-names $cruft_new >cruft.raw &&

I like how $cruft_new is still kept because its mtime is still
"later than now".

> +		sort cruft.raw >cruft.expect &&
>  		test_cmp cruft.expect cruft.actual
>  	)
>  '
> --- >8 ---
> 
>> It would be helpful to include a test for the multi-value case where
>> multiple scripts are executed and maybe include an "exit 1" in some
>> of them?
> 
> Definitely, that is a great suggestion (especially because it would have
> caught the "if (!ret)" bug that you pointed out above).
> 
> Thanks for a thorough review. I'll wait for other feedback before
> re-rolling, or do so in a couple of days if I haven't heard anything.

Thanks,
-Stolee
