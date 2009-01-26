From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: ensure the default stylesheet is accessible
Date: Mon, 26 Jan 2009 02:48:20 +0100
Message-ID: <200901260248.22120.jnareb@gmail.com>
References: <1232933322-9186-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 02:50:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRGby-0002Bx-6n
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 02:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbZAZBsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 20:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbZAZBsf
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 20:48:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:19112 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZAZBse (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 20:48:34 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3336362fgg.17
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 17:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LrSNclzlHI69JixkeR35Wp/TUYF/RaxhViyeKhGcAnY=;
        b=PoXxeGvd+XzA0TzH/R+tSJLcuztS7GNNLZ9k+BoARwyukyguLUOwXG0y1s/Y6kHmUK
         OL1ib/X909c6cp55HkfiVhRyPxF1X+AWAgVoCNL/kPc/MMEoJJyh8cKTXOXmztjptSDA
         PVKK1+FTr35aUf4W9LAcHFM1xILV43EgEklmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=A3dxc8Yb6X+vJ0ocb3SDeuF5ewZQyTOa3swU6u9E4O8JrhRutGXwoDAHYg4uWIhfnX
         jwIF68gIv+NimtVhtk3UKGJBsQXDDaZe0RsuDYC5KyHGfxgkUFiPXhjJc9K1w0z392fB
         aQB6hXfAyR8ROwdBP93FtwDrX0OL9r2PQ5mwc=
Received: by 10.86.84.18 with SMTP id h18mr425249fgb.22.1232934512965;
        Sun, 25 Jan 2009 17:48:32 -0800 (PST)
Received: from ?192.168.1.15? (abvk161.neoplus.adsl.tpnet.pl [83.8.208.161])
        by mx.google.com with ESMTPS id 4sm11803411fgg.44.2009.01.25.17.48.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jan 2009 17:48:32 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1232933322-9186-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107155>

On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:

> On some installations the CSS fails to be linked correctly when
> path_info is enabled, since the link refers to "gitweb.css", whereas it
> should be "${my_uri}/gitweb.css". Fix by setting the appropriate default
> in the Makefile.

Why "on some installations"? What does "some" mean? I don't think it
is something indeterministic: please spell when one can have problems
with linking CSS file.


Wouldn't it be simpler to deal with problem of base URL when using
path_info gitweb URLs to add BASE element to HTML head if we use
path_info? Something like:

	if ($ENV{'PATH_INFO'}) {  # $path_info is unfortunately stripped
		print qq(<base href="$my_uri">\n);
	} 

somewhere in git_header_html() subroutine?

See also comment below.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 4ef8234..4f60de9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -215,7 +215,7 @@ GITWEB_STRICT_EXPORT =
>  GITWEB_BASE_URL =
>  GITWEB_LIST =
>  GITWEB_HOMETEXT = indextext.html
> -GITWEB_CSS = gitweb.css
> +GITWEB_CSS = $${my_uri}/gitweb.css
>  GITWEB_LOGO = git-logo.png
>  GITWEB_FAVICON = git-favicon.png

It is not the same case for git-logo.png and git-favicon.png as for
gitweb.css? If it is not, please explain why in commit message.
If it is, then your patch is only partial solution to path_info
problem.

>  GITWEB_SITE_HEADER =
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
