Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFE4C56201
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFC92074B
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0oBT+HG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgKKQJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgKKQJo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 11:09:44 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9834EC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 08:09:42 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so2097110qkc.12
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 08:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=CzJ72iOh6G4bZjXzGtiQsf+dN8ZUUh2ZAoWG6Bc2OTQ=;
        b=m0oBT+HGnNHDuISpQFGp37jMlm9r1fs0k13JJaL/ocO6wHyx8OHPS0mf+qyvI3fUaA
         78pzyzvkyXp0xgA0DytlLtS3oTFAbyiAVjYVY1He45T5oiYaUfOoSzejEQ8DrbrvTIYY
         u5qLBkFBBLfTKW67a3HjR9P1Q+udBEser1F5v9LHRnwaJcnSXeiMocb2h2oMT8PfAGHU
         cnxpDtuyqSBSf1+gAnC1zqIE1i1bzcujcIb27SwGsev//NmDFeuRHKlgLzxmzsTadUKP
         RHz9/5vnfDG0JfEuYLAakBsV6tgGMiCtCNcp63wa9D9pkU+YD7Vj/wSuRf0eOHfjhiie
         SZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CzJ72iOh6G4bZjXzGtiQsf+dN8ZUUh2ZAoWG6Bc2OTQ=;
        b=QTk8L6UeT3GEmH3mbkSTEUEDKRSisce0YNwN3HhlILj6g8kgBgmGb2LBN32tZ6LmUa
         2K81GXPAXFYIPoVzCeRgXAFGR0bMUuUxa9Q+d3uaQzkCJO15kmUwnW5ad7ddC11bA9Gb
         XMktExIwH3Gcbw/ftcKyWjKCheEe5/Eeq0rOzb3fJwszWqDCjNeL+VZpWhjqwmjPtR4V
         4bRMbzXHstQ/EImNBjTFlWgVgENRbjs8ptm+MFnKCWkzAF8ahvYXi2f36g+sO/Z4vYN4
         7H/P4F3MSn+OJWNC+uelkqCvfqX0Pa764nTPaECOqDiGwFzV8wA+CMZElCdv4nNVGiQ0
         FaVQ==
X-Gm-Message-State: AOAM530jldllLJyNK5SZTKr0X6aMVB7SCQBsdJiI9R2R3qaxA9ibQZxh
        TgE/3QDxHOBWT6MsejHdZxCAW8ccxtRaWQ==
X-Google-Smtp-Source: ABdhPJzVsoHh9YqXtW0VqgCASOMZ/VI03MrQrha/xEeooiGJ9CIYoVtCxFTCPrxL0yRYFJXGKqrYRA==
X-Received: by 2002:a37:9d04:: with SMTP id g4mr26121545qke.358.1605110980963;
        Wed, 11 Nov 2020 08:09:40 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c9d4:abc:8d:1568? ([2600:1700:e72:80a0:c9d4:abc:8d:1568])
        by smtp.gmail.com with UTF8SMTPSA id r204sm2447702qka.122.2020.11.11.08.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 08:09:40 -0800 (PST)
Subject: Re: [PATCH v2 12/20] merge-ort: have process_entries operate in a
 defined order
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <20201102204344.342633-1-newren@gmail.com>
 <20201102204344.342633-13-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4432ae6c-90ae-90d9-218f-15856395efac@gmail.com>
Date:   Wed, 11 Nov 2020 11:09:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201102204344.342633-13-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2020 3:43 PM, Elijah Newren wrote:
> We want to handle paths below a directory before needing to handle the
> directory itself.  Also, we want to handle the directory immediately
> after the paths below it, so we can't use simple lexicographic ordering
> from strcmp (which would insert foo.txt between foo and foo/file.c).
> Copy string_list_df_name_compare() from merge-recursive.c, and set up a
> string list of paths sorted by that function so that we can iterate in
> the desired order.

This is at least the second time we've copied something from
merge-recursive.c. Should we be starting a merge-utils.[c|h] to group
these together under a common implementation?

> +	/* Put every entry from paths into plist, then sort */
>  	strmap_for_each_entry(&opt->priv->paths, &iter, e) {
> +		string_list_append(&plist, e->key)->util = e->value;
> +	}

nit: are braces required here?

-Stolee
