From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Thu, 06 Apr 2006 16:53:29 -0700
Message-ID: <7vk6a2uupy.fsf@assigned-by-dhcp.cox.net>
References: <20060406205724.12216.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 07 01:53:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FReIF-0001I5-VD
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 01:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWDFXxc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 19:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWDFXxc
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 19:53:32 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50908 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932229AbWDFXxb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Apr 2006 19:53:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060406235330.DFK20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Apr 2006 19:53:30 -0400
To: linux@horizon.com
In-Reply-To: <20060406205724.12216.qmail@science.horizon.com>
	(linux@horizon.com's message of "6 Apr 2006 16:57:24 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18487>

linux@horizon.com writes:

>> Right now we LRU the pack files and evict older ones when we
>> mmap too many, but the unit of eviction is the whole file, so it
>> would not help the case like yours at all.  It might be possible
>> to mmap only part of a packfile, but it would involve fairly
>> major surgery to sha1_file.c.
>
> The simplest solution seems to be to limit pack file size to a reasonable
> fraction of a 32-bit address space.  Say, 0.5 G.

I do not think that would help the original poster's situation
where only 5 revs result in a 1.5G pack.  I would _almost_ say
"do not pack such a repository", but there is the initial
cloning over git-aware transports which always results in a
repository with a single pack.
