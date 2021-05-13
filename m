Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F48C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A86D6143C
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhEMUKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 16:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbhEMUKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 16:10:09 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C9FC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 13:08:59 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so24654197otp.11
        for <git@vger.kernel.org>; Thu, 13 May 2021 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=fjK23bwYEWiWxFykvKN20tCAbS0CTCHIwBI/wdVe+2c=;
        b=VNSLWGQqDLg16kOP4UXZ+e4VvWCPktvXxQhPie4vyhvCgipnwU5zFhsO9SjhI9gQuw
         KaAMJRtNvBi8tGzRb6QuJHnaUTQwOApaNjPt2Nt90JtvIXwpoBAX5HEuuWrwKyWMZMht
         F8Hx0jShVmRF9kuHvZ5LHVYvmu5YpMLtc/+1+4sdz5ebiH/WYYwa2WvAPphpJs8wiptZ
         vCQzRiBkmn4r0Zxw+f81ucYjAlsR3U3UDG3cXFc65HXK88SjzGCvDgTe/XliMt+s037O
         xzO66o40kfEno6Xbwg4gSHJgexK6sFrhkXQP4BQ7Z6SKAnvSnIOznEGZ7R4zmYYuixs9
         A/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=fjK23bwYEWiWxFykvKN20tCAbS0CTCHIwBI/wdVe+2c=;
        b=figgKE3/PxYgM/CM+zzYDJZdKU7Q3wPf8C2oNugSI9mLCT+0591jx0sz3OLuIMnUa7
         i18oarb8KyuMWhzWkQh0SZcnikB11nJj9tgZiIHbDDBKq+R+cdyYVNZzwwY/igM5MWmB
         vj0F/snIx0wAbnsjEjPJA1L9xW8wNVDZcq41Lyg7b8T7rmvcr4pAc4MYgsgEsOZYvUwe
         BW4h7YDLj6Jvj2KFEh//TnmRuiNAp3DJSXiRfJbG0p0i6dXuiV9HzHs94heTzxNUuJOV
         A7uIspU2/Hg24NRJJhESg2oJY/EZ5JaVdm2Z8tawBw/QtFoDk/Tnxl+W1PgeBgQOoRzI
         oR0g==
X-Gm-Message-State: AOAM53229jB9b9b4XQ7DJ2JWz61092HLM+HtDb6EF++5OrAH7ZbhOYk1
        6xfXBS9/rZtosytpTSn54fOoES9peAB3CA==
X-Google-Smtp-Source: ABdhPJx7c+EwOg8WOLYMCt2agjgve4udbQA+3W/Y93swDnmaE5uHY+/xUm3ML0vBKBHj1WVRy0thLg==
X-Received: by 2002:a05:6830:40a4:: with SMTP id x36mr33425389ott.342.1620936538622;
        Thu, 13 May 2021 13:08:58 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r17sm874705oos.39.2021.05.13.13.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 13:08:57 -0700 (PDT)
Date:   Thu, 13 May 2021 15:08:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Message-ID: <609d875881c7c_80a2208e7@natae.notmuch>
In-Reply-To: <20210513144550.GB11882@localhost>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
 <patch-3.3-9da5bc4a0c-20210512T084137Z-avarab@gmail.com>
 <20210512235136.GB10785@localhost>
 <609cc953e0ade_329320811@natae.notmuch>
 <20210513144550.GB11882@localhost>
Subject: Re: [PATCH 3/3] SubmittingPatches: remove pine-specific hints from
 MUA hints
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Huseby wrote:
> On 13.05.2021 01:38, Felipe Contreras wrote:
> >Have you tried notmuch? There's multiple clients.
> 
> I haven't. Is that popular for mailing list style Git work? When I was
> part of the Tor Project back in the day, a couple of the main developers
> used nmh and custom python scripts to great effect. I was always
> impressed with the CLI-fu they had.

The notmuch cli-fu is superior to anything else, by far (IMO).

> Where do you recomment I start with notmuch? Tutorials?

The getting started guide [1], of course.

> Favorite client?

The one I wrote ;) notmuch-vim [2] [3]

Cheers.

[1] https://notmuchmail.org/getting-started/
[2] https://github.com/felipec/notmuch-vim
[3] https://www.youtube.com/watch?v=JGD7IbZmnIs

-- 
Felipe Contreras
