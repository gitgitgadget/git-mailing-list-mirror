Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB930C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C055E24655
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PboTq1Ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgANTow (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:44:52 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43213 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgANTow (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:44:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id t129so13304512qke.10
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2U4duVo40KFpe+wtfunsH2glqfxRJ44OjMuhGZgfcwQ=;
        b=PboTq1KoLSQCUvPEZmJbRYeeVtHAPHXCrJ4pnjM84zEB9gC2Z3Gg4luSagnvQgX9Q6
         CLqLpboDxdB8ktHFTehDHSUlMQHFli4e3ZlcVu5tv8M7NYX8WQ4ZpGfEF0tpVcccPxK3
         0WI8GvBhgCP3zL+4/lokR5jJGjv+f8ewBaBqdB/Oyq6Wi7ITtRnyr4r3t4hHyZBcMKKr
         8lPmo/nTwxXgriXu/bmpy86bF3MUtubYetFcet+X9x3U7v99UVzFbZ5kIiZ1v+FB0oHO
         sqBs4JAgfL9mTHeWyeugcwof/ZYtnuJogioT/N+DH6qD2sg749Ga4t2oTZHUd+hnXASn
         Ol5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2U4duVo40KFpe+wtfunsH2glqfxRJ44OjMuhGZgfcwQ=;
        b=kY4d4yxt8eW1/bTVOU78tQ9QGB/BZv5OeVSPF7zm+ZJTl05bou7GNIEtEwALheWQtv
         Qc7ImqbZ+9msBJxJQ1mnm2VstEYvgiLpYP+1WtDJi300HGEw9J9ngzFnRoxA/lZrTUmg
         Sbye2z6qGPQhBVOAEkQSPDyhGjkZblPYjRMV590Jo2ntLhHh1O8nPiqw3M3gHnOQ5o0G
         Xdprr+zgEdDSQFg2f1p8be31/BEhvkAKvKN5hKrGyMhMaEm16EXH2HvF7pMieszLNctv
         FHcvX0bQWy5TVWXRr5isxkqH99vKOmcgIuGkoHL3Bk14BRBUlVuhupGH0IrLHN3bc0EZ
         cHiQ==
X-Gm-Message-State: APjAAAVJKWZDAkiOEEpVlVypU6zbH/7JEAMHxcf0eqtCKZZkWKgd1TV3
        WWlFgFd0YeagtKz37MTkJzc=
X-Google-Smtp-Source: APXvYqxZ5YEcSfwnFq41jJARZYDDOmwGO8gxEj50xmi0vjFaK0TAF92Dz4h/mW9H/QJnPQw2bYomNQ==
X-Received: by 2002:a37:5183:: with SMTP id f125mr23447343qkb.47.1579031091468;
        Tue, 14 Jan 2020 11:44:51 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:b9d5:2afd:ca1f:e483? ([2001:4898:a800:1012:6b09:2afd:ca1f:e483])
        by smtp.gmail.com with ESMTPSA id g53sm8057166qtk.76.2020.01.14.11.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 11:44:50 -0800 (PST)
Subject: Re: [PATCH 0/8] Harden the sparse-checkout builtin
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
 <20200114193405.GA8674@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c05c7dcb-43b4-dcf8-bc5d-e162f0b2d1a4@gmail.com>
Date:   Tue, 14 Jan 2020 14:44:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200114193405.GA8674@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/14/2020 2:34 PM, Taylor Blau wrote:
> Hi Stolee,
> 
> On Tue, Jan 14, 2020 at 07:25:54PM +0000, Derrick Stolee via GitGitGadget wrote:
>> This series is based on ds/sparse-list-in-cone-mode.
>>
>> This series attempts to clean up some rough edges in the sparse-checkout
>> feature, especially around the cone mode.
>>
>> Unfortunately, after the v2.25.0 release, we noticed an issue with the "git
>> clone --sparse" option when using a URL instead of a local path. This is
>> fixed and properly tested here.
> 
> I haven't had a chance to look at the other patches (besides the one
> that I have already reviewed on- and off-list), so take my comments here
> with a grain of salt.
> 
> It's too bad that 'git clone --sparse' isn't working with URLs in
> v2.25.0, but it happens, and I don't think that this is a grave-enough
> issue to warrant a new release. At least, since '--sparse' is new in
> v2.25.0, we're not breaking existing workflows that have already relied
> on it.
> 
> And, since sparse-checkout is still relatively niche (at, least for now
> ;-)), I think that this not handling cloning from URLs is fine until
> v2.26.0.

Since we've already worked out the workaround to be:

	git clone --no-checkout <url> <dir>
	cd <dir>
	git sparse-checkout init --cone

there is no rush to fix this. Users _may_ discover the --sparse option
from the clone docs and complain, but we can point them to the above
directions for now.

> Of course, if there's ever another need for v2.25.1, I don't think that
> this would *hurt* to release then, which is to say that we definitely
> should have these patches in a release, soon, but I don't think that
> there's a terrible sense of urgency in the meantime.

I wouldn't complain to have patches 1-3 in an otherwise-warranted .1 release.

Thanks,
-Stolee
