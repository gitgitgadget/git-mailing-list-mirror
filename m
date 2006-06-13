From: Junio C Hamano <junkio@cox.net>
Subject: Re: Thoughts on adding another hook to git
Date: Tue, 13 Jun 2006 11:41:06 -0700
Message-ID: <7virn4gapp.fsf@assigned-by-dhcp.cox.net>
References: <448DB201.5090208@shlrm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 13 20:41:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDpA-0004ZL-6S
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWFMSlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWFMSlI
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:41:08 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:8632 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932105AbWFMSlH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 14:41:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060613184107.WTMC18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Jun 2006 14:41:07 -0400
To: David Kowis <dkowis@shlrm.org>
In-Reply-To: <448DB201.5090208@shlrm.org> (David Kowis's message of "Mon, 12
	Jun 2006 13:27:13 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21802>

David Kowis <dkowis@shlrm.org> writes:

> I'd like to be able to modify the commit message before it ends up in
> the $EDITOR. This is a fairly trivial thing to implement:
> Call ${GIT_DIR}/hooks/pre-editor on COMMIT_MESSAGE before opening it in
> $EDITOR.

Three random thoughts.

 - pre-editor is too generic a name because before making a
   commit is not the only place we give you $EDITOR (both am and
   tag do EDITOR thing IIRC).  So the hook name must be more
   specific to the commit codepath (otherwise your pre-editor
   hook needs to be able to tell which codepath called it).

 - git-commit gives you EDITOR when you are making a merge, and
   you would probably want to keep the default merge commit
   message without the prefixed directory thing.  You probably
   do not want to do this while doing --amend either.

 - it might make sense to have a "commit template" that is used
   when making a non-merge commit afresh (i.e. without -F, -m,
   -c or -C to specify messages), instead of a hook script.
