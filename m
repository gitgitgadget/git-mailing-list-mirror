From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 07/12] gitweb: remotes view for a single remote
Date: Sun, 26 Sep 2010 22:55:44 +0200
Message-ID: <201009262255.45959.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <1285344167-8518-8-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 22:56:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzyGP-0005jU-QA
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 22:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758094Ab0IZUz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 16:55:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51574 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851Ab0IZUz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 16:55:56 -0400
Received: by fxm3 with SMTP id 3so1485486fxm.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 13:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7uQEvkbbZY+kn3qAAGHdIXGhgQ0Bc0BJOVXXOyVT/Uo=;
        b=bauuIWHxjcOEHOxUMze3q44W9laD9Z9u85qtCl+WXLLChaeVKH9Mfpt0vHsM6ePvZ4
         ycP7DO6x3RjHwJbXRZF8aODuA2k9nwVA8prmAz23iGwbJkamCpNzWTBWqCOKff/0NgHv
         TgIXD+sELqBdKYpx8MXiohN6+MKmXwlWi2IEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nCT9X1jXer4xzjvPOfCdm8VYPas/l3C2fcplzFczWAoN1Z0pRquuM2nfLnFA7dszqy
         iER/19FGNhKoM0yOyO2SFaGNl8Qgg2SKPMDZg6TauUZuD4rl+c+usjjKMBlbspdruyeJ
         gnTevcNF1HUipzPpVdsD+F8AS9bIZWUjd8im4=
Received: by 10.223.114.19 with SMTP id c19mr6707322faq.29.1285534554772;
        Sun, 26 Sep 2010 13:55:54 -0700 (PDT)
Received: from [192.168.1.13] (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id b11sm2062544faq.6.2010.09.26.13.55.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 13:55:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1285344167-8518-8-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157259>

On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

> If the hash parameter is passed to gitweb, remotes will interpret it as
> the name of a remote and limit the view the the heads of that remote.

Errr... I think this commit message needs rewriting to be more clear.
Perhaps:

  When 'remotes' view is passed 'hash' parameter, it would interprete it
  as the name of a remote ...

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   25 ++++++++++++++++++++-----
>  1 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 76cf806..7c62701 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5547,13 +5547,28 @@ sub git_remotes {
>  		or die_error(403, "Remote heads view is disabled");
>  
>  	my $head = git_get_head_hash($project);
> -	git_header_html();
> -	git_print_page_nav('','', $head,undef,$head,format_ref_views('remotes'));
> +	my $remote = $input_params{'hash'};

I am not sure about using 'hash' parameter for that.

On one hand it is a hack that allow us to not worry about adding extra
code to evaluate_path_info() subroutine, so that natural path_info URL
of http://git.example.com/repo.git/remotes/<remote> would use <remote>
as name of remote to limit to.

On the other hand it is abusing semantic of 'hash' parameter.  Remote
name is not revision name or object id.  

What makes this issue stronger is the fact that URL is part of API,
and if we make mistake here, we would have to maintain backward 
compatibility (at least if it appears in a released version).

> +
> +	git_header_html(undef, undef, 'header_extra' => $remote);

I don't quite like the name of this parameter, and I am not sure
if I like the API either.

> +	git_print_page_nav('', '',  $head, undef, $head,
> +		format_ref_views($remote ? '' : 'remotes'));

Why this change?

>  	git_print_header_div('summary', $project);
>  
> -	my @remotelist = git_get_heads_list(undef, 'remotes');
> -	if (@remotelist) {
> -		git_heads_body(\@remotelist, $head);
> +	if (defined $remote) {
> +		# only display the heads in a given remote
> +		my @headslist = map {
> +			my $ref = $_ ;
> +			$ref->{'name'} =~ s!^$remote/!!;
> +			$ref
> +		} git_get_heads_list(undef, "remotes/$remote");

Hmmm... do we need this temporary variable?  Does it make anything
more clear?

> +		if (@headslist) {
> +			git_heads_body(\@headslist, $head);
> +		}

This part is the same (modulo name of variable) in both branches of this
conditional.

> +	} else {
> +		my @remotelist = git_get_heads_list(undef, 'remotes');
> +		if (@remotelist) {
> +			git_heads_body(\@remotelist, $head);
> +		}
>  	}
>  	git_footer_html();
>  }
> -- 
> 1.7.3.68.g6ec8
> 
> 

-- 
Jakub Narebski
Poland
