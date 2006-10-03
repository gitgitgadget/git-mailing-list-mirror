From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Move code resolving packed refs into its own function.
Date: Tue, 03 Oct 2006 10:39:20 -0700
Message-ID: <7v4pulpad3.fsf@assigned-by-dhcp.cox.net>
References: <20060930220158.d331bb7c.chriscool@tuxfamily.org>
	<7vmz8hccxl.fsf@assigned-by-dhcp.cox.net>
	<200610010606.32561.chriscool@tuxfamily.org>
	<7vodsw2w9g.fsf@assigned-by-dhcp.cox.net> <eftjua$2ii$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 03 19:40:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUoEo-00034R-Vr
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 19:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWJCRjX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 3 Oct 2006 13:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWJCRjW
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 13:39:22 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:51376 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030227AbWJCRjV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 13:39:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003173921.RYJY21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Oct 2006 13:39:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VtfE1V00b1kojtg0000000
	Tue, 03 Oct 2006 13:39:15 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28284>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> =A0- I think gitweb should be Ok; it does peek-remote on the
>> =A0 =A0repository. =A0Although we would probably want to update
>> =A0 =A0git_get_references and git_get_refs_list sub to use
>> =A0 =A0for-each-ref there, that can be done as a later optimization.
>
> I'd rather have gitweb use git-for-each-ref after the command
> is in the official release... if not, then keep it in the 'next'
> branch.

Of course.  What else did you expect?

> By the way, I have an idea to join the git-show-ref and git-for-each-=
ref:
> simply add --deref option to git-for-each-ref, which would output
> dereferenced tag just after the reference itself (well, perhaps with =
the
> exception when sorting, perhaps not), with the deref name like in
> git-show-ref and git-peek-remote, i.e. <ref>^{}

Patches welcome.  --verify needs to use totally separate
codepath though.  for-each-ref is primarily for easy displaying
and expects the caller to script in order to skip ones that are
irrelevant while listing (e.g. asking for *objectname does not
error for a non-tag but the caller can deduce that ref is not a
tag by it being empty and skip it); show-ref --verify is for
easy checking for an exact match and should not even walk.
