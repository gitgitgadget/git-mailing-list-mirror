From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: Remove unneeded packs
Date: Sun, 13 Nov 2005 13:31:55 +0100
Organization: Chalmers
Message-ID: <4377323B.4000203@etek.chalmers.se>
References: <1131800663.29461.11.camel@blade> <4375EA80.7070405@op5.se> <1131802238.29461.18.camel@blade> <43766687.2000007@etek.chalmers.se> <7voe4pclwm.fsf@assigned-by-dhcp.cox.net> <43771C43.7000104@etek.chalmers.se> <20051113150051.4a10365d.vsu@altlinux.ru> <43772C96.9030805@etek.chalmers.se> <20051113122017.GA9996@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Nov 13 13:31:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbH1E-0003fm-UZ
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 13:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVKMMbe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 07:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVKMMbe
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 07:31:34 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:32422 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932492AbVKMMbd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 07:31:33 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn1.fre.skanova.net (7.2.060.1)
        id 436FB1AD00194563; Sun, 13 Nov 2005 13:31:29 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20051113122017.GA9996@procyon.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11738>

Sergey Vlasov wrote:
> On Sun, Nov 13, 2005 at 01:07:50PM +0100, Lukas Sandstr?m wrote:
> 
>>Sergey Vlasov wrote:
>>
>>>On Sun, 13 Nov 2005 11:58:11 +0100 Lukas Sandstr?m wrote:
> 
> 
>>>>-if test "$remove_redandant" = t
>>>>+if test "$all_into_one" = t
>>>
>>>
>>>This should be
>>>
>>>if test "$all_into_one$remove_redandant" = tt
>>>
>>>(otherwise "git repack -a" becomes the same as "git repack -a -d").
>>>
>>>
>>
>>This was the behaviour before git-pack-redundant, I just restored it.
> 
> 
> But the old code was:
> 
> if test "$remove_redandant" = t
> then
> 	# We know $existing are all redandant only when
> 	# all-into-one is used.
> 	if test "$all_into_one" != '' && test "$existing" != ''
> 	then
> 		sync
> 		( cd "$PACKDIR" &&
> 		  for e in $existing
> 		  do
> 			case "$e" in
> 			./pack-$name.pack | ./pack-$name.idx) ;;
> 			*)	rm -f $e ;;
> 			esac
> 		  done
> 		)
> 	fi
> fi
> 
> So without the -d option nothing was removed, even with -a.
> 
True. I forgot to look at the context around the changed lines...
Btw, remove_redundant is misspellt.
> (And test "$existing" != '' might also be needed for some shells which
> are confused by the empty list in the for statement.)
> 
> 
>>Someone else gets to decide if git repack -a implies "remove all old packs".
> 
> 
> If there is a separate -d option for this, just using -a probably
> should not remove anything.

True, but you will have trouble removing stale packfiles if they contain
unreachable objects unless you remove them when you create the -a pack.

Anyway, ignore the patch above.
