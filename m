Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE990C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 12:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D9421D79
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 12:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYxp2ZUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635830AbgDPMhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635690AbgDPMgz (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 08:36:55 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63046C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 05:36:54 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s30so16201976qth.2
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cy64lx1ctMl/iXVHBI0f+iUYxK1DO6Reg+v+Ujt9LM0=;
        b=pYxp2ZUveJbYiMnv37gJ9Fa6zsnwWt2qA2cDJxI/KyFS7vrbTEVfbflFRImEyruspB
         im0Wotfw6H8gJwZhPxEzj3XktCf8MlbyDJKQvCfNq1FNRkRApjuK8TIVykL2fnxJQFkS
         VEs3pp4Njg4YxU1H/WdatQDiX9TLftPVkadoDBBKQ0BSpV0gAb91YScdypSra/pTpmqn
         /bi5KnoWGpnC/vQ9gzhajdUVZv72Hd1puv0kMXRM7GiJcnOwd1XYsxRdwMTB06ZDDYJm
         ZXnJ1Tm9/bUm0w2qN/93a0VAeTvM7hpZ7tJielozolmhAFtAk456y0818gbIDBzW2dCh
         94xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cy64lx1ctMl/iXVHBI0f+iUYxK1DO6Reg+v+Ujt9LM0=;
        b=WXCyw/KRJ8nvCiXksGAmg19bbdI034tcNyzRs3twdsGupLajsasVbPd8DSgzYPNSBz
         uj5hZY1JGCt9eFpN2iiLUfhA4P8z23hqnJzGoJ6NiG6TbxY1Mfm1Wxu6YvJivzot1qZ9
         g2Jq1RwMiBvERJLuzIEH1/YB5Jj1+JAqihxUZHnZJ9T3D93qv6w0xxuLDwT6ljuqkmnp
         lnMXrkCJeSRWZ9VkADozmTVhnvAiscPbzcIbJKBaM9/Fz3EKkxqr3c4AoUcDqgqycgZQ
         Xs8X3sanBoGS4i2yiMh88F051rF8Cjiqt0VjU+9lTmcJGfI87/XfqpR/Z7fyOvPaI72c
         ldgw==
X-Gm-Message-State: AGi0PuZVLP5d0sxUZcITvO9I8Pg2z9TRm3ysPID80QnosgXlXRmFgXe+
        w2yEIyzl8SBZkWEgHbRx6xBPKFQ2NbI=
X-Google-Smtp-Source: APiQypIxTLmlULbpFn60claNGGPLldd2XM6QdOBjP17cxEPJwYuTnE7LnhElr3ga77OBVG5CJ9P6pQ==
X-Received: by 2002:ac8:45cf:: with SMTP id e15mr26409050qto.21.1587040613482;
        Thu, 16 Apr 2020 05:36:53 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g133sm2692243qke.73.2020.04.16.05.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 05:36:52 -0700 (PDT)
Subject: Re: [PATCH v2] log: add log.excludeDecoration config option
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
 <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com>
 <xmqqftd47jce.fsf@gitster.c.googlers.com>
 <xmqqblns7j4u.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <681fc3a9-9402-44a0-dc73-56c8ad14ba47@gmail.com>
Date:   Thu, 16 Apr 2020 08:36:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqblns7j4u.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/15/2020 1:29 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Hmph.  Do we still need "found" here?  If there are include patterns
>> given explicitly from the command line, a ref MUST match one of them
>> in order to be included, and a ref that matches one of them will be
>> included no matter that exclude config says.
>>
>> So shouldn't the updated logic for the include patterns part be more
>> like ...
> 
> I still think that the two clean-ups I mentioned are both worth
> doing, but without them, but with the simplification of the code 
> I suggested, the resulting helper becomes like this, which I think
> is quite easy to understand.  It seems to pass t4202, which you
> updated, too.
> 
> 
> 
> int ref_filter_match(const char *refname,
> 		     const struct string_list *include_patterns,
> 		     const struct string_list *exclude_patterns,
> 		     const struct string_list *exclude_patterns_config)
> {
> 	struct string_list_item *item;
> 
> 	if (exclude_patterns && exclude_patterns->nr) {
> 		for_each_string_list_item(item, exclude_patterns) {
> 			if (match_ref_pattern(refname, item))
> 				return 0;
> 		}
> 	}
> 
> 	if (include_patterns && include_patterns->nr) {
> 		for_each_string_list_item(item, include_patterns) {
> 			if (match_ref_pattern(refname, item)) {
> 				return 1;
> 			}
> 		}
> 		return 0;
> 	}
> 
> 	if (exclude_patterns_config && exclude_patterns_config->nr) {
> 		for_each_string_list_item(item, exclude_patterns_config) {
> 			if (match_ref_pattern(refname, item))
> 				return 0;
> 		}
> 	}
> 
> 	return 1;
> }

This reorganization of the code is much cleaner, and it can
guide cleaning up the documentation comment in the header file.

I see you included it in a SQUASH??? commit, which I will squash
into my branch for v3.

Thanks,
-Stolee


