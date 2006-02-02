From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question around git-shell usage in Everyday Git
Date: Wed, 01 Feb 2006 16:04:55 -0800
Message-ID: <7v8xsu62xk.fsf@assigned-by-dhcp.cox.net>
References: <200602012301.56141.alan@chandlerfamily.org.uk>
	<7vy80u64xf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011530530.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 01:05:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Ry8-0005fl-Lk
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 01:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWBBAE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 19:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWBBAE6
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 19:04:58 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:8131 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750709AbWBBAE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 19:04:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202000216.KZDJ17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 19:02:16 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602011530530.21884@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 1 Feb 2006 15:37:36 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15469>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 1 Feb 2006, Junio C Hamano wrote:
>> 
>> Do you mean to reuse single directory /home/gitu/ for user A, B, C,
>> and hang repositories /home/gitu/{X,Y,Z} for projects?  I'd
>> imagine things could be arranged that way.  User A and B but not
>> C may be in "projectX" group and /home/gitu/X is writable only
>> by projectX group members and such...
>
> That would work from a _git_ angle, but I don't think that was what Alan 
> was talking about, and it would failr horribly from a "ssh" perspective 
> (because "ssh" will want $HOME/.ssh/authorized_keys etc).

Hmph.  I thought that was what Alan was talking about, after he
read about the shared repository configuration section that
mentions git-shell, which is about shared repository.

Project administrator or project secretary sets up the shared
repository for the project and member accounts on that machine,
and members just use that shared repository.  Not allowing
remote repository creation nor deletion over git-shell is a
slightly lesser issue in this context.

> However, to be truly useful for this kind of hosting schenario, 
> "git-shell" still needs to be extended to be able to at a minimum create 
> (and delete) projects.

Hosting is a different story and I think branch/tag removal in
addition to repository creation, and deletion you listed above
are needed in that context.  Your "my projects are all under my
HOME directory, it is very convenient and things naturally work"
would apply for non-shared (i.e. something each person can call
"my") repositories, and would apply to hosting situation, of
course.

> It probably also makes a lot of sense to be able to pre-populate a 
> project, so that you don't have to do a remote "git push" to push a big 
> project over the network, when another version of that project already 
> exists at the hosting site.

Depends on what you mean by pre-populate, but that may just mean
to be able to manage objects/info/alternates remotely.
Capability to manage hook scripts may also be needed to a
certain degree if the repository side access control (e.g. who
can push into this branch) is done by hooks/pre-update, but in
either the hosting environment or a shared project setup, the
machine owner who is paranoid to install git-shell would want to
control what hooks can do very carefully.  The operator would
probably not allow updating of hooks at all, but install a BCP
hook by Carl Baldwin.  The users can only manage what is in the
info/allowed-{users,groups} file.

What this implies is extending what git-shell allows is a
concious policy decision and probably be quite different from
site to site until a set of BCP emerges.
