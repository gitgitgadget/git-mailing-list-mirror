Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260E4C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 04:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIHEcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 00:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHEcr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 00:32:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28716816B8
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 21:32:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k9so23962159wri.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 21:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date;
        bh=kn7lIXJrb7m0tqtdxCKp+lJ1H5OcY0eFQqn3TbRdHzY=;
        b=G7XdTcyVJ7NyCsU42u4uI6HKUeBo8BuNU8pxT0YyVB1y6hnpihwzjPqBuzRX5iSA0m
         wwQoIFEiIVICxbKzoeImwx2LAy3oVNqVv8/tO8UqtpzAGLZgVqUJUJtOIhNWN+omb6xo
         +55hSRT9dZks5lJHF1RWxqQ7ewo+G0CTYGzubHY9OM0chAQgTuyAgvKXVmTLzlk/8aUM
         4lLCoWoKWsqmh/2rCqBz33dgVozpXOpM0RrxHF9NaHfRQWG+u3PS5QlT426i0uCcQJbc
         Ld1+YLG114p9ogWiJeLRTCx1STSLJwUBZRVsB6ZPbQnQoX71GBRXD8xMvsA6mYNb1nVa
         8Ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kn7lIXJrb7m0tqtdxCKp+lJ1H5OcY0eFQqn3TbRdHzY=;
        b=EibkvdlUCjL8BRLF+a4egBYMW6gcOyp9RYdGR9/STKPOOEMC9kS6a/BQpyOt1caJue
         FRS039anNJ653Hv3p6tOLD2tKhFTq9sg5+p1wr2JggRzCvMSL8VsmB3S1oNIcxql24Kd
         0J0Qug+Jfw6Ho+c4bSGjRsmLCKbGLeCNdNe0MByA8JWrdZT0sHqCdz5O20THrpH4HV83
         A2VF0BziDsmuWlw9bo2ih12fD56SfNZMMsg05LHEY2nxzRuCq+w1vfKPtNcUPArZ+Jku
         J0lJI2tQyP/cducyRkXUD/EqKiBsJAJaOXBtyOOEVLasVGFspQIoiJ0TRcau0XqXbILm
         y5BA==
X-Gm-Message-State: ACgBeo2IJVLgLoFFtSKPL/xGDgY/jvc8vAZw33TFm2ZMHMVXWOkjolo0
        Ve927ROlTV8mDHDgv8WJaOt/jKJDX04=
X-Google-Smtp-Source: AA6agR7kYJreQEFBYDMnkMWrSzUPW3YqMMtBQ15j7G9izy/7NHAr35kwwwn0OeIHF4As3qZDVlqq8A==
X-Received: by 2002:a5d:588b:0:b0:227:1c28:f470 with SMTP id n11-20020a5d588b000000b002271c28f470mr3946921wrf.331.1662611564613;
        Wed, 07 Sep 2022 21:32:44 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c2ccf00b003a5c7a942edsm1253461wmc.28.2022.09.07.21.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 21:32:44 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] branch: refactor "edit_description" code path
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <d2624238-048c-ac5b-1d45-e08051202c79@gmail.com> <xmqq7d2fszhk.fsf@gitster.g>
 <a5e5f94d-965b-3766-60c2-27183148e052@gmail.com>
Message-ID: <cfe2ec91-0d7a-3634-feda-82a48e79638d@gmail.com>
Date:   Thu, 8 Sep 2022 06:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a5e5f94d-965b-3766-60c2-27183148e052@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/7/22 11:24 PM, Rubén Justo wrote:
> 
> On 9/7/22 10:25 PM, Junio C Hamano wrote:
> 
> Maybe the return 1 when edit_branch_description(), was a typo I was maintaining?
> 
>>> -		}
>>> -		strbuf_release(&branch_ref);
>>> +		} else
>>> +			ret = edit_branch_description(branch_name);
>>>  
>>> -		if (edit_branch_description(branch_name))
>>> -			return 1;
>>> +		strbuf_release(&branch_ref);
>>> +		return ret;
> 
> Thanks for you review.
> 

Nevermind. 1 is the return for exit. Sorry.

I'm sending a v3 with your suggestions. Thanks again.
