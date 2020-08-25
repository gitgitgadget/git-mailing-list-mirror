Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CC1C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 15:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3F52076C
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 15:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6uo6yUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHYPOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYPOn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 11:14:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25749C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 08:14:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b14so11227614qkn.4
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wp0kxyjVvfjfi0SrLfgc7CPpou/SZSSv3K1Lf2mL3pE=;
        b=o6uo6yUt2Owf0gfqEF66s7aBzRiAhZ3GWwF6IL0NYFYnG0haZEHHMIovc1MAuFV8ia
         KknbAlb6jKwlfFzB+K19I0onhn0yZutbGayXUAux/37+knSqRxvTqyau3ELxc3rapriE
         4/qMMBG9XoItmqO3Xp7E66jTwgivtuv+0A3F7O9JKpYYCib1wxyl26E9s9sLNJShkoeP
         FH3zcIBXqXcPSjEDjB4pBwQJtzy0V9lboLsAFU3n47Q25h1cv4wvoFjZNEI4m3LBGMKB
         j2tZ+9Ycs/l7Vp6ftM27TXNLvVkha6Z6ie4ZlL2ZH6301z1/ZcpNGewManqHg7m8XIyE
         ZW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wp0kxyjVvfjfi0SrLfgc7CPpou/SZSSv3K1Lf2mL3pE=;
        b=GqdsCYZ+lMj22ghFNx8dAYaB2wS2nbnmBUvKEgZ5Hv+bwEx+ENpK8DS7ks4Bfk+Nbp
         NlnRAM+dPfZN+Rv7iyKxvF3wW6uBW6d0nZM5JW6oR2IjekdMl2vqA5KD6nz7cU8IsNXU
         OuWwX05HKto1GSuBM2MaaNGXRD2TNjTq6fWgv3z6zybByJNgIWF7a22ziLlQ41jTGRVo
         yq98AASCTCUmfeWMQUxEnM8kcCpfGiKQUcWGgsOYLsSdAf/cpmcXHznI/U5ZkA4STPgi
         YV/s5zEoWwDo6lBVa8PeydxdKfnqIZHBHz8XYGLi++NSjaZUvdRJq6KVDcPMhal+MTIY
         0p/g==
X-Gm-Message-State: AOAM533SPqUUCKB5Z1flLLJlbcwnY4RrN4ATXWQGA9Jc/dTHL1Bn7mNv
        eg2YcbxyP1fXzj3R68JlZ6Y=
X-Google-Smtp-Source: ABdhPJzXCeunB783WKwuizBX65Mt6fW+BHYwrPeYqjmvYj0KXwRt3FbwFew4t8EDfN+32s/HyflqxQ==
X-Received: by 2002:a37:bc43:: with SMTP id m64mr9530304qkf.53.1598368481970;
        Tue, 25 Aug 2020 08:14:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:600d:49d2:12ae:f5e7? ([2600:1700:e72:80a0:600d:49d2:12ae:f5e7])
        by smtp.gmail.com with ESMTPSA id r48sm484015qtb.26.2020.08.25.08.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 08:14:41 -0700 (PDT)
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        dstolee@microsoft.com
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <20200825022614.GA1391422@coredump.intra.peff.net>
 <20200825023710.GA98081@syl.lan>
 <e7eb9fb6-f1ea-f932-efaa-7434ad809989@gmail.com>
 <20200825144146.GA7671@syl.lan>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6a34d7ee-8c6b-8c6c-93bd-0013dccccafb@gmail.com>
