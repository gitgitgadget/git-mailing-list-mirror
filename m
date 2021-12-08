Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBCBC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhLHO07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 09:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhLHO06 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 09:26:58 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED531C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:23:26 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id j17so2314536qtx.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LPWwpCL4EkTbZRntN5t8r0xyrUMSx4OhZhpBnIbvkNA=;
        b=dW7vQCNIzPu148Q/+3dy6bIedd4xHP0qC9kkrSi02MQcG3W0yd6mmlpHmwjFw52Zux
         E0/IYVz0a94tGymOUytdX7nINaGQ2pE7ihnIKsYVVPPXVVVSeEKVkkP0AF6OQBV/xJGf
         PQPrzZwsfmNx5wSsXSoBGtzTdCcwnayU+X2SOF07mL2rrgmqn2bW+io640Nj7j67RNnw
         zldIuVKrkXQMrK3ze/RBh1r2UB9vf9gWIM9rwsWrtQ4mJSfOW4TesShstdaxoDr3wXRO
         ZoGJvqpquUlrGSv1JeCsUirKFjppXa/KnthxoHcrzFUdXW4skuOmIMNWkxklfmQtuggt
         wUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LPWwpCL4EkTbZRntN5t8r0xyrUMSx4OhZhpBnIbvkNA=;
        b=Sy7+NoQkiGoqOQDq1sFjoVhsO8uDXhV6xI/cz7vgMJhNmolf/ot+223z0xmITm19vg
         j69ibUiO5J4jjAUi1PwcES4v8cel8NEUy1LpkpE36caB3kMZ4+87vjuR3+uJtRGGxmNY
         dobRmYWTbSveB7hWe4YIcqjAcybPaUfnNSb1PL25Pb4/eBWltekuwqWxqB5S9dujFxQu
         swzEWkokUuf12BSZLJWCNgjl6yk1HtnvYyQrjUsjCvJxqwo41PTcL5+AxntJWyIS+QL7
         yfYNkO8ABIKdcEe41N4+a51+GOLEHQRhs3HqQqBDV5+8uTZ15iIadICnwqL588HWJ+fu
         eveQ==
X-Gm-Message-State: AOAM530kkW58PvVcki1PTivD7Rdf4SsBIN7CS0gcGSBEPHDZls6MgkXH
        GHNwUuNXs5hqw6DzjbuLnA4=
X-Google-Smtp-Source: ABdhPJznMgsPhby+7YIOgTx1sWIlRWB/pnhbeedzZihT0RujH/1VVDAQ/ENwZp34QuyOHDyVdu8fqg==
X-Received: by 2002:a05:622a:202:: with SMTP id b2mr8257217qtx.34.1638973406033;
        Wed, 08 Dec 2021 06:23:26 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5056:be20:f10c:bfd5? ([2600:1700:e72:80a0:5056:be20:f10c:bfd5])
        by smtp.gmail.com with ESMTPSA id t35sm1950516qtc.83.2021.12.08.06.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 06:23:25 -0800 (PST)
Message-ID: <63bae98d-5c81-a6e4-5364-a643dbe4ef5e@gmail.com>
Date:   Wed, 8 Dec 2021 09:23:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/3] sparse-checkout: fix segfault on malformed patterns
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
 <CABPp-BF-xvJzfWO33p1ODtkLGMy2KENAbEu7KnrxPNq7UubbFg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BF-xvJzfWO33p1ODtkLGMy2KENAbEu7KnrxPNq7UubbFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2021 4:51 PM, Elijah Newren wrote:
> On Tue, Dec 7, 2021 at 12:02 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This series fixes some issues with parsing sparse-checkout patterns when
>> core.sparseCheckoutCone is enabled but the sparse-checkout file itself
>> contains patterns that don't match the cone mode format.
> 
> I was only able to find what I think is a small typo in one of the
> commits.  Everything else looks good to me.

Thanks. I'll give this a few more days for more feedback before sending
a v2 with that fix.
 
>> The first patch fixes a segfault first reported in [1]. The other two
>> patches are from an earlier submission [2] that never got picked up and I
>> lost track of. There was another patch involving 'git sparse-checkout init
> 
> Sorry for missing that series earlier.  Glad we've got some of them now.

The fault was my own for dropping this during a particularly busy time.

Thanks,
-Stolee
