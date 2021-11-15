Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C074C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056FE6323D
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbhKOUfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 15:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347485AbhKOTj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:39:59 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2D8C06122B
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 11:34:17 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y12so20233592eda.12
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 11:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=i6yp8Zt3j1Zz13wWtycs7kvw0jxIlyNFTT28Vh99Wxo=;
        b=HjBybZ75i5PppodBsDbQRpOqREzW9601FkScX7+RjxCYzRzqMLzBytZWlmO1MF4dpp
         5l9HikxEjm7xVJUq0anUO7ZkNA5EWNWYyDGjEHbn3/v8T7vNHeXftIjFY9p8W0cwiSKV
         dwfYHGo3fMTqPzmLjVs8lx/bnHcOJRdvjTdrhY8mJIC5cWyGN2qfXA9WGTzyTTT4O3rg
         b77WJ/X8ApRfJI2Ml971WquK7AthgIkGQhD/QjIPHRAeIpWg9JDJq80BC0MBwmI1fmZ7
         dt7m9k3iPLevJfFGX4F1xEFe+eGRZBTXsQfdyyje4jo9gsmt3QEBIh7Fo/MyXRzfeDM/
         3B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=i6yp8Zt3j1Zz13wWtycs7kvw0jxIlyNFTT28Vh99Wxo=;
        b=dFgcA1x/hh++C7qv6iIym5MEx7x7htBL5RSwAdq864AlesfC494FmnCyrAXt3ByKD9
         kEcmJGOfWUmUSRppqs0ADyZiT30GqcB5CYZlY9larpui56KYSND3zyxqvaBOr4GIMvbY
         +kEOwD9vZQLmyVfLm5/sz0ejSjj0kSy99AgSDuQvPVj4l6AW+LKLZ5YEcTtNdbO7PR5g
         TqvNafSAYwiEQep3P0DBrvC0MMMr2i4lsO28n84p8kF8eUhbabNSy46gYU/xODLrwX4U
         bzJCmbEe9dV+jmbMKUr5Gc2qYzjNU3HRBmzBLkIQhpng6BUSR7L6BVghmUVAhsvc9bYa
         xsuw==
X-Gm-Message-State: AOAM530FY5/2Ai2bsPb5uvTdBKou59R9b7KlIx7lL9gbu6H8T3ndDF2l
        WCOqLQ/Cv8JKXH0RvXe9vLV6/p7Z8Y4=
X-Google-Smtp-Source: ABdhPJy1dte06D9exbMLo+jLEW+Zk6PiZRLk4wj/F3mzHnPBbfpf0keBv5HHUfudacLmsJ17lFydLA==
X-Received: by 2002:a17:906:d54e:: with SMTP id cr14mr1802138ejc.458.1637004856202;
        Mon, 15 Nov 2021 11:34:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id yc11sm5041341ejb.104.2021.11.15.11.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 11:34:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmhk6-001CO7-Oz;
        Mon, 15 Nov 2021 20:34:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/mark-leak-free-tests-even-more (was: What's cooking in git.git
 (Nov 2021, #04; Sun, 14))
Date:   Mon, 15 Nov 2021 20:30:46 +0100
References: <xmqqv90tfhh2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqv90tfhh2.fsf@gitster.g>
Message-ID: <211115.861r3hrz61.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 15 2021, Junio C Hamano wrote:

> * ab/mark-leak-free-tests-even-more (2021-11-01) 15 commits
>  - leak tests: mark some fast-import tests as passing with SANITIZE=leak
>  - leak tests: mark some config tests as passing with SANITIZE=leak
>  - leak tests: mark some status tests as passing with SANITIZE=leak
>  - leak tests: mark some clone tests as passing with SANITIZE=leak
>  - leak tests: mark some add tests as passing with SANITIZE=leak
>  - leak tests: mark some diff tests as passing with SANITIZE=leak
>  - leak tests: mark some apply tests as passing with SANITIZE=leak
>  - leak tests: mark some notes tests as passing with SANITIZE=leak
>  - leak tests: mark some update-index tests as passing with SANITIZE=leak
>  - leak tests: mark some rev-parse tests as passing with SANITIZE=leak
>  - leak tests: mark some rev-list tests as passing with SANITIZE=leak
>  - leak tests: mark some misc tests as passing with SANITIZE=leak
>  - leak tests: mark most gettext tests as passing with SANITIZE=leak
>  - leak tests: mark "sort" test as passing SANITIZE=leak
>  - leak tests: mark a read-tree test as passing SANITIZE=leak
>
>  More tests are marked as leak-free.
>
>  Will merge to 'next'?

That would be great. I've got a rather large queue of leak fixes
pending, and due to marking up the tests incrementally they've pretty
much got to go in sequence.

For this sort of topic that's just marking existing tests as running
under the linux-leaks job I'd think it could proceed relatively quickly
after it's not been causing test smoke on master/next/seen for a bit,
which with the release cycle has been a couple of weeks in this case.
