Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AFFF202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 16:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbdJZQVC (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 12:21:02 -0400
Received: from smtprelay0151.hostedemail.com ([216.40.44.151]:50808 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932345AbdJZQVC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2017 12:21:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6269E181D12E7;
        Thu, 26 Oct 2017 16:21:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crow84_7d130aec7595b
X-Filterd-Recvd-Size: 1511
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Oct 2017 16:20:59 +0000 (UTC)
Message-ID: <1509034857.11245.4.camel@perches.com>
Subject: Re: grep vs git grep performance?
From:   Joe Perches <joe@perches.com>
To:     SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git <git@vger.kernel.org>
Date:   Thu, 26 Oct 2017 09:20:57 -0700
In-Reply-To: <20171026161354.23037-1-szeder.dev@gmail.com>
References: <20171026161354.23037-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-10-26 at 18:13 +0200, SZEDER Gábor wrote:
> > Comparing a cache warm git grep vs command line grep
> > shows significant differences in cpu & wall clock.
> > 
> > Any ideas how to improve this?
> > 
> > $ time git grep "\bseq_.*%p\W" | wc -l
> > 112
> > 
> > real	0m4.271s
> > user	0m15.520s
> > sys	0m0.395s
> > 
> > $ time grep -r --include=*.[ch] "\bseq_.*%p\W" * | wc -l
> > 112
> > 
> > real	0m1.164s
> > user	0m0.847s
> > sys	0m0.314s
> 
> Note that this "regular" grep is limited to *.c and *.h files, while
> the above git grep invocation isn't and has to look at all tracked
> files.  How does
> 
>   git grep "\bseq_.*%p\W" "*.[ch]"
> 
> fare?

Same-ish

$ time git grep "\bseq_.*%p\W" -- "*.[ch]" | wc -l
112

real	0m4.225s
user	0m14.485s
sys	0m0.413s
