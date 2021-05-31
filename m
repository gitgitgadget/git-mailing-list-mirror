Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9880AC47095
	for <git@archiver.kernel.org>; Mon, 31 May 2021 03:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D35F61186
	for <git@archiver.kernel.org>; Mon, 31 May 2021 03:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhEaDhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 23:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEaDhf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 23:37:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F3DC061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 20:35:56 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q15so7316694pgg.12
        for <git@vger.kernel.org>; Sun, 30 May 2021 20:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cFFhwb8l6fH3svKkxDcGBadWOIv2wz994H8O/iOGnIk=;
        b=MDiQ2y5lpUBFXh5u2bH6UMLWA8oolCPoOR9JBQlnHETj/gfBHbIM0zLuC/KVs94Wp3
         uORY2D0rIXc+0TZEcZ/AlOUBBTFeA9GKs2QFEa+0rpLQfuZhB/1ZeiyF1OesAgCpTqlS
         vkd8fatknz0NO9taxM1mgeWtLTTSVXiDEDLItpqpPI/TMCTAQjca4uiBWdCbbttli9w0
         TTBQyTvra3tT0gkfEnYRZQHbhg2sxQAlzOJNhKVbC/odClCGZpBY1P6GSpZk8+ki+k1K
         6F1DXXMk6XbV6wVfy5zApnTFgI7n+aNCBc48vCcmVRiwVjBmLELbdtRWrnRan1ndcUkD
         xJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cFFhwb8l6fH3svKkxDcGBadWOIv2wz994H8O/iOGnIk=;
        b=DGybUwxjAgN7NWhCP7aco0DlqifI/gfBspl8Bsj9w/+LjEb+bwTsb5L8tbGXCtFTsD
         /16EHraj7cLFSJVa2kPzxEWXaGYFOfNc8+DUxEIQem5APl7hZA4SbqsggOG8Pzej+b3C
         nA+8B82fHjkOEQFn4OM7Nqme662rc2blX9fkv1++hKi+iBs3wTl29qtSscI2D3HOlNam
         W0syeTbv2sw3MB2l3stbH7ks0z4bN5BSMIW3lqFSg8OaqvH+6Nutv3Wcrry2797XD80v
         Pra/3RjeoWTc+5wdpaia9yHc9ncRK0PUNoOrxCxpwkdTwRm2IinheZ+kEGhCouU5r6g1
         Q0HQ==
X-Gm-Message-State: AOAM531ScOR20DYf4ogWnu7jYPRWiV+mm14n0RRDYZkcehbBaUgl7XPO
        ShP1rNvx508B6cOTkUyAvtNHUPpIE2wPZQ==
X-Google-Smtp-Source: ABdhPJwBa3D3TBv6/GvC5s7Lln5xIbIwfN+42WtRJkBLrvEK1y68bOqoLezakCvGSBg0Vza2InwI0A==
X-Received: by 2002:a63:2bd5:: with SMTP id r204mr20428873pgr.426.1622432153870;
        Sun, 30 May 2021 20:35:53 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id k21sm10226302pgb.56.2021.05.30.20.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 20:35:53 -0700 (PDT)
Subject: Re: [BUG REPORT] File names that contain UTF8 characters are
 unnecessarily escaped in 'git status .' messages
To:     Thomas Guyot <tguyot@gmail.com>, Yuri <yuri@rawbw.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <f7e2e271-dcec-2886-f33e-62778a429850@rawbw.com>
 <xmqq35u9ax5j.fsf@gitster.g> <6318ccec-ec96-91a8-fd65-85daf4a9a22b@rawbw.com>
 <20210527045628.uvesihyhtqrfyfae@tb-raspi4>
 <YK+mWZP+sl3zXECx@coredump.intra.peff.net>
 <4dd22f16-72f0-a28a-8be0-aec622acf0d3@rawbw.com>
 <50e2780a-21f3-499f-7960-76bf24f550f0@gmail.com>
 <6fef4b1e-1ec7-b697-c311-59caf6408b29@rawbw.com>
 <20210529092752.kifzqt3haddzgsob@tb-raspi4>
 <YLQHPu0bIy4qHEWP@coredump.intra.peff.net>
 <481fbc88-3e7d-6b00-0997-1a80b87a637d@rawbw.com>
 <c1afaf46-0425-110b-6303-f68d3f994b7f@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <ec3adb99-ba20-8db6-4bff-eae7524e6361@gmail.com>
Date:   Mon, 31 May 2021 10:35:49 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <c1afaf46-0425-110b-6303-f68d3f994b7f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/05/21 08.14, Thomas Guyot wrote:
> Even if the terminal supports UTF8, will it print it properly? The font
> used could have no or minimal utf8 support. Even when it's supported,
> some characters might look alike and this could have undesired
> consequences (ex accidentally switching from a normal space to a
> non-break space while renaming a file that has spaces...).

On Linux distributions, Noto and DejaVu fonts are often installed as 
default fonts, because Noto has almost complete Unicode coverage and 
DejaVu Mono become goto monospace font.

And yeah, we steer clear of using non-monospace fonts (either serif or 
sans serif), because many terminal-only programs depend on text 
alignment which often can be achieved only with monospace fonts, and 
reading texts on terminal screen is vertical-oriented as opposed to 
horizontal-oriented texts like books.

-- 
An old man doll... just what I always wanted! - Clara
