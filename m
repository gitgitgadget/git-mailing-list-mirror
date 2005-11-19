From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Sat, 19 Nov 2005 13:45:27 +0100
Message-ID: <437F1E67.8020302@etek.chalmers.se>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>	 <Pine.LNX.4.64.0511160837000.13959@g5.osdl.org>	 <cda58cb80511170236p4a7e2baay@mail.gmail.com>	 <Pine.LNX.4.64.0511170817480.13959@g5.osdl.org>	 <cda58cb80511171347yef4f090g@mail.gmail.com>	 <Pine.LNX.4.64.0511171443000.13959@g5.osdl.org> <cda58cb80511190423w1e46bf5bu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Franck <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 13:46:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdS5c-0002YO-Ri
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 13:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVKSMo7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 07:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbVKSMo7
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 07:44:59 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:28296 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751102AbVKSMo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 07:44:59 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 437DDFC20002C44D; Sat, 19 Nov 2005 13:44:55 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <cda58cb80511190423w1e46bf5bu@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12335>

Franck wrote:
> 2005/11/17, Linus Torvalds <torvalds@osdl.org>:
> 
>>>On Thu, 17 Nov 2005, Franck wrote:
>>>
>>>ok that's what I was trying to do by killing the parent object.  Now
>>>when looking a the graph using gitk all old objects have been removed.
>>>But I'm suprised because the git repository is the same size as it was
>>>before pruning all old objects. Can you explain why ?
>>
>>make sure you re-pack if it was packed. "git prune" will not remove packs
>>at all, so..
>>
> 
> 
> I just looked at git-prune script and it seems to remove unreachable
> objects only in .git/objects/[0-9a-f][0-9a-f] directories, not in pack
> files.
> 
> Then by running git-repack -a -d, I build a new small pack that
> contains only latest objects, but then the script runs
> git-redundant-pack script which erases the new small one since all its
> objects are included in the old big one. Is that correct ? If so
> git-redundant-pack script could return the oldest redundant ?
> 
> Thanks
> --
>                Franck

The reason the old pack is kept instead of the new one is that it
is a proper superset of the new one. 

The "git-repack -a -d" case is fixed in Junios master, and I have sent out
a patch which lets you pipe git-fsck-objects --full --unreachable to
git-pack-redundant in the other cases, so the problem should hopefully
be resolved shortly.

/Lukas
