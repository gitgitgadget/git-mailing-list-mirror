From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-send-email.perl extract_valid_address issue
Date: Mon, 29 May 2006 15:12:40 -0700
Message-ID: <20060529221240.GE24077@localdomain>
References: <20060529200026.GA32457@h4x0r5.com> <200605292109.k4TL9g7E014263@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>,
	Nicolas Troncoso Carrere <ntroncos@alumnos.inf.utfsm.cl>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 00:12:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkpyg-0006Gk-TT
	for gcvg-git@gmane.org; Tue, 30 May 2006 00:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWE2WMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 18:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWE2WMo
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 18:12:44 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44466 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751328AbWE2WMn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 18:12:43 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 86C8C2DC01A;
	Mon, 29 May 2006 15:12:41 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 29 May 2006 15:12:40 -0700
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200605292109.k4TL9g7E014263@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20985>

Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Fix regexps to better match email addresses if Email::Valid isn't present
> Make it return the address on match containing a @
> 
> Signed-off-by:  Horst H. von Brand <vonbrand@inf.utfsm.cl>
> ---
>  git-send-email.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 312a4ea..6e39f2f 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -309,14 +309,14 @@ sub extract_valid_address {
>  	my $address = shift;
>  
>  	# check for a local address:
> -	return $address if ($address =~ /^([\w\-]+)$/);
> +	return $address if ($address =~ /^([\w\-.]+)$/);
>  
>  	if ($have_email_valid) {
>  		return Email::Valid->address($address);
>  	} else {
>  		# less robust/correct than the monster regexp in Email::Valid,
>  		# but still does a 99% job, and one less dependency
> -		return ($address =~ /([^\"<>\s]+@[^<>\s]+)/);
> +		return ($address =~ /([\w\-.]+@[\w\-.]+)/) ? $1 : undef;
>  	}
>  }

Oops on the original bug, my fault :x
Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