Date:   Tue, 25 Aug 2020 11:14:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200825144146.GA7671@syl.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2020 10:41 AM, Taylor Blau wrote:
> On Tue, Aug 25, 2020 at 09:14:19AM -0400, Derrick Stolee wrote:
>> The code in builtin/repack.c looks good for sure. I have a quick question
>> about this new test:
>>
>> +test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
>> +	git multi-pack-index write &&
>> +	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
>> +	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
>> +
>> +	# Write a new pack that is unknown to the multi-pack-index.
>> +	git hash-object -w </dev/null >blob &&
>> +	git pack-objects $objdir/pack/pack <blob &&
>> +
>> +	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
>> +	test_cmp_bin $objdir/pack/multi-pack-index \
>> +		$objdir/pack/multi-pack-index.bak
>> +'
>> +
>>
>> You create an arbitrary blob, and then add it to a pack-file. Do we
>> know that 'git repack' is definitely creating a new pack-file that makes
>> our manually-created pack-file redundant?
>>
>> My suggestion is to have the test check itself:
>>
>> +test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
>> +	git multi-pack-index write &&
>> +	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
>> +	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
>> +
>> +	# Write a new pack that is unknown to the multi-pack-index.
>> +	git hash-object -w </dev/null >blob &&
>> +	HASH=$(git pack-objects $objdir/pack/pack <blob) &&
>> +
>> +	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
>> +	test_cmp_bin $objdir/pack/multi-pack-index \
>> +		$objdir/pack/multi-pack-index.bak &&
>> +	test_path_is_missing $objdir/pack/pack-$HASH.pack
>> +'
>> +
>>
>> This test fails for me, on the 'test_path_is_missing'. Likely, the
>> blob is seen as already in a pack-file so is just pruned by 'git repack'
>> instead. I thought that perhaps we need to add a new pack ourselves that
>> overrides the small pack. Here is my attempt:
>>
>> test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
>> 	git multi-pack-index write &&
>> 	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
>> 	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
>>
>> 	# Write a new pack that is unknown to the multi-pack-index.
>> 	BLOB1=$(echo blob1 | git hash-object -w --stdin) &&
>> 	BLOB2=$(echo blob2 | git hash-object -w --stdin) &&
>> 	cat >blobs <<-EOF &&
>> 	$BLOB1
>> 	$BLOB2
>> 	EOF
>> 	HASH1=$(echo $BLOB1 | git pack-objects $objdir/pack/pack) &&
>> 	HASH2=$(git pack-objects $objdir/pack/pack <blobs) &&
>> 	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
>> 	test_cmp_bin $objdir/pack/multi-pack-index \
>> 		$objdir/pack/multi-pack-index.bak &&
>> 	test_path_is_file $objdir/pack/pack-$HASH2.pack &&
>> 	test_path_is_missing $objdir/pack/pack-$HASH1.pack
>> '
>>
>> However, this _still_ fails on the "test_path_is_missing" line, so I'm not sure
>> how to make sure your logic is tested. I saw that 'git repack' was writing
>> "nothing new to pack" in the output, so I also tested adding a few commits and
>> trying to force it to repack reachable data, but I cannot seem to trigger it
>> to create a new pack that overrides only one pack that is not in the MIDX.
>>
>> Likely, I just don't know how 'git rebase' works well enough to trigger this
>> behavior. But the test as-is is not testing what you want it to test.
> 
> I think this case might actually be impossible to tickle in a test. I
> thought that 'git repack -d' looked for existing packs whose objects are
> a subset of some new pack generated. But, it's much simpler than that:
> '-d' by itself just looks for packs that were already on disk with the
> same SHA-1 as a new pack, and it removes the old one.

If 'git repack' never calls remove_redundant_pack() unless we are doing
a "full repack", then we could simplify this logic:

 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
 	struct strbuf buf = STRBUF_INIT;
-	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
+	struct multi_pack_index *m = get_multi_pack_index(the_repository);
+	strbuf_addf(&buf, "%s.pack", base_name);
+	if (m && midx_contains_pack(m, buf.buf))
+		clear_midx_file(the_repository);
+	strbuf_insertf(&buf, 0, "%s/", dir_name);
 	unlink_pack_path(buf.buf, 1);
 	strbuf_release(&buf);
 }

to

 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
 	struct strbuf buf = STRBUF_INIT;
	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
+	clear_midx_file(the_repository);
 	unlink_pack_path(buf.buf, 1);
 	strbuf_release(&buf);
 }

