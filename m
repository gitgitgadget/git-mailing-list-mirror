From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] filter-branch: use git-sh-setup's ident parsing functions
Date: Thu, 18 Oct 2012 09:49:04 +0200
Message-ID: <507FB470.2060404@viscovery.net>
References: <20121018072207.GA1605@sigill.intra.peff.net> <20121018072535.GB9999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 09:49:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOkr4-0007Rb-0x
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 09:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab2JRHtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 03:49:11 -0400
Received: from so.liwest.at ([212.33.55.24]:2625 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509Ab2JRHtK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 03:49:10 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TOkqn-0005AX-Bq; Thu, 18 Oct 2012 09:49:05 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1D87E1660F;
	Thu, 18 Oct 2012 09:49:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121018072535.GB9999@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207975>

Am 10/18/2012 9:25, schrieb Jeff King:
> -# When piped a commit, output a script to set the ident of either
> -# "author" or "committer
> +# Ensure non-empty id name.
> +fallback_name() {
> +	echo "case \"\$GIT_$1_NAME\" in \"\") GIT_$1_NAME=\"\${GIT_$1_EMAIL%%@*}\" && export GIT_$1_NAME;; esac"
> +}
>  
>  set_ident () {
> -	lid="$(echo "$1" | tr "[A-Z]" "[a-z]")"
> -	uid="$(echo "$1" | tr "[a-z]" "[A-Z]")"
> -	pick_id_script='
> -		/^'$lid' /{
> -			s/'\''/'\''\\'\'\''/g
> -			h
> -			s/^'$lid' \([^<]*\) <[^>]*> .*$/\1/
> -			s/'\''/'\''\'\'\''/g
> -			s/.*/GIT_'$uid'_NAME='\''&'\''; export GIT_'$uid'_NAME/p
> -
> -			g
> -			s/^'$lid' [^<]* <\([^>]*\)> .*$/\1/
> -			s/'\''/'\''\'\'\''/g
> -			s/.*/GIT_'$uid'_EMAIL='\''&'\''; export GIT_'$uid'_EMAIL/p
> -
> -			g
> -			s/^'$lid' [^<]* <[^>]*> \(.*\)$/@\1/
> -			s/'\''/'\''\'\'\''/g
> -			s/.*/GIT_'$uid'_DATE='\''&'\''; export GIT_'$uid'_DATE/p
> -
> -			q
> -		}
> -	'
> -
> -	LANG=C LC_ALL=C sed -ne "$pick_id_script"
> -	# Ensure non-empty id name.
> -	echo "case \"\$GIT_${uid}_NAME\" in \"\") GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\" && export GIT_${uid}_NAME;; esac"
> +	parse_ident_from_commit author AUTHOR committer COMMITTER
> +	fallback_name AUTHOR
> +	fallback_name COMMITTER
>  }

Didn't you lose the export GIT_$uid_{NAME,EMAIL,DATE} parts somewhere on
the way?

Thanks for working on this!

-- Hannes
