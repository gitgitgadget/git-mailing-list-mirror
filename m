Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C353C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8646610E6
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhJMNds (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhJMNdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:33:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBD5C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:31:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y12so10463529eda.4
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2/l1VF0PvMQGoDabhGWKLZQQZ/O/JzbTKCSbQUK56aw=;
        b=bPosx8TCEUY5ezzvY5zUZ0K1dL0T6p3VB3CfwM9f3p9vJkXYqyAv63KQv0VucP1x//
         5BSyRralwZtgCVKizaw63NYnpft16g7qg0XluLmlflOjygPc0pBm/xPuaiAzdpAWyQac
         dMdT0PMtBNZFotEWP7EgDNwNvew4LCWUtfeNfCHGo1D9uXCg/IM+6LJv7HixpEq9v0cP
         9HwjmTpWNlXE/ROOVNcqD9Hd0zWDWkBMhZOizBL9PWmkolThzAn9TxsfAu/hNvW8n3zS
         yX/uHfMeOItT9GsTy4AD48XNq/r2EdoJEp5jsY/jPy7AJY+MUW+6bAE00alyuVXax5PC
         Js3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2/l1VF0PvMQGoDabhGWKLZQQZ/O/JzbTKCSbQUK56aw=;
        b=ba10DN5POV779VsCymHc08OtjaxExlGExHDuRDTJ6aIU4mKVkPX5u7MU4i+X5LKsfV
         D/Eu9crn50XRJ8kMhjW1UffI8PIRga7y+aZ7/nf1soBgLuKOZntFHxxiz1UIFEpc2H1i
         D5Hu+vvINgHleI8G/g3vzX0AefWpvQuhxQnl53WzboPFZil5zNH5syjTbi/sF9SygEV5
         TUV/zlc0M3vQPwABF4fr3CcOAjrOb6JefP3hbF9ODqXKXdJOxZ04mCDvah07FG0fJbY+
         /2RGsQhxlEuT8uowOOwshnLjv5JVSMS/Zal8gT7TpO6JkPbN5b4WQ/fTx+I5RZqQm95m
         e21w==
X-Gm-Message-State: AOAM532JZf4DH6z7KNmmBIFUC7B8rk2HiU/JoU1oXalMX7PPKbYIHMfS
        oBqR/5OpiuqphvQeg4E2SrWdjFYFlQt20A==
X-Google-Smtp-Source: ABdhPJyA+l6BMyS7Vb8JeWD569kiyfjnJ35zFeQD4goIY1WIa5U0DAGMRO6SyyaEsYE5VUdaMwV3YQ==
X-Received: by 2002:a17:906:c186:: with SMTP id g6mr10714977ejz.259.1634131900793;
        Wed, 13 Oct 2021 06:31:40 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m15sm5855504edd.5.2021.10.13.06.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:31:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/mark-leak-free-tests
Date:   Wed, 13 Oct 2021 15:28:44 +0200
References: <xmqqv9239k15.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqv9239k15.fsf@gitster.g>
Message-ID: <87bl3thwzo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 11 2021, Junio C Hamano wrote:

> * ab/mark-leak-free-tests (2021-10-07) 11 commits
>  - leak tests: mark some misc tests as passing with SANITIZE=leak
>  - leak tests: mark various "generic" tests as passing with SANITIZE=leak
>  - leak tests: mark some read-tree tests as passing with SANITIZE=leak
>  - leak tests: mark some ls-files tests as passing with SANITIZE=leak
>  - leak tests: mark all checkout-index tests as passing with SANITIZE=leak
>  - leak tests: mark all trace2 tests as passing with SANITIZE=leak
>  - leak tests: mark all ls-tree tests as passing with SANITIZE=leak
>  - leak tests: mark t0000-init.sh as passing with SANITIZE=leak
>  - leak tests: run various "test-tool" tests in t00*.sh SANITIZE=leak
>  - leak tests: run various built-in tests in t00*.sh SANITIZE=leak
>  - Merge branch 'ab/sanitize-leak-ci' into ab/mark-leak-free-tests
>
>  Bunch of tests are marked as "passing leak check".
>
>  Expecting a reroll.
>  cf. <xmqqmtnko3zn.fsf@gitster.g>

I submitted an update for this at
https://lore.kernel.org/git/cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com/;
which also ejected a change that semantically conflicted with "seen"
(which has a new memory leak). I think this should be ready to go.
