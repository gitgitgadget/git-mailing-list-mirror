Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7692C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 16:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83BDD23A79
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 16:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgLSQUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 11:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgLSQUN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 11:20:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98ADC0613CF
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 08:19:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id h205so13401364lfd.5
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 08:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pFgYcb4jmuyMY/T7bXC1FwcVmnhD2a83C2kH6Ld35aw=;
        b=NWnsVzc5ul/iPVaTZP3T9Po5ihmBFF6/T36fXzJjTKpxHwP6T3NNxeywOLZWWHM+Kj
         5Ygv+wXv3jtVXqAPgWLPbmhF51rX7vYLrSSVM3oGoNuW1KcJYI138uS0KQkUHqFFXlGE
         Q4M/3BihYF6LGvgbCzWIXswi9Yr9TcydD/DMwwwAWntaQV2gHNp7EU4/GX3aOgV6or1N
         UL0gX8Rc1Y9LAXM0Nz+OQ0yZUZ/dsgulMyUZqdt/4jZ/ToJD3Rz69uD5eEOKSiPuvguU
         LDkrReyRkpZ3AgTrAc0W+RE0V4gTS55NTWlCK7b7r5MqJ99F76JKnwjyKPFVL0DdN5Uj
         j3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=pFgYcb4jmuyMY/T7bXC1FwcVmnhD2a83C2kH6Ld35aw=;
        b=HUIz3px9uVTO0uRV6zE2mz/uB6+d7ENcCqvz9UwS1sgxJ7hJUo5VLzbY4YzZNpwX6G
         1oyfMgmOGa96FW+lpiN+5WTaZSxmk+Er91LQQU1x5lJvJy/RCmeLgXbLLkRzYwwNf0lP
         ZG3DsnwSIM5bQhaxwCNyE17UeX3TN+reiNdQZZA0q/rS10n5kHYwqhZGtp9RWEj34NzD
         JF9rJukD+Bb6dmxKIftBt9vyBdTKaGIq8Bu/3Wnyl16rv6DfBbVp35IR+a5BYRCU0CYc
         jQTkTCrp5LOFYev6CgZc/72TMf/58IOzdH1CyBZcdFfbFrj9Wzs3vNSfQoRO4bzSP2MA
         lKsw==
X-Gm-Message-State: AOAM531FddVkgtI33Um963FeslSvwJpYc7owUTj7xdN1YBNIvSUx2a3g
        /14+mR2PiZzWbe5gusWdTevNVPboI8E=
X-Google-Smtp-Source: ABdhPJxmPDOh8b+C30b7lAyMV4RLkAV+fhsnmr2QCR/0oLaf/WGlwV6Ovm+A/JWMmzAPi4R7gJFXsw==
X-Received: by 2002:a19:bd3:: with SMTP id 202mr3331153lfl.605.1608394770971;
        Sat, 19 Dec 2020 08:19:30 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n6sm1340037lfi.112.2020.12.19.08.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 08:19:30 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 26/33] diff-merges: let new options enable diff
 without -p
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-27-sorganov@gmail.com>
        <5fde01e133b93_1de0de20818@natae.notmuch>
Date:   Sat, 19 Dec 2020 19:19:28 +0300
In-Reply-To: <5fde01e133b93_1de0de20818@natae.notmuch> (Felipe Contreras's
        message of "Sat, 19 Dec 2020 07:36:33 -0600")
Message-ID: <87mty9lqen.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> diff --git a/log-tree.c b/log-tree.c
>> index f9385b1dae6f..67060492ca0a 100644
>> --- a/log-tree.c
>> +++ b/log-tree.c
>> @@ -899,15 +899,21 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>>  	int showed_log;
>>  	struct commit_list *parents;
>>  	struct object_id *oid;
>> +	int is_merge;
>> +	int regulars_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
>>  
>> -	if (!opt->diff && !opt->diffopt.flags.exit_with_status)
>> +	if (!regulars_need_diff && !opt->merges_need_diff)
>>  		return 0;
>>  
>>  	parse_commit_or_die(commit);
>>  	oid = get_commit_tree_oid(commit);
>>  
>> -	/* Root commit? */
>>  	parents = get_saved_parents(opt, commit);
>> +	is_merge = parents && parents->next;
>> +	if(!is_merge && !regulars_need_diff)
>> +		return 0;
>
> Missed a space:
>
>         if (!is_merge && !regulars_need_diff)

Oops, thanks!

-- Sergey
