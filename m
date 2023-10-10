Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1283CD8CA5
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 15:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjJJPGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjJJPGs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 11:06:48 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375D9AC
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 08:06:47 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1dd4115b369so852576fac.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696950406; x=1697555206; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xr4rEz/lp7Gp2hQo/DfqI+oc+zkpME5JQ+dNlL1gnFo=;
        b=UgsRMMyOVDo4K12cexHZ69m3jZojs07K3pqWQmixMeaOto0S6j327TgXekxytsYw1e
         x32rQhYZMUbBKX5PAlBI4rUUJn60MdF/nI/RHfS4JPNR3A1c4qoAXMyItUAzJX26te+0
         r4LVNrRmeocsOwfbzx7tKB0f+Sz24ggQu035RndPLssJjVE+RLVr/6mA5vcoIxaJxRJz
         d9aa5bCHS3iVsNep3AqPRTcfZUFVSFtO/eGe6IUvENKSSGX7nAUn35h8VmuXMP+OTBfJ
         UrwjMsuhVxafktlbCYHIGTb73e8ulo9RsJg+Ldg3dS0J6mmXDsEJ5NuLC0Vd8Mp+qLZw
         J0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696950406; x=1697555206;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xr4rEz/lp7Gp2hQo/DfqI+oc+zkpME5JQ+dNlL1gnFo=;
        b=hQTVsLDSuTjVoiVyz1QpLumhFVaEDSGiM1eOz0hFE+qLHUBxTHD4SMqRHjPQQ0OPBS
         Q5U1va/067g7wQOt0VS8t8oshapqwv7HHX+KZcLFkYRAgNFLz2U8dly+3lHWEIRVNFhV
         Bkn+JL1gbPV8N6krOWB7Sbed66AcfgPGE0uBvaQKVo67jFEBZJsrs6eM92QGwVOBFAuM
         CUetKsgRpLgccnCF5XrZgP8gIUdEBruwJ4e0s9zUnAG/IrCdO5ZRkLIjUno7xi/2ei0Q
         oSHBTLccEw0AibkmcLo6w1qbcrbeJ8fsb3E11Zkn9XL8z9ggAXF9hvHB3d88JCYGm/VJ
         WWLQ==
X-Gm-Message-State: AOJu0YxBXzMJ3ybEaRUzeGjMtmT36ZKrXyZdYE5zh6arENDaWrBWtr8X
        PnGBPLkJYA1t/QDiFXNK5Ho=
X-Google-Smtp-Source: AGHT+IG8Sh/9FQD/KNces0MUFVynrSXy+Dk4a9w+4J1Ne23cSBBlbWvAgtwSXpkGMF8P6Zw5zMQxGA==
X-Received: by 2002:a05:6870:f599:b0:1d0:e372:6cf8 with SMTP id eh25-20020a056870f59900b001d0e3726cf8mr19180402oab.2.1696950405998;
        Tue, 10 Oct 2023 08:06:45 -0700 (PDT)
Received: from [192.168.1.239] (ool-182e6d73.dyn.optonline.net. [24.46.109.115])
        by smtp.gmail.com with ESMTPSA id a14-20020a0cca8e000000b00655e4f57732sm4786078qvk.35.2023.10.10.08.06.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2023 08:06:45 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] merge-ort: initialize repo in index state
Date:   Tue, 10 Oct 2023 11:06:44 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <7E296F4F-82E1-4DA2-94C5-EFBBD2B05BB3@gmail.com>
In-Reply-To: <xmqq4jizxyla.fsf@gitster.g>
References: <pull.1583.v2.git.git.1696781998420.gitgitgadget@gmail.com>
 <pull.1583.v3.git.git.1696857660374.gitgitgadget@gmail.com>
 <xmqq4jizxyla.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 9 Oct 2023, at 17:41, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>     Fix this by initializing the repository in the index state.
>>
>>     Changes since V2:
>>
>>      * fixed test by using printf instead of echo
>
> Much better than using unportable \n with echo.
>
>>      -+		echo "foo\nbar\nbaz" >expect &&
>>      ++		printf "foo\nbar\nbaz\n" >expect &&
>
> But if we are using printf, it would be easier to read lines
> separately, which would look more like
>
> 	printf "%s\n" foo bar baz >expect
>
> And we have
>
> 	test_write_lines foo bar baz >expect
>
> to make it even more discoverable.

wasn't aware of test_write_lines, thanks.

>
>>       +		git cat-file -p "$tree:file1" >actual &&
>>       +		test_cmp expect actual
>>       +	)
>>
>>
>>  merge-ort.c           |  1 +
>>  t/t4300-merge-tree.sh | 27 +++++++++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/merge-ort.c b/merge-ort.c
>> index 7857ce9fbd1..36537256613 100644
>> --- a/merge-ort.c
>> +++ b/merge-ort.c
>> @@ -1902,6 +1902,7 @@ static void initialize_attr_index(struct merge_options *opt)
>>  	struct index_state *attr_index = &opt->priv->attr_index;
>>  	struct cache_entry *ce;
>>
>> +	attr_index->repo = opt->repo;
>>  	attr_index->initialized = 1;
>>
>>  	if (!opt->renormalize)
>> diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
>> index 57c4f26e461..c3a03e54187 100755
>> --- a/t/t4300-merge-tree.sh
>> +++ b/t/t4300-merge-tree.sh
>> @@ -86,6 +86,33 @@ EXPECTED
>>  	test_cmp expected actual
>>  '
>>
>> +test_expect_success '3-way merge with --attr-source' '
>> +	test_when_finished rm -rf 3-way &&
>> +	git init 3-way &&
>> +	(
>> +		cd 3-way &&
>> +		test_commit initial file1 foo &&
>> +		base=$(git rev-parse HEAD) &&
>> +		git checkout -b brancha &&
>> +		echo bar >>file1 &&
>> +		git commit -am "adding bar" &&
>> +		source=$(git rev-parse HEAD) &&
>> +		git checkout @{-1} &&
>> +		git checkout -b branchb &&
>> +		echo baz >>file1 &&
>> +		git commit -am "adding baz" &&
>> +		merge=$(git rev-parse HEAD) &&
>> +		git checkout -b gitattributes &&
>> +		test_commit "gitattributes" .gitattributes "file1 merge=union" &&
>
> OK, the branch "gitattributes" will be used to drive merge of file1
> using the union merge to avoid conflicting.
>
>> +		git checkout @{-1} &&
>
> But such attribute will only be available in that branch, not in the
> checked out working tree.  And then
>
>> +		tree=$(git --attr-source=gitattributes merge-tree --write-tree \
>> +		--merge-base "$base" --end-of-options "$source" "$merge") &&
>
> we use the gitattributes branch as the tree-ish to take the
> attribute information from.  Makes sense.
>
>> +		printf "foo\nbar\nbaz\n" >expect &&
>
> I'll squash in the "test_write_lines" change while queuing.

thank you!
John

>
>> +		git cat-file -p "$tree:file1" >actual &&
>> +		test_cmp expect actual
>> +	)
>> +'
>> +
>>  test_expect_success 'file change A, B (same)' '
>>  	git reset --hard initial &&
>>  	test_commit "change-a-b-same-A" "initial-file" "AAA" &&
>>
>> base-commit: 493f4622739e9b64f24b465b21aa85870dd9dc09
>
> Thanks.  Looking good.
