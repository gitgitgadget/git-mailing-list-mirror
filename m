From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git performance
Date: Fri, 24 Oct 2008 10:53:20 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810241050310.3287@nehalem.linux-foundation.org>
References: <000901c93490$e0c40ed0$a24c2c70$@com> <20081023163912.GA11489@coredump.intra.peff.net> <000001c9358f$232bac70$69830550$@com> <20081024142947.GB11568@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Edward Ned Harvey <git@nedharvey.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 19:54:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtQs5-00075H-I3
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 19:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757639AbYJXRxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 13:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757645AbYJXRxj
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 13:53:39 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36551 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752257AbYJXRxi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2008 13:53:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9OHrLF5003095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Oct 2008 10:53:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9OHrKcd010885;
	Fri, 24 Oct 2008 10:53:21 -0700
In-Reply-To: <20081024142947.GB11568@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.443 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99047>



On Fri, 24 Oct 2008, Jeff King wrote:
> 
> Side note: on Linux, it is much easier to clear the cache via
> 
>   echo 1 >/proc/sys/vm/drop_caches

Use "echo 3" instead of "1".

It's actually a bitmask, with bit 0 being "data" (pagecache) and bit 1 
being "metadata" (inodes and directory caches).

And since git (or any SCM) is very metadata-intensive, you really should 
make sure to drop metadata too, otherwise your caches won't be really very 
cold at all.

(But it obviously depends on the operation you're testing - some are more 
about the inodes and directories, others are about file data access).

			Linus
