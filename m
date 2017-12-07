Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46DCF20C31
	for <e@80x24.org>; Thu,  7 Dec 2017 07:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbdLGH5y (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 02:57:54 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:31206 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750807AbdLGH5y (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2017 02:57:54 -0500
X-IronPort-AV: E=Sophos;i="5.45,371,1508796000"; 
   d="scan'208";a="304351111"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 07 Dec 2017 08:57:52 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Subject: Re: [PATCH v3] send-email: extract email-parsing code into a subroutine
References: <CAGb4CBWZciqxdfpSkK1vezhiuSYX5Yy-xSq=Uj4h+vhRo9uyoQ@mail.gmail.com>
        <2b59497271cd4fada4ff590a001446cf@BPMBX2013-01.univ-lyon1.fr>
Date:   Thu, 07 Dec 2017 08:57:46 +0100
In-Reply-To: <2b59497271cd4fada4ff590a001446cf@BPMBX2013-01.univ-lyon1.fr>
        (PAYRE NATHAN's message of "Wed, 6 Dec 2017 23:02:25 +0000")
Message-ID: <q7h9609jotqd.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr> writes:

> Without the "print" used for testing. 

But still smoe broken indentation:

>  git-send-email.perl | 90 +++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 63 insertions(+), 27 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2208dcc21..a10574a56 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -715,41 +715,63 @@ EOT3
>  	if (!defined $compose_encoding) {
>  		$compose_encoding = "UTF-8";
>  	}
> -	while(<$c>) {
> -		next if m/^GIT:/;
> -		if ($in_body) {
> -			$summary_empty = 0 unless (/^\n$/);
> -		} elsif (/^\n$/) {
> -			$in_body = 1;
> -			if ($need_8bit_cte) {
> +
> +    my %parsed_email;
> +	$parsed_email{'body'} = '';
> +    while (my $line = <$c>) {
> +	    next if $line =~ m/^GIT:/;
> +	    parse_header_line($line, \%parsed_email);
> +	    if ($line =~ /^\n$/i) {
> +	        while (my $body_line = <$c>) {
> +                if ($body_line !~ m/^GIT:/) {
> +                    $parsed_email{'body'} = $parsed_email{'body'} . $body_line;
> +                }
> +	        }
> +		}
> +	}

This may display properly in your text editor with your setting, but
appears broken at least with tab-width=8. Don't mix tabs and spaces. The
Git coding style is to indent with tabs.

To see what I mean, open the script in Emacs and type M-x
whitespace-mode RET.

-- 
Matthieu Moy
https://matthieu-moy.fr/
