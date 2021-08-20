Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029FEC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC5E61102
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbhHTOdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 10:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhHTOdN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 10:33:13 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A043C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:32:35 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id c14so5584396qvs.9
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ikyWYfUyJwWoORupw3RJJQzZHddcTL9n6VhxRJ+P2sQ=;
        b=nat7HIOakLNZsfaAdG02WM02mgDRzn4ENMhzcF7DeeCJV4mrZ/PX3s0uAL4S5+rzrH
         G/Z8THbq3QbOX95GSwWuWL1dFmw7TSZMRIG8PcazM9pQG+mGnfpLlxB/Qzh+j/IibeGb
         mn86WwYbel7iWJPRvNO7vIQNm09zBJXAYBrtI87PMBT+/nHbce6ZaIdSAKEIeSQjXDy6
         s+anwiYKaSzlkk1nwHh6bjzpB750FXFONgWBLHELXp2yxZkTOM+H2mY5hcBIWkmIvT7I
         NOEx9HVhmtrrZmthSJub0YFc+b19hA66Wtj0sLS4sfwpB98scDWlPzpFVCIFTvJerR8t
         9ViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ikyWYfUyJwWoORupw3RJJQzZHddcTL9n6VhxRJ+P2sQ=;
        b=H+fMSI8eK1xQZGaMjhKloJ8vktuUEmPSNbw7WcjZv1Ql7m+eSlW9ikYwK3vKhsZ7tp
         8JAvfyh/qiiBVzqO30GBhSDgBR9LXAfM4kCsQbUfsOkL0ESGl+I+NxG+5Athf8uXgqSl
         f13p4gkqqHQEmhTOng8uU4T+BDvzbeWihlB6Bz4yrhb9LamrEglMkPr7bFZVUZ3ZeqaI
         09HNYx81d7CeBHKGkWf2K49lVuybkCaPI6yRxx/8E16qV44FfGn0W5hQDGSHkbR9NuEz
         mqOzjVpAAem87r4+M9wGOydSD/cND1bXTEqpHunLWhHWOdIKWwONVpw4h5v20tdJZX8Z
         oOhA==
X-Gm-Message-State: AOAM530SepeTtUtxZdOigW4h5A4pD5LZX5x3sKUOw3EnA6O3X+Q7ZQe1
        M3L1l9nmwgzKxkzSHTbasvI=
X-Google-Smtp-Source: ABdhPJxyz7Z47VlmNfggQldQaFnOI+iG39vtgzqsySqoe5x6bjX768YUNkZsoE/ncqhHfBsSJIDLwA==
X-Received: by 2002:a0c:f68e:: with SMTP id p14mr2736339qvn.13.1629469954332;
        Fri, 20 Aug 2021 07:32:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id b19sm3341964qkc.7.2021.08.20.07.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 07:32:33 -0700 (PDT)
Subject: Re: [PATCH 3/6] connected: refactor iterator to return next object ID
 directly
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1629452412.git.ps@pks.im>
 <3bdad7bc8b0debd44138a4d3df5744d5a245475d.1629452412.git.ps@pks.im>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ffb5da19-937e-fba6-10f8-3993ca5ff0ef@gmail.com>
Date:   Fri, 20 Aug 2021 10:32:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3bdad7bc8b0debd44138a4d3df5744d5a245475d.1629452412.git.ps@pks.im>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2021 6:08 AM, Patrick Steinhardt wrote:
> The object ID iterator used by the connectivity checks returns the next
> object ID via an out-parameter and then uses a return code to indicate
> whether an item was found. This is a bit roundabout: instead of a
> separate error code, we can just retrun the next object ID directly and
> use `NULL` pointers as indicator that the iterator got no items left.
> Furthermore, this avoids a copy of the object ID.
> 
> Refactor the iterator and all its implementations to return object IDs
> directly. While I was honestly hoping for a small speedup given that we
> can now avoid a copy, both versions perform the same. Still, the end
> result is easier to understand and thus it makes sense to keep this
> refactoring regardless.

It's too bad about the lack of measurable performance gains, but the
new code _is_ doing less, it's just not enough.

I agree that the new code organization is better.

Thanks,
-Stolee
