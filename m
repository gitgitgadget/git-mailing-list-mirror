From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: hosting git on a nfs
Date: Fri, 14 Nov 2008 12:32:01 -0600
Message-ID: <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org> <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org> <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: James Pickens <jepicken@gmail.com>,
	Bruce Fields <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 19:33:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L13UL-0001P3-PU
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 19:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbYKNSce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 13:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbYKNSce
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 13:32:34 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40034 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbYKNSce (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 13:32:34 -0500
Received: by mail.nrlssc.navy.mil id mAEIW2k2008247; Fri, 14 Nov 2008 12:32:04 -0600
In-Reply-To: <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org>
X-OriginalArrivalTime: 14 Nov 2008 18:32:02.0084 (UTC) FILETIME=[49494E40:01C94687]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100998>

Linus Torvalds wrote:
> 
> On Thu, 13 Nov 2008, Linus Torvalds wrote:
>> I'll clean it up a bit and make a less hacky version. And I'll try to make 
>> it work for "git status" and friends too.
> 
> Ok, this is a no-longer-totally-hacky thing, which also adds support for 
> doing the same for "git status". I haven't actually done any timings, but 
> the preload algorithm is all the same. The interface is just a much more 
> natural one.

git status > /dev/null

Before:

   0.06user 0.37system 0:03.04elapsed 14%CPU
   0.07user 0.36system 0:03.25elapsed 13%CPU
   0.07user 0.36system 0:03.08elapsed 14%CPU

After:

   0.06user 0.53system 0:01.02elapsed 58%CPU
   0.05user 0.54system 0:01.01elapsed 58%CPU
   0.06user 0.52system 0:01.04elapsed 57%CPU


git diff > /dev/null

Before:

   0.02user 0.31system 0:02.88elapsed 11%CPU
   0.01user 0.32system 0:02.53elapsed 13%CPU
   0.01user 0.28system 0:02.78elapsed 10%CPU

After:

   0.01user 0.47system 0:00.52elapsed 92%CPU
   0.01user 0.48system 0:00.52elapsed 94%CPU
   0.01user 0.47system 0:00.54elapsed 88%CPU


I have no explanation for why the diff numbers are different from yesterday.
Could be that there was some nightly cron job running last night which
slowed things down. Still, the same ~5x speedup is observed!

Wow! Thanks!

-brandon
