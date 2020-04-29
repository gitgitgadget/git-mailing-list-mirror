Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73919C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E22208E0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfY2M5l2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD2U1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2U1D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 16:27:03 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936EAC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 13:27:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y4so4058703ljn.7
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=t/SCvgn+kHuknqdhvwIak6HsPQ42ptMrUhEKQpn92CU=;
        b=pfY2M5l27BEzMSnK4NBZrm7giFPeN4WcuDo5eWoWccTY0QmirYzHliOD3qlTtPT6q8
         1tx7QtFI6rqxZjWCJ5TkW87LLXZ4oCNKAQuruHn4mn/reieF5jwX2r0YUMPz/tIBKYqS
         G64yLVnmy6g1bKJkOJwTFWGzzypCwxufTD+0fDQNk+LLpNxLS3mISQwzFzEedNLp/g3+
         zqGMWTBV6FBC55XCt3J3MdP7V5CFPfOpY0ThfRzhvZZAcSm8LUfNV9h/LC5X8nwudtZV
         E4W8hbtCkzCW66DQjdrYMwd+yZYHuOvTwEqCOnUxmbSO+vVyVPI67CiQz9ybbo0Vg3pT
         EEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=t/SCvgn+kHuknqdhvwIak6HsPQ42ptMrUhEKQpn92CU=;
        b=FpeMeb4qEJ1JW5vFZpLi5SLncf5JfHDY8+doFY0wv2zLseN1vkkGqff6bU3kVhvbvV
         zqRUcraygSQ1AGnM22Iiptvi2u73jk+DZqqygRQhyxx0myjDfuUXhJylb/x2yM6Iy2IO
         q9jkPKauManiVUQO0UZolgNIQtrZhePmSGoCoYzDJkS04mJRkWd2TICFvS1Lbvv/JU+i
         8J4Xg5kWwI9Vq1OD3JzaDatL6pYldzBNgF9n7W91L+u1fcBZyivSPYfJ3WK7njOYmLgj
         +dsHPlNBWwzzCctw3j7qF64Cz9WTBLOp+x3XazKJPhiXj55yo65KSu3guNbmHugv8Pdk
         PiLg==
X-Gm-Message-State: AGi0PuZdTCMmM8RU0XIwx3URVJ/CzliJDqR+ioJUVHoBnraPMqwDOTwW
        UBDV+7JezdHZQ7Z4jFrwpOE=
X-Google-Smtp-Source: APiQypLHUk9Kz6uPLN1aZbEVnOLT3zkkW3C6rPPkYi5IglLn3cPED8nE/phFnIMzSoOiUOaipPtwPQ==
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr21038588ljj.137.1588192020983;
        Wed, 29 Apr 2020 13:27:00 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q23sm3078990lji.92.2020.04.29.13.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:27:00 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Ivan Tham <pickfire@riseup.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
References: <20200429130133.520981-1-pickfire@riseup.net>
        <877dxyo1k8.fsf@osv.gnss.ru> <20200429190013.GG83442@syl.local>
        <87v9likr5a.fsf@osv.gnss.ru> <20200429195745.GC3920@syl.local>
Date:   Wed, 29 Apr 2020 23:26:59 +0300
In-Reply-To: <20200429195745.GC3920@syl.local> (Taylor Blau's message of "Wed,
        29 Apr 2020 13:57:45 -0600")
Message-ID: <87imhihwbw.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Apr 29, 2020 at 10:50:41PM +0300, Sergey Organov wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> [...]
>>
>> > In my opinion, it is fairly clear that 'git branch -D -' means "delete
>> > the last branch", and not "delete a list of branches from stdin.
>>
>> Honestly, I'd never guess it'd "delete the last branch". No way.
>
> I'm having trouble understanding why. This is how 'git checkout -'
> behaves, so I have no idea why 'git branch' wouldn't work the same
> way.

Well, if I knew 'git checkout -' does this, then yes, it'd be obvious.
The problem is that I didn't. Well, then, as I said in my original
reaction, I'm probably too late on this.

BTW, it was not that easy to find it in the "git help checkout" even
when I was specifically looking for it.

Thanks,
-- Sergey
