From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: git-pack-redundant returns the most containing pack
Date: Thu, 17 Nov 2005 00:23:09 +0100
Organization: Chalmers
Message-ID: <437BBF5D.5040105@etek.chalmers.se>
References: <20051116230956.GA21444@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	=?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Thu Nov 17 00:23:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcWc0-0000SN-RX
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 00:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbVKPXWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 18:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbVKPXWl
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 18:22:41 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:52218 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1161011AbVKPXWl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 18:22:41 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 4378EBDA000D2E34; Thu, 17 Nov 2005 00:22:40 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051116230956.GA21444@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12068>

Alex Riesen wrote:
> ...which very confusing: "git-repack -a -d" leaves the repository with
> exactly the same packs as before, by creating a super-pack, and then
> happily removing it, because pack-redundant returns the newly created
> pack!
> 
> So, even if it is logically correct, it's hardly useful in practice.
> 

That's bad. Your new pack should contain some objects not present in
the older packfiles and thus it shouldn't be removed, unless there
were no new objects to pack. 

If no new objects were packed, the sum of the old packs might be smaller 
than the new superpack, or the old packs could contain unreachable objects,
which makes git-pack-redundant unable to detect that they should be removed.

Could you try updating to the latest snapshot? There was a bug in a
list handling function which was fixed recently, perhaps your problem
is related.
