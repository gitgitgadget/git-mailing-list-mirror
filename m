From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] pull: require choice between rebase/merge on non-fast-forward pull
Date: Thu, 18 Jul 2013 19:38:39 +0200
Message-ID: <871u6v93a8.fsf@igel.home>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130718143009.GC2337@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jul 18 19:38:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzsAJ-0000Zj-0I
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 19:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759089Ab3GRRiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 13:38:51 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:48285 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117Ab3GRRiu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 13:38:50 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3bx2dF2Vtcz3hhXD;
	Thu, 18 Jul 2013 19:38:41 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3bx2dF2GMqzbbmL;
	Thu, 18 Jul 2013 19:38:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id J560UcDAYebA; Thu, 18 Jul 2013 19:38:40 +0200 (CEST)
X-Auth-Info: XCzZSe3aJtWh2puILc1cwo5yTN35flmpHHH06uVRa+o=
Received: from igel.home (ppp-88-217-116-104.dynamic.mnet-online.de [88.217.116.104])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Thu, 18 Jul 2013 19:38:40 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id F08A5E450B; Thu, 18 Jul 2013 19:38:39 +0200 (CEST)
X-Yow: MERYL STREEP is my obstetrician!
In-Reply-To: <20130718143009.GC2337@serenity.lan> (John Keeping's message of
	"Thu, 18 Jul 2013 15:30:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230710>

John Keeping <john@keeping.me.uk> writes:

> On Thu, Jun 27, 2013 at 12:48:52PM -0700, Junio C Hamano wrote:
>> diff --git a/git-pull.sh b/git-pull.sh
>> index 638aabb..4a6a863 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -264,6 +274,30 @@ case "$merge_head" in
>>  		die "$(gettext "Cannot rebase onto multiple branches")"
>>  	fi
>>  	;;
>> +*)
>> +	# integrating with a single other history
>> +	merge_head=${merge_head% }
>> +	if test -z "$rebase$no_ff$ff_only${squash#--no-squash}" &&
>> +		test -n "$orig_head" &&
>> +		! $(git merge-base --is-ancestor "$orig_head" "$merge_head")
>
> I think this needs to be:
>
> 	! $(git merge-base --is-ancestor "$orig_head" "$merge_head" ||
> 	    git merge-base --is-ancestor "$merge_head" "$orig_head")

Neither makes sense.  You want to check the exit status of git
merge-base --is-ancestor, not execute its (empty) output as a command.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
