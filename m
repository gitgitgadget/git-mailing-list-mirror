Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9562BC433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D43864FCE
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhCIVph (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhCIVpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 16:45:25 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D540BC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 13:45:24 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id x78so16682164oix.1
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 13:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ydUMvUSWHHylkUtT01Gc2os2qwh5h4EUbNSeEaRoQ0w=;
        b=PPnfup3PcXaepnZ5UuOL55oqCxFNgYranWMFZb93tDRl6Ztnw858vQ4PgCx2F/bnEE
         KnCTS3D3JEWFvVfgmFiSvaQmNr95Ku1YhdCPxamq7Pjqk7B7TkjEJSjhz4LzMfk2dITh
         GgV2NeGWdq7kLNSsvHVh968iDNKYIzlzw8CrMZt2WXg9fKGC0fD+lOSU7MdAldtkedWg
         DTFn2ZRPMBW2IXtMArGzUBntGmaaU2Z+1EP54Oc1FS9El6U6EeCpV7BaEt9w7GtQk9AX
         GNo9OCj9PiqEQTe4ulfPXGhtzGfWO6dU6hbi8nmJGAz4nJRCGcgR9ZuUaF3VcpNeJ1bN
         AEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ydUMvUSWHHylkUtT01Gc2os2qwh5h4EUbNSeEaRoQ0w=;
        b=kW5ibfH/DOaNjtyRCmCGgPKYKDOsAeNoBtmHBNg2mQOTAPcYPEpa2oEPqXlXtcIl8x
         iPssCvRSJj1uV1QwfVtJ9dodIY1Ar0n4Rr4uu3IT2h/hBQyPE7jh35ylkwFEl6pAmLJw
         KMnA4eXxyEWKrkGCRGfWy5BXT5HqSD8VTSWIqNukXoNIE0Sri4DhMiHd+87px1QI3bgT
         wgAGEe3RU/JqwB/VuTjP5/pA6TYHcwfIkNfjsIkXjinzis/oLcieCwaEFq/Ku4mcT3Sa
         FU0n8KvV1EogZMgr+mm1OoIGqxItuFNwfwZfYerVb7/5ukOUq4L9veBwcj3iuA7amb3P
         KPJA==
X-Gm-Message-State: AOAM530OYu2Yojb+eWYhX0t9Ns0cW/tHIbO9SpVpUQ73EHLUjS8c99HO
        GmbEDYiizvEaFcZmpGzgeYgFGEcQ5Wb6jA==
X-Google-Smtp-Source: ABdhPJy/0PYApUtE0ftehDSSHjfuSFHmnkqWg3y/IsN2eN5LPC4d+W970NQspAp+CpmR/TWvsDPpEg==
X-Received: by 2002:aca:53cc:: with SMTP id h195mr183321oib.12.1615326324257;
        Tue, 09 Mar 2021 13:45:24 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:88a7:dd04:71df:86ee? ([2600:1700:e72:80a0:88a7:dd04:71df:86ee])
        by smtp.gmail.com with ESMTPSA id f197sm3332743oob.38.2021.03.09.13.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 13:45:23 -0800 (PST)
Subject: Re: [PATCH 15/20] sparse-index: create extension for compatibility
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <564503f7878475f220024def9e3bf20e4d518436.1614111270.git.gitgitgadget@gmail.com>
 <CABPp-BFnOgadewk+fSGy1ObHuZQb_-E0roz7HPE_cRHr3aW1UQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7a771c46-88ce-201d-3a01-25d73d3d99d3@gmail.com>
Date:   Tue, 9 Mar 2021 16:45:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFnOgadewk+fSGy1ObHuZQb_-E0roz7HPE_cRHr3aW1UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/25/2021 2:45 AM, Elijah Newren wrote:
> On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Previously, we enabled the sparse index format only using
>> GIT_TEST_SPARSE_INDEX=1. This is not a feasible direction for users to
>> actually select this mode. Further, sparse directory entries are not
>> understood by the index formats as advertised.
>>
>> We _could_ add a new index version that explicitly adds these
>> capabilities, but there are nuances to index formats 2, 3, and 4 that
>> are still valuable to select as options. For now, create a repo
>> extension, "extensions.sparseIndex", that specifies that the tool
>> reading this repository must understand sparse directory entries.
> 
> This commit is unchanged from the RFC series, but given your comments
> in the design document about how you do intend to create an index
> format v5 now, do you want to reference that here?

I'll insert detail about v5.
 
>> +extensions.sparseIndex::
>> +       When combined with `core.sparseCheckout=true` and
>> +       `core.sparseCheckoutCone=true`, the index may contain entries
>> +       corresponding to directories outside of the sparse-checkout
>> +       definition. Versions of Git that do not understand this extension
>> +       do not expect directory entries in the index.
> 
> I had a wording suggestion for this paragraph in the RFC series --
> https://lore.kernel.org/git/CABPp-BFEJE82k4VgkR=Jf7V7sZxZzo2pHMfAGshhi9_vV6iK0w@mail.gmail.com/.
> Let me know if you just decided to leave it out so I don't bug you
> about stuff you already considered.

I'll take your suggestion, thanks.

-Stolee
