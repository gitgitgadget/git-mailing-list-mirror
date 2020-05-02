Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B0AC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BD42137B
	for <git@archiver.kernel.org>; Sat,  2 May 2020 22:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sudoforge.com header.i=@sudoforge.com header.b="oVz4Y/DC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hN11BzY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgEBWVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 18:21:11 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49797 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728530AbgEBWVL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 18:21:11 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E7955C0567;
        Sat,  2 May 2020 18:21:10 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute2.internal (MEProxy); Sat, 02 May 2020 18:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sudoforge.com;
         h=mime-version:message-id:date:from:to:cc:subject:content-type;
         s=fm1; bh=POjzRB8zrA+20tdcWp1sJYuTjP1TNQwkW6HK5hLt+TY=; b=oVz4Y
        /DCu3PBi7AkxzKR7VAmfhT1lOKqTDcPzIyseWkRQMPGfmxNVJOM8CE8Yrc+w7S9o
        u+rRgrBdD80dWf3WODbw+1lZmWFqrAFqrjr2kfyjks1kOQmz5DlEsPeq33WKb+h1
        KdjZR28H0ybENRwjy7avDk1D5QVvDoTrMkQDCV76wSc4In4u8LGDOqpaurMlAyjl
        FRViXgA2HACYbCmaCPj0mq/KWE5k8Ex2PUofdb+hYiMXLAFD1P0FBf5DJNJz7dzD
        Z1dIoZQDOFiawD3Zc7E9/77BvfKgfD50JTwzl9bmj+euid47+gDJct8xqMVAApLJ
        lmV4BnSawSUse6QsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=POjzRB8zrA+20tdcWp1sJYuTjP1TN
        QwkW6HK5hLt+TY=; b=hN11BzY4WN5i+P5LzFXdLQ0YZdmyJwv+P016xvGhcZTqT
        X4jfRlkKAnBJrNLWiwmkQQMGAABD3+ucDpE3HfY46uOSASlY7VOnr0eKUP31eStG
        /ef/IGz34KX+6OK623YEHIXWnTIbLHinL/TscD1iXauwiKn/v36buLToE5TSKola
        H4b4L/QVFpclIqtjzolnHusKd+Zg0is+Qh6yJsG5gz3eOvVnA9njA2phk7XmTmH6
        S8NkaMQ8AeXwJc5VhBJMfgSayYFV8nv596q7EiUnPqo0V2JiSyph8yG730qaUn6Q
        zkmqm9QsNGnXv39V/2W8qPW479aDDzFVABxy4dYuA==
X-ME-Sender: <xms:VfKtXvH0pWuYUTVtk28s6i5byEa416x2nQhkQHF97Jvnm7Uze7xgaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjedtgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpefofg
    ggkfffhffvufgtsehttdertderredtnecuhfhrohhmpedfuegvnhcuffgvnhhhrghrthho
    ghdfuceosggvnhesshhuughofhhorhhgvgdrtghomheqnecuggftrfgrthhtvghrnheptd
    ejieettdeigeefgfehgeekteekffeludehieffffdtteeivdffkeegffehleeknecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvnhesshhuug
    hofhhorhhgvgdrtghomh
X-ME-Proxy: <xmx:VfKtXntnbtQ93S_6uAbOgxZNx_FohQqgnJyUUd0vF_i6XVuhIHxJHQ>
    <xmx:VfKtXvAVdAvN1djfituZfZDAbsmPEFOVGxO9IqWkLrJzKiOPRsQTYQ>
    <xmx:VfKtXoOAfyy4JgE7c5piB7IJ58DU0iPYk_05ImZ1K6GE6gJh32dVqw>
    <xmx:VvKtXnQZIchmQvKQIDLcMllFjxbUTyAfyq7hAAw_o8AexFQwYNH6bQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AB2FEE00EA; Sat,  2 May 2020 18:21:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-351-g9981f4f-fmstable-20200421v1
Mime-Version: 1.0
Message-Id: <6320df09-571e-4540-8deb-b122b4e59242@www.fastmail.com>
Date:   Sat, 02 May 2020 15:20:48 -0700
From:   "Ben Denhartog" <ben@sudoforge.com>
To:     ben@sudoforge.com
Cc:     git@vger.kernel.org
Subject: Re: --no-tags doesn't appear to be working as intended
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I should note that this occurs with Git v2.26.2 on x86_64 architecture with kernel 5.6.4 -- so it doesn't appear to be due to an outdated build. I was not able to find any previous bug report in the mailing list, nor have I tested this with previous versions of Git to determine whether it is a regression or a bug that has existed since the flag was introduced. 

-- 
  Ben Denhartog
  ben@sudoforge.com
