Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9447C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 20:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjFBUMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 16:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjFBUMj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 16:12:39 -0400
Received: from qproxy4-pub.mail.unifiedlayer.com (qproxy4-pub.mail.unifiedlayer.com [66.147.248.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810711AB
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 13:12:37 -0700 (PDT)
Received: from gproxy2-pub.mail.unifiedlayer.com (gproxy2-pub.mail.unifiedlayer.com [69.89.18.3])
        by qproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id 179D58026289
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 20:12:37 +0000 (UTC)
Received: from cmgw12.mail.unifiedlayer.com (unknown [10.0.90.127])
        by progateway4.mail.pro1.eigbox.com (Postfix) with ESMTP id BD91C1004807D
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 20:12:36 +0000 (UTC)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with ESMTP
        id 5B8WqpC0Y0K9w5B8WqoU4N; Fri, 02 Jun 2023 20:12:36 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=Xf5McK15 c=1 sm=1 tr=0 ts=647a4d34
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=of4jigFt-DYA:10:nop_rcvd_month_year
 a=3EOfIcITIxQA:10:endurance_base64_authed_username_1 a=Dx4yW56zAAAA:8
 a=uHhnXkA7vyChcXNcswkA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=zZCYzV9kfG8A:10:nop_mobile_phish_fin_urg a=X_u8qhY6y2Nm79co_leF:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XHEyhFaBNxR6oc15SXt+L4pvQ7yxviyaGkSnF3lBqLg=; b=2Hj4pe/42tdX+1k1emPL49voFa
        2GYOGz599i0e3UTNBbm0VctbYmU9TLG4NAjQbBbLC0b+ructU0DgLeZknURD8M/bJxSAP9bk12bCs
        wgeKnTn653V0wyYt7jOGToPJa;
Received: from [160.231.0.90] (port=14850 helo=llin-psh13-dsa.dsone.3ds.com)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <paul@mad-scientist.net>)
        id 1q5B8W-0019Vw-E0
        for git@vger.kernel.org;
        Fri, 02 Jun 2023 14:12:36 -0600
Message-ID: <110083dc83b21cad7a9cb143604cd13dba097110.camel@mad-scientist.net>
Subject: Re: Anyone know why git ls-remote output might be corrupted?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     git@vger.kernel.org
Date:   Fri, 02 Jun 2023 16:12:35 -0400
In-Reply-To: <000f01d9958d$347d6220$9d782660$@nexbridge.com>
References: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
               <7aa2ab6714bd14671ba9cfff611dea2fa088c99e.camel@mad-scientist.net>
              <000501d99589$358d4850$a0a7d8f0$@nexbridge.com>
         <679863bd1ed8a54b48472ad310c2bae7f274e1ec.camel@mad-scientist.net>
         <000f01d9958d$347d6220$9d782660$@nexbridge.com>
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
X-Exim-ID: 1q5B8W-0019Vw-E0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.0.90]:14850
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2023-06-02 at 16:02 -0400, rsbecker@nexbridge.com wrote:
> > > Does your CI/CD system use sparse checkout or depth=3D1 or some
> > > other partial clone?
> >=20
> > Yes, the local copy of the repo is a sparse checkout.
> >=20
> > I'm surprised that matters to ls-remote... I would have expected
> > that the "sparseness" of the local repo is irrelevant when listing
> > the state of the remote's heads?
>=20
> I'm just wondering whether this might be an impact somehow and adding
> info to help the team diagnose. I have seen other commands have some
> issues in the past with --depth=3Dn

I see.  Well I can try changing my call to avoid the local repo in any
way, and run 'git ls-remote --heads user@server:reponame' from a
temporary directory outside of any repo, rather than using "origin".

I would be surprised if it makes a difference but the behavior is sure
strange enough that I wouldn't be THAT surprised :)
