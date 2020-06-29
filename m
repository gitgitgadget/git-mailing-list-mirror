Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725EBC433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 19:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332FA2073E
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 19:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LQSBQfwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgF2TO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731786AbgF2TOX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:23 -0400
X-Greylist: delayed 384 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 Jun 2020 03:24:36 PDT
Received: from forward103o.mail.yandex.net (forward103o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29D3C008610
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 03:24:36 -0700 (PDT)
Received: from mxback26j.mail.yandex.net (mxback26j.mail.yandex.net [IPv6:2a02:6b8:0:1619::226])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 2805F5F80ED2
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 13:18:09 +0300 (MSK)
Received: from myt4-ee976ce519ac.qloud-c.yandex.net (myt4-ee976ce519ac.qloud-c.yandex.net [2a02:6b8:c00:1da4:0:640:ee97:6ce5])
        by mxback26j.mail.yandex.net (mxback/Yandex) with ESMTP id YhPMjnfo9o-I8G0l59h;
        Mon, 29 Jun 2020 13:18:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1593425889;
        bh=YxiQh9jM4LKpkisOT7/pkRUa0xEGsgSczd55LzRrcCs=;
        h=To:From:Subject:Date:Message-ID;
        b=LQSBQfwZxyATisSjL+hexuYtxc5Tcbh6dSSDiM8zDco9iIVmwRudYZsAML8QEl7hf
         44Yll+h8C4i3fn7Cjf/MYwWG4fHWm84Zc93R9yKdftIEghsc6uUWtUFIOL79DdMGk8
         dx8Jdp9UbNaE3YpquVFbLs8DZJhSw2lqEZwY0ufs=
Authentication-Results: mxback26j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt4-ee976ce519ac.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id MTYVli23Sw-I8kigqWs;
        Mon, 29 Jun 2020 13:18:08 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <e37cdda3b73094f4f1a929dd181a64936a649c48.camel@yandex.ru>
Subject: Listing changed identifiers with git log/diff
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     git@vger.kernel.org
Date:   Mon, 29 Jun 2020 13:18:08 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git is able to recognise functions/variables changed, and even allows to see the history of such identifier with `-L` option.

But I couldn't find: how does one get a list of such identifiers in `git log` or `git diff`? This would be particularly useful for projects with odd requirements to have a list of identifiers changed in the commit message.

FTR, the diff text after the "@@…@@" does not cut it because for example if the diff is at the beginning of the function, then it would have a name of the previous function, i.e. not the one modified. As a hack, I tried passing an option `-U0`, but that didn't help, for one-line identifiers it still shows the name of the prev. identifier.

