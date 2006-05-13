From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tracking branch history
Date: Fri, 12 May 2006 21:38:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605122136100.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org>
 <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org> <20060513034051.GA21586@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 06:38:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeltW-0001Gm-Ep
	for gcvg-git@gmane.org; Sat, 13 May 2006 06:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWEMEiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 00:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWEMEiT
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 00:38:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932326AbWEMEiS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 May 2006 00:38:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4D4cDtH015727
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 May 2006 21:38:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4D4cCtZ005375;
	Fri, 12 May 2006 21:38:12 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060513034051.GA21586@spearce.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19925>



On Fri, 12 May 2006, Shawn Pearce wrote:
> 
> Why not intergrate this into git-update-ref.  Almost every tool which
> deals with a GIT repository (aside from my pure-Java Eclipse plugin
> which is still a major work-in-process) performs ref changes through
> git-udpate-ref.  So just have it append the ref's history to a file:
> 
> 	.git/log/refs/heads/$branch
> 
> where the history records are stored as:
> 
> 	40 byte commit-ish SHA1
> 	<SP>
> 	<committer>
> 	<LF>

Sure. Except it's not really "committer", in the ordinary sense (there's 
no "commit" for a fast-forward). But yes, re-using that format (with date 
and all) makes sense.

> Of course a major issue here is locking the log file during the ref
> update, but it looks like it might just be safe to append the entry
> to the log file right after the re_verify and before the rename.

I'd suggest just opening it with O_APPEND, and doing the update with a 
single write() system call. Let the OS do the locking for you. 

		Linus
