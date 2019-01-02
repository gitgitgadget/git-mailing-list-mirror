Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51441F770
	for <e@80x24.org>; Wed,  2 Jan 2019 09:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfABJNs convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 2 Jan 2019 04:13:48 -0500
Received: from smtp.msys.ch ([46.175.8.2]:29455 "EHLO sleipnir.msys.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbfABJNs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 04:13:48 -0500
Received: from mail.msys.ch (smtp.msys.ch [46.175.8.2])
        by sleipnir.msys.ch (8.14.3/8.14.3) with ESMTP id x02B1nhT025593
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Jan 2019 11:01:50 GMT
Received: from dev.arcapos.ch (dev.arcapos.ch [46.175.8.141])
        (authenticated bits=0)
        by mail.msys.ch (8.14.3/8.14.3) with ESMTP id x02B1mvm028793
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Jan 2019 11:01:49 GMT
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
From:   Marc Balmer <marc@msys.ch>
In-Reply-To: <20190101131947.GA18907@ash>
Date:   Wed, 2 Jan 2019 10:13:38 +0100
Cc:     Git Mailing List <git@vger.kernel.org>, roger.strain@swri.org,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <A447E554-FFF7-4F70-A735-80C44A2285A4@msys.ch>
References: <B81E8278-965A-4860-95E1-20ADCAB29BC9@msys.ch>
 <CACsJy8B7=xNBeyYYgMqh-aU_1-Rb8g5t5SwK5jvfbMw4ch-ZLQ@mail.gmail.com>
 <11AC6C27-4C74-43B1-89F6-98ABBFE74E0E@msys.ch>
 <CACsJy8AQ1raB+2wjEBtDrAvJm0v-3exJ-FVB2ZyL6VpRFQkspQ@mail.gmail.com>
 <0F754615-C852-49D8-8E0C-DD2A00A15ED1@msys.ch>
 <CACsJy8C8DVz7u7z01Q3T_vY+DY-StwCQLhkhDJ6XK5C2z0agLA@mail.gmail.com>
 <DE854533-FC7C-4DD4-8F42-C02C4D4524CB@msys.ch> <20190101131947.GA18907@ash>
To:     Duy Nguyen <pclouds@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-SMTP-Vilter-Version: 1.3.6
X-Spamd-Symbols: BAYES_00,RCVD_IN_DNSWL_LOW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> [...]
> 
>> 
> 
> Hmm.. I'm not that familiar with git-subtree.sh, so here's one last
> blind shot.
> 
> There's a format change between git-show and git-rev-parse. The former
> separates commits by spaces while the latter by newlines. Will this
> help?
> 
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 147201dc6c..23f570beee 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -633,7 +633,7 @@ process_split_commit () {
> 	else
> 		# processing commit without normal parent information;
> 		# fetch from repo
> -		parents=$(git rev-parse "$rev^@")
> +		parents=$(git rev-parse "$rev^@" | tr '\n' ' ')
> 		extracount=$(($extracount + 1))
> 	fi
> 

Unfortunately, this did not change the situation.  It still segfaults.

> --
> Duy

