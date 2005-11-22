From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/6] Add check_repo_format check for all major operations.
Date: Tue, 22 Nov 2005 09:46:18 -0800
Message-ID: <7vd5ksefth.fsf@assigned-by-dhcp.cox.net>
References: <11326192921291-git-send-email-matlads@dsmagic.com>
	<113261929333-git-send-email-matlads@dsmagic.com>
	<7vlkzhf5li.fsf@assigned-by-dhcp.cox.net>
	<200511221555.24572.matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 18:49:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EecDp-0001JY-CF
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 18:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVKVRqW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 12:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVKVRqW
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 12:46:22 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:10486 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965033AbVKVRqV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 12:46:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122174541.ELVT20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 12:45:41 -0500
To: Martin Atukunda <matlads@dsmagic.com>
In-Reply-To: <200511221555.24572.matlads@dsmagic.com> (Martin Atukunda's
	message of "Tue, 22 Nov 2005 15:55:23 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12560>

Martin Atukunda <matlads@dsmagic.com> writes:

>> that call in the current series yet.  Even if you had, this does
>> not feel quite right to me.
>
> would something like the following apply in this case: (totally untested :)

Yes, although that is exactly what I said "this does not quite
feel right" ;-).  Is it hard to arrange things so that a process
does exactly one check_repo_format() during its lifetime?

Two more issues I've been thinking about:

1. The core.repositoryformatversion scheme assumes and relies on
   that at least .git/config would stay forward compatible.  But
   if you cover unconditionally the three main entry points, I
   suspect "git-var" or "git-config-set --get" would stop
   working in a wrong repository.  I think the scripts and
   Porcelains need a way to check if we are on a repository from
   the correct vintage before running other low-level commands,
   so one of these commands probably needs to be made to work
   without check_repo_format() dying. Or we could introduce a
   new command 'git-check-repo-format' for this specific
   purpose, and special case only that one.

2. Some commands are read-only and are handy for problem
   diagnosis (e.g. cat-file), so it _might_ make sense to allow
   them to attempt running in a newer repository (which may well
   fail due to repository format difference).  I am not sure
   about the merit of doing that outweighs the complexity,
   though.  What you did covers _everything_ uniformly, and
   certainly is simpler, easier to explain, and nicer.



   
