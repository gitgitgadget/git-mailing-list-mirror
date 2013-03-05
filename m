From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v6] submodule: add 'deinit' command
Date: Tue, 5 Mar 2013 08:29:46 +0100
Message-ID: <20130305072944.GA4677@sandbox-ub>
References: <5112C6F6.4030607@web.de>
 <CABURp0oQcPotK20QcqCG1pGQPVoa4RnN2nDA=iQoKS99gnPEAQ@mail.gmail.com>
 <511BEA75.6000002@web.de>
 <7vip5w6l8s.fsf@alter.siamese.dyndns.org>
 <5121384B.10009@web.de>
 <7v38wufu5t.fsf@alter.siamese.dyndns.org>
 <51227EFE.6030908@web.de>
 <51351018.20301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 05 08:30:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCmKH-000707-5a
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 08:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab3CEH3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 02:29:51 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:60833 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab3CEH3u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 02:29:50 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UCmJm-0001c1-LW; Tue, 05 Mar 2013 08:29:46 +0100
Content-Disposition: inline
In-Reply-To: <51351018.20301@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217433>

Hi,

On Mon, Mar 04, 2013 at 10:20:24PM +0100, Jens Lehmann wrote:
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 004c034..44f70c4 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -547,6 +548,80 @@ cmd_init()
>  }
> 
[...]
> +
> +	module_list "$@" |
> +	while read mode sha1 stage sm_path
> +	do
> +		die_if_unmatched "$mode"
> +		name=$(module_name "$sm_path") || exit
> +
> +		# Remove the submodule work tree (unless the user already did it)
> +		if test -d "$sm_path"
> +		then
> +			# Protect submodules containing a .git directory
> +			if test -d "$sm_path/.git"
> +			then
> +				echo >&2 "$(eval_gettext "Submodule work tree '\$sm_path' contains a .git directory")"
> +				die "$(eval_gettext "(use 'rm -rf' if you really want to remove it including all of its history)")"
> +			fi
> +
> +			if test -z "$force"
> +			then
> +				git rm -n "$sm_path" ||
> +				die "$(eval_gettext "Submodule work tree '\$sm_path' contains local modifications; use '-f' to discard them")"

Minor nit. IMO, there is an indentation for the || missing here. Maybe
Junio can squash that in on his side?

> +			fi
> +			rm -rf "$sm_path" || say "$(eval_gettext "Could not remove submodule work tree '\$sm_path'")"
> +		fi
> +
> +		mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$sm_path'")"

[...]

Everything else looks good to me.

Cheers Heiko
