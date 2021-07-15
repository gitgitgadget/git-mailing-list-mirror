Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7D2C5CFC2
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A21611AB
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhGORkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:40:06 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:40626 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhGORkF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:40:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 168DCDC8;
        Thu, 15 Jul 2021 19:37:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1626370629; x=1628185030; bh=u5cAwgi6/l57wiUrwr3
        FAi59h8D9ijb7bGiBMLqxXVY=; b=PA9lOMjbWj+ojJFxOc7DcsUJJl5QIIQQ7f7
        7Le9bGvW1r6qo84Ic7za9yeN0HiYhLmfw45st0lEDgHnD0+C6Azv0pLuvQeOQPW8
        W1V2ULCnOz13KM7h5ZdNcrgYFTnh9yrBC6wkd6bkbEKsW7Zte/EUrS65YbjLeF+B
        vSvSUivFTaIgsap13LrKqesA6xycISYv7EbKQBGURFqvJ2O+xIzUc9cpfPlkFhe3
        nis6i1rt4pFxKb7rS6OxtnV4NmVRx63woYFAfxh+iQaa5Jcb1/K5xDyJ5mBh30zm
        ij8Dc9ePq4xyRUWEa8B9BiYVBpZSfDQpb/D2fGl3YyF1a/1t9lzQlIA3z/x54cSm
        4m6FugmKnNQl6lbwh3a4Ski9tYBhP5RmzGF267ZsjVAenTk88BJxGBpj+iYRSRQy
        7VwqQUh84gy1T5YATDoFaQwrsK3R4+rBDuEe8+VafVyEBcCbzDV8z5xS2DFzW8lt
        hY3ZGLv6GYZnD8jQDwB6noxFc+ubfEgMvhFhp/il/iq4GBEAsxbT8ohsPedu4FOm
        D8jFTTLb8bgPibW/Ufbxc1UYaKgmpSRub9FmFxrzSOqf5ifJBZGi69Y+cGYCuuXa
        ayRvii/9NN+PLPLDPt1WWWUgqVIurf7SDqRLbXnHqnvCoU7c/HxkduBwBrcUQjhO
        LB0aW6J8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RJvPvv6D73qh; Thu, 15 Jul 2021 19:37:09 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 4401468F;
        Thu, 15 Jul 2021 19:37:09 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 3425B43D9;
        Thu, 15 Jul 2021 19:37:05 +0200 (CEST)
Subject: Re: [PATCH v2 3/4] SANITIZE tests: fix memory leaks in t5701*, add to
 whitelist
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-3.4-b7fb5d5a56-20210714T172251Z-avarab@gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <c6c7cfea-8292-2034-f9d6-de350e6e2692@ahunt.org>
Date:   Thu, 15 Jul 2021 19:37:02 +0200
MIME-Version: 1.0
In-Reply-To: <patch-3.4-b7fb5d5a56-20210714T172251Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/07/2021 19:23, Ævar Arnfjörð Bjarmason wrote:
> Fix a memory leak in a2ba162cda (object-info: support for retrieving
> object info, 2021-04-20) which appears to have been based on a
> misunderstanding of how the pkt-line.c API works, there is no need to
> strdup() input to, it's just a printf()-like format function.
> 
> This fixes a potentially large memory leak, since the number of OID
> lines the "object-info" call can be arbitrarily large (or a small one
> if the request is small).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   protocol-caps.c      | 5 +++--
>   t/t5701-git-serve.sh | 1 +
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/protocol-caps.c b/protocol-caps.c
> index 13a9e63a04..901b6795e4 100644
> --- a/protocol-caps.c
> +++ b/protocol-caps.c
> @@ -69,9 +69,10 @@ static void send_info(struct repository *r, struct packet_writer *writer,
>   			}
>   		}
>   
> -		packet_writer_write(writer, "%s",
> -				    strbuf_detach(&send_buffer, NULL));
> +		packet_writer_write(writer, "%s", send_buffer.buf);
> +		strbuf_reset(&send_buffer);
>   	}
> +	strbuf_release(&send_buffer);
>   }

Good catch! strbuf's seem to be a common source of leak, where either 
the release is forgotten or detach is used incorrectly - and I'm tempted 
to try and implement some automated checks to catch those (I wonder if 
coccicheck is powerful enough for this?).

>   ...
