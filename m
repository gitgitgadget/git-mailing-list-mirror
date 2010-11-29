From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] cvsimport.txt: document the mapping between config
 and options
Date: Mon, 29 Nov 2010 12:23:53 -0800
Message-ID: <7v7hfv3mli.fsf@alter.siamese.dyndns.org>
References: <4CF2ADC9.8020504@drmicha.warpmail.net>
 <317523448870044a68311f811b42bd9461b90d43.1290973138.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 29 21:24:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNAGj-0001ZM-G0
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 21:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab0K2UYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 15:24:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0K2UYA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 15:24:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3D643788;
	Mon, 29 Nov 2010 15:24:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Kh3LZhik97Q8gexyY68jebjmt0M=; b=uuC7ZojrE/tFRkWUedfGQ+M
	DVAJkIY9S7H6iTmpzUDk/bLY86Fp9uVeP+CYGlcELQ5hOW9hWncs81TzHJvYaabl
	HyJ139mHJjNX9Hj5NXvJcPjq7NdMu5Ek2lLE7VFnoWwxGjmC2y23UqSrh9MCDjS1
	yH4QJgnEJHBnKCKviIgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=EuIVGImvL3fiZb5LmOeAEl3SrQpfuUIfOU4MfVNsHi4ZVZsgh
	0HRM0fp4aflmzdAtov9t0gdhjhURxfpilyWaQveEWoI7qrtSZU/awqQQKoWP8ysb
	k4bQZh4Vv05fE/lsk0tnt38BAX++Kk8AkibqD+yXQkCYgzNBfGNijDP0B4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B28823786;
	Mon, 29 Nov 2010 15:24:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9229E3785; Mon, 29 Nov 2010
 15:24:12 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A2D61714-FBF6-11DF-AE80-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162423>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/git-cvsimport.txt |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> index 608cd63..b5d5b27 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -176,6 +176,13 @@ messages, bug-tracking systems, email archives, and the like.
>  -h::
>  	Print a short usage message and exit.
>  
> +CONFIG
> +------
> +For any option '-x' you can set the config variable 'cvsimport.x' to the value
> +you would specify for '-x', or to 'true' for a boolean option. For an
> +uppercase option '-X' use the config variable 'cvsimport.xx' (or
> +'cvsimport.XX').
> +

I still think this is not about fixing "parsing" as 2/3 states but about
"working around the initial design flaw of how configuration variables are
used in cvsimport" in that the initial design didn't take it into account
that the last component of a configuration variable is case insensitive.

While mapping -X to .xx may be a usable workaround, it looks really ugly.
Worse, if we are going to give long command line options to the command
someday, we will really regret it doing it the way your patch does.

Would it be a better alternative to give conflicting but rarely used
uppercase options longer option name synonyms, and have them specified in
the gitconfig file in their full names?  Then we can disambiguate with
something like

    [cvsimport]
    	generate-cvs-revisions = yes
        remote = origin

which would be more readable, no?
