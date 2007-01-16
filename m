From: Jason Riedy <ejr@cs.berkeley.edu>
Subject: Re: [PATCH] Solaris 5.8 returns ENOTDIR for inappropriate renames.
Date: Mon, 15 Jan 2007 19:16:41 -0800
Message-ID: <18145.1168917401@lotus.CS.Berkeley.EDU>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 04:16:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6eoZ-0007OQ-6R
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 04:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbXAPDQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 22:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbXAPDQo
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 22:16:44 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:45224 "EHLO
	lotus.CS.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbXAPDQo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 22:16:44 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id l0G3GfSH018151;
	Mon, 15 Jan 2007 19:16:41 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id l0G3GftD018148;
	Mon, 15 Jan 2007 19:16:41 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: 7vslebznl5.fsf@assigned-by-dhcp.cox.net 
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.0.91
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36918>

And Junio C Hamano writes:
> > -		if (errno==EISDIR) {
> > +		if (errno==EISDIR || errno==ENOTDIR) {

> Now ".git/logs/foo/bar" might already exist as a directory, and
> this error path is attempting to catch EISDIR that comes out
> from it (and in that case, if there is nothing but empty
> directories in the hierarchy under .git/logs/foo/bar, we 
> remove them and retry).
> 
> Does Solaris give ENOTDIR in such a case?

Exactly.  rename(file, directory) produces an error.  Some
systems associate the error with the directory and give EISDIR.
Solaris (at least 5.8) associates the error with the file and
gives ENOTDIR.

Looks like SUS declares EISDIR as the correct errno.  I didn't
realize that...  I don't think it's worth a full compat wrapper
just for this, but I could be wrong.

It is worth including your very lucid explanation in the
routine's comments, though.

Jason
