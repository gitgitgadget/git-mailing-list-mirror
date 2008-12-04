From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Allow passing of --directory to git-am.
Date: Thu, 4 Dec 2008 23:46:31 +0100
Message-ID: <200812042346.33496.jnareb@gmail.com>
References: <49382612.3010207@fs.ei.tum.de> <m3hc5jivjo.fsf@localhost.localdomain> <493858CE.1030601@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Dec 04 23:48:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8MzE-00074H-DR
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 23:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756937AbYLDWqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 17:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbYLDWqm
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 17:46:42 -0500
Received: from gv-out-0910.google.com ([216.239.58.189]:28343 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756889AbYLDWql (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 17:46:41 -0500
Received: by gv-out-0910.google.com with SMTP id e6so922750gvc.37
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 14:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AI4PmbfXiXFt+SZ0tO+TCYbWI3hErB81xhphXPnlOQ8=;
        b=kU1+BMXbEktOGxDtlBiDHlwvN8cZX5VD1Lo3rWMMIE6L0EeNJfdSVX5nx9KVtrrkQN
         XGujoBkkTG8D3RaYyJfc08Sbq78IWclCgTeftYylm/Ay1UKHG5xCOhFSJ8ic+IpHYL+N
         bDjD2iq0imlwSvEr3YdeJfF1IE51XG3l5GJL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ovr+icqrOxYOM0UxW058/zJwAU+OsNwFhKuvuKl0Psg80YLiBb7nAJKOTIc2ZgxDhC
         RtzjzJ/gYZmECegav9cQtS4DBgcHlkXZJm3rA3nxPpAdj5zBI3xFRqO+L0yr2LW1/QA7
         RA5wG6UwloWObIExs/yQUMnrGf+y32rd8NogE=
Received: by 10.103.240.15 with SMTP id s15mr7058862mur.82.1228430800270;
        Thu, 04 Dec 2008 14:46:40 -0800 (PST)
Received: from ?192.168.1.11? (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id j2sm11825508mue.5.2008.12.04.14.46.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Dec 2008 14:46:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <493858CE.1030601@fs.ei.tum.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102374>

Simon 'corecode' Schubert wrote:
> Jakub Narebski wrote:
>> Simon 'corecode' Schubert wrote:
 
>>> @@ -155,8 +156,9 @@ do
>>>   		;;
>>>   	--resolvemsg)
>>>   		shift; resolvemsg=$1 ;;
>>> -	--whitespace)
>>> -		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
>>> +	--whitespace|--directory)
>>> +		quot=$(echo "$2" | sed -e "s/'/'\\\''/g")
>> 
>> Why not simply use "git rev-parse --sq"?
> 
> What I need is to convert $2 into a form suitable for quoting, does git 
> rev-parse --sq do that?

  $ git rev-parse --sq -- "don't do that"
  '--' 'don'\''t do that'

Without terminating newline. The '--' is needed because otherwise
git-rev-parse expects revisions... and doesn't find any.
 
By the way you could both simplify option parsing _and_ take care of
proper quoting by using --parseopt, i.e. use git-rev-parse in PARSEOPT
mode. But that is more involved change.

>>> @@ -454,7 +456,7 @@ do
>>>
>>>   	case "$resolved" in
>>>   	'')
>>> -		git apply $git_apply_opt --index "$dotest/patch"
>>> +		eval git apply $git_apply_opt --index '"$dotest/patch"'
>>
>> Why eval?
> 
> I quoted the above variable, so I now need to unquote it, that's done by eval.

Ah.
-- 
Jakub Narebski
Poland
