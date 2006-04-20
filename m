From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-clone produces "___" file and no working tree
Date: Thu, 20 Apr 2006 10:36:25 -0700
Message-ID: <7vejzsywrq.fsf@assigned-by-dhcp.cox.net>
References: <20060419053640.GA16334@tumblerings.org>
	<20060419094916.GD27689@pasky.or.cz>
	<20060419142131.GD4104@tumblerings.org>
	<20060419144827.GX27631@pasky.or.cz>
	<20060420164908.GA540@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 19:36:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWd4z-0004LD-JE
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 19:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWDTRg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 13:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWDTRg1
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 13:36:27 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:32692 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751069AbWDTRg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 13:36:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420173626.CXAK18351.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 13:36:26 -0400
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20060420164908.GA540@tumblerings.org> (Zack Brown's message of
	"Thu, 20 Apr 2006 09:49:08 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18983>

Zack Brown <zbrown@tumblerings.org> writes:

> I just downloaded the latest versions of git and cogito from kernel.org:
> cogito-0.17.2 and git-1.3.0; put their directories in my path, and ran "make" on
> both of them. There's no other version in my path.

Earlier, you were having this symptom:

>> What do these command say?
>> 
>> 	$ git --exec-path
>> 	$ ls -l "`git --exec-path`/git-clone"
>
> 22:07:05 [zbrown] ~$ git --exec-path
> /home/zbrown/bin
> 07:10:34 [zbrown] ~$ ls -l "`git --exec-path`/git-clone"
> ls: /home/zbrown/bin/git-clone: No such file or directory
>
> Does that mean it's looking in /home/zbrown/bin for the git binaries?

If that is the case, you did not just (quote) "and ran "make"".

You must have run "make frotz=xyzzy target", but you did not mention
what frotz, xyzzy and target were.

> 09:46:55 [zbrown] ~/git/trees$ "ls" -ltc `which git; which git-init-db`
> -rwxrwxr-x 2 zbrown zbrown 452312 Apr 20 09:44 /home/zbrown/git/git//git
> -rwxrwxr-x 1 zbrown zbrown 235282 Apr 20 09:43 /home/zbrown/git/git//git-init-db

So you are doing

	make bindir=$HOME/git/git/ install

as the last step of your installation.  I _strongly_ suspect
your breakage is caused because you did a make with different
configuration before that.  That is, if you do this, that is
consistent with the symptom:

	make
	make bindir=$HOME/git/git/ gitexecdir=$HOME/git/git/ install

It probably would help if you did this:

	make clean
	make bindir=$HOME/git/git gitexecdir=$HOME/git/git/
	make bindir=$HOME/git/git gitexecdir=$HOME/git/git/ install

As I said in a previous message, the first paragraph in INSTALL
file explains this.