and get the same results as we are showing in these tests. This does
move us incrementally to a better situation: don't delete the MIDX
if we aren't deleting pack files. But, I think we can get around it.

> Note that 'git repack' uses 'git pack-objects' internally to find
> objects and generate a packfile. When calling 'git pack-objects', 'git
> repack -d' passes '--all' and '--unpacked', which means that there is no
> way we'd generate a new pack with the same SHA-1 as an existing pack
> ordinarily.
> 
> So, I think this case is impossible, or at least astronomically
> unlikely. What is more interesting (and untested) is that adding a _new_
> pack doesn't cause us to invalidate the MIDX. Here's a patch that does
> that:
> 
>   diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>   index 16a1ad040e..620f2058d6 100755
>   --- a/t/t5319-multi-pack-index.sh
>   +++ b/t/t5319-multi-pack-index.sh
>   @@ -391,18 +391,27 @@ test_expect_success 'repack removes multi-pack-index when deleting packs' '
>           test_path_is_missing $objdir/pack/multi-pack-index
>    '
> 
>   -test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
>   -       git multi-pack-index write &&
>   -       cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
>   -       test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
>   -
>   -       # Write a new pack that is unknown to the multi-pack-index.
>   -       git hash-object -w </dev/null >blob &&
>   -       git pack-objects $objdir/pack/pack <blob &&
>   -
>   -       GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
>   -       test_cmp_bin $objdir/pack/multi-pack-index \
>   -               $objdir/pack/multi-pack-index.bak
>   +test_expect_success 'repack preserves multi-pack-index when creating packs' '
>   +       git init preserve &&
>   +       test_when_finished "rm -fr preserve" &&
>   +       (
>   +               cd preserve &&
>   +               midx=.git/objects/pack/multi-pack-index &&
>   +
>   +               test_commit "initial" &&
>   +               git repack -ad &&
>   +               git multi-pack-index write &&
>   +               ls .git/objects/pack | grep "\.pack$" >before &&
>   +
>   +               cp $midx $midx.bak &&
>   +
>   +               test_commit "another" &&
>   +               GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
>   +               ls .git/objects/pack | grep "\.pack$" >after &&
>   +
>   +               test_cmp_bin $midx.bak $midx &&
>   +               ! test_cmp before after
>   +       )
>    '

After looking at the callers to remote_redundant_pack() I noticed that it is only
called after inspecting the "names" struct, which contains the names of the packs
to group into a new pack-file. We can use a .keep file to preserve the pack-file(s) in
the MIDX but also to ensure multiple pack-files outside of the MIDX are repacked and
deleted. While this is very unlikely in the wild, it is definitely possible.

test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
	git init preserve &&
	test_when_finished "rm -fr preserve" &&
	(
		cd preserve &&
		midx=.git/objects/pack/multi-pack-index &&

		test_commit 1 &&
		HASH1=$(git pack-objects --all .git/objects/pack/pack) &&
		touch .git/objects/pack/pack-$HASH1.keep &&

		cat >pack-input <<-\EOF &&
		HEAD
		^HEAD~1
		EOF

		test_commit 2 &&
		HASH2=$(git pack-objects --revs .git/objects/pack/pack <pack-input) &&
		touch .git/objects/pack/pack-$HASH2.keep &&

		git multi-pack-index write &&
		cp $midx $midx.bak &&

		test_commit 3 &&
		HASH3=$(git pack-objects --revs .git/objects/pack/pack <pack-input) &&

		test_commit 4 &&
		HASH4=$(git pack-objects --revs .git/objects/pack/pack <pack-input) &&

		GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -ad &&
		test_path_is_file .git/objects/pack/pack-$HASH1.pack &&
		test_path_is_file .git/objects/pack/pack-$HASH2.pack &&
		test_path_is_missing .git/objects/pack/pack-$HASH3.pack &&
		test_path_is_missing .git/objects/pack/pack-$HASH4.pack
       )
'

I believe this checks your condition properly enough.

Thanks,
-Stolee
