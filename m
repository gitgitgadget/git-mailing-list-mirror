Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16C6EB64DD
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 10:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjHGKAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 06:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjHGKAx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 06:00:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8097310CC
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 03:00:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31783d02093so3807588f8f.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691402450; x=1692007250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B32oivsZ2ZJznzvikWCykx8nghbn1lv5bGGuzGBoVGU=;
        b=LqjigKiVfyZbvFCmHxb0zVpZHTjwCDetN1QazDdSsVmijeCQHq881qFFvSO8gLznzS
         AJW/4nUET6o4cFeM6KXjJ5JyWneq1QuP5Ivbl4P6MQsHW6r3g4B83mq+71Bg6uOSi0Hw
         KjP960sfz/t9C5WLWgnwSASlJdLS5azHCBXp9lqRA6baO4RhffRQWzJ2X3f8m4U5tfd5
         SVktJPozanDMGwDtvjP7CTz6yEeqmCBJj6a2EfgokxlP5FYvyJCxBIyJj116QwDYexoW
         GeIwX6eVrlqFyRos02LVY6EzDeP0sFEbcrZDtyWDpOibvLVavrRQss06qFX3tbkQ8w+a
         E7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691402450; x=1692007250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B32oivsZ2ZJznzvikWCykx8nghbn1lv5bGGuzGBoVGU=;
        b=lS/pmbiQGik52PoJglLNwyMR+bFIguwE4rBGfB1eO42Ie0SBCrG9eBQicKnAIXogLJ
         95KRnD9wojC60JstyWQw/ftube2H2DNLNs6CJGqNb89lvNiue8piEoQ+3Q9RkfSrrqhw
         eMdbrDi974hsN/3TL6BbWLGoSnwzxR1thYCY4Iynp2j6z7O/Wbito/hNlQO2ABIgYdGZ
         QI89juG90Dc611aBr0MobYOVp4XRidNWv+bDzI2JOPp7hhEUC6gcvYXUP1Wu4w+BJoqL
         bjGimhGJwrDFHDUYua+D1o7jdbSxFeqiNeQk+7AV7fVyVvUyNjJbWUejUyL953QPnUJL
         u+MA==
X-Gm-Message-State: AOJu0YwwMSCE7mscP/SF/lcn46hFPPvj+M96Rqd0P8vdNCO30ZSSY7a3
        nMT1+Z7JV3swKTnoOvsCIHA=
X-Google-Smtp-Source: AGHT+IG0QbTffBfgk6ZULkKciwRIfdyDYvs/knqB6GgIMbZHHaMJQGWIPfOmhzQX0e82VPh3NYX/bQ==
X-Received: by 2002:a5d:62c6:0:b0:317:6992:855c with SMTP id o6-20020a5d62c6000000b003176992855cmr6064278wrv.19.1691402449738;
        Mon, 07 Aug 2023 03:00:49 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id e10-20020adfe38a000000b00317a29af4b2sm9935431wrm.68.2023.08.07.03.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 03:00:49 -0700 (PDT)
Message-ID: <b6690531-c5e7-5fdd-107a-22c3d2435b5e@gmail.com>
Date:   Mon, 7 Aug 2023 11:00:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase --skip: fix commit message clean up when skipping
 squash
Content-Language: en-US
To:     Marc Branchaud <marcnarc@xiplink.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1558.git.git.1691068176051.gitgitgadget@gmail.com>
 <32c8a181-76aa-5c90-427a-53b1ccdec8a3@xiplink.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <32c8a181-76aa-5c90-427a-53b1ccdec8a3@xiplink.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08/2023 21:38, Marc Branchaud wrote:
>> The fist issue is fixed by splitting up the "if" condition into several
> 
> s/fist/first/
> 
> (I'm not qualified to review anything else about this patch, but I like 
> its intention...  :D )

Thanks Marc, it looks like Junio fixed that typo when he applied the patch.

Best Wishes

Phillip

