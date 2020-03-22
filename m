Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFE0C4332D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81AA20767
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU7K6ddG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgCVAXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:23:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45176 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCVAXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:23:16 -0400
Received: by mail-qk1-f193.google.com with SMTP id c145so11402852qke.12
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d/XZDWgSItfa3rKpP/heUQaVjHjgZTAhwmbkTypNjmw=;
        b=DU7K6ddGGcHLBxEnLSshOeEpIzFmtcOJb4GkzdAn+HXyF4KYjF1wBqEVQ1zRbPPjI8
         S2+6OUpiEZe8pxt/wyH0iXrXpmVe9CRgqaq4/vuwVNHAdlkIUZzDQ1KuQwfYJmsS2U0C
         pzpBoKMHUIERyumlhg9FGXQxw+arJEDEHSzo40UNI5Gfh2M80YNcMi2LZXSxIIpI1sm4
         DQ0NnuoRYhLRVAmImPe/7jbZ7gQt0mfTajrpUvPQnfgiehEGLCbWO3a3KM+120YvCHEX
         mc7QVpFGnkjqxPktUI4NTEU4Vhobp31M/HVGSTSPGyq9TKi4t5MAXp5Ild31OAeqMLWI
         MIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d/XZDWgSItfa3rKpP/heUQaVjHjgZTAhwmbkTypNjmw=;
        b=CpRZ4802h4j97tApn7WvqKgQ4gJtZnHnHE4gbRtF+BsuFM33tqGrKx8YlTgr14S2bK
         JpwNradIvPr1gvyzHeDIHnBsGsvg8S/WFzNvpr923w7blTqySjuXKk+1yHPWCatucgWu
         Q28wsv1kI1ecDMayKcjkPeVPsEBYP/Digi9PvEwhwPzcQAOX1KQ7cjwt+7YARUBHxDVc
         Di8vN525YQFWPwdh3Va9aGNV84c5dpr8jDlGR356JW/yCnoqFE5sRejFt/884LEUtrpU
         M8P02SHcm68tofTgQpn65cJsM12gqxNMVRXO4bOwFAQCv5LAdinG/8FSAWiPtYArOakT
         7qzw==
X-Gm-Message-State: ANhLgQ39V8Y9yzNVH7l67DCuMHlHwhmKe4Illf++wrp8CfkWlX0dt32L
        1oE8Rbah9nIWY+wNuIPinio=
X-Google-Smtp-Source: ADFU+vuoB9p05qSvY/5FxrzfMzRfaT4vDYJ9o6ncDbGiUiytMuk9ueY0ap9zv9bBw59G3PYPiYmjOg==
X-Received: by 2002:a37:27cd:: with SMTP id n196mr15555066qkn.144.1584836595292;
        Sat, 21 Mar 2020 17:23:15 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x14sm358427qkj.66.2020.03.21.17.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:23:14 -0700 (PDT)
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, dstolee@microsoft.com
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
 <a0de34e3-3f60-1838-dbaf-2ee3dddc7c89@gmail.com>
 <20200322002005.GA48038@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1cb561fc-5bce-28f0-e5e1-886f590fba92@gmail.com>
Date:   Sat, 21 Mar 2020 20:23:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200322002005.GA48038@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/2020 8:20 PM, Taylor Blau wrote:
> On Sat, Mar 21, 2020 at 08:03:01PM -0400, Derrick Stolee wrote:
>> On 3/21/2020 2:50 PM, Junio C Hamano wrote:
>>> Do we need to worry about INFO_QUICK and SKIP_FETCH_OBJECT in this
>>> codepath, by the way?
>>
>> I was coming back to this thread to bring up these exact flags for
>> consideration. The good news is that in a partial clone with any
>> amount of filtering we will still have all reachable commits, which
>> are necessary for the commit-graph to make sense. The only ones that
>> would fail has_object_file() are ones removed by GC, but they may
>> still exist on the remote. So without SKIP_FETCH_OBJECT, we would
>> generate a network call even if the server has GC'd to remove the
>> commits. This gets particularly bad when the server returns all
>> reachable objects from that commit!
> 
> That makes sense. Do you think something like this should be applied?

Yes, I think this is the appropriate update. Thanks!

> diff --git a/commit-graph.c b/commit-graph.c
> index c7cfadc786..0097318798 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1594,6 +1594,7 @@ static void merge_commit_graph(struct write_commit_graph_context *ctx,
>  {
>         uint32_t i;
>         uint32_t offset = g->num_commits_in_base;
> +       int flags = OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT;
> 
>         ALLOC_GROW(ctx->commits.list, ctx->commits.nr + g->num_commits, ctx->commits.alloc);
> 
> @@ -1606,7 +1607,7 @@ static void merge_commit_graph(struct write_commit_graph_context *ctx,
>                 load_oid_from_graph(g, i + offset, &oid);
> 
>                 /* only add commits if they still exist in the repo */
> -               if (repo_has_object_file(ctx->r, &oid)) {
> +               if (repo_has_object_file_with_flags(ctx->r, &oid, flags)) {
>                         result = lookup_commit(ctx->r, &oid);
>                         if (repo_parse_commit(ctx->r, result))
>                                 result = NULL;
