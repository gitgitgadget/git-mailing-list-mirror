Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D10ECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 18:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiIBSpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 14:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiIBSpP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 14:45:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4357B5A2FF
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 11:45:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o4so2840401pjp.4
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 11:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=Op8w6wu61Sy6z5JKRzSnlSjBcziu4QKBsB5bX/elMx8=;
        b=pu0MeWcxD1LSvU/gIiYQzO711T7ZtjvRbrlqQG7rsV+oYFMRGt2H+J38UXg5niDU8O
         uuoUzJTTG1wv5jWk6hKwLydiT0VBYhxdJSgckuAV3xjKiXdfy5OBwKe4PynZI544nBbY
         s0y2Ag74MF3ByCVb2CROGIj+xvHS3xxKdhTpG7WqxlSero1mTBwfT4l4sn+iwPwM3Apo
         VKq93tyukAHuvLMz61nlw1IKjMIAa0ouApSDmyfBDc6WP1g6S4s4e+I4agSC4m4A0qAp
         Lv3kZ9ZJ+4/eGueyub7GTBwhNx64fe0SMUW9t7WlISu4N11H0VbDXbVi8TkkOfmntykn
         +Jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Op8w6wu61Sy6z5JKRzSnlSjBcziu4QKBsB5bX/elMx8=;
        b=uiKS3xvMmoLInjSpB82ZdghdjjmU+OQ227jzjPfTanmYqW0sPV9wLV5VMvoX9M7G09
         kO73p+hOoV2DJ2sxcgqLLRFqI2LNKwq+OXTfHsZenFJp4OQwKfTXXbnO+J6Lb/Rk9tcK
         EMC73MBsAfo739rzfktZTdhdeJ9Z3M76Lj4JWfxkbp5smQJ+BeX0w1vey9zrqR7H3Dux
         JjxmX/ApDPZHum8Kr9WPy+CHnjYYKRHDmAQF0K0o3rW8YyHJWpWYoivC/6m/bkdCDRoO
         ZtMUmDKHrW0x2fWm8PErsNXeYrP2xKKiToyFtPuB+owIGWssAb4XOLbY0dB1HEqAnq7t
         b2RQ==
X-Gm-Message-State: ACgBeo2fjSSoNPsMjFsozc+qM2izjVS0TD/yen44/eNncYmJoqzjvmDu
        HdSOtRUwv1tDfjYNZ9yriEQ=
X-Google-Smtp-Source: AA6agR5M0KYA7708S6/K9z65dypYZHlwvMq166qAXEq+S2irtys0yVfo68hvZtH3U6iG2ZEcpuUHGQ==
X-Received: by 2002:a17:90b:4acd:b0:1f4:cf0c:7a68 with SMTP id mh13-20020a17090b4acd00b001f4cf0c7a68mr6148848pjb.178.1662144311542;
        Fri, 02 Sep 2022 11:45:11 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e126-20020a621e84000000b00535c4b7f1eesm2130769pfe.87.2022.09.02.11.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:45:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org, ingy@ingy.net, szeder.dev@gmail.com
Subject: Re: [PATCH] rev-parse --parseopt: detect missing opt-spec
References: <20220902175902.22346-1-oystwa@gmail.com>
        <20220902180134.23225-1-oystwa@gmail.com>
Date:   Fri, 02 Sep 2022 11:45:10 -0700
In-Reply-To: <20220902180134.23225-1-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
        message of "Fri, 2 Sep 2022 20:01:34 +0200")
Message-ID: <xmqq1qst8vk9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Øystein Walle <oystwa@gmail.com> writes:

> Damnit, forgot the v3. Hope that's okay.
>
> Øsse

Sure, and thanks.
