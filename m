Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9331C7EE25
	for <git@archiver.kernel.org>; Fri,  9 Jun 2023 15:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbjFIPdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jun 2023 11:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241643AbjFIPdr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2023 11:33:47 -0400
Received: from qproxy4-pub.mail.unifiedlayer.com (qproxy4-pub.mail.unifiedlayer.com [66.147.248.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8181D2D74
        for <git@vger.kernel.org>; Fri,  9 Jun 2023 08:33:45 -0700 (PDT)
Received: from alt-proxy28.mail.unifiedlayer.com (alt-proxy28.mail.unifiedlayer.com [74.220.216.123])
        by qproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id 11095802743C
        for <git@vger.kernel.org>; Fri,  9 Jun 2023 15:33:45 +0000 (UTC)
Received: from cmgw14.mail.unifiedlayer.com (unknown [10.0.90.129])
        by progateway1.mail.pro1.eigbox.com (Postfix) with ESMTP id A333B1003A124
        for <git@vger.kernel.org>; Fri,  9 Jun 2023 15:33:44 +0000 (UTC)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with ESMTP
        id 7e7UqJppuIaKl7e7Uqc6XR; Fri, 09 Jun 2023 15:33:44 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=b7Z3XvKx c=1 sm=1 tr=0 ts=64834658
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=of4jigFt-DYA:10:nop_rcvd_month_year
 a=3EOfIcITIxQA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=5j-VAoQKFfIXgBnZFdcA:9 a=PRpDppDLrCsA:10:nop_bhvr_url2n_url_nonascii
 a=QEXdDO2ut3YA:10:nop_charset_2 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PlM23d7eqPx8q7dLlUslKgRJsWyrqv2B4KRLpk4Fu8g=; b=GNs42HP3/icDN8Zk899njDtoTz
        1xTLQ6LjP3GdWjVt84zA/mCMwqAgaAzMaqTcI6E9XAp+Kv9hiCh2JHoek5nnrb3anuatYKI62qm+V
        7kRCP82aJIrhPnqf8gHLx/qH1;
Received: from [160.231.0.90] (port=51227 helo=llin-psh13-dsa.dsone.3ds.com)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <paul@mad-scientist.net>)
        id 1q7e7T-0046rv-Ux;
        Fri, 09 Jun 2023 09:33:44 -0600
Message-ID: <e6f9334dd93c683b97ecdf61eb06bbe28b0a4e30.camel@mad-scientist.net>
Subject: Re: Anyone know why git ls-remote output might be corrupted?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Date:   Fri, 09 Jun 2023 11:33:42 -0400
In-Reply-To: <CABPp-BF9Xjww=BBkL4qQcENo-UCHd8eEj334ho1iO1EMbGxhZw@mail.gmail.com>
References: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
         <CABPp-BF9Xjww=BBkL4qQcENo-UCHd8eEj334ho1iO1EMbGxhZw@mail.gmail.com>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (by Flathub.org) 
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 160.231.0.90
X-Source-L: No
X-Exim-ID: 1q7e7T-0046rv-Ux
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.0.90]:51227
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2023-06-02 at 18:12 -0700, Elijah Newren wrote:
> Sounds kind of like
> https://lore.kernel.org/git/6786526.72e2EbofS7@devpool47/=C2=A0which also
> triggered for some other tooling and then was reduced down to some
> shell commands.=C2=A0 Unfortunately, the thread ended without a lot of
> resolution other than "don't mix stdout and stderr" and "if we slow
> down the network connection somehow, that'll avoid the problem".

As I was riding my bike home last week I had this exact same epiphany.
So, I examined my script and discovered that indeed, I was using
subprocess.PIPE for stderr, which is the Python equivalent of the
shell's 2>&1 operation.  So, both stdout and stderr are going to the
same place.

I also checked and indeed, the git ls-remote command does print to both
stdout and stderr as part of its "standard" behavior:

  $ git ls-remote --heads >/dev/null
  From git@git:myrepo

This is unexpected to me, although of course there's nothing inherently
wrong with it but usually you don't expect "regular" output to go to
stderr.  I suppose the idea is that people can run:

  $ git ls-remote --heads 2>/dev/null

if they want just the output without the header.

Anyway, I modified my scripting to keep stdout and stderr separate and
I haven't heard anything about things continuing to fail so I guess
that was the problem.

The mode of failure is very very bizarre to me: first why is it just
one "bogus" character embedded in the output?  Second why are 60 lines
just dropped?  Third where did the REST of the stderr output go?

And finally, why did this not fail 100% of the time on Linux?  I can
believe that Windows pipe behavior is not POSIX and maybe Python's
emulation of it is imperfect, but surely that is not the case on Linux
and we would ALWAYS get the full results of both stdout and stderr on
Linux, even if mixed together?!?!

The mysteries never end.

Thanks all; hopefully this helps someone else.
