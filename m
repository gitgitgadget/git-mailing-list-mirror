From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: hosting git on a nfs
Date: Thu, 13 Nov 2008 15:48:30 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811131545071.3468@nehalem.linux-foundation.org>
References: <200811121029.34841.thomas@koch.ro>  <20081112173651.GA9127@linode.davidb.org>  <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org>  <loom.20081113T174625-994@post.gmane.org>  <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
  <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org> <885649360811131523h2e10dc44x8603c9793dae03b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bruce Fields <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 00:50:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0lwx-0007fh-6P
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 00:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYKMXsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 18:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbYKMXsq
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 18:48:46 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47468 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752723AbYKMXsp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 18:48:45 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mADNmWjo023787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Nov 2008 15:48:33 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mADNmV1X001227;
	Thu, 13 Nov 2008 15:48:32 -0800
In-Reply-To: <885649360811131523h2e10dc44x8603c9793dae03b8@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.432 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100930>



On Thu, 13 Nov 2008, James Pickens wrote:
> 
> I'm trying to test this and so far I'm not seeing any effect.

Ok, try my second version. The first version would get _some_ parallelism, 
but very little due to all the threads often trying to just look up in the 
same directory. The second version should hopefully have less of that 
effect.

Also, under Linux, try it with caches cleared in between runs, so that you 
can avoid any issues of the Linux client caching the directory lookup data 
(which linux _will_ do - I think the default timeout is 30 seconds or 
something like that):

	echo 3 > /proc/sys/vm/drop_caches ; time git diff

which should hopefully get you more reliable timings.

			Linus
