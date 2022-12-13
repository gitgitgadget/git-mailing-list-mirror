Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D406CC4167B
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 15:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiLMPeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 10:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbiLMPeV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 10:34:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9715227
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 07:34:19 -0800 (PST)
Received: from [192.168.1.90] (unknown [86.123.78.117])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD3D66602BE3;
        Tue, 13 Dec 2022 15:34:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670945658;
        bh=ShkNkUs1pO/mMsYzUkbzwbjENdr9Vqj5ZBgQ8Khrddg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OUCfA5VZ/iaodX217eZ+bEVvHPkaqD23FuLMPWGFkDVPa/Nxr6ViKPjEsy0BNbuBv
         8TyRXojwwKrfDiFXoFV7atWct1zNHTOtrJxFO/jd5vgA0Zv54nhW/cQ3xYTbmtpttf
         WIzB3G4taq335W9D6ya8dv1KBFC6rvoURrmv2OIKt29gaC/IIoOYXGNE5gBdUXjTev
         WpAohKez1/bkxbi5STnTD53Emi2uI7DE+Yk0HZHIdpItDc+ZC/migW7NspBopmN2AI
         8z1OqRIffsCQj2yFJ4kIBM4NkGFwheADwJCAyZ2AEB0Td/UJiJQwJfPfJtbSNna2CY
         bm5+kTYBJ+PUw==
Message-ID: <9e06bfd1-3e63-2414-e18c-6901fbb290e3@collabora.com>
Date:   Tue, 13 Dec 2022 17:34:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 0/1] rebase --onto detection of already applied
 commits
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20221212113516.27816-1-cristian.ciocaltea@collabora.com>
 <xmqqlencqhxy.fsf@gitster.g>
 <f4b485c8-3bc4-fb0c-3f7a-084daac7c14d@collabora.com>
 <51209c56-c82e-c393-6983-2a8c1a7388d3@dunelm.org.uk>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <51209c56-c82e-c393-6983-2a8c1a7388d3@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 12/13/22 15:04, Phillip Wood wrote:
> Hi Christian
> 
> On 13/12/2022 10:37, Cristian Ciocaltea wrote:
>> Currently '--onto' works as if the user provided the 
>> '--reapply-cherry-picks' flag,
> 
> --onto does not affect the cherry-pick detection. When running
> 
>      git rebase --onto new-base upstream feature
> 
> any commits in upstream have been cherry-picked from feature they will 
> not be rebased. What it does not do is look for cherry-picks in 
> onto...feature. It would be nice to add that but I'm not sure it is 
> straight forward to do so and still exclude commits that have been 
> cherry-picked from feature to upstream.

The proposed patch enables looking for commits into new-base..feature 
range and excluding the ones reachable from upstream. Since this is a 
change in the existing behavior, we might need to introduce a new flag 
to enable it. I previously suggested to use '--no-reapply-cherry-picks' 
for this purpose, but now it's pretty obvious this will be a source of 
confusion, since the "cherry-picks" term refers to the commits picked 
from feature to upstream instead of new-base, as you already mentioned.

I agree it would be nice to support both exclusion ranges, but I'm not 
sure how complicated the implementation would be, since I don't have any 
previous experience with the Git internals. Could this be added as a 
separate feature at a later point?

Thanks,
Cristian

> Best Wishes
> 
> Phillip
