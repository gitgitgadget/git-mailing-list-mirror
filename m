From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 4/6] instaweb: add minification awareness
Date: Thu, 1 Apr 2010 13:09:59 +0200
Message-ID: <201004011310.01068.jnareb@gmail.com>
References: <4BB430F1.60002@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Apr 01 13:17:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxIOe-0007xG-Sl
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 13:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355Ab0DALRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 07:17:00 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:41868 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122Ab0DALQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 07:16:58 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Apr 2010 07:16:57 EDT
Received: by qyk4 with SMTP id 4so1217746qyk.24
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=YMcofs4GqiJQb13UflCS9ghZxVzms6ZaQfVrZfpv4U8=;
        b=KJUsgZOjcPxvU1ohYZYBfJSbduJ2+aYHO3PoClG8txz1J6ZYOOiY9YkuF5g+MllGur
         nwGEKBHJaY8DFLIGfuT+8XdmVVmDVDiezBNnUcjPuBe2tzQIOnUk6tphJID/AevwcioS
         DjCocudJKZxcnmWUSkUM6sYzga03oHoCITW9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jK+fW7rYN88SuIdfen/WviZ1Ir794sjcdHj/YSGjXtTAqB91sZ3PHiQhFoMTNr4Q81
         2qcs5kWz1v8aXMjRhB7gb0tD1RdaVvab5kkbSCaI96MK1Fa18Pebt39ueZOD3owen+RM
         Z0Ydi4UFuQ8W2gMYPNKriFcK5FM9Y5kqIFWXY=
Received: by 10.229.211.140 with SMTP id go12mr1113437qcb.49.1270120212714;
        Thu, 01 Apr 2010 04:10:12 -0700 (PDT)
Received: from [192.168.1.13] ([72.14.241.38])
        by mx.google.com with ESMTPS id 8sm3253236qwj.20.2010.04.01.04.10.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Apr 2010 04:10:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BB430F1.60002@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143725>

On Thu, 1 Apr 2010, Mark Rada wrote:

> This patch will cause git-instaweb to use the minified version of gitweb
> support files (e.g. CSS and JavaScript) if they were generated.

I was not sure if git-instaweb should use minified files or not, and
that is why I didn't add support for this to git-instaweb generation.
But I forgot that git-instaweb uses gitweb.cgi... which in turn can
use minified versions of gitweb support files.

> 
> Without minification awareness, generating the minified version of
> gitweb's support files will generate a broken instaweb script since the
> copy of gitweb.cgi will look for gitweb.min.* which will not exist.

Good catch!

> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>

CC-ed Eric Wong, original author of git-instaweb.sh script.

> ---
> 
> No changes since previous revision.
> 
> 
>  Makefile        |   12 ++++++++++--
>  git-instaweb.sh |    6 ++++--
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index ef1a232..c97021f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1565,9 +1565,15 @@ gitweb:
>  
>  ifdef JSMIN
>  GITWEB_PROGRAMS += gitweb/gitweb.min.js
> +GITWEB_JS = gitweb/gitweb.min.js
> +else
> +GITWEB_JS = gitweb/gitweb.js
>  endif
>  ifdef CSSMIN
>  GITWEB_PROGRAMS += gitweb/gitweb.min.css
> +GITWEB_CSS = gitweb/gitweb.min.css
> +else
> +GITWEB_CSS = gitweb/gitweb.css
>  endif
>  OTHER_PROGRAMS +=  gitweb/gitweb.cgi  $(GITWEB_PROGRAMS)
>  gitweb/gitweb.cgi: gitweb/gitweb.perl $(GITWEB_PROGRAMS)
> @@ -1590,11 +1596,13 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.
>  	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
>  	    -e '/@@GITWEB_CGI@@/r gitweb/gitweb.cgi' \
>  	    -e '/@@GITWEB_CGI@@/d' \
> -	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
> +	    -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS)' \
>  	    -e '/@@GITWEB_CSS@@/d' \
> -	    -e '/@@GITWEB_JS@@/r gitweb/gitweb.js' \
> +	    -e '/@@GITWEB_JS@@/r $(GITWEB_JS)' \
>  	    -e '/@@GITWEB_JS@@/d' \
>  	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
> +            -e 's|@@GITWEB_CSS_NAME@@|$(GITWEB_CSS)|' \
> +            -e 's|@@GITWEB_JS_NAME@@|$(GITWEB_JS)|' \
>  	    $@.sh > $@+ && \
>  	chmod +x $@+ && \
>  	mv $@+ $@
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 6a65f25..d4941a9 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -391,18 +391,20 @@ EOFGITWEB
>  gitweb_css () {
>  	cat > "$1" <<\EOFGITWEB
>  @@GITWEB_CSS@@
> +
>  EOFGITWEB
>  }
>  
>  gitweb_js () {
>  	cat > "$1" <<\EOFGITWEB
>  @@GITWEB_JS@@
> +
>  EOFGITWEB
>  }
>  
>  gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
> -gitweb_css "$GIT_DIR/gitweb/gitweb.css"
> -gitweb_js  "$GIT_DIR/gitweb/gitweb.js"
> +gitweb_css "$GIT_DIR/@@GITWEB_CSS_NAME@@"
> +gitweb_js  "$GIT_DIR/@@GITWEB_JS_NAME@@"
>  
>  case "$httpd" in
>  *lighttpd*)
> -- 
> 1.7.0.3.519.g7e0613
> 
> 

-- 
Jakub Narebski
Poland
