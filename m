Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4988C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 09:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbjALJZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjALJZE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 04:25:04 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160EF5AC4D
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:13:51 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id l22so13446845eja.12
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Do9hT/q5qzjUBXJszTSj36VnNqatmT/EQQ70MvoWS4w=;
        b=NBAg6CY8g0Zs/8InalOXym2NiPIBNwB4Iu+OWbcu04bwLtRxVSXqc7RHlitLtnwBPC
         l2Kx4fDUCoVHRvjE5mrQE352kShYFIeGTOPV7RABpO+HNYKuAy6/LSVa00r/bas2OwWr
         2KdEsJ2Zggk4mjvmATsw/TVO0Svr5L14W+oMgahKE70P7A2QldajHmVqg8mZogmudatM
         eGpGkxTRFPMiuQjDJZJywLQ/k6XnpYrWelNby1LTa8uGk4tgiv8wWDviM8ksTlJ88Rpp
         hdOh71eBitZ1vUGpgsFtdW7zqHvwrz9nddqtEhZ8GbseTkbmFki1A0zUBMfUjHXG7Nos
         l+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do9hT/q5qzjUBXJszTSj36VnNqatmT/EQQ70MvoWS4w=;
        b=haiecTHwwKxNg8jf86n9kh7c3uyPpYRJOXi/1lK08yT47SZfB6iJFgjGGqm2Pdhelg
         XY+Ss+0tLD2WiIK59CiDRis7sroKNCvbr98QgNZHOPqy5uzeRuHV9J6sOmD7/xN4c8Cn
         9dxlhFBoFyX3RE/+pl5RjjRd+mKx3+ywQOkS3el7iLP7xwoWoDSbKc6R1/Xe+MPHKDtm
         /F09W9zm/k10TIflYWM1zw7ZOOhkRkYMGkEhxEsI/hNQ0EfSWTYsSugrsaKykpqII11I
         XhrbcFBNRA2VX1Cwg5VYADDUWclm2jKC6vHpxFScnYnEF8744MgcIEY9nIpAn2lI4gn2
         4qew==
X-Gm-Message-State: AFqh2koWGQQr1ajSO4C78XsbevTEUAh1/b/KZ5crbTb/pMWN+8FTFzPV
        QdhIO9hcW3O6au9AlcDgsaQ=
X-Google-Smtp-Source: AMrXdXtyXxlbSc/fr+39ltnKNuEFMra4zktDu1VKSTDs51jcTTVVysFbh+t5ZKBZIHUlk0FrRLwQhQ==
X-Received: by 2002:a17:906:eda7:b0:7c4:f402:9769 with SMTP id sa7-20020a170906eda700b007c4f4029769mr81868616ejb.76.1673514830374;
        Thu, 12 Jan 2023 01:13:50 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709062f9700b0084d3bf44996sm5698450eji.142.2023.01.12.01.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 01:13:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFtef-0005TC-1i;
        Thu, 12 Jan 2023 10:13:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/5] object-file: inline calls to read_object()
Date:   Thu, 12 Jan 2023 10:13:20 +0100
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
 <Y7l4RznPhTr+O8ZP@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y7l4RznPhTr+O8ZP@coredump.intra.peff.net>
Message-ID: <230112.86k01s2jzm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 07 2023, Jeff King wrote:

> +	oi.typep = type;
> +	oi.sizep = size;
> +	oi.contentp = &data;
> +	if (lookup_replace)
> +		flags |= OBJECT_INFO_LOOKUP_REPLACE;
> +	if (oid_object_info_extended(r, oid, &oi, flags))
> +	    return NULL;

Style: This is "\t    ", but should be "\t\t".
