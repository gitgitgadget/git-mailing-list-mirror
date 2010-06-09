From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCHv2] bash completion: Support "divergence from upstream"
 warnings in __git_ps1
Date: Wed, 09 Jun 2010 22:48:06 +0200
Message-ID: <4C0FFE06.60903@drmicha.warpmail.net>
References: <4C0AE640.3040503@pileofstuff.org> <201006062014.59386.trast@student.ethz.ch> <4C0C09BF.4070503@pileofstuff.org> <201006070942.34753.trast@student.ethz.ch> <4C0EB7F1.1030707@pileofstuff.org> <4C0F5C26.5080108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed Jun 09 22:48:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMSC8-0008Hz-44
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 22:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758121Ab0FIUsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 16:48:09 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51400 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755464Ab0FIUsI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 16:48:08 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F2413F8908;
	Wed,  9 Jun 2010 16:48:07 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 09 Jun 2010 16:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=eqkXF6JEr7qZeq0aP+CrocGUQoc=; b=FcBwiTkVaLU5cMXN9OyuB909zVFSRhvM0uD8SDd3UZu6rd9DB2fCSwR0i7iI4qaiHs2ZWkTGXJ0lmSYBEywbWwVZNeaSLhRY9oql43uYNvIA375Kn5BNtzTkJPTPK1ilRJ+dM64qHUPHBbbqMYNwdkWkBBQFRKY/X47eQMHheTI=
X-Sasl-enc: FSNGP2S1xgkeiGnYJYpWEON6bT2m9gQ+mDlF900WIESP 1276116487
Received: from localhost.localdomain (p54858C81.dip0.t-ipconnect.de [84.133.140.129])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5A94C4DCB50;
	Wed,  9 Jun 2010 16:48:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100604 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <4C0F5C26.5080108@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148813>

Michael J Gruber venit, vidit, dixit 09.06.2010 11:17:
...
> An alternative would be to use something like
> myrepo:master+5-3
> 
> The numbers should make this distinguishable from the "--cached +". Of
> course it eats up more space and is slightly confusing unless it is read
> master = upstream + 5 -3.
> OTOH it is very analogous to status -s and branch -vv.
...
>> +				if p="$( git rev-list \
>> +						--left-right "$upstream"...HEAD 2>/dev/null )"
> 
> Here you have all the info to do a "grep \<|wc -l" etc. instead of the
> below if you go for the +5-3.
> 
>> +				then
>> +					case "$p" in
>> +						\<*\>*|\>*\<* ) p="<>" ;;
>> +						*\<*          ) p="<"  ;;
>> +						*\>*          ) p=">"  ;;

I mean something like this

					case "$p" in
						\<*\>*|\>*\<* ) p="+"$(echo "$p"|grep ">"|wc -l)"-"$(echo
"$p"|grep "<"|wc -l)  ;;
						*\<*          ) p="-"$(echo "$p"|grep "<"|wc -l)  ;;
						*\>*          ) p="+"$(echo "$p"|grep ">"|wc -l)  ;;

with

		printf "${1:- (%s)}" "$c${b##refs/heads/}$p${f:+ $f}$r"

resulting in a prompt like

[mjg@localhost git (mjg/sane-symlink-diff+4-153 *+%)]

on my branch "mjg/sane-symlink-diff".

Cheers,
Michael
