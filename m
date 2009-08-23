From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: pull ref markes pull out of subject <a> tag
Date: Sun, 23 Aug 2009 22:13:47 +0200
Message-ID: <200908232213.48786.jnareb@gmail.com>
References: <1251016089-10548-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 22:14:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfJSJ-0004Vt-13
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 22:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934046AbZHWUNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 16:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934021AbZHWUNz
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 16:13:55 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:62152 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934018AbZHWUNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 16:13:54 -0400
Received: by ewy3 with SMTP id 3so1876832ewy.18
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 13:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zvYnKzG1elD+yJsZTQp8vmc9wSA6CMJ4FccD3DjRvOc=;
        b=Z10jaHXt3k3R7Z2HCMhBNwFzyl4eujlI1mcrsB7+0wrNdhkUZck2pXgchcU6oY5wpY
         iOfPI4g1Tonprar96FgP/SfOnnc+fmwWdFtqVBajpnPNVD/D1z69RS630s7Fb8zfpmwk
         tiGzk9UmtXV9xzup+/jDfCCm7CoviSz5kPALg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xEqXhGmoxo4yFrcQsw2XdMhYZZIZA3LR7Uczg/61PmATDJd3shKn/hh8sUq59/y2zD
         tGTgABAiV0v63yNLlMNtWqcXQnV6uQ9iuMbpnL1p6keLAH0N7dPae2UvBdY2yfuL3ncu
         jn93VgaRDLUizGJR1KPIxBxgzcUGfoAKTcLkE=
Received: by 10.210.53.1 with SMTP id b1mr3953098eba.56.1251058435120;
        Sun, 23 Aug 2009 13:13:55 -0700 (PDT)
Received: from ?192.168.1.13? (abvk11.neoplus.adsl.tpnet.pl [83.8.208.11])
        by mx.google.com with ESMTPS id 7sm2808649eyb.47.2009.08.23.13.13.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 Aug 2009 13:13:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1251016089-10548-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126868>

On Sun, 23 Aug 2009, Giuseppe Bilotta wrote:

> Since 4afbaefffa9095fe1391b4b61289a7dc954e9f7b ref markers that
> accompain the subject in views such as shortlog and history point to
> something different from the subject itself. Therefore, they should not
> be included in the same <a> tag.
> 
> Benefits of the change are:
> * better compliance to the XHTML standards, that forbid links within
>   links even though the restriction cannot be imposed via DTD; this also
>   benefits visualization in some older browsers;

Yes, some older browsers (like Mozilla 1.7.12, Gecko/20050923) did 
_enforce_ that requirement when served document with XHTML DOCTYPE,
and application/xml+xhtml Content-Type, by moving inner link (A element)
just outside (just after) outer, containing <a> element.

For format_subject_html which you are fixing, and which is used by 
'shortlog', 'history' and 'tags' views this didn't cause much changes
in layout.  But the way gitweb uses git_print_header_div in views such
as 'tree', 'blob' etc., where the outer (containing) link is made into
*block* element[1] by the way of CSS (display: block) makes layout 
(visualisation) very screwed up in older browser.  But I don't expect
you to fix that.

[1] Originally so the area to click is larger.

> * when hovering the subject, only the subject itself is underlined; when
>   hovering the ref markers, only the text in the hovered ref marker is
>   underlined; previously, hovering any written part of the subject
>   column led to complete underlying of everything at the same time,
>   with unpleasing effects.

Signoff?

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> The next step would be to find a way to layout decently the case when
> some shortlog entries have a _humongous_ amount of ref markers. See
> for example http://git.oblomov.eu/acecad/shortlog
> 
> I honestly doubt these cases happen in normal git repositories, but it
> might still be worth taking them into consideration. Possibilities
> include hard-limiting the title column maximum width (in browsers for
> which the corresponding attributes and rules work), manual insertion of
> hard line breaks <br/> every n-th ref marker, or something more dynamic
> such as hiding most of the ref markers when they are more than, say, 5,
> and showing them on hover.
> 
> Suggestions? Comments?

Perhaps limiting to heads and tags if there are too many refs?

> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ce6e8f6..bb9648b 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1524,10 +1524,10 @@ sub format_subject_html {
>  		$long =~ s/[[:cntrl:]]/?/g;
>  		return $cgi->a({-href => $href, -class => "list subject",
>  		                -title => to_utf8($long)},
> -		       esc_html($short) . $extra);
> +		       esc_html($short)) . $extra;
>  	} else {
>  		return $cgi->a({-href => $href, -class => "list subject"},
> -		       esc_html($long)  . $extra);
> +		       esc_html($long)) . $extra;
>  	}
>  }
>  
> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
