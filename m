From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 04/12] gitweb: nagivation menu for tags, heads and remotes
Date: Sun, 26 Sep 2010 19:52:07 +0200
Message-ID: <201009261952.07803.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <1285344167-8518-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 19:52:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzvOg-0003Ze-T8
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 19:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab0IZRwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 13:52:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45646 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab0IZRwR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 13:52:17 -0400
Received: by bwz11 with SMTP id 11so2869026bwz.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=y5WPNJbj9vGUlXKwPets38pnFv/rk9YgNUfvlB2EBPc=;
        b=PL1FnOE1nSHTDFtz4MD2x6NQUenNdn8PPdxLyqTUkPCd86J7lW5nVTQVlFEfB6wJMp
         lsDjfDo10ASmx753t7kDRHh/xmjg1UQiCOnrSbnU2+OAyqyBdoM2H46iJguCatO3V2gM
         JOy+5HHM032CzOozfN31Js2r6L3ntcD8RBDk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=X2DPVZ3yTX/OP4q0iyjDoLHQnzAEH5GUbe8ziADnBdgWsW35rOO0y0tBTKmtBcj7wL
         jF9SphDJdN44J2/lC/7CWIZYdON1FPlV5SsNRZfwS7PLyfko8W23gHrdlh4utoymVbnN
         1V18efQcqFrKQ/HE9u3fLwCTzLZyofS86r7E4=
Received: by 10.204.19.83 with SMTP id z19mr4442721bka.43.1285523536077;
        Sun, 26 Sep 2010 10:52:16 -0700 (PDT)
Received: from [192.168.1.13] (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id f18sm3576264bkf.15.2010.09.26.10.52.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 10:52:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1285344167-8518-5-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157245>

On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

> tags, heads and remotes are all views that inspect a (particular class
> of) refs, so allow the user to easily switch between them by adding
> the appropriate navigation submenu to each view.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Nice idea.  FWIW

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   20 +++++++++++++++++---
>  1 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index fe9f73e..c3ce7a3 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3721,6 +3721,20 @@ sub git_print_page_nav {
>  	      "</div>\n";
>  }
>  
> +# returns a submenu for the nagivation of the refs views (tags, heads,
> +# remotes) with the current view disabled and the remotes view only
> +# available if the feature is enabled
> +

Minor nitpick: this empty line here is not necessary.  But I think
that Junio can remove it when applying.

> +sub format_ref_views {
> +	my ($current) = @_;
> +	my @ref_views = qw{tags heads};

Hmmm... should we pass it as argument, or use $action in place of
$current?  Each solution has its advantages and disadvantages.  Current
solution has the advantage of avoiding using global variables, solution
using $action has the (supposed) advantage of automatically detecting
current action.

I would probably write

  +	my $current) = shift;
  +	my @ref_views = qw(tags heads);

but it makes no difference, and this style is also good.

> +	push @ref_views, 'remotes' if gitweb_check_feature('remote_heads');
> +	return join " | ", map {
> +		$_ eq $current ? $_ :
> +		$cgi->a({-href => href(action=>$_, -replay=>1)}, $_)
> +	} @ref_views
> +}
[...]

> -	git_print_page_nav('','', $head,undef,$head);
> +	git_print_page_nav('','', $head,undef,$head,format_ref_views('tags'));

> -	git_print_page_nav('','', $head,undef,$head);
> +	git_print_page_nav('','', $head,undef,$head,format_ref_views('heads'));

> -	git_print_page_nav('','', $head,undef,$head);
> +	git_print_page_nav('','', $head,undef,$head,format_ref_views('remotes'));

Nice API.  I like it.

-- 
Jakub Narebski
Poland
