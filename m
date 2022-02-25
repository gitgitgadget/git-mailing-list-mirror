Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11A4C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 03:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiBYDIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 22:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiBYDIF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 22:08:05 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE6FB7149
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 19:07:34 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id a200-20020a621ad1000000b004e191fdcb4dso2367609pfa.1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 19:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LWes1tzdK3TYELlO3jBzr7n4+wSccnthO336YlG/2EA=;
        b=poxL4cDpcJLebcPQJe/Zj88irxI2DpZI7EttBfiIQcQWI+5L6Msi+cFvSQUA/s2e/x
         fkJBcXP/7T1cyfz2km+jFWIJdW1NXxUmkvv3p/3F2jNIOtpchrcqfdgRECYseHyHSP4K
         0ykdRiATDklfHJC5MP723KwmpXzw8S/CQxEdmSWr5VUPHEPtXpN/ML+ldfo4tpe/QVwL
         AiDwQpZvD+wyl3K2lw/iNr8tQ+x+aoOnIGiFJndvEGOEOXL7TSzpqVA9FdIzUWMPu017
         WEbiJ0aM7103I2sltScdIoMSG/WSTaFK6+LMicqlkdrkPw0Pa3Ikqgcnl+CB/JCXq9dT
         kedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LWes1tzdK3TYELlO3jBzr7n4+wSccnthO336YlG/2EA=;
        b=kBszdfVYiAaMtwKt0H8sUdIq8upAVr7TejM6IaXYeROYMRsRuLtD/DcPZz4ps7Y9ws
         FlahrsQq0/l6hrHgemzfBKtxkV9euUGkpIv8CfsxTUu5KK55DeUhnv9ulAK6BV06uGZn
         vYNGyTqZ98eCZvZhp++/F0bdh/sEGpaIsqvwve9T9xoOrvID5rbbsx22QHlG3ChhOyQI
         WU+1ZwKebSZAM+u9pqEgGGOUagBmxmGU//xfRLygGW9ugtsrsEc5ixVkBhkrds7FvwSC
         NPQ0kS3tBDhKjvOh3Wv3b+VbrkQgcbi7NuYm297WIcuomnRe8RklLOd7iCsxnLRJ+JAs
         5W0A==
X-Gm-Message-State: AOAM5323owzaq2RHZob68Ll3AmfilSos62LUGGXbvh1Hu/8qnmnyLbv9
        RlrLEa66xE3H0kSgcwIlOhTcTAUTOM6JqA==
X-Google-Smtp-Source: ABdhPJx1k8rRJewmsmdoxiDxAF/YU3lFblpLQMUWPPHwEyKYqvBMhQ8JSvotYSjWRY4Q52Bf9tJzMB0ZQAqyPQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:a38a:b0:14f:c714:47d3 with SMTP
 id x10-20020a170902a38a00b0014fc71447d3mr5462162pla.124.1645758453535; Thu,
 24 Feb 2022 19:07:33 -0800 (PST)
Date:   Fri, 25 Feb 2022 11:07:31 +0800
In-Reply-To: <xmqqsfs7hjiy.fsf@gitster.g>
Message-Id: <kl6l8rtz4pak.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
 <20220224100842.95827-10-chooglen@google.com> <xmqqsfs7hjiy.fsf@gitster.g>
Subject: Re: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>
>> +static struct fetch_task *
>> +get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
>> +			    struct strbuf *err)
>> +{
>> +	for (; spf->changed_count < spf->changed_submodule_names.nr;
>> +	     spf->changed_count++) {
>> +		struct string_list_item item =
>> +			spf->changed_submodule_names.items[spf->changed_count];
>> +		struct changed_submodule_data *cs_data = item.util;
>> +		struct fetch_task *task;
>> +
>> +		if (!is_tree_submodule_active(spf->r, cs_data->super_oid,cs_data->path))
>> +			continue;
>
> Where does this function come from?  I seem to be getting compilation errors.

Sorry, this was introduced in gc/branch-recurse-submodules, but I
neglected to mention that I used that as the base in v1.

>> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
>> index ee4dd5a4a9..639290d30d 100755
>> --- a/t/t5526-fetch-submodules.sh
>> +++ b/t/t5526-fetch-submodules.sh
>> @@ -15,8 +15,9 @@ pwd=$(pwd)
>>  
>>  check_sub() {
>
> Style.  
>
> 	check_sub () {
>
>>  	NEW_HEAD=$1 &&
>> +	SUPER_HEAD=$2 &&
>>  	cat <<-EOF >$pwd/expect.err.sub
>
> Style.
>
> 	cat <<-EOF >"$pwd/expect.err.sub"
>
> You may swap the order of redirection (having <<here-doc at the end
> of the line might look more familiar to some people).  Try to do as
> majority of surrounding code does.
>
> Make sure you quote the redirection target filename if it involves
> variable interpolation (see Documentation/CodingGuidelines, look for
> "Redirection").
>
>> +	cat <<-EOF > expect.err.combined &&
>
> Style.
>
> 	cat <<-EOF >expect.err.combined &&
>
> No SP between redirection operator and its target.
>
>> +	sed -E "s/[0-9a-f]+\.\./OLD_HEAD\.\./" actual.err >actual.err.cmp &&
>
> No ERE in sed.  "[0-9a-f][0-9a-f]*" instead of "[0-9a-f]+" should be
> sufficient, I think.

Thanks :)
