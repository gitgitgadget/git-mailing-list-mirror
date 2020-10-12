Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE2AC43457
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB59208FE
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=narod.ru header.i=@narod.ru header.b="FtPVwbqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbgJLLKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 07:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387783AbgJLLKs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 07:10:48 -0400
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Oct 2020 04:10:48 PDT
Received: from forward100o.mail.yandex.net (forward100o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57023C0613CE
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 04:10:48 -0700 (PDT)
Received: from mxback6j.mail.yandex.net (mxback6j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10f])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id D48854AC19A8
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 14:05:31 +0300 (MSK)
Received: from myt6-efff10c3476a.qloud-c.yandex.net (myt6-efff10c3476a.qloud-c.yandex.net [2a02:6b8:c12:13a3:0:640:efff:10c3])
        by mxback6j.mail.yandex.net (mxback/Yandex) with ESMTP id GbCCdqYDho-5VOqjVUS;
        Mon, 12 Oct 2020 14:05:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narod.ru; s=mail; t=1602500731;
        bh=+z5seupsXbdgGO8p4p6ORsWYLVtyGeuGscUCdFIXWwI=;
        h=Subject:From:To:Date:Message-ID;
        b=FtPVwbqGJcM3vcXMQ6gIzpQzxNJcuvmJwekb760TWNg6k5MMg7oPytYXiYKp6KQvs
         0Liy/8NS5VoX57T4o+7ks8rTCJclieiZt6usbFrUss3kjSOs9yyjiv617Xg88LvtQc
         0XVDkfVp2FgoVZO1SQd/j7yb0vQ9Hr9icxWEdG90=
Authentication-Results: mxback6j.mail.yandex.net; dkim=pass header.i=@narod.ru
Received: by myt6-efff10c3476a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id GMxQoqOyAP-5VmexPkr;
        Mon, 12 Oct 2020 14:05:31 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     git@vger.kernel.org
From:   Victor Porton <porton@narod.ru>
Subject: Feature: checkout and merge
Autocrypt: addr=porton@narod.ru; keydata=
 mDMEX3jsrhYJKwYBBAHaRw8BAQdAe070of34x3DrKbRD/txe/g8cWLeKEXuC9hXVTfFoTM20
 H1ZpY3RvciBQb3J0b24gPHBvcnRvbkBuYXJvZC5ydT6IkAQTFggAOBYhBFvZfvcPyBy3zb0E
 tMg/jYQvC2W6BQJfeOyuAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEMg/jYQvC2W6
 /Z4BALR9Ftngv/bjrj0QoQHJf55ph7Xu6ARBEXQGTzklBXdJAP9ZssTJEe+QnnCxdUlgY913
 2M1vn7uBx+8KrPNvGy84A7g4BF947K4SCisGAQQBl1UBBQEBB0BjrVMq/DFtBsyNkUy3pBdC
 Lj3FGBl9sWO0ROrYtXSUBgMBCAeIeAQYFggAIBYhBFvZfvcPyBy3zb0EtMg/jYQvC2W6BQJf
 eOyuAhsMAAoJEMg/jYQvC2W6/ZcBAIQayxy650jTa81o9xF22+U4xS9TlhKhD3gNhUBNFr58
 AQD5Bz6FTt78i4/CZuw7xpXQFPgqHnDVcD8KhRD2echFBA==
Message-ID: <1884b456-e80a-c0f1-775b-1f517d82ad6c@narod.ru>
Date:   Mon, 12 Oct 2020 14:05:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is a very often need to checkout a branch and them merge there the
branch that was before the checkout. Moreover after this is very often
needed to push.

So please add the flags to `checkout`:

1. to merge the old branch immediately after checkout

2. to push after checkout

I repeatedly write:

git checkout stable && git merge main && git push && git checkout main

(I am not subscribed to this mailing list.)


