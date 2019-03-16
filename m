Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F5B20248
	for <e@80x24.org>; Sat, 16 Mar 2019 19:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCPThK (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 15:37:10 -0400
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:47783 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726573AbfCPThJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 Mar 2019 15:37:09 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Mar 2019 15:37:09 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id DACD018036187
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 19:30:37 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1D5E3100E86C5;
        Sat, 16 Mar 2019 19:30:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: light39_5c993f5191f42
X-Filterd-Recvd-Size: 2283
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 16 Mar 2019 19:30:36 +0000 (UTC)
Message-ID: <8e28e622af4143b13a9bfa5c7a6df33d8baf1b5e.camel@perches.com>
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
From:   Joe Perches <joe@perches.com>
To:     Baruch Siach <baruch@tkos.co.il>, git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Date:   Sat, 16 Mar 2019 12:30:35 -0700
In-Reply-To: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2019-03-16 at 21:26 +0200, Baruch Siach wrote:
> Since commit ef0cc1df90f6b ("send-email: also pick up cc addresses from
> -by trailers") in git version 2.20, git send-email adds to cc list
> addresses from all *-by lines. As a side effect a line with
> '-Signed-off-by' is now also added to cc. This makes send-email pick
> lines from patches that remove patch files from the git repo. This is
> common in the Buildroot project that often removes (and adds) patch
> files that have 'Signed-off-by' in their patch description part.

Why is such a line used and why shouldn't an author
of a to-be-removed patch be cc'd?

> 
> Consider only *-by lines that start with [a-z] (case insensitive) to
> avoid unrelated addresses in cc.
> 
> Cc: Joe Perches <joe@perches.com>
> Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  git-send-email.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 8eb63b5a2f8d..5656ba83d9b1 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1693,7 +1693,7 @@ sub process_file {
>  	# Now parse the message body
>  	while(<$fh>) {
>  		$message .=  $_;
> -		if (/^([a-z-]*-by|Cc): (.*)/i) {
> +		if (/^([a-z][a-z-]*-by|Cc): (.*)/i) {
>  			chomp;
>  			my ($what, $c) = ($1, $2);
>  			# strip garbage for the address we'll use:

