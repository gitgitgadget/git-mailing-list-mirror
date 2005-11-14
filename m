From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Mon, 14 Nov 2005 13:15:31 -0800
Message-ID: <7vwtjbvslo.fsf@assigned-by-dhcp.cox.net>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
	<43730E39.6030601@pobox.com> <7v64qzni9c.fsf@assigned-by-dhcp.cox.net>
	<4375DD4A.5050103@op5.se> <7vwtjb3c4i.fsf@assigned-by-dhcp.cox.net>
	<4378578E.5090409@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 22:17:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eblg2-0002y8-8c
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 22:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVKNVPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 16:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVKNVPe
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 16:15:34 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:11940 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932132AbVKNVPd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 16:15:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114211440.UZXZ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 16:14:40 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4378578E.5090409@op5.se> (Andreas Ericsson's message of "Mon, 14
	Nov 2005 10:23:26 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11849>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>> My current thinking about this problem is that the handful
>> programs that need to run "on the other end" should stay in
>> /usr/bin, even after we move most things out of /usr/bin, if
>> only to avoid configuration hassles.  They are:
>> 	receive-pack, upload-pack
>>         ssh-fetch, ssh-pull, ssh-push, ssh-upload
>
> I liked your suggestion of deprecating the /usr/bin use a month or two 
> before it's effected better. We could then provide symlinks for the 
> necessary programs that point to their real locations in GIT_EXEC_PATH 
> and (someday) drop those links when they're no longer needed.

Yes, but the problem is when that "someday" comes.  Unlike a
single machine installation where we can tell "git" to look into
somewhere different at the same time we move the subcommands out
of /usr/bin, "the other end" can lag behind and sometimes not
under control of the end user.

I think it's simpler to manage and can be made configuration
free if we keep receive-pack and upload-pack in /usr/bin and
always call these programs in dash-form (i.e. not "git
upload-pack") from the other end.  .bash_profile is not read for
incoming ssh connections to execute a single command, but many
people set their PATH in there, without setting PATH in .bashrc.

I personally think that having to set PATH in .bashrc it is
actually a bug in what bash does, but that is OT.
