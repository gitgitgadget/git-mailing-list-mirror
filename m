From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: bugfix: a.list formatting regression
Date: Tue, 22 Aug 2006 21:43:39 -0700 (PDT)
Message-ID: <20060823044339.28307.qmail@web31806.mail.mud.yahoo.com>
References: <11562409683011-git-send-email-jnareb@git.vger.kernel.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 23 06:43:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFkaj-0005ta-HF
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 06:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWHWEnl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 00:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWHWEnl
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 00:43:41 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:604 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932352AbWHWEnk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 00:43:40 -0400
Received: (qmail 28309 invoked by uid 60001); 23 Aug 2006 04:43:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wBe5KkcyAKtJGfL6izR6TDCbKxnDrtoFUxGqtMXIl/ydPGcROOkx9QCb6rQXdluuDIdoe6N9fNS+O7covjVuTy9z1P+O+7O/Unao9IZSUM2ThdcLai10URf9/g0eU2wmwrrB5lJ2/mZmAsGA2gvC+lzlVCeNJ7dp7qp0ianyaOY=  ;
Received: from [71.84.29.50] by web31806.mail.mud.yahoo.com via HTTP; Tue, 22 Aug 2006 21:43:39 PDT
To: Jakub Narebski <jnareb@git.vger.kernel.org>, git@vger.kernel.org
In-Reply-To: <11562409683011-git-send-email-jnareb@git.vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25893>

--- Jakub Narebski <jnareb@git.vger.kernel.org> wrote:

> From: Jakub Narebski <jnareb@gmail.com>
> 
> Fix regression introduced by
> commit 17d07443188909ef5f8b8c24043cb6d9fef51bca.
> 
> "a.list" being "bold", makes a myriad of things shown by
> gitweb in bold font-weight, which is a regression from
> pre-17d07443188909ef5f8b8c24043cb6d9fef51bca behavior.
> 
> The fix is to add "subject" class and use this class
> to replace pre-format_subject_html formatting of subject
> (comment) via using (or not) <b>...</b> element. This
> should go back to the pre-17d0744318... style.
> 
> Regression noticed by Luben Tuikov.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> ---

ACK.  Looks good.

   Luben


> Luben Tuikov wrote:
> 
> > 1. Commit 17d07443188909ef5f8b8c24043cb6d9fef51bca defines
> > "a.list" twice in gitweb.css, once with bold and once with
> > normal font-weight.
> 
> "table.tags a.list" means "a.list" inside "table.tags",
> so it is not redefinition of "a.list", but override
> (more specific CSS rule wins). It is for subject of tags
> list ("summary" and "tags" actions) to be in normal
> weight, as in such list the tag itself (ref) is in bold,
> not the tag comment (first line of free form part of tag).
> 
>  gitweb/gitweb.css  |    7 +++++--
>  gitweb/gitweb.perl |    4 ++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 9013895..6c13d9e 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -117,11 +117,14 @@ div.list_head {
>  
>  a.list {
>  	text-decoration: none;
> -	font-weight: bold;
>  	color: #000000;
>  }
>  
> -table.tags a.list {
> +a.subject {
> +	font-weight: bold;
> +}
> +
> +table.tags a.subject {
>  	font-weight: normal;
>  }
>  
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 90157d5..40c5177 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -504,11 +504,11 @@ sub format_subject_html {
>  	$extra = '' unless defined($extra);
>  
>  	if (length($short) < length($long)) {
> -		return $cgi->a({-href => $href, -class => "list",
> +		return $cgi->a({-href => $href, -class => "list subject",
>  		                -title => $long},
>  		       esc_html($short) . $extra);
>  	} else {
> -		return $cgi->a({-href => $href, -class => "list"},
> +		return $cgi->a({-href => $href, -class => "list subject"},
>  		       esc_html($long)  . $extra);
>  	}
>  }
> -- 
> 1.4.1.1
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
