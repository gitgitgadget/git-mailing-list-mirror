Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B444BC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbiBOWKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:10:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243913AbiBOWJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:09:57 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D9123BC2
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:09:46 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gb39so262503ejc.1
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=a6Wwv4rzokX++mfLLagjr9MXnqaqvLgpKyXr2gPWqiw=;
        b=bTBN3TZLOWHohilKtoRC70F7/WRzDy7cj3kQMykUdVzX8rTTXjB3CHznYBolL+QtKt
         IYjJ4PcVgXOeEHUxjJjamI8c9emSiJcZ2wz4n5GuGlXxX06SyLPz/Od3mUZtDfdT7DkI
         Jc73YdCHBGkN/VOoan0KWvWrVCeBstWk4LSmZ6ApvL0s58o6KWDcJd+e3u7EEwCho6h6
         MrRx3qz3GtqpIVVMEypFhhkPrK3EwOoDD04Ud9o44eDKnn8M2eplc1uRf7KDfzJ1Pol4
         ytdLSp7PmCy+Q3RzDgwU/3seV5cZiEBBcQ3sqvN7M8FRdoAeNEEMLOKE1NGnIWs9sXx5
         q0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=a6Wwv4rzokX++mfLLagjr9MXnqaqvLgpKyXr2gPWqiw=;
        b=dfnw2uurph4tSQjA3FUDdqbXaI7QIZMB/lxTQJARhbOLFVtM6NlWHM0hgVEskOQhL2
         Z/n3HjB/KOPubq9NNIJNrFj9b195FzYJq2fAMbRarGs0j+DqeS+1/kuodn2mbNzkGL8W
         +VXhneKXQBzeTyLylaM0G4AGJtz9jVRcQTQs1ysYBpCEIpWVgLsGxfiAUg/f8m6sHpNe
         ekvto0TYpUNT3qXSX/obF1yAhxoN7SLIN0PzdxHaJ5Dfa8lxAr+8kXj422CRQRnweiYz
         C/G6vUowg4dlUCDYM2m1x4eNsie7Atp61wDLyjmf5z4bWDiiQ8dmTDVXTyNCjKAe9KmG
         2wbQ==
X-Gm-Message-State: AOAM533sLMAoRVzV0eAn7rjlD0e5/+AiLilKFU4YmMyD/d6FSq4S12s+
        O86HuXrBHUaSMgdXbezQkiFTryOGnz4=
X-Google-Smtp-Source: ABdhPJz4PWkBiuXXLxlQDEcSxT356nc0ciaxhsb7d/WALvsqe0cmGFRXBzh/sC+njAlUFNsNYlYqJA==
X-Received: by 2002:a17:906:2dd6:b0:6ce:1052:d10b with SMTP id h22-20020a1709062dd600b006ce1052d10bmr109531eji.118.1644962985019;
        Tue, 15 Feb 2022 14:09:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r2sm11345411ejo.65.2022.02.15.14.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:09:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nK611-002tjX-Ux;
        Tue, 15 Feb 2022 23:09:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/9] fetch: fetch unpopulated, changed submodules
Date:   Tue, 15 Feb 2022 23:06:24 +0100
References: <20220210044152.78352-1-chooglen@google.com>
 <20220215172318.73533-1-chooglen@google.com>
 <20220215172318.73533-8-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220215172318.73533-8-chooglen@google.com>
Message-ID: <220215.86ee43wzmg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Glen Choo wrote:

> +		switch (get_fetch_recurse_config(task->sub, spf)) {
> +		default:

Unfortunately get_fetch_recurse_config() returns "int", and the enum
fields here defined in submodule.h aren't of a named type, so we can't
get the advantage of a complier check for exhaustive enum member
checking here...

> +		case RECURSE_SUBMODULES_DEFAULT:
> +		case RECURSE_SUBMODULES_ON_DEMAND:
> +			*default_argv = "on-demand";
> +			break;
> +		case RECURSE_SUBMODULES_ON:
> +			*default_argv = "yes";
> +			break;
> +		case RECURSE_SUBMODULES_OFF:
> +			continue;

...in any case there's a lot more of them, so just having this "default"
case seems to make sense...
