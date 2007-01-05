From: Junio C Hamano <junkio@cox.net>
Subject: Re: Default "tar" umask..
Date: Fri, 05 Jan 2007 13:03:50 -0800
Message-ID: <7vzm8xdw3t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612301037570.4473@woody.osdl.org>
	<7vfyaxjiaj.fsf@assigned-by-dhcp.cox.net>
	<459EB78B.60000@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 22:04:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2wEL-0002F6-Ke
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 22:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbXAEVDz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 5 Jan 2007 16:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbXAEVDz
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 16:03:55 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:43381 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbXAEVDz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 16:03:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105210352.TZWJ2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 16:03:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7Z331W00T1kojtg0000000; Fri, 05 Jan 2007 16:03:03 -0500
In-Reply-To: <459EB78B.60000@lsrfire.ath.cx> (=?iso-8859-1?Q?Ren=E9?=
 Scharfe's message of "Fri,
	05 Jan 2007 21:39:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36022>

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
>> ...
>> Having said that, I do not see much reason for anybody to want to
>> extract any material that is worth to be placed under version contro=
l
>> in a way that is world-writable, so I do not mind having 002 as the
>> default, but I feel that group-writability should be kept under
>> control of the umask of end users who know what they are doing.
>
> Yes, using 002 is tempting.  But it's got the same "looseness" proble=
ms
> as 000, only on a smaller scaler: there are certainly situations wher=
e a
> user doesn't want to share write permissions with all the members of =
her
> current group.  If we change the default, let's go all the way to 022=
=2E

I don't think the above argument makes much sense -- it does not
explain why you do not go "all the way" to 077.

On the other hand, I can explain 002 fairly easily and
consistently.  This matters only for users who can become root
and does not know or care about implied -p, and the group root
belongs to had better not contain any suspicious user, so
leaving group open does not hurt.  022 actively hurts sane usage
(i.e. work always with a sane umask and extract as non root
users) while 002 does not.

> Admittedly, that doesn't help users who download from a "022" project=
,
> but really want something looser.  I think it's more important to
> avoid violating the expectations of all those who freak out at 0666
> permission modes attached to their freshly downloaded files, though.

Exactly, and that is why I think 002 is much saner.
