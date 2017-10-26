Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE964202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 17:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbdJZRlm (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 13:41:42 -0400
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:51731 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932309AbdJZRlm (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2017 13:41:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2B384837F243;
        Thu, 26 Oct 2017 17:41:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bun82_65ba8e2d99957
X-Filterd-Recvd-Size: 1951
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Oct 2017 17:41:38 +0000 (UTC)
Message-ID: <1509039696.11245.9.camel@perches.com>
Subject: Re: grep vs git grep performance?
From:   Joe Perches <joe@perches.com>
To:     Stefan Beller <sbeller@google.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
Date:   Thu, 26 Oct 2017 10:41:36 -0700
In-Reply-To: <CAGZ79ka41NdzNxGAvtVW802088KydKkp3yHx=Z5q3Mc9GGa_+g@mail.gmail.com>
References: <1509030170.10651.59.camel@perches.com>
         <CAGZ79ka41NdzNxGAvtVW802088KydKkp3yHx=Z5q3Mc9GGa_+g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-10-26 at 09:58 -0700, Stefan Beller wrote:
> + Avar who knows a thing about pcre (I assume the regex compilation
> has impact on grep speed)
> 
> On Thu, Oct 26, 2017 at 8:02 AM, Joe Perches <joe@perches.com> wrote:
> > Comparing a cache warm git grep vs command line grep
> > shows significant differences in cpu & wall clock.
> > 
> > Any ideas how to improve this?
> > 
> > $ time git grep "\bseq_.*%p\W" | wc -l
> > 112
> > 
> > real    0m4.271s
> > user    0m15.520s
> > sys     0m0.395s
> > 
> > $ time grep -r --include=*.[ch] "\bseq_.*%p\W" * | wc -l
> > 112
> > 
> > real    0m1.164s
> > user    0m0.847s
> > sys     0m0.314s
> > 
> 
> I wonder how much is algorithmic advantage vs coding/micro
> optimization that we can do.

As do I.  I presume this is libpcre related.

For instance, git grep performance is better than grep for:

$ time git grep -w "seq_printf" -- "*.[ch]" | wc -l
8609

real	0m0.301s
user	0m0.548s
sys	0m0.372s

$ time grep -w -r --include=*.[ch] "seq_printf" * | wc -l
8609

real	0m0.706s
user	0m0.396s
sys	0m0.309s


