Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46A5E1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 04:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbfH2Eel (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 00:34:41 -0400
Received: from forward501o.mail.yandex.net ([37.140.190.203]:46218 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbfH2Eel (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Aug 2019 00:34:41 -0400
Received: from mxback28o.mail.yandex.net (mxback28o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::79])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 4217D1E8045F;
        Thu, 29 Aug 2019 07:34:38 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback28o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id n2iqpIEB3o-YaeWPGTl;
        Thu, 29 Aug 2019 07:34:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1567053277;
        bh=MGcejs8aYleHXTtAdIfQjwxEE5Yx2BZMzzJbSP8XyyY=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=MT7V1VyV2tqMa5FkX5HGtputlKoJCFvI/nwfawhx1n7fQFPzu+UcQ3m4WEerrPEaH
         Lcba/Zo94gSrTtcoLF3I59IT92SnWujA6OdMLEDD4aP14Uh1lUD46DgYEo6mnLhWCQ
         vhxAXEmxjtWiWTolbjaqtTGT/28w5cJmQqpNh1HU=
Authentication-Results: mxback28o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-3b71b6ddd4dd.qloud-c.yandex.net with HTTP;
        Thu, 29 Aug 2019 07:34:36 +0300
From:   Andrey <ahippo@yandex.ru>
Envelope-From: ahippo@yandex.com
To:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
Cc:     Andrey Mazo <amazo@checkvideo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Peter Osterlund <peterosterlund2@gmail.com>,
        "cclauss@me.com" <cclauss@me.com>
In-Reply-To: <CAE5ih79dF7LJSp=hUgj_r2XUmWKYnU3XgSReSjOetG8Sek599A@mail.gmail.com>
References: <CAE5ih79dF7LJSp=hUgj_r2XUmWKYnU3XgSReSjOetG8Sek599A@mail.gmail.com>
Subject: Re: git-p4, and python2 EOL
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 29 Aug 2019 00:34:36 -0400
Message-Id: <44585511567053276@sas2-3b71b6ddd4dd.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke,

28.08.2019, 04:49, "Luke Diamand" <luke@diamand.org>:
> We're coming up on when Python2 is end-of-lifed - we have until
> January 1st 2020.
>
> git-p4 uses python2, and doesn't work under python3 at all.
>
> The problem is the conversions between Python3 unicode strings and git
> (utf-8) and p4 (utf-8, except when it isn't).
>
> I had a go at fixing this here:
>
> https://github.com/luked99/git/commits/git-p4-python3-final-showdown
>
> You can see from the comments that I wasn't really finding it straightforward.
>
> I think I know a bit more about the problem now, but before I start
> having another go at fixing this, I wondered if anyone else had any
> thoughts on this, or even better, some time to spend on this.

Please, find a few random thoughts below.
  1. As far as I can see, git-p4 tried to maintain compatibility with both python2 and python3.
     Since python2 is approaching it's EOL, would it make sense to drop support for it in git-p4 completely?
     This would simplify the implementation and wouldn't require fancy objects like PolyStringDict.
     Many projects [2] plan to drop python 2.7 support in 2020 or earlier.
     There are, of course, enterprise distros (RHEL, CentOS), which will keep supporting python2 for several years more.
     As far as I can see, python3 doesn't come by default with CentOS 7, which ends its support in 2024.
     However, RHEL/CentOS ships its own (old) version of git, and python3.6 is available through EPEL repository.
  2. Someone tried to use git-p4 with python3 and a bare repository [1] recently, unsuccessfully.
     A few my stupid attempts to patch git-p4 didn't help.
  3. I no longer work with git-p4 daily, neither have a real P4 repository to test on,
     so I can't really test anything beyond unit tests.
     I'll be glad to review any changes though.

[1] https://public-inbox.org/git/34d6121da46f35e4b81d38169b1b86ca123cef37.camel@gmx.net/
[2] https://python3statement.org/

Thank you,
Andrey.

