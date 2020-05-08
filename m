Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11000C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D95E621841
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmNVxNkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgEHPkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 11:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEHPky (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 11:40:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0CAC061A0C
        for <git@vger.kernel.org>; Fri,  8 May 2020 08:40:54 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n14so1950931qke.8
        for <git@vger.kernel.org>; Fri, 08 May 2020 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CnkS2vNmMJBUu9TqaGvi7MBRupnI1I1CVj/0ufvKuxM=;
        b=bmNVxNkpEJPuJxr7GikZSr4b2vzrDF68PnfqvyzD0qy28PyGQCefMc6U9XUsGFQdXD
         z7ayP+ytqCQ+CU6K+UlC9hKTME+mdiDM2Ock+PAzlcbrI3StYyJ8MyN51o8qNty8805P
         6Nvu93hbkkHHSlSeisHpHLiI1KR/CpuZKho7HkLTkyg03ktleLPf+JlhxvwC5ix2bdrP
         A6mwXxekJgFmDFG9/YmZKNbxX8N42+aL5hs/8DocwA2llBIm8CLKXvSaKuBgmiEimgvg
         PZSNXKsftTFsk5JXTRq0m7BLr/o+1ll5eHSBFh/RUvpDO252q29vH3WXlevMYwIwlFCy
         PU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CnkS2vNmMJBUu9TqaGvi7MBRupnI1I1CVj/0ufvKuxM=;
        b=tNm9jnSJ1hAvi3HVsObslsuRrBX1RUIe0UdFf9aLo499qlv0dIoqzoQbz+et8kjFMP
         daEsd5QiY/b4GRbVe/Q5lFeOzrcGE9vxL5G9qHnJu8JcRyZ1J6bZ9juEbrSK+4+0MCJB
         LOjGrFv4fsf+Nxv9H3l0SsQLg2Tzot0CJQXm/i87fmktwjV0sHQkrw6UhwirP462tLRi
         yu3NLNekXOGAgu0KXD/aoEXYV6tZ7SZk3DceGNpPxBwJeKIzI8KEBVlewu6HUmcDZKK3
         h/UaQrSMDPrcnLz/nYjxHjwTFGt+5rnOdZfzNzlzj3+9ITQeBJ/xToUznJqFUixPUopm
         n3UA==
X-Gm-Message-State: AGi0Puaqx8lkS1yyhGwuissGFWKzSfQKazfPUBkcNnE7PM8CbKZdooS3
        FqKRQGTrIRmm4lqxUUD8NKL9CMGfOzoC3A==
X-Google-Smtp-Source: APiQypLxAgfi5BgRMg6Vm9Yc4/iiD97D5gyolE54OnpjalghxVXcSA2hZwybNYyNEEyVHAj385UGGg==
X-Received: by 2002:a05:620a:cd7:: with SMTP id b23mr3369150qkj.22.1588952453341;
        Fri, 08 May 2020 08:40:53 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j6sm1383755qkl.87.2020.05.08.08.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 08:40:52 -0700 (PDT)
Subject: Re: [PATCH 04/10] sparse-checkout: allow in-tree definitions
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmaill.com, peff@peff.net,
        me@ttaylorr.com, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
 <2188577cd848d7cee77f06f1ad2b181864e5e36d.1588857462.git.gitgitgadget@gmail.com>
 <xmqqeerv2w01.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6d354901-9361-d8d1-539d-3b6c3edb2d9f@gmail.com>
Date:   Fri, 8 May 2020 11:40:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqeerv2w01.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/7/2020 6:58 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> One of the difficulties of using the sparse-checkout feature is not
>> knowing which directories are absolutely needed for working in a portion
>> of the repository. Some of this can be documented in README files or
>> included in a bootstrapping tool along with the repository. This is done
>> in an ad-hoc way by every project that wants to use it.
>>
>> Let's make this process easier for users by creating a way to define a
>> useful sparse-checkout definition inside the Git tree data. This has
>> several benefits. In particular, the data is available to anyone who has
>> a copy of the repository without needing a different data source.
>> Second, the needs of the repository can change over time and Git can
>> present a way to automatically update the working directory as these
>> sparse-checkout definitions change over time.
> 
> And two lines of development can merge them together?
> 
> Any time a new "feature" pops up that would eventually affect how
> "git clone" and "git checkout" work based on untrusted user data, we
> need to make sure there is no negative security implications.  
> 
> If it only boils down to "we have files that can record list of
> leading directory names and without offering extra 'flexibility'", I
> guess there aren't all that much that a malicious sparse definition
> can do and we would be safe, though.

Yes. I hope that we can be extremely careful with this feature.
The RFC status of this series implicitly includes the question
"Should we do this at all?" I think the benefits outweigh the
risks, but we can minimize those risks with very careful design
and implementation.

>> To use this feature, add the "--in-tree" option when setting or adding
>> directories to the sparse-checkout definition. For example:
>>
>>   $ git sparse-checkout set --in-tree .sparse/base
>>   $ git sparse-checkout add --in-tree .sparse/extra
>>
>> These commands add values to the multi-valued config setting
>> "sparse.inTree". When updating the sparse-checkout definition, these
>> values describe paths in the repository to find the sparse-checkout
>> data. After the commands listed earlier, we expect to see the following
>> in .git/config.worktree:
>>
>> 	[sparse]
>> 		intree = .sparse/base
>> 		intree = .sparse/extra
> 
> What does this say in human words?  "These two tracked files specify
> which paths should be in the working tree"?  Spelling it out here
> would help readers of this commit.

You got it. Sounds good.

>> When applying the sparse-checkout definitions from this config, the
>> blobs at HEAD:.sparse/base and HEAD:.sparse/extra are loaded. 
> 
> OK, so end-user edit to the working tree copy or what is added to
> the index does not count and only the committed version gets used.
> 
> That makes it simple---I was wondering how we would operate when
> merging a branch with different contents in the .sparse/* files
> until the conflicts are resolved.

It's worth testing this case so we can be sure what happens.

>> In those
>> files, the multi-valued config values "sparse.dir" are considered as
>> the directories to construct a cone mode sparse-checkout file. The end
>> result is as if these paths were provided to "git sparse-checkout set"
>> in cone mode.
> 
> OK.
> 
>> For example, suppose .sparse/base had the following content:
>>
>> 	[sparse]
>> 		dir = A
>> 		dir = B/C
>> 		dir = D/E/F
>>
>> and .sparse/extra had the following content:
>>
>> 	[sparse]
>> 		dir = D
>> 		dir = X
>>
>> Then, the output of "git sparse-checkout list" would be
>>
>> 	A
>> 	B/C
>> 	D
>> 	X
>>
>> Note that since "D" contains "D/E/F", that directory replaces the
>> position of "D/E/F" in the list.
>>
>> Since these are parsed using the config library, the parser is robust
>> enough to understand comments and complicated string values.
>>
>> The key benefit to this approach is that it can be extended by defining
>> new config values. In a later change, we will introduce "sparse.inherit"
>> to point to another file in the tree. This will solve the problem of
>> editing many files when core dependencies change.
> 
> With only a multi-valued sparse.dir elements allowed in these
> in-tree .sparse/* files, I guess there isn't much mischeaf a
> malicious .sparse/* file can do.  Can it try to [includeIf] some
> paths external to the repository to cause a remote attacker to learn
> about the paths on the local system, perhaps? 

I was unaware of includes in the config format [1]. While the behavior
should be safe because we are only pulling very specific data from the
config, it would be best to see if we can disable includes when reading
config from a blob.

[1] https://git-scm.com/docs/git-config#_includes

> 
>> diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
>> new file mode 100644
>> index 00000000000..c1fce87cd33
>> --- /dev/null
>> +++ b/Documentation/config/sparse.txt
>> @@ -0,0 +1,15 @@
>> +sparse.inTree::
>> +	The `core.sparseCheckout` config option enables the `sparse-checkout`
>> +	feature, but if there are any values for the multi-valued
>> +	`sparse.inTree` config option, then the sparse-checkout patterns are
>> +	defined by parsing the files listed in these values. See
>> +	linkgit:git-sparse-checkout[1] for more information.
> 
> Does "... but if ... then" mean "by parsing the files and ignoring
> all other things that may otherwise define patterns"?
> 
>> +sparse.dir::
>> +	This config setting is ignored if present in the repository config.
>> +	Instead, this multi-valued option is present in the files listed by
>> +	`sparse.inTree` and specifies the directories needed in the
>> +	working directory. The union of all `sparse.dir` values across all
>> +	`sparse.inTree` files forms the input for `git sparse-checkout set`
>> +	in cone mode.  See linkgit:git-sparse-checkout[1] for more
>> +	information.
> 
> If this is *not* a config in the usual sense, we probably should not
> include it in this document and in the "git config --help" output.
> That will allow us to drop the first sentence.
> 
> Those .sparse/* in-tree files are like .gitmodules in the sense that
> they happen to use the same syntax so that the parser can be shared,
> but they are not allowed to affect end-user configuration
> (e.g. writing "[diff] external=rm -fr ." in the file has no effect)
> at all, right?
> 
> And we should describe what we can write in these in-tree files
> separately and make it clear that they are _different_ from the
> configuration variables.

I can move the "keys" from the config documentation and into the
git-sparse-checkout.txt file.

Thanks,
-Stolee
