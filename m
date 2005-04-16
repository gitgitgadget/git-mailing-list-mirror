From: David Lang <david.lang@digitalinsight.com>
Subject: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 15:46:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504161543150.22652@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>  
 <20050416123155.GA19908@elte.hu>   
 <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz><4261132A.3090907@khandalf.com>
 <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: omb@bluewin.ch, Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:45:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMw2O-0000kj-Ea
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVDPWs5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVDPWs5
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:48:57 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:20385 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261175AbVDPWsw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 18:48:52 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sat, 16 Apr 2005 15:43:45 -0700
Received: by atlexc02.diginsite.com with Internet Mail Service (5.5.2653.19)
	id <24Z87ATR>; Sat, 16 Apr 2005 18:46:28 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 29YX15LL; Sat, 16 Apr 2005 15:46:17 -0700
To: "C. Scott Ananian" <cscott@cscott.net>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

that's the difference between CS researchers and sysadmins.

sysadmins realize that there are an infinante number of files that map to 
the same hash value and plan accordingly (becouse we KNOW we will run 
across them eventually), and don't see it as a big deal when we finally 
do.

CS researches quote statistics that show how hard it is to intentiallly 
create two files with the same hash and insist it just doesn't happen 
until presented by the proof, at which point it is a big deal.

a difference in viewpoints.

David Lang


  On Sat, 16 Apr 2005, C. Scott Ananian wrote:

> Date: Sat, 16 Apr 2005 10:58:15 -0400 (EDT)
> From: C. Scott Ananian <cscott@cscott.net>
> To: omb@bluewin.ch
> Cc: David Lang <david.lang@digitalinsight.com>, Ingo Molnar <mingo@elte.hu>,
>     git@vger.kernel.org
> Subject: Re: SHA1 hash safety
> 
> On Sat, 16 Apr 2005, Brian O'Mahoney wrote:
>
>> (1) I _have_ seen real-life collisions with MD5, in the context of
>>    Document management systems containing ~10^6 ms-WORD documents.
>
> Dude!  You could have been *famous*!  Why the aitch-ee-double-hockey-sticks 
> didn't you publish this when you found it?
> Seriously, man.
>
> Even given the known weaknesses in MD5, it would take much more than a 
> million documents to find MD5 collisions.  I can only conclude that the hash 
> was being used incorrectly; most likely truncated (my wild-ass guess would be 
> to 32 bits; a collision is likely with > 50% probability in a million 
> document store for a hash of less than 40 bits).
>
> I know the current state of the art here.  It's going to take more than just 
> hearsay to convince me that full 128-bit MD5 collisions are likely. I believe 
> there are only two or so known to exist so far, and those were found by a 
> research team in China (which, yes, is fairly famous among the cryptographic 
> community now after publishing a paper consisting of little apart from the 
> two collisions themselves).
>
> Please, let's talk about hash collisions responsibly.  I posted earlier about 
> the *actual computed probability* of finding two files with an SHA-1 
> collision before the sun goes supernova.  It's 10^28 to 1 against.
> The recent cryptographic works has shown that there are certain situations 
> where a decent amount of computer work (2^69 operations) can produce two 
> sequences with the same hash, but these sequences are not freely chosen; 
> they've got very specific structure.  This attack does not apply to 
> (effectively) random files sitting in a SCM.
>  http://www.schneier.com/blog/archives/2005/02/sha1_broken.html
>
> That said, Linux's widespread use means that it may not be unimaginable for 
> an attacker to devote this amount of resources to an attack, which would 
> probably involve first committing some specially structured file to the SCM 
> (but would Linus accept it?) and then silently corrupting said file via a 
> SHA1 collision to toggle some bits (which would presumably Do Evil).  Thus 
> hashes other than SHA1 really ought to be considered...
>
> ...but the cryptographic community has not yet come to a conclusion on what 
> the replacement ought to be.  These attacks are so new that we don't really 
> understand what it is about the structure of SHA1 which makes them possible, 
> which makes it hard to determine which other hashes are similarly vulnerable. 
> It will take time.
>
> I believe Linus has already stated on this list that his plan is to 
> eventually provide a tool for bulk migration of an existing SHA1 git 
> repository to a new hash type.   Basically munging through the repository in 
> bulk, replacing all the hashes.  This seems a perfectly adequate strategy at 
> the moment.
> --scott
>
> WASHTUB Panama Minister Moscow explosives KUGOWN hack Marxist LPMEDLEY 
> genetic immediate radar SCRANTON COBRA JANE KGB Shoal Bay atomic Bejing
>                         ( http://cscott.net/ )
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
