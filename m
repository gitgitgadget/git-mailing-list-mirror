From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule working directory in git gui and gitk
Date: Thu, 07 Jan 2010 20:04:17 +0900
Message-ID: <20100107200417.6117@nanako3.lavabit.com>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <4B42F425.4010901@web.de> <alpine.DEB.1.00.1001051032440.4985@pacific.mpi-cbg.de> <20100105142727.GA83546@book.hvoigt.net> <20100106073718.6117@nanako3.lavabit.com> <alpine.DEB.1.00.1001060009530.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 07 12:05:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSqAy-0006QB-A8
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 12:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab0AGLFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 06:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149Ab0AGLFE
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 06:05:04 -0500
Received: from karen.lavabit.com ([72.249.41.33]:56259 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127Ab0AGLFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 06:05:03 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id B2A7311BA0D;
	Thu,  7 Jan 2010 05:05:01 -0600 (CST)
Received: from 9668.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id GN67F2CBF2H4; Thu, 07 Jan 2010 05:05:01 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=WIrdaCuWSp/yi8H5OPFmLoAyTUtooVq15/Q473wtkE+U2H5Pe3Y+2BwfAu3Ty2BaXPhcUUyzuCzKeqITK4ZdALn1XUeHYE8A4CjynNuDPB/I3teZo7CuOWHPLret5LmgwLnZUiiu4yelPU0G6A48hfShCVYWCvGfNrv0ZmdR5B8=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <alpine.DEB.1.00.1001060009530.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136337>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 6 Jan 2010, Nanako Shiraishi wrote:
>
>> I found this other discussion in the design area enlightening.
>> 
>> http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47621
>
> Could you be so kind and summarize the result of the thread in something 
> like 2000 characters?

Sorry, but I only said "enlightening". There wasn't a conclusion that lets you stop thinking and just go ahead implementing the design specified in the thread, if that is what you are looking for.

Instead, let me tell you an example of what I found enlightening. It isn't a summary of the result. I don't think there was a *result*; otherwise somebody already would have implemented it.

I often wonder why 'git-submodule init' copies data to .git/config file. If .gitmodules file gives the default and I can use .git/config file to override it, it seems stupid to copy entries between these files. I can just keep using data from .gitmodules file until I need to override something.

Reading the thread made me realize how wrong I was. It became very clear why .gitmodules file shouldn't even be the default that is read when no entries is in .git/config file and why .git/config file should be the only thing that is used at runtime.

Unfortunately I can't summarize the reason in '2000 characters', so you need read the thread yourself if you are interested. The key concept that I was missing was that remote repositories can move or change over time, and you may want to check out and interact with a very old version of your supermodule. The .gitmodules file checked out in such a case still records old information. Treating .gitmodules file as a hint and always looking into .git/config file is a part of the fundamental solution to that problem, but I didn't even realize that such an issue existed when I read the current discussion until I found the old thread.

I think the 'git-submodule' script is mainly based on the 'three-level thing Steven Grimm suggested', but it doesn't seem to implement all the ideas in the thread yet. It gives no interactive prompt to suggest URL from 'git-submodule init' command. Neither it records which URLs have been seen with subproject.*.seen variable. But the issues that high level design must take into account looks very well thought out already.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
