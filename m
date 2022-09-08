Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0558BC54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 20:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiIHUq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 16:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHUq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 16:46:58 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ECEE622A
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 13:46:56 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r134so158143iod.8
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=z9/lSN5jAvheCmwdCOMV5h7aFggx+ya0XIMQgmIs9Us=;
        b=ILE3tM5ipkxrFk/2xJBgL5VH9kAT2uCu3y/vqpL/lIij1MM6tCzlE5Iy5+U/uf830I
         dec1yRMP2oXci4OEDqAl5isPhadA5DYvMgndkKqLAYs7l0OQV1zvV3eH5UF+HXAJnlun
         IrZF9y1ZA9TbPRjQR6iENm3F5Baa3hKY6o4Au86FFbP0y2hFM/EQti4DDw5x0phTCgCN
         jUbHEmXZQquzD2WGTozyV/H59MWYjjvQBIFzeX1rDEIAgKx1PPMgtSqU1TMYAlnFROm9
         aFDa6KLabfyMb9iviL+hCRrE7tMriWnRsubi+5oh6la0TM7ost4VlrxfZMakPu50jbaN
         Ad8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=z9/lSN5jAvheCmwdCOMV5h7aFggx+ya0XIMQgmIs9Us=;
        b=YbX7TRyVreDhRNMDld/7KHx0OZnuxuSITk2GetwqvEaB9aZv98q3NR4GTR331+xI+2
         gkZ5P2nZ1ln8zqJNHkOpKCDaVIMDYpKg7LMZLyL5NxpAwSjdo/u/LKmHKVGBHH3KsQsg
         ULzlI0nHY1YWmxlmDNXITkXT85629DAzB95ET3jOgrYhXPUjiyybmealEbA2ahX1SFjP
         0XD047jMlAf0zicjdGsVjwW2exrD8eyAXPWDw1RvuX0L75784aj27iPUUStpkkqAV0PF
         hNChllFOGdBNa4coY54ItMbAjtwwt+haJ0trXEHsDGrXYRfDeM/FYfVT/+1W0dtHIS7X
         lfIg==
X-Gm-Message-State: ACgBeo3vFNbzLLeRrlhgzEpB8KmjGttJrijFtJHnONZlP7lIIaSHgT+i
        xrQNJr27SkF15UB6qjkPppq0VXaAgyUy
X-Google-Smtp-Source: AA6agR4TzmWY8t2jxtjiMtYaXSDU48ceO4SmO92hd2/TNfBueVidsnLDLiOJyVTwcw4Ww3sg+/eOBA==
X-Received: by 2002:a05:6602:4015:b0:688:c39a:dcd9 with SMTP id bk21-20020a056602401500b00688c39adcd9mr4935458iob.206.1662670015959;
        Thu, 08 Sep 2022 13:46:55 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e10-20020a92de4a000000b002f165ceb09bsm1208454ilr.64.2022.09.08.13.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 13:46:55 -0700 (PDT)
Message-ID: <093827ae-41ef-5f7c-7829-647536ce1305@github.com>
Date:   Thu, 8 Sep 2022 16:46:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 3/3] builtin/grep.c: walking tree instead of expanding
 index with --sparse
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     vdye@github.com, git@vger.kernel.org
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-4-shaoxuan.yuan02@gmail.com>
 <xmqqczc5rblr.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqczc5rblr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2022 1:59 PM, Junio C Hamano wrote:
> Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:
> 
>> +
>> +	/*
>> +	 * NEEDSWORK: when reading a submodule, the sparsity settings in the
>> +	 * superproject are incorrectly forgotten or misused. For example:
>> +	 *
>> +	 * 1. "command_requires_full_index"
>> +	 * 	When this setting is turned on for `grep`, only the superproject
>> +	 *	knows it. All the submodules are read with their own configs
>> +	 *	and get prepare_repo_settings()'d. Therefore, these submodules
>> +	 *	"forget" the sparse-index feature switch. As a result, the index
>> +	 *	of these submodules are expanded unexpectedly.
> 
> Is this fundamental, or is it just this version of the patch is
> incomplete in that it still does not propagate the bit from
> the_repository->settings to submodule's settings?  Should a change
> to propagate the bit be included for this topic to be complete?
> 
> To put it another way, when grep with this version of the patch
> recurses into a submodule, does it work correctly even without
> flipping command_requires_full_index on in the "struct repository"
> instance for the submodule?  If so, then the NEEDSWORK above may be
> just performance issue.  If it behaves incorrectly, then it means
> we cannot safely make "git grep" aware of sparse index yet.  It is
> hard to tell which one you meant in the above.
> 
> I think the same question needs to be asked for other points
> (omitted from quoting) in this list.

I think this comment is misplaced. It should either be contained in
the commit message or placed closer to this diff hunk:

>> @@ -537,8 +561,20 @@ static int grep_cache(struct grep_opt *opt,
>>  
>>  		strbuf_setlen(&name, name_base_len);
>>  		strbuf_addstr(&name, ce->name);
>> +		if (S_ISSPARSEDIR(ce->ce_mode)) {
>> +			enum object_type type;
>> +			struct tree_desc tree;
>> +			void *data;
>> +			unsigned long size;
>> +
>> +			data = read_object_file(&ce->oid, &type, &size);
>> +			init_tree_desc(&tree, data, size);
>>  
>> -		if (S_ISREG(ce->ce_mode) &&
>> +			hit |= grep_tree(opt, pathspec, &tree, &name, 0, 0);
>> +			strbuf_setlen(&name, name_base_len);
>> +			strbuf_addstr(&name, ce->name);
>> +			free(data);
>> +		} else if (S_ISREG(ce->ce_mode) &&

The conclusion we were trying to reach is that you (Junio) correctly
identified a bug in how we were calling grep_tree() in this hunk in
its v4 form.

HOWEVER: it "doesn't matter" because the sparse index doesn't work
at all within a submodule. Specifically, if a super-repo does not
enable sparse-checkout, but the submodule _does_, then we don't
know how Git will behave currently. His reasonings go on to explain
why the situation is fraught:

* command_requires_full_index is set in a builtin only for the
  top-level project, so when we traverse into a submodule, we don't
  re-check if the current builtin has integrated with sparse index
  and expand a sparse index to a full one.

* core_apply_sparse_checkout is a global not even associated with
  a repository struct. What happens when a super project is not
  sparse but a submodule is? Or vice-versa? I honestly don't know,
  and it will require testing to find out.

Shaoxuan's comment is attempting to list the reasons why submodules
do not currently work with sparse-index, and specifically that we
can add tests that _should_ exercise this code in a meaningful way,
but because of the current limitations of the codebase, the code
isn't actually exercised in that scenario.

In order to actually create a test that demonstrates how submodules
and sparse-checkout work with this logic, we need to do some serious
refactoring of the sparse-checkout logic to care about the repository
struct, along with some other concerns specifically around the sparse
index. This doesn't seem appropriate for the GSoC timeline or even for
just this topic.

Victoria and I have noted this issue down and will try to find time
to investigate further, with a target of being able to actually
exercise this grep_tree() call within a sparse index in a submodule,
giving us full confidence that name_base_len is the correct value to
put in that parameter.

Thanks,
-Stolee

