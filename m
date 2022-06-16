Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A0FC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 14:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377463AbiFPOAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 10:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377285AbiFPOAr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 10:00:47 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965671DA43
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 07:00:46 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h8so1537385iof.11
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/gxW/uZnMcGpe1ZgZLqYOfg+yw0YQh6CbdCQu+FbK9I=;
        b=IkoWPspNfUmIDiVAjyPmuggPOiFb2dUf/5IlQseeY2S2EU+ks+FR2H8I079hYiSeWU
         aTjfXVuiwrGN5yMDGBV+HYmmTlxDzL/7mVTzDqZ83jk2OZ1TbfDAW2RwmPMXG+cbYTOa
         uzjyEjd+hdvWbIECcZMoJq5XFQZA5PPujlsmHH6Bli2/HVcYlCVlIz/6oaFmLv+kNn39
         cfemRYJTQ2C26KBAqiZvzIZsndUqtZAfYTb2l3x6y3sxJSK/db2aE1Vt/+KZF9g0s1TI
         3oeabX0ymVSZdaHBOteicxWH/XY1zoQ+TEZpJwGAsVBNRMf6HQ6+naND6AtTvQoW77jN
         7KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/gxW/uZnMcGpe1ZgZLqYOfg+yw0YQh6CbdCQu+FbK9I=;
        b=RE/rGNPJX3jo9luAL1qUpDthLrjpiq89xZ5rML2/DTEMg/qgTNkTJziOle8OW0ZBw6
         NIol2rLgJ7IATer/sYal3P6yNSLGCN2LL9bcVu3HSKZM1tAK0NDlPpSf+2G9J8uHTD08
         bLXGBpPz08ppxhv7/BT+BjZsPjwl94U3a3JNeBl93SJ+Mj6+Hvenm+35gCF0VUBIXbZn
         mUHdd7fv3sepLqROag5me90h/xQTct1f9V38KAKGc8TBpICvoXqjlrrou0FAFYgndIp3
         U1NzzfpFLsNfQZn69BV0uXXRMQKGfEx8g2N0AX/cuXSgzcYJZUsYWLT6sm3rWIwknCMm
         cqyQ==
X-Gm-Message-State: AJIora/TRalQcWMUm8CCgF3Bf+55AG9ZHnDofE/xoow/I3Bg6YvD4bFw
        El2qRB3SIDjl1xUdLdlZ0NY5
X-Google-Smtp-Source: AGRyM1upddpIF7ch+sEWX/dO+XHbY9RBB4Pbetg5eRJ+UR/pTdjnvTTpnp2rrqIglm9z2gYOWdcu8w==
X-Received: by 2002:a02:6d2b:0:b0:332:1027:a2dc with SMTP id m43-20020a026d2b000000b003321027a2dcmr2655658jac.65.1655388046001;
        Thu, 16 Jun 2022 07:00:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:cfb:ad5:8ed2:9eba? ([2600:1700:e72:80a0:cfb:ad5:8ed2:9eba])
        by smtp.gmail.com with ESMTPSA id i12-20020a02cc4c000000b0033428e3000esm907295jaq.109.2022.06.16.07.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 07:00:45 -0700 (PDT)
Message-ID: <1682f396-018a-8751-1907-7c244fe06ea9@github.com>
Date:   Thu, 16 Jun 2022 10:00:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] is_promisor_object(): walk promisor packs in pack-order
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Richard Oliver <roliver@roku.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, jonathantanmy@google.com
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
 <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
 <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
 <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
 <YqkpRE8nykqVv8cn@nand.local> <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
 <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com>
 <1fe6c00a-806c-89de-cb67-d063dc4a5279@github.com>
 <YqrIrYHKUP6b/EtN@coredump.intra.peff.net>
 <YqrTsbXbEjx0Pabn@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YqrTsbXbEjx0Pabn@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/16/2022 2:54 AM, Jeff King wrote:
> On Thu, Jun 16, 2022 at 02:07:41AM -0400, Jeff King wrote:
> 
>> Those rev-lists run in 1.7s and 224s respectively. Ouch!
> 
> Even though I expected the second one to be slow, I was shocked at just
> how slow it was. The patch below speeds it up by a factor of 2, and I
> think is worth applying separately, regardless of anything else being
> discussed in this thread.

I agree. It's extremely simple for the value it provides.

> diff --git a/packfile.c b/packfile.c
> index 8e812a84a3..ed69fe457b 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2275,7 +2275,8 @@ int is_promisor_object(const struct object_id *oid)
>  		if (has_promisor_remote()) {
>  			for_each_packed_object(add_promisor_object,
>  					       &promisor_objects,
> -					       FOR_EACH_OBJECT_PROMISOR_ONLY);
> +					       FOR_EACH_OBJECT_PROMISOR_ONLY |
> +					       FOR_EACH_OBJECT_PACK_ORDER);
>  		}

Thanks,
-Stolee

