From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 16:05:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704111600390.28394@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org><Pi
 ne.LNX.4.64.0704092115020.6730@woody.linux-foundation.org><461D6432.90205@v
 ilain.net>  <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org><461D6858.4090
 007@vilain.net> <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:37:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbmN1-00055z-8n
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 01:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbXDKXg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 19:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbXDKXg4
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 19:36:56 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:36504 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753698AbXDKXgz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 19:36:55 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Wed, 11 Apr 2007 16:36:55 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Wed, 11 Apr 2007 16:36:26 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44277>

On Wed, 11 Apr 2007, Linus Torvalds wrote:
> On Thu, 12 Apr 2007, Sam Vilain wrote:
>
> The reason a *full* global fsck is so expensive is that it would have an
> absolutely humungous working set, and effectively keep everything in
> memory through it all. Doing it in stages ("fsck smaller individiual trees
> separately") is actually the same amount of absolute work, but the working
> set never grows, so it scales much better.
>
> (fsck'ing projects individually also happens to allow you to do the
> sub-project fsck's in parallel across multiple CPU's or multiple machines,
> so it actually scales much better that way too - but the big problem
> tends to be excessive memory use, so the "SMP parallel version" only
> makes sense if you have tons of memory and can afford to do these things
> at the same time!)

would it make sense to have a --multiple-project option for fsck that would let 
you specify multiple 'projects' that share a object set and have the default 
checking not do the reachability checks that cause problems in this case?

Then people can share the objects if they want to and still do a full check, but 
would get warned that the full check would take a lot of time. which is not a 
big problem for a housekeeping thing that's run infrequently to find unreachable 
objects (which is something that should seldom happen in a well managed project)

David Lang
