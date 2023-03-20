Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E741C7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 16:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjCTQX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjCTQXe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 12:23:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A9E132F8
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:16:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso12957524pjb.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679328998;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYWezzovCjre5hEnqTG3SqjeaeHlRdwzskeQ9kPbi5g=;
        b=qgmA/hXCHOOwD62gx8iqpn17x5+RnGD6C2C7WMuyL7sH+vnVjr0ftEed18e5M0aHSl
         tH9MBQ8jyOkaKLkvDcuAhcW6L/cqE4qzz/xCh+hEMnz2S7XxYwO9OBmNCStucdDL8/kO
         AlBZPQiMl6SDaaDJGmOgIyVGNBvaxlzat6ufqFZYzhx29AzzBjnab+HWeJbBKfO+J7TS
         zNDpTRqkfh0jQjexF0zsuNKvlTW0ImnQ0UZ+yQ260MHGgano03wKO1wIbU34OSnU1H1f
         wuDCDFOLw3POYLxJ1E+N/QRMEW9W3qFEchFcdZ/TN2DL+IC5BqskuRQIGlmcQfjxwUcp
         xqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328998;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYWezzovCjre5hEnqTG3SqjeaeHlRdwzskeQ9kPbi5g=;
        b=eA4ESJuZ8OBievx1BgnjRWH1pFQtLp3aHxlfvTvOH1B92kLYOEgMOxjuhsYU53L3bl
         u1QXrnkfaV7mzn1Qnxwvniy+JCyncE6HwArBtFkhD1Jto8FT/Efa/mGKJoYrwh5VW8t4
         RAt8Yx1n4Q4ghun0p2EZb1f7ISBiFOBqNqu4QgxvSerxT47Jv02IHugDVbSMYZptN9xX
         iOcRvpGgVbNLv8/3K0+KFAuctr3DXSUIc+KXM4IbswYA+UI8UoC2al/uW1RnYm6LSUAO
         x/OX+0eBHrY3MvhIbhvRZBQchHRf9284+7IgtKGc/QeaNGbPIhirrJl5fBEqBres6SgA
         sx/w==
X-Gm-Message-State: AO0yUKVkTU8crnlsVAFS+a7Rl/i9UwQcZ9r+oLQd23Ku7pBs9VUu9T+2
        w4Bz1LfgynYP7S6HjnyqG44=
X-Google-Smtp-Source: AK7set803aZKj71vWUrWAsxXQxoe9E8X+1YU+V/zFypQWsQFSt8j537eqL+vO7I6m55BJOfwPlDbkA==
X-Received: by 2002:a05:6a20:4f29:b0:cc:c3f7:9178 with SMTP id gi41-20020a056a204f2900b000ccc3f79178mr16072515pzb.31.1679328998229;
        Mon, 20 Mar 2023 09:16:38 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79185000000b0062612b97cfdsm6514287pfa.123.2023.03.20.09.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:16:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org,
        Matthias =?utf-8?Q?G=C3=B6rgens?= <matthias.goergens@gmail.com>
Subject: Re: Bug in git archive + .gitattributes + relative path
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
        <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
        <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
        <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de>
        <xmqqcz5lbxiq.fsf@gitster.g>
        <d16c6a22-05d8-182c-97b4-53263d22eaa6@web.de>
        <xmqqo7p59049.fsf@gitster.g>
        <3da35216-ca42-9759-d4f9-20451a44c231@web.de>
        <xmqq4jqx8q6q.fsf@gitster.g>
        <f7949f1b-4bad-e1bf-4754-f8b79e3ce279@web.de>
        <xmqqjzzly84q.fsf@gitster.g>
        <9e215e5c-0b67-0362-fd53-8c22b8d348ff@web.de>
Date:   Mon, 20 Mar 2023 09:16:37 -0700
In-Reply-To: <9e215e5c-0b67-0362-fd53-8c22b8d348ff@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 18 Mar 2023 22:30:24 +0100")
Message-ID: <xmqqlejro0t6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>> 	$ cd some/deep/place
>> 	... work work work
>> 	$ git archive --full-tree :/other :/hier :/archy
>>
>> is what I had in mind.  Without --full-tree, due to the first bullet
>> point above, paths in our archive are relative to some/deep/place.
>
> I don't see the difference.

OK.  I do not work in Java anyway ;-)
