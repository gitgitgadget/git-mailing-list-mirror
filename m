Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B0C6FD19
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 17:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCPRqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 13:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCPRqd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 13:46:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DB6E41DE
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 10:46:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r18so2301854wrx.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678988779;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DoM5mf4+E+dswt9ye0rr/t+eEgsbVGiDGEWrq3LqyB0=;
        b=YroHAKrFI8+GEEpqyk7Y0Yks5GCZ9Iw4579yVnUyhgZGSY4VZRce1nS2A/whR/BooN
         yi7fix2W0w+D9bFtR6J9q7zNXwyRxVxR9e6jNlVVoHYpHxQfieJI7iLnVfGP3A1Ab8V4
         KC9M5QgkX/082M1vVd/Pmt/4pn7BB9FqVoLCmccFpnVmGCON16kaXBk8OZumV2igLqaw
         hz4Ztw33LPjLaR1ScqXqhgN1lahHutbyboKcU0lIC/EEIMM29Hcn1F/2gORjIXIpdjMm
         f/IdXg/ZFLCLxSOOxOksI3cQXPmMv/jSb6UiqDcV6tBzbCCDhF/s3zIY3OhYEK+/xt+E
         TVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988779;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoM5mf4+E+dswt9ye0rr/t+eEgsbVGiDGEWrq3LqyB0=;
        b=wlsXU8I156EaVWmVrcZqwqEtgoPfBOtIdq1zZljLvgWbIQT5WQ2WnIe99srC9c2n5+
         VaGsfNbgohXnrvHkxgMjUsE5i7O5PXpYJQFQJG+DoiZg2/GBZcOkNWMQyUyHsp5X94E8
         L5LSx98JUKnP6G9XfEJgIdF6nzqzGV1KuPuakJ34rI1CWnnxt3HGKRWY2dN4qumKrfdJ
         yobh0FL4G9WPY+I6KIH/2b82Ku2sMTipUeHheD0l+TbWtRogyua4qIO0kug2meecsM28
         RqCBL9YvTPgcfjIERnhfjajF4QqDXTccfggvwmCQnCITpbW480HfZ5AnwFcEegRClRjX
         QDFA==
X-Gm-Message-State: AO0yUKX7MYZoFnqtsXWncybZiaWwW/Dhi8v4XwxGiTAYsXYiZEHvkKVW
        DZCM49OYtyvZlfff8L7UkLxHmQ2T3+Y=
X-Google-Smtp-Source: AK7set94zW0gBT4VuD0ziOqsbNIu/fj07s2q1c3bbnp2mlRKGtSpBo41bNeLGW0YzHbUo274g9AcXw==
X-Received: by 2002:adf:e792:0:b0:2ca:6cb1:c9c5 with SMTP id n18-20020adfe792000000b002ca6cb1c9c5mr5373325wrm.30.1678988779354;
        Thu, 16 Mar 2023 10:46:19 -0700 (PDT)
Received: from [192.168.1.212] ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4b87000000b002cfe0ab1246sm14582wrt.20.2023.03.16.10.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 10:46:18 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <f7577c57-f70d-cca3-3f25-18525d40d79b@dunelm.org.uk>
Date:   Thu, 16 Mar 2023 17:46:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: en-US
To:     Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
 <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
 <db9f3be7-097f-006e-927a-91be7a50360c@dunelm.org.uk>
 <3ab454f1-2bb5-d990-4cc4-4e2fde2ba294@haller-berlin.de>
 <97eec89b-6a10-434a-a9aa-54c266da7fb1@haller-berlin.de>
 <18763465-de3b-7e64-129b-1f9337ea1924@dunelm.org.uk>
 <4d13d02a-ddaf-7b8f-7a27-c7a030816523@haller-berlin.de>
 <722659e9-02ac-a9d2-b0fd-b9a2a3d85753@dunelm.org.uk>
 <805626af-b147-d3cf-5257-a5b90b7cf1d9@haller-berlin.de>
In-Reply-To: <805626af-b147-d3cf-5257-a5b90b7cf1d9@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

On 10/03/2023 17:42, Stefan Haller wrote:
> I tried the algorithm now and seems to do exactly what I want, so thanks
> for the help with this, I'm happy now.

I'm glad you've got something working

> There's a slight correction though: if a command is rescheduled, then
> git appears to re-append the last successful command to the end of the
> "done" file (it's in there twice now). So I have to check the > second-to-last command of "done" against the first command of
> "git-rebase-todo" to find out if a command was rescheduled.

Oh, sorry I'd misremembered how it works. I think it is actually a bug 
that we write the last successful command to "done" again when 
rescheduling but it sounds like you have a reliable work-around.

Best Wishes

Phillip

> -Stefan
