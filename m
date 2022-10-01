Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEE9C433F5
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 09:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJAJP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 05:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJAJPW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 05:15:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D247F47B3
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 02:15:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so4773042wrr.3
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 02:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date;
        bh=q/+DGIwOfg5IXRrUPEkEomIr8AtZGjwTEaaXiND7APE=;
        b=H8cued2ccwcJs0nJJr9tvWQVk34hA2yDmjL9w3FMfFpM5LrbW0VxT1t9SxIAir2R+T
         a6Bdz2V22Z9pMzCdLktuMIRfbG26Za+8c8nrLN4nIOiqzHSNeXs24LwTW/fg1U+CynmS
         usjwPRGOfGhbS/cax5RF+vanlhjeTJUn2tE1/OKVaX0nP304fzphN/SMNAi4Igb0Kn4Q
         dyM3f1q4/Tc9Vz5RTprex30RQUGbHK/UVIxBDIkuIdYhVKeCPz4kqUYSbfZXawnv1Lkz
         yOQMhfY9jTtEYhSUz18KaCh+EqpBGLuQAsn7nWvJwH21/oCm71PM8McI0DWydUfm0/Bo
         1Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q/+DGIwOfg5IXRrUPEkEomIr8AtZGjwTEaaXiND7APE=;
        b=sXo2mYuGg+wwVyNzWTCUeQyWbocID85ehEOIpqaaRsw6RIyd1LaKyL/jvpE8FS83eh
         bQkqYzRSoINDnFRjC1rfvH3XYqTU+kj4PPd6RtX9ocRCrLKjC+fWfBayLesjmPnOOS+E
         tMwkAuJq9r4QwC2fctKRG5KHh51Zptrhc0UPeE9U2KnTRmrAB3pGH5RtL0pioK2YZnNy
         9rgn+YYA5aHzFEpPq9ZwJtXWsD6vNKFdxS6Okk4L5Jcw+eGv827CpGZf5EkUU5F3lynP
         ixIGTdrh369OjeFH4IY1bFAhPepGAoHzwfGhR+1kuJVEaLn589hdwVsqIefFHxWCros+
         BhLQ==
X-Gm-Message-State: ACrzQf1KT2lNGNXvDdz+hTm4f6arOMOycY9mOTLrRIfjYlFCKHQ1wzje
        g+lfvefRCRfss8CPvnkaCtc7njOearQ=
X-Google-Smtp-Source: AMsMyM7pGPdfN2Vv31w9BI8uiWn/U0mjeDHUdNapt25lZfe0wCavTaSh7QGfs8ZMm+YEhqFI6+jnog==
X-Received: by 2002:a5d:47c3:0:b0:22b:ac9:92e with SMTP id o3-20020a5d47c3000000b0022b0ac9092emr8566070wrc.376.1664615717641;
        Sat, 01 Oct 2022 02:15:17 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id z2-20020a05600c0a0200b003b48dac344esm10398513wmp.43.2022.10.01.02.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:15:17 -0700 (PDT)
Subject: Re: [PATCH] branch: do not fail a no-op --edit-desc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqczbftina.fsf@gitster.g>
 <ba8a503b-76e2-5de9-1082-3b4c6ecd0cc3@gmail.com> <xmqq7d1lom12.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <c354947a-06d6-3852-6afe-bd560dd34d6e@gmail.com>
Date:   Sat, 1 Oct 2022 11:15:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq7d1lom12.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let me add, to my other reply to this..

On 30/9/22 0:26, Junio C Hamano wrote:

>> But.. do we want to implement this this way? Maybe we will have to
>> implement on purpose this feature in some future refactorization?
> 
> Absolutely.  It is simpler and there is not much downside.

Once I realize this is porcelain, I strongly agree with this.

The TOCTOU might be resolved, perhaps outside the scope of this patch,
warning the user or not allowing two concurrent editions.

Maybe... :-) even I would dig deeper in the TOCTOU, avoiding the call
to git_config_set if no change has been made to the branch description.

Anyway, as it is, it's good, imo. Simple and resolves a confuse error
removing it.  Nice.

> The official stance is "if it hurts, do not do it then".  The side
> discussion about TOCTOU was to see how much hurt we are making the
> user responsible for, and explaining that it is not that much.
> 
