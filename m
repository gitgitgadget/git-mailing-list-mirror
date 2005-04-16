From: David Lang <dlang@digitalinsight.com>
Subject: Re: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 15:56:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504161549410.22652@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz><20050416123155.GA19908@elte.hu>
 <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz><4261132A.3090907@khandalf.com>
 <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu><20050416151116.GC19099@pasky.ji.cz>
 <Pine.LNX.4.61.0504161114530.29343@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Petr Baudis <pasky@ucw.cz>, omb@bluewin.ch,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:54:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwAu-0001Rt-BY
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVDPW5o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVDPW5o
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:57:44 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:10659 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261181AbVDPW5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 18:57:37 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sat, 16 Apr 2005 15:52:29 -0700
Received: by atlexc01.digitalinsight.com with Internet Mail Service (5.5.2657.72)
	id <JCF7DWCA>; Sat, 16 Apr 2005 18:54:30 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 29YX15RH; Sat, 16 Apr 2005 15:56:24 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0504161114530.29343@cag.csail.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, C. Scott Ananian wrote:

> Date: Sat, 16 Apr 2005 11:36:28 -0400 (EDT)
> From: C. Scott Ananian <cscott@cscott.net>
> To: Petr Baudis <pasky@ucw.cz>
> Cc: omb@bluewin.ch, David Lang <david.lang@digitalinsight.com>,
>     Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
> Subject: Re: Re: SHA1 hash safety
> 
> On Sat, 16 Apr 2005, Petr Baudis wrote:
>
>>> I know the current state of the art here.  It's going to take more than
>>> just hearsay to convince me that full 128-bit MD5 collisions are likely.
>> 
>> http://cryptography.hyperlink.cz/MD5_collisions.html
>
> OK, OK, I spoke too sloppily.  Let me rephrase:
>  It's going to take more than just hearsay to convince me that full
>  128-bit MD5 collisions *IN ARBITRARILY CHOSEN DOCUMENTS* are likely.
>
> I could add, "WITHOUT SPECIAL EFFORT BY AN ATTACKER".

you are missing the point.

I'm not talking about takeing one document (sched.c) and finding a 
replacement that can drop in without being noticed.

what I'm talking about is the chance that somewhere, sometime there will 
be two different documents that end up with the same hash

what git is doing (in very crude sysadminish terms) is to take all the 
files you care about, move them into a new directory where they are named 
by their hash with a symlink that replaces the origional file (and then a 
bunch of stuff to manage multiple versions of those symlinks)

if you are taking every file that you ever care about and loosing all 
refrence to it except by it's hash then when you get a second file that 
has the same hash you loose the contents of one of the two files (race 
condition over which file gets written into the storage directory last)

anywhere else that hashing algorithms are used people realize that there 
will be hash collisions and plan accordingly, however people tend to put 
blinders on when you say SHA1 or MD5 and decide that somehow the same 
thing cannot happen with these types of hashes.

they can, and eventually they will so you need to plan accordingly.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
