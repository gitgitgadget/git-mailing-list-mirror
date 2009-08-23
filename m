From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Pulling one commit at a time.
Date: Mon, 24 Aug 2009 06:07:10 +0900
Message-ID: <20090824060710.6117@nanako3.lavabit.com>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
	<4A9172D0.6030507@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Sanjiv Gupta <sanjiv.gupta@microchip.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 23:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfKID-00086F-T5
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 23:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904AbZHWVHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 17:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934105AbZHWVHx
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 17:07:53 -0400
Received: from karen.lavabit.com ([72.249.41.33]:36754 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755897AbZHWVHw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 17:07:52 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id AF37911B850;
	Sun, 23 Aug 2009 16:07:54 -0500 (CDT)
Received: from 2794.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id YEI6X9SNUZW3; Sun, 23 Aug 2009 16:07:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=hpOnbIMg9MUWtWwISdj70yj5iwcGMVkWkauyTAptDXEfjIXx4cOzvCdQwHJeJvfEKHO+JsjW14lDwwffTV+/V0V8JITCsV7L8fq/nawk30FLBodK04qbI/tHE2rK+kd/5/BOiJCQJAd7/keJfEBH0KBoWJ0a3zM3dNpjUNAXjGo=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4A9172D0.6030507@microchip.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126879>

Quoting Sanjiv Gupta <sanjiv.gupta@microchip.com>

> I just wanted to know how can I pull one commit at a time from public
> repository.
> e.g.
> when I first cloned from the public repo, it was at X. now it has
> reached Y. I just want to pull x+1.

When your histories look like this:

      A                 your 'master'
     /
 ---X---U---V---W---Y   public 'master' (your 'origin')

instead of creating a single merge like this with "git pull":

      A---------------M your 'master' (fully merges 'origin')
     /               / 
 ---X---U---V---W---Y   public 'master'

you want to create a history like this?

      A---J             your 'master' (lacks V, W and Y)
     /   /
 ---X---U---V---W---Y   public 'master'

For that, you can fetch first.

 git fetch origin

Then look at the history in gitk

 gitk master origin

And find the commit you are interested in merging (U in the above picture). And merge it.

 git merge origin~3

Replace "origin~3" in the example above with whatever commit you want to merge the entire history leading to it.

You can repeat this final step as many times you want. For example, if you want create a history like this:

      A---J---K---L---M your 'master'
     /   /   /   /   / 
 ---X---U---V---W---Y   public 'master'

you can do so by repeating the last step for V, W and Y in turn.

In general the public history isn't necessarily a single straight line like this picture and it doesn't make sense to merge one at a time for all the commits on the public branch, but if that is what you really want to do, you can do so.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
