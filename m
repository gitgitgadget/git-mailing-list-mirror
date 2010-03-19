From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] instaweb: use minified gitweb.js if available
Date: Fri, 19 Mar 2010 08:36:01 +0100
Message-ID: <4BA32961.6080901@viscovery.net>
References: <4BA3138F.1010201@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Fri Mar 19 08:36:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsWki-0005RR-3R
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 08:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966Ab0CSHgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 03:36:10 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8557 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab0CSHgI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 03:36:08 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NsWkU-0007lm-FY; Fri, 19 Mar 2010 08:36:02 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 17D611660F;
	Fri, 19 Mar 2010 08:36:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4BA3138F.1010201@mailservices.uwaterloo.ca>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142565>

Mark Rada schrieb:
> --- a/Makefile
> +++ b/Makefile
> @@ -1551,12 +1551,12 @@ gitweb:
>  	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
>   ifdef JSMIN
> -OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
> -gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
> +GITWEB_JS=gitweb/gitweb.min.js
>  else
> -OTHER_PROGRAMS += gitweb/gitweb.cgi
> -gitweb/gitweb.cgi: gitweb/gitweb.perl
> +GITWEB_JS=gitweb/gitweb.js
>  endif
> +OTHER_PROGRAMS += gitweb/gitweb.cgi $(GITWEB_JS)
> +gitweb/gitweb.cgi: gitweb/gitweb.perl $(GITWEB_PROGRAMS)
>  	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
>   ifdef JSMIN
> @@ -1574,12 +1574,13 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.
>  	    -e '/@@GITWEB_CGI@@/d' \
>  	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
>  	    -e '/@@GITWEB_CSS@@/d' \
> -	    -e '/@@GITWEB_JS@@/r gitweb/gitweb.js' \
> +	    -e '/@@GITWEB_JS@@/r $(GITWEB_JS)' \
>  	    -e '/@@GITWEB_JS@@/d' \
>  	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
>  	    $@.sh > $@+ && \
>  	chmod +x $@+ && \
> -	mv $@+ $@
> +	mv $@+ $@ && \
> +	sed -i '' -e 's/min\.js/js/' $@

sed -i is not portable. But do you need it at all? Can't you add this
change to the -e list above?

> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -397,6 +397,7 @@ EOFGITWEB
>  gitweb_js () {
>  	cat > "$1" <<\EOFGITWEB
>  @@GITWEB_JS@@
> +
>  EOFGITWEB
>  }
>  -- 1.7.0.1.300.gd855a

This new blank line is an accident, isn't it?

-- Hannes
