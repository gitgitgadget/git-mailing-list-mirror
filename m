Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EF3EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 22:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjFPWe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjFPWex (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 18:34:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8442D6B
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:34:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f7378a75c0so10142755e9.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686954891; x=1689546891;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNjkPXNpK39EB47t58fmgOzYY+aj5YQWZYDikE44ygk=;
        b=NWWIS/Jh8/kbtXo5WN84MXcQgrnvN3OO7fodvMQKJn6fRzYuEl9+g0AisVSQ83j42H
         ey1KbiceN7o1K/L4SR3EbhmuG7CgSU2bpcLYCuULoK6uWgcQnhBtfckPmo/a7VnoNm6P
         YiZpHsS7/e54Ce0kiB3308zKjYZJuXVXmayfIyj/9w5YH1OgpGFiRakIckJU7vsND6wE
         OVfGLHHY1X3H+5nU7vXFMMw0+8hiO3kvY2ncr5851wuQEU8s3ngloIhaJiyU2pK4wJRN
         aHTj9j/zRMG6kT6mko1vqIy7YObSxJfg3X9FhG2Y9XEe4vWZU+Lzl3rqUtecVdCf0hF6
         /Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686954891; x=1689546891;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNjkPXNpK39EB47t58fmgOzYY+aj5YQWZYDikE44ygk=;
        b=BXKlvhan1dCEPjY/6V+kt3EA5HFsR7H6vr2XyTpK/BGIW58jGvtVGfdozTBGIwsMQ/
         qvZrAqYbWczDdT8VYUroXfT1fW7sOaOO8sze/OM0jUTxxL1EFGmqTcmCTctFy10/Vk7s
         Or/GMlDKNriteZ8guypN8dF/N09SFanI9GLFIyaRKz4H4rtTzPatKxu3Bmd2gCOJpHyx
         uz9mqCN4/+54sQjObR3SNjVBgYxD7q9+mV6nZRaPcmsn+5jZu0CHsPRNYw6AmpYExymR
         ATb06BaBbOIUlY2TbWLqK4KxEFFMyp8cw6FDdcMCXxZ3gL16ii3BZ8GsDnYEiNG/DKGG
         tsZg==
X-Gm-Message-State: AC+VfDxJ0yyUNnvOM/pfoh2nPzdDAjQ9ATfA7mbgs8Wa8oom3wEdYcVe
        zjcwWztiIofTpN9I/NRuRQL/19rM/TE=
X-Google-Smtp-Source: ACHHUZ7REV4YVCKRgshEkdBcT+iKbDOnR8T9lwQaBzb6piWcdJtebg28nMsVgPDOkBOvvuRPWTo99g==
X-Received: by 2002:adf:fc82:0:b0:30f:c188:67e0 with SMTP id g2-20020adffc82000000b0030fc18867e0mr2602035wrr.21.1686954890974;
        Fri, 16 Jun 2023 15:34:50 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d4643000000b0030fd23381ffsm5692635wrs.11.2023.06.16.15.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 15:34:50 -0700 (PDT)
Subject: Re: [PATCH 01/11] rev-parse: fix a leak with --abbrev-ref
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <dc821efb-bf2a-10bb-4547-98d4ba11dbb3@gmail.com>
 <20230612031239.GA306352@coredump.intra.peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <3e124763-944d-e147-88fb-cb989fbd06b7@gmail.com>
Date:   Sat, 17 Jun 2023 00:34:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230612031239.GA306352@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11-jun-2023 23:12:39, Jeff King wrote:

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 852e49e340..6dc8548e1f 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -156,9 +156,12 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
>  				 */
>  				break;
>  			case 1: /* happy */
> -				if (abbrev_ref)
> -					full = shorten_unambiguous_ref(full,
> +				if (abbrev_ref) {
> +					char *old = full;
> +					full = shorten_unambiguous_ref(old,
>  						abbrev_ref_strict);
> +					free(old);
> +				}
>  				show_with_type(type, full);
>  				break;
>  			default: /* ambiguous */

Simpler.  Nice.

Thanks!
