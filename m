Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07491C88CB2
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 20:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjFLUB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjFLUBU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 16:01:20 -0400
Received: from qproxy3-pub.mail.unifiedlayer.com (qproxy3-pub.mail.unifiedlayer.com [67.222.38.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C6D1981
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 13:00:49 -0700 (PDT)
Received: from gproxy3-pub.mail.unifiedlayer.com (gproxy3-pub.mail.unifiedlayer.com [69.89.30.42])
        by qproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id DFBCE8033CF6
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 20:00:11 +0000 (UTC)
Received: from cmgw10.mail.unifiedlayer.com (unknown [10.0.90.125])
        by progateway5.mail.pro1.eigbox.com (Postfix) with ESMTP id AFE621004B4FF
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 19:59:11 +0000 (UTC)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with ESMTP
        id 8nh1q8XAuwySw8nh1qUHjC; Mon, 12 Jun 2023 19:59:11 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=IIjHtijG c=1 sm=1 tr=0 ts=6487790f
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=of4jigFt-DYA:10:nop_rcvd_month_year
 a=3EOfIcITIxQA:10:endurance_base64_authed_username_1 a=pBbsfl06AAAA:8
 a=PusmU9CYaV5Vi8dc6OgA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=Pykvx6M6Og9ney6Qs4Vj:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ofWokGtzSgAedJ8aDbYwaVjXQIZEz4wbQJ3uHj8c+do=; b=r7qqt1MFKnSUupOkYylNFwVu6m
        FOzf4mo4dxAtg2/PLrUI871WZ88EBarlhUTiPQay4gRwzlt9qpiXwRHXDPJqW1wnOTJxNoSwVqGr2
        dPeyKhSSFMpTE5DzXBVrhDrOh;
Received: from [160.231.0.90] (port=37373 helo=llin-psh13-dsa.dsone.3ds.com)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <paul@mad-scientist.net>)
        id 1q8nh1-002Gyj-0a;
        Mon, 12 Jun 2023 13:59:11 -0600
Message-ID: <21193d97d43094a01b4ac9442448135867e22c70.camel@mad-scientist.net>
Subject: Re: Anyone know why git ls-remote output might be corrupted?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Date:   Mon, 12 Jun 2023 15:59:09 -0400
In-Reply-To: <xmqqo7loo42s.fsf@gitster.g>
References: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
         <CABPp-BF9Xjww=BBkL4qQcENo-UCHd8eEj334ho1iO1EMbGxhZw@mail.gmail.com>
         <e6f9334dd93c683b97ecdf61eb06bbe28b0a4e30.camel@mad-scientist.net>
         <xmqqo7loo42s.fsf@gitster.g>
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
X-Exim-ID: 1q8nh1-002Gyj-0a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.0.90]:37373
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2023-06-10 at 03:58 +0900, Junio C Hamano wrote:
> Paul Smith <paul@mad-scientist.net> writes:
>=20
> > I also checked and indeed, the git ls-remote command does print to
> > both stdout and stderr as part of its "standard" behavior:
> >=20
> > =C2=A0=C2=A0 $ git ls-remote --heads >/dev/null
> > =C2=A0=C2=A0 From git@git:myrepo
> >=20
> > This is unexpected to me, although of course there's nothing
> > inherently wrong with it but usually you don't expect "regular"
> > output to go to stderr.=C2=A0 I suppose the idea is that people can run=
:
> >=20
> > =C2=A0=C2=A0 $ git ls-remote --heads 2>/dev/null
> >=20
> > if they want just the output without the header.
>=20
> The above sounds like a reasonable expectation; then the issue is
> there are some fflush missing when the command writes to one stream
> and switches to write to another stream?

It's not immediately clear to me which "above" you refer to as a
reasonable expectation (the reason for the stdout vs. stderr different
I suppose?)

But I agree that forcing flush would be a good idea (or perhaps forcing
line buffering?  Changing buffering can be annoying to do portably),
for situations in which the output is being sent to a non-TTY, because
the default in that situation is fully buffered output.

Maybe it would be sufficient to have any output to stderr run
fflush(stdout) before the output, and fflush(stderr) after the output.
Presumably output to stderr is relatively rare, and so this wouldn't be
very noticeable.
