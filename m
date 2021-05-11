Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D989C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D26361625
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhEKSI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:08:57 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37935 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhEKSI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:08:57 -0400
X-Originating-IP: 73.26.133.58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620756469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=rUDQ/y+VK7gWTa/cjDbtErXp+AEazN0EnvkfcNtpxAo=;
        b=XHVs6LhkSvw+f8XZo/oN+y1P8Qo9FjmeuKtY6VNsnNcq9JPN2jcrdiz/M2DsOY4mbPl53H
        XC0jTyxa0tZu7WsXRE8FBFenbRubfdxWfi3SnP6COhx+dEP4go5hAQUSD/rLqKJ6NkOqVc
        Ef1bchkOjc10vuEbsE46Bv9hKIeKP5UUoElCe6g2+OZcXizbT/87O29KkGABZVntFEbDND
        PnYfRvvOi2Hd7ruAM9BojrqbgffMU8NVf3PGnSVD5OUGbm/2cmtuXbqjbhHsocTuS8uyjP
        ob+YsjlsuWxK4rhICM5IxyQ19JaJAKPDxvM8YCHZW80VB4RxHzJgSPgk6TTWIQ==
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 42E701C0006
        for <git@vger.kernel.org>; Tue, 11 May 2021 18:07:49 +0000 (UTC)
Date:   Tue, 11 May 2021 12:07:46 -0600
From:   Gregory Anders <greg@gpanders.com>
To:     git@vger.kernel.org
Subject: Syntax for specifying a command in git config
Message-ID: <YJrH8uqzapnpNEsb@gpanders.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Certain git config parameters (notably sendemail.smtpServer) expect an 
absolute path in order to use a command. If the value begins with a / 
git interprets it as a command; otherwise, it's interpreted it as a 
server hostname.

Using an absolute path is not very portable, however. If I want to have 
a common shared config file across multiple machines, each of which uses 
a command for smtpServer (e.g. msmtp) but installed at different 
locations, I have to modify the config file on each machine to update 
the absolute path.

Obviously this is not a *huge* deal, but it is a minor annoyance. I'm 
wondering if it would be possible to add a new syntax to config options 
like this. For example,

     [sendemail]
             smtpServer = !msmtp

The leading ! character says "the following value is a command that 
should be looked up in PATH". This is congruent with alias definitions, 
where the leading ! means to run the following value as a command 
directly instead of as a git subcommand.

This also is unambiguous since server hostnames will never begin with a 
! character.

I would be happy to attempt a patch at this change if it's something the 
git maintainers are open to. And if there are any other options that 
this would make sense for, I can add those too.

Thanks,

Greg
