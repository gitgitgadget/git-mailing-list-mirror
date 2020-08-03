Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF8BC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A307206D4
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgHCShc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:37:32 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49315 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCShc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:37:32 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BL67X6S4Cz1qrfx;
        Mon,  3 Aug 2020 20:37:28 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BL67X5fTYz1qwTH;
        Mon,  3 Aug 2020 20:37:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id BSaKjiqPJSmb; Mon,  3 Aug 2020 20:37:28 +0200 (CEST)
X-Auth-Info: WkrP54dDYJZ0rub6PVEnd89FIzE1jnLZbDF78n/AoxeYOIfp8s315h9wdobqlPYF
Received: from igel.home (ppp-46-244-160-167.dynamic.mnet-online.de [46.244.160.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  3 Aug 2020 20:37:27 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 78B242C0A92; Mon,  3 Aug 2020 20:37:27 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/14] git-cvsexportcommit: port to SHA-256
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
        <20200622180418.2418483-1-sandals@crustytoothpaste.net>
        <20200622180418.2418483-15-sandals@crustytoothpaste.net>
X-Yow:  I'll clean your ROOM!!  I know some GOOD stories, too!!  All about
 ROAD Island's, HUSH Puppies, and how LUKE finds GOLD on his LAND!!
Date:   Mon, 03 Aug 2020 20:37:27 +0200
In-Reply-To: <20200622180418.2418483-15-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 22 Jun 2020 18:04:18 +0000")
Message-ID: <87zh7bo9so.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jun 22 2020, brian m. carlson wrote:

> diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> index fc00d5946a..6483d792d3 100755
> --- a/git-cvsexportcommit.perl
> +++ b/git-cvsexportcommit.perl
> @@ -22,6 +22,10 @@
>  my $repo = Git->repository();
>  $opt_w = $repo->config('cvsexportcommit.cvsdir') unless defined $opt_w;
>  
> +my $tmpdir = File::Temp->newdir;

File::Temp in perl 5.10 doesn't have the newdir method.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
