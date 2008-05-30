From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: reducing prune sync()s
Date: Thu, 29 May 2008 21:50:43 -0400
Message-ID: <20080530015043.GB4032@redhat.com>
References: <20080529205743.GC17123@redhat.com> <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org> <alpine.LFD.1.10.0805291727490.3141@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Fri May 30 03:53:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1tnz-00048X-Sr
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 03:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbYE3Bw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 21:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbYE3Bw3
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 21:52:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59013 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994AbYE3Bw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 21:52:28 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4U1pskQ019148;
	Thu, 29 May 2008 21:51:54 -0400
Received: from pobox-3.corp.redhat.com (pobox-3.corp.redhat.com [10.11.255.67])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4U1psuA019708;
	Thu, 29 May 2008 21:51:54 -0400
Received: from touchme.toronto.redhat.com (IDENT:postfix@touchme.yyz.redhat.com [10.15.16.9])
	by pobox-3.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4U1pLch019210;
	Thu, 29 May 2008 21:51:53 -0400
Received: from ton.toronto.redhat.com (ton.yyz.redhat.com [10.15.16.15])
	by touchme.toronto.redhat.com (Postfix) with ESMTP
	id 7BC118001FF; Thu, 29 May 2008 21:51:04 -0400 (EDT)
Received: from ton.toronto.redhat.com (localhost.localdomain [127.0.0.1])
	by ton.toronto.redhat.com (8.13.1/8.13.1) with ESMTP id m4U1omCs019022;
	Thu, 29 May 2008 21:50:48 -0400
Received: (from fche@localhost)
	by ton.toronto.redhat.com (8.13.1/8.13.1/Submit) id m4U1ohbt019021;
	Thu, 29 May 2008 21:50:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805291727490.3141@woody.linux-foundation.org>
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83264>

Hi --

On Thu, May 29, 2008 at 05:32:30PM -0700, Linus Torvalds wrote:

> [...]  Side note: a lot of systems make "fsync()" pretty expensive
> too. It's one of my main disagreements with most log-based
> filesystems - fsync() can in theory be fast, but almost always
> implies flushing the whole log, even if 99.9% of that log is totally
> unrelated to the actual file you want to fsync(). [...]

The scenario where I ran into this was different: a usb-drive
filesystem was busy running receiving backups, collecting, oh, several
GB of dirty data, while git was working on a normal local disk on a
separate filesystem.  The system-wide git sync unnecessarily blocked
on the usb filesystem too.

- FChE
