Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAD3C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2ADA2084D
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgHETYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:24:16 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59536 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgHER31 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:29:27 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BMJWq12nlz1qsb0;
        Wed,  5 Aug 2020 19:29:11 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BMJWq0Cr1z1qvK9;
        Wed,  5 Aug 2020 19:29:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id rnREwbE85U_7; Wed,  5 Aug 2020 19:29:10 +0200 (CEST)
X-Auth-Info: Vq0brFvb/MYQVlI6lyhBbk9aTMg7iyF9rNEaLbd5WvplwoFVkgE8yjT5WG5GtPPD
Received: from igel.home (ppp-46-244-173-159.dynamic.mnet-online.de [46.244.173.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  5 Aug 2020 19:29:10 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 9AB262C28C8; Wed,  5 Aug 2020 19:29:09 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/14] git-cvsexportcommit: port to SHA-256
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
        <20200622180418.2418483-1-sandals@crustytoothpaste.net>
        <20200622180418.2418483-15-sandals@crustytoothpaste.net>
        <87zh7bo9so.fsf@igel.home>
        <20200803235007.GN6540@camp.crustytoothpaste.net>
X-Yow:  I wish I was a sex-starved manicurist found dead in the Bronx!!
Date:   Wed, 05 Aug 2020 19:29:09 +0200
In-Reply-To: <20200803235007.GN6540@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 3 Aug 2020 23:50:07 +0000")
Message-ID: <878setj922.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Aug 03 2020, brian m. carlson wrote:

> On 2020-08-03 at 18:37:27, Andreas Schwab wrote:
>> On Jun 22 2020, brian m. carlson wrote:
>> 
>> > diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
>> > index fc00d5946a..6483d792d3 100755
>> > --- a/git-cvsexportcommit.perl
>> > +++ b/git-cvsexportcommit.perl
>> > @@ -22,6 +22,10 @@
>> >  my $repo = Git->repository();
>> >  $opt_w = $repo->config('cvsexportcommit.cvsdir') unless defined $opt_w;
>> >  
>> > +my $tmpdir = File::Temp->newdir;
>> 
>> File::Temp in perl 5.10 doesn't have the newdir method.
>
> That method was added in File::Temp 0.19, which was added in 2007.  Does
>
>   my $tmpdir = File::Temp::tempdir(CLEANUP => 1);
>
> do the right thing on your Perl 5.10?

With that change, the testsuite runs sucessfully.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
