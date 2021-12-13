Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815F6C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbhLMQ1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240777AbhLMQ0z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:26:55 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E31C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:26:55 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id t5so53726585edd.0
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=NiBufAq+JepzzeDivte+4hlpVPwe6B26SUlsgkhHgj0=;
        b=hDAV7X2Jm9S8ZufaE3wN4usGZmJqM7SEPp6aquXTh1x2vHU2BmsTOhYDaZ0svsxrRr
         sgmY2dHh6WztEEalorzJJDnivyOOsECiA5BtNL0Bj+MnlVjW9/YpO81a9JC62cHLRRQi
         6s7MItjNnuuSSBiEySMbrM4i2Ao2qeoPUA+nwdBrAJO+dpXrPhjTPudLPvvRvUkNRgKx
         EaapOM3cCNq5ftFGiAhgCmu9Rck06IlQLOmOUEOjqhzFSFoSee45Bi3Q5EnK/WTzEByn
         uegCu9fxMJ9JR0zPwakIwTAVT60C+2/dbyxG/U+Suhr29gbXgT/pYkFA7ZC7hICRYbpB
         J/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=NiBufAq+JepzzeDivte+4hlpVPwe6B26SUlsgkhHgj0=;
        b=Ulkzg7UQDBBY6OoQ/uFEYZfsqeC3c/3DRkO74YeFwvnzKmfrEGPm85pm7kL6cOoiOK
         58wYc2mpQaC7d51+oy5cduQb/Ne7YzKZGkRwYGF/KDM9r9LvYM0G6bKmR5ZDlOAhIgCF
         UaFcHgagPIuTsPo07EBWFzn1W4Bn0hS+TSpLEkSe8DMCRwzxx6M6nlxQgorMPzcFZLzE
         OoVCR3dPCKuJ5nR1AgYo94Okz0otcQSUQ0WuZCzIQTCr3lDanHfWVsDF0JPsJ4/jFWqm
         6wxtFEl2phViQsbTZUiq2TLb9ldqUIObcS55TqraWmcVMzP9BN1CF4RIFdKJEh4ZKbJz
         WItg==
X-Gm-Message-State: AOAM53307zCcZt2m2NVuNL/76u8tp2XKXvXOJVwaip3p64A2BGp/6ldg
        xITuTvR4ZNi3lXXYlgidoYReJjFfD95tvg==
X-Google-Smtp-Source: ABdhPJwi8UfNh0kvYyK/hW1skYU9n9cv+ilwlihHM6qm+UMx1yjXRWivpF42cmEO9SJ9mDTFU44RQw==
X-Received: by 2002:a17:907:1614:: with SMTP id hb20mr44554003ejc.299.1639412813311;
        Mon, 13 Dec 2021 08:26:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b7sm6612565edj.24.2021.12.13.08.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:26:52 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwoA7-000uCO-IP;
        Mon, 13 Dec 2021 17:26:51 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 09/11] reftable: drop stray printf in readwrite_test
Date:   Mon, 13 Dec 2021 17:26:31 +0100
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
 <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
 <6b0af68f0b94fb96c81e25f9a1911fa05dcf07fd.1639411309.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <6b0af68f0b94fb96c81e25f9a1911fa05dcf07fd.1639411309.git.gitgitgadget@gmail.com>
Message-ID: <211213.86czm08o8k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 13 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/readwrite_test.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
> index 42caf0bde4c..f6546d7b8d1 100644
> --- a/reftable/readwrite_test.c
> +++ b/reftable/readwrite_test.c
> @@ -663,7 +663,6 @@ static void test_write_key_order(void)
>  	err = reftable_writer_add_ref(w, &refs[0]);
>  	EXPECT_ERR(err);
>  	err = reftable_writer_add_ref(w, &refs[1]);
> -	printf("%d\n", err);
>  	EXPECT(err == REFTABLE_API_ERROR);
>  	reftable_writer_close(w);
>  	reftable_writer_free(w);

Is this something coverity raised and I'm missing why it's bad (per the
CL), or just a stray unrelated cleanup?
