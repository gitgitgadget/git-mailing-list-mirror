From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Improve sed portability
Date: Wed, 11 Jun 2008 16:04:13 +0200
Message-ID: <484FDB5D.7060606@viscovery.net>
References: <1213189759-11565-1-git-send-email-chris.ridd@isode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Ridd <chris.ridd@isode.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 16:12:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6QyT-0007X1-Bx
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 16:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249AbYFKOER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 10:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756241AbYFKOER
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 10:04:17 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39770 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230AbYFKOEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 10:04:16 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K6Qvt-0007Tt-M2; Wed, 11 Jun 2008 16:04:14 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 747176B7; Wed, 11 Jun 2008 16:04:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1213189759-11565-1-git-send-email-chris.ridd@isode.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84611>

Chris Ridd schrieb:
> On Solaris /usr/bin/sed apparently fails to process input that doesn't
> end in a \n. Consequently constructs like
> 
>   re=$(printf '%s' foo | sed -e 's/bar/BAR/g' $)
> 
> cause re to be set to the empty string.

So does /usr/bin/sed of AIX 4.3!

> @@ -73,7 +73,7 @@ resolve_relative_url ()
>  module_name()
>  {
>  	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
> -	re=$(printf '%s' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
> +	re=$(printf "%s\n" "$1" | sed -e 's/[].[^$\\*]/\\&/g')

You change sq into dq. Is this not dangerous? Shouldn't backslash-en be
hidden from the shell so that printf can interpret it?

>  	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
>  		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )

I trust you have tested this. But I wonder whether this leaves a stray
newline in $re that gets in the way inside the sed expression...

>         test -z "$name" &&


-- Hannes
