Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59095C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 16:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiAJQm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 11:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbiAJQm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 11:42:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0006C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 08:42:25 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w16so55882185edc.11
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 08:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8xUl1lpFg8sgMg/1t7u7OyWf+xvhtRijPb6PWPrUbZE=;
        b=C2V+2KBmtp8u9/wxHAIBBOleUeR6NrqJiA96lP7vn6HefoyMlmx3zIaO73uY467L/y
         fhHCZP0OD5n49R2JFm/IUtKyXrgSmC74PbnL2HNF+GA/tyja5DMS489211Z+7Jud4wzs
         kfo0FWpsa/pQvZEJJyB787at9mHcaaKwGHh1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8xUl1lpFg8sgMg/1t7u7OyWf+xvhtRijPb6PWPrUbZE=;
        b=usrJJOTy6ak2f7AhdJoRV4/uK9cz5ye9HiuX15+1Le2/w9OYwevdjwUlwLcgDhsSvA
         dmOM3EjXT7M/q427BOaS2jKW8mUeiOi5huPFuQjk0yPQbUn92PYnTbFFQZCafkVaLB7p
         wvxj82fB/xBtpL5d53pkgf+OVOwHvllKsbhR830hsljFhEmdJpDG3Ii7q1tjaprobsVB
         nnwhTP8alrQH7H65xoYx3wWXt8jGM7V/THs+a8AX++Jp+WXmi/LMtrcatKqmIi/BTkRG
         keS+RrMyweT5LJJn67h99sEdyBBe6zfnlvPWItED512lq3b2W63dEAkcgfLuyF5m+0/E
         DDsw==
X-Gm-Message-State: AOAM531Q4d8/NetFlNsSuU8eJDRkR7zNOXxii6hKPeCf4amzJ2F7ILdj
        lOYeFV6XqzDSfUKz61RCOna6KEcSzb+4SuHCrsM=
X-Google-Smtp-Source: ABdhPJx10YBP2xEu+KYt4/bFIqPRldERZgUiUhZXkUD21761q1YA0QraubuLoFxPqUleXnuo79bfpw==
X-Received: by 2002:a17:907:d29:: with SMTP id gn41mr454167ejc.538.1641832944342;
        Mon, 10 Jan 2022 08:42:24 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id oz31sm2604019ejc.35.2022.01.10.08.42.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 08:42:23 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso9657456wmj.2
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 08:42:23 -0800 (PST)
X-Received: by 2002:a05:600c:4c94:: with SMTP id g20mr6129539wmp.26.1641832943590;
 Mon, 10 Jan 2022 08:42:23 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 08:42:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whXPxWL7z3GiPkaDt+yygrRmagrYUnib7Lx=Vvrqx2ufg@mail.gmail.com>
Message-ID: <CAHk-=whXPxWL7z3GiPkaDt+yygrRmagrYUnib7Lx=Vvrqx2ufg@mail.gmail.com>
Subject: git ssh signing changed broke tag merge message contents
To:     Fabian Stelzer <fs@gigacodes.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I made the mistake of updating my git tree as I started doing my
merge window for 5.17, and suddenly all the messages from signed tags
disappeared from the merge commits.

I bisected it to commit 02769437e1 ("ssh signing: use sigc struct to
pass payload"), but haven't done any other analysis.

I assume it's the change to fmt-merge-msg.c, but have no time to actually check.

Easy enough to test:

   echo "Dummy file" > dummy
   git commit -m "Dummy commit" dummy
   git tag -s -m "Dummy tag" dummy-tag
   git reset --hard HEAD^
   git merge --no-ff dummy-tag

With the above, you are *supposed* to get a merge message in your
editor something like

    Merge tag 'dummy-tag'

    Dummy tag

    * tag 'dummy-tag':
      Dummy commit

(ok, that last part you only get with merge.summary=true, of course)

But with the broken commit, that "Dummy tag" message from the tag
contents does not exist.

Holler if there are questions, but I'm hoping the above explanation is
clear enough since I'm about to be very busy..

                Linus
