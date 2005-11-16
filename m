From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Wed, 16 Nov 2005 22:37:42 +0100
Organization: Chalmers
Message-ID: <437BA6A6.8080900@etek.chalmers.se>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> <20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se> <20051115223340.GA3951@steel.home> <Pine.LNX.4.64.0511151552400.11232@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Alex Riesen <raa.lkml@gmail.com>, junkio@cox.net,
	=?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Wed Nov 16 22:40:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcUy0-0003yq-3l
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 22:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbVKPVhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 16:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbVKPVhP
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 16:37:15 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:52641 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1030496AbVKPVhO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 16:37:14 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 4378EBDA000CF11D; Wed, 16 Nov 2005 22:37:13 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0511151552400.11232@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12060>

Linus Torvalds wrote:
> 
> On Tue, 15 Nov 2005, Alex Riesen wrote:
> 
>>Sorry, it doesn't. The code loops here:
>>
>>401             /* find the permutations which contain all missing objects */
>>402             perm_all = perm = get_all_permutations(non_unique);
> 
> 
> Looks like the whole thing is exponential.
> 
Slightly less, but not far from.
> A good way to do sane pack handling is to keep a _sorted_ list of all 
> objects each pack has. At that point it becomes much easier to see which 
> objects only exist in one particular pack.
> 
git-pack-redundant already does this.
> The sorting itself is O(nlogn), and the "does this pack have any unique 
> objects" (or "is this pack a superset of all other packs") question should 
> then be O(n).
> 
Ah, but the question is: "Does this set of packs contain a superset of
all objects available in packfiles?" The answer to the question for a
certain set is indeed O(n), but the number of sets which have to be tested
are ~ O(e**n). (Where n is the number of non-unique packs.)

/Lukas
