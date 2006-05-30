From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-fetch - repack in the background after fetching
Date: Mon, 29 May 2006 21:51:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605292147010.5623@g5.osdl.org>
References: <11489641631558-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 06:51:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkwCR-0008HK-86
	for gcvg-git@gmane.org; Tue, 30 May 2006 06:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWE3EvS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 00:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWE3EvS
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 00:51:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50667 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932139AbWE3EvR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 May 2006 00:51:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4U4p12g006544
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 21:51:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4U4p0ap028838;
	Mon, 29 May 2006 21:51:01 -0700
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <11489641631558-git-send-email-martin@catalyst.net.nz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21013>



On Tue, 30 May 2006, Martin Langhoff wrote:
> 
> There's been some discussion about repacking proactively without
> preventing further work. But as Linus said, repacking on an active
> repo is _safe_

Repacking is, but "-d" is not necessarily.

You really should do the prune-packed only _after_ you've repacked, and no 
old git programs are around.

Some long-running (in git terms) git programs will look up the pack-files 
when they start, and if you repack after that, they won't see the new 
pack-file, but they _will_ notice that the unpacked files are no longer 
there, and will be very unhappy indeed.

So the "-d" part really isn't necessarily safe.

Of course, in -practice- you won't likely see this, and the archive itself 
is never corrupted, but concurrent git ops can fail due to it in theory, 
and quite frankly, that's not the kind of SCM I like to use.

So either just do "git repack -a", or do things synchronously.

		Linus
