Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A0AC77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 19:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjFBTxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 15:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjFBTxN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 15:53:13 -0400
Received: from qproxy2-pub.mail.unifiedlayer.com (qproxy2-pub.mail.unifiedlayer.com [69.89.16.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1928419A
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 12:53:12 -0700 (PDT)
Received: from alt-proxy28.mail.unifiedlayer.com (alt-proxy28.mail.unifiedlayer.com [74.220.216.123])
        by qproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id C986680493EA
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 19:53:11 +0000 (UTC)
Received: from cmgw12.mail.unifiedlayer.com (unknown [10.0.90.127])
        by progateway1.mail.pro1.eigbox.com (Postfix) with ESMTP id 5A3951003F978
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 19:53:11 +0000 (UTC)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with ESMTP
        id 5Apjqp2eE0K9w5ApjqoKpP; Fri, 02 Jun 2023 19:53:11 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=Xf5McK15 c=1 sm=1 tr=0 ts=647a48a7
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=of4jigFt-DYA:10:nop_rcvd_month_year
 a=3EOfIcITIxQA:10:endurance_base64_authed_username_1 a=Dx4yW56zAAAA:8
 a=xGwI6Rj7CTxsdUQT0vcA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=X_u8qhY6y2Nm79co_leF:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s0p++Y+ECvskAhAmP7mFuBp7t8JQBB85YtUBVM1XQ0M=; b=zUdvMq4TAjVgffFAD3Ox762XAA
        VLM9k4rdgtX0L9u6RLVcjYqnW/fWIatLV8lmG/9XohwXIZ1cXTcEoZVJazCS/kyS0ARomCblFbatm
        tD9AsxFrFCwAGby8K4cLSUntt;
Received: from [160.231.0.90] (port=42044 helo=llin-psh13-dsa.dsone.3ds.com)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <paul@mad-scientist.net>)
        id 1q5Api-000t5N-VL;
        Fri, 02 Jun 2023 13:53:11 -0600
Message-ID: <679863bd1ed8a54b48472ad310c2bae7f274e1ec.camel@mad-scientist.net>
Subject: Re: Anyone know why git ls-remote output might be corrupted?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     rsbecker@nexbridge.com, git@vger.kernel.org
Date:   Fri, 02 Jun 2023 15:53:09 -0400
In-Reply-To: <000501d99589$358d4850$a0a7d8f0$@nexbridge.com>
References: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
         <7aa2ab6714bd14671ba9cfff611dea2fa088c99e.camel@mad-scientist.net>
         <000501d99589$358d4850$a0a7d8f0$@nexbridge.com>
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
X-Exim-ID: 1q5Api-000t5N-VL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.0.90]:42044
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 2
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2023-06-02 at 15:34 -0400, rsbecker@nexbridge.com wrote:
> On Friday, June 2, 2023 3:13 PM, Paul Smith wrote:
> > On Fri, 2023-06-02 at 14:59 -0400, Paul Smith wrote:
> > > Also a bunch of the heads are missing.=C2=A0 It's pretty clear that
> > > right in the middle of printing one of the SHAs we suddenly lost
> > > a bunch of output, and started printing stuff from later (in the
> > > last instance 66 out of 131 heads were missing).
> >=20
> > I forgot to mention: git ls-remote does not exit with an error
> > code.  The exit code is 0 (success).
> >=20
> > The reason I get this failure is that as I parse the output I
> > notice that the SHA is invalid (contains a non-hex character "i")
> > and it throws this error.
>=20
> Does your CI/CD system use sparse checkout or depth=3D1 or some other
> partial clone?

Yes, the local copy of the repo is a sparse checkout.

I'm surprised that matters to ls-remote... I would have expected that
the "sparseness" of the local repo is irrelevant when listing the state
of the remote's heads?  Is that the reason for the issue I'm seeing?
