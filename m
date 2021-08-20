Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32B0C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6C6610FF
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhHTOiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 10:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhHTOiN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 10:38:13 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC76C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:37:36 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso2866950ots.5
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Df34HbHlCno3xddPmt4K0EglwumdFoGFf0ybF4YCytU=;
        b=GWRBZ4GtUckw40WByq5efeAdXIEJSvDWx5FtPL4WorpoD75xOuugJDLUlq0+EzIFpr
         h8Ed/u6KJ13zhaQo3TSYwDjY3p853lxldWySePxYwqXPI+QC7lE3vn+HW6Y3QpveRfqf
         ll1PLp/1ZAuYW6o7i7ZB8S3DXAWOTUv8sKgH4ZqSvSsNXaAm/d1+rM2R5pk+fMSOXzHK
         yCFVH25qIeqsavsn8G2Mv5r726jbydq0eFSSqocFiKbazVoOCO7Oo7jFM0zaD6y0NADS
         BEEdraA+xPn9jZuPlrirvVCbLgzk31G8Gjj6FnEaz8+r82uPvmZ67PbMFFmMw8Vlt0ye
         X0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Df34HbHlCno3xddPmt4K0EglwumdFoGFf0ybF4YCytU=;
        b=fgjh2yDEpt5td97oUPW3BgM05itya5q7ddCp6vmwhtiMS3FQZs/3foUo5rjuD1IkGf
         trd2AgLyap3wTTjBLjkenhEargo6aTq+MvCW2M0KC3z4IEWUb3S8fu/cwrI99RTsnsi/
         GBYTHIoMcg4R6vyGgy8qVk2weQSbOWKynXLKDPEzDtHJRUVDFIeCvd4t+KwCUC88wc0m
         +lfJyia0KaaAoAtm+SiSjdtlmQB6ILL2SkQ4d7ZYT2WXRgQ4qkLVmD+pdhCGIsbZTTiy
         oQosnlClRYktX9iVJ2PfQ/rVGOeSTynFEZYiNFuF1YP71hsIpcFe3g8B0UhwYCf4nErl
         0dSA==
X-Gm-Message-State: AOAM532aKQvNwQrGtifSToJFSB625jEk5/sLJqfJhBv8eNchMLEoLDoo
        neb3g7jpcy/zj1qL4AADhsw=
X-Google-Smtp-Source: ABdhPJyXQNtJ1VRxMRRJYQ2jzPpnV0i4HozbziA57i1zJ3OFyc99kywjx4sGvXlX5kxpdqfu9Hwu5A==
X-Received: by 2002:a9d:5f0e:: with SMTP id f14mr17094102oti.107.1629470255268;
        Fri, 20 Aug 2021 07:37:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id b11sm1305626ooi.0.2021.08.20.07.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 07:37:34 -0700 (PDT)
Subject: Re: [PATCH 4/6] fetch-pack: optimize loading of refs via commit graph
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1629452412.git.ps@pks.im>
 <67917af7ceeefe41ae0f6edf69cd61e2ee8c0ea3.1629452412.git.ps@pks.im>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d280d167-3e62-f73b-5504-9d1d8bdacaab@gmail.com>
Date:   Fri, 20 Aug 2021 10:37:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <67917af7ceeefe41ae0f6edf69cd61e2ee8c0ea3.1629452412.git.ps@pks.im>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2021 6:08 AM, Patrick Steinhardt wrote:
> In order to negotiate a packfile, we need to dereference refs to see
> which commits we have in common with the remote. To do so, we first look
> up the object's type -- if it's a tag, we peel until we hit a non-tag
> object. If we hit a commit eventually, then we return that commit.
> 
> In case the object ID points to a commit directly, we can avoid the
> initial lookup of the object type by opportunistically looking up the
> commit via the commit-graph, if available, which gives us a slight speed
> bump of about 2% in a huge repository with about 2.3M refs:
> 
>     Benchmark #1: HEAD~: git-fetch
>       Time (mean ± σ):     31.634 s ±  0.258 s    [User: 28.400 s, System: 5.090 s]
>       Range (min … max):   31.280 s … 31.896 s    5 runs
> 
>     Benchmark #2: HEAD: git-fetch
>       Time (mean ± σ):     31.129 s ±  0.543 s    [User: 27.976 s, System: 5.056 s]
>       Range (min … max):   30.172 s … 31.479 s    5 runs
> 
>     Summary
>       'HEAD: git-fetch' ran
>         1.02 ± 0.02 times faster than 'HEAD~: git-fetch'

This 2% gain is nice, especially because you are measuring the
end-to-end scenario. If you use GIT_TRACE2_PERF=1 on a few runs,
then you could likely isolate some of the regions from
mark_complete_and_common_ref() and demonstrate a larger improvement
in that focused area.

> @@ -119,6 +119,11 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
>  {
>  	enum object_type type;
>  	struct object_info info = { .typep = &type };
> +	struct commit *commit;
> +
> +	commit = lookup_commit_in_graph(the_repository, oid);
> +	if (commit)
> +		return commit;

Obviously a correct thing to do.

>  	if (type == OBJ_COMMIT) {
> -		struct commit *commit = lookup_commit(the_repository, oid);
> +		commit = lookup_commit(the_repository, oid);

Re-using the local simplifies this. Good.

Thanks,
-Stolee
