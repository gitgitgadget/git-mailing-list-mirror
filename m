Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA8CC433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F4E2098B
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdinc.us header.i=@pdinc.us header.b="POOJ8xay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgFPRKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:10:03 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:50334 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgFPRKD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 13:10:03 -0400
X-Greylist: delayed 3307 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2020 13:10:03 EDT
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 05GGEj39017952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Jun 2020 12:14:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 05GGEj39017952
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1592324086; bh=6pkKba5cXi2BBbQc1sotPZ8CJNyFxZcoRKWQzJ/c11c=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=POOJ8xaykCHxVHElv8VrbvazpUickU3FJD3zJjW9Q07A1RT5oUBaDsN+0xh0/hM2w
         IkaAJxtw+AQKXIEByGhQYfoyHMLuLCNC2psF+9RQbN63zDwo2sz3KIABss2jJzu/VD
         aHFmKZBV2u7aCb+K0IMMGGSl4/PFuk2OLiw5oQ2n40vCnRSqefLGJFEhbMoFk/XOzq
         XUHEMlbNT8qVj1Oq431dng1Gf4F9J/60K/g5Big2W41nP8Xz9tW3qbkmzMghq2SZXa
         oyeCCi3HwUWVuGOaVyoVPY6Css5Et8MqgJAVAQF/bQBQwfHdXApJByzN1O08h9L8kc
         ZSJUYK5MvCdiQ==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Taylor Blau'" <me@ttaylorr.com>,
        "'James Ramsay'" <james@jramsay.com.au>,
        "'Bryan Turner'" <bturner@atlassian.com>,
        "'Konstantin Ryabitsev'" <konstantin@linuxfoundation.org>,
        "'Jeff King'" <peff@peff.net>
References: <20200615205722.GG71506@syl.local> <20200615212154.GA79696@syl.local> <20200616143107.GL666057@coredump.intra.peff.net> <20200616161001.fa5wa2br5ois2csr@chatter.i7.local>
In-Reply-To: <20200616161001.fa5wa2br5ois2csr@chatter.i7.local>
Subject: RE: Consensus on a new default branch name
Date:   Tue, 16 Jun 2020 12:14:55 -0400
Organization: PD Inc
Message-ID: <14ba01d643f9$46a9f730$d3fde590$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
thread-index: AQIHqZ+JFomW5Koz4SoF22NfbYORsAMNkY45Arsp5q0CZtNrn6g3IiMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Konstantin Ryabitsev
> Sent: Tuesday, June 16, 2020 12:10 PM
>=20
> On Tue, Jun 16, 2020 at 10:31:07AM -0400, Jeff King wrote:
> >
> > My biggest concern here was trying to understand what could break.
> > Having read the patches from Johannes and thought about it a lot, I =
have
> > a pretty good handle on where Git itself cares about the name. And I
> > feel pretty confident that we can make the change in a way that =
won't
> > cause problems there (and in fact, I think some of the code will be
> > made more robust by relying on HEAD more appropriately).
> >
> > There's a more open question of what _else_ will break in the =
ecosystem.
>=20
> What if we work on making this configurable for now, but stick with =
the
> legacy name until we introduce breaking sha1 changes? Almost =
everything
> will need to retool for those anyway (and all documentation =
rewritten),
> so it is reasonable to bundle these changes to happen at the same =
time.

+1 - that will also allow for a more social influence on the other =
tooling in the ecosystem. Projects new and existing will start to adopt =
a name, and that will be surveyable.

