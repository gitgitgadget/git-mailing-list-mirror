From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rev-list --sparse?
Date: Sun, 30 Oct 2005 13:42:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510301337500.27915@g5.osdl.org>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510292204520.3348@g5.osdl.org> <7v64rfxuwl.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 30 22:53:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWL6Y-0001gd-2v
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 22:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVJ3Vwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 16:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbVJ3Vwj
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 16:52:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41144 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751145AbVJ3Vwj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2005 16:52:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9ULsPFR006467
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 30 Oct 2005 13:54:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9ULghEl005867;
	Sun, 30 Oct 2005 13:42:44 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64rfxuwl.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10834>



On Sun, 30 Oct 2005, Junio C Hamano wrote:
> 
> The --sparse flag does not seem to have much use either; not
> giving pathspec has the same effect.

No.

--sparse _does_ have effect, but it's subtler.

Try "--sparse" together with a pathspec. It will only do the merge 
follow optimization.

Now, how useful is that? It's potentially useful as a way to "linearize 
the history". For example, let's say that you wanted to simplify the 
commit history for a project, and you only cared about the history of 
certain files - but you do want all the other files to _exist_ in that 
history.

So then you could do "git-rev-list --sparse HEAD -- filelist" and you'd 
get the minimal history that is still relevant in those files. Any merges 
that touch anything else than those files will becomes just regular diffs: 
they'll have been linearized away.

Useful? Quite possibly not. But I felt that simplifying merges was 
conceptually a very different operation from then compressing a linear 
history.

		Linus
