Return-Path: <SRS0=73cz=AB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12435C433DF
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 08:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDEA523A3B
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 08:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgFTIC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Jun 2020 04:02:59 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:44876 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgFTIC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jun 2020 04:02:59 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49pp7h0fxGz1qrf8;
        Sat, 20 Jun 2020 10:02:56 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49pp7g6mYJz1sPMl;
        Sat, 20 Jun 2020 10:02:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id DqGgRNI52W3b; Sat, 20 Jun 2020 10:02:55 +0200 (CEST)
X-Auth-Info: 6UhupUVplgC7x/hIcYmSptYaYSZGD+/mL7CySDz56Zj6psky+BkhSXk5CPaCai/a
Received: from hase.home (ppp-46-244-167-203.dynamic.mnet-online.de [46.244.167.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 20 Jun 2020 10:02:55 +0200 (CEST)
Received: by hase.home (Postfix, from userid 1000)
        id EBA41101677; Sat, 20 Jun 2020 10:02:53 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Matthew DeVore <matvore@google.com>,
        Eric Wong <e@80x24.org>, Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH 07/14] t/lib-git-svn: make hash size independent
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
        <20200619223947.947067-8-sandals@crustytoothpaste.net>
X-Yow:  Now I'm being INVOLUNTARILY shuffled closer to the CLAM DIP
 with the BROKEN PLASTIC FORKS in it!!
Date:   Sat, 20 Jun 2020 10:02:53 +0200
In-Reply-To: <20200619223947.947067-8-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 19 Jun 2020 22:39:40 +0000")
Message-ID: <87lfkinp02.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jun 19 2020, brian m. carlson wrote:

> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index 7d248e6588..4780b45337 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -78,29 +78,30 @@ maybe_start_httpd () {
>  }
>  
>  convert_to_rev_db () {
> -	perl -w -- - "$@" <<\EOF
> -use strict;
> +	perl -w -e "use strict; my \$oidlen = $(test_oid rawsz);" -e '

$(test_oid rawsz) could be passed as an additional argument.

perl -w -- - "$(test_oid rawsz)" "$@" <<\EOF
use strict;
my $oidlen = shift;
...
EOF

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
