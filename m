Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E995DC433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 23:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C041560F3A
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 23:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhJ3Xig (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 19:38:36 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.1]:45637 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231387AbhJ3Xif (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 30 Oct 2021 19:38:35 -0400
X-Greylist: delayed 1246 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Oct 2021 19:38:35 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 97612244E35A
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 18:15:15 -0500 (CDT)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with SMTP
        id gxZDmgKsXG0jLgxZDmklBj; Sat, 30 Oct 2021 18:15:15 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yi9YIU9RYq3Fl2ylH+U/GrHbOvg/8hwYtd3Zdqjre5I=; b=AczyS96BRLUHtsDsaP26SEEoHg
        DD9UyaJFgzojOy7XGtqLWn9dogYUQEMKaUBZ6O8BVlwqbMYyUMsVBpcBzIxGGkB8TSYXlVrl+sGXJ
        +KjuAeUtW81gf9dhDsNbGd+Ht;
Received: from pool-96-233-64-159.bstnma.fios.verizon.net ([96.233.64.159]:52204 helo=pdslaptop.home.arpa)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <paul@mad-scientist.net>)
        id 1mgxZD-0037B9-86; Sat, 30 Oct 2021 17:15:15 -0600
Message-ID: <f5807fd2eb0c16ab0400e8f3138a90f564fd303c.camel@mad-scientist.net>
Subject: Re: [PATCH] Makefile: replace most hardcoded object lists with
 $(wildcard)
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Date:   Sat, 30 Oct 2021 19:15:14 -0400
In-Reply-To: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 96.233.64.159
X-Source-L: No
X-Exim-ID: 1mgxZD-0037B9-86
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-96-233-64-159.bstnma.fios.verizon.net (pdslaptop.home.arpa) [96.233.64.159]:52204
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2021-10-31 at 00:32 +0200, Ævar Arnfjörð Bjarmason wrote:
> +LIB_OBJS += $(patsubst %.c,%.o,$(foreach dir,$(LIB_OBJS_DIRS),$(wildcard $(dir)/*.c)))

Another way to write this would be:

   LIB_OBJS += $(patsubst %.c,%.o,$(wildcard $(addsuffix /*.c,$(LIB_OBJS_DIRS)))

I don't know that there's any reason to choose one over the other.  I
don't think there's any real performance difference although one could
imagine this version to be VERY SLIGHTLY faster.  Also this one is a
little more "Lisp-ish"... that might be a pro or a con depending :).

Just kibitzing while waiting for dinner to arrive...

