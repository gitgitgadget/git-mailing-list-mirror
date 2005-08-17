From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fixed two bugs in git-cvsimport-script.
Date: Wed, 17 Aug 2005 03:01:43 -0700
Message-ID: <7vacjgyj94.fsf@assigned-by-dhcp.cox.net>
References: <u5tacjjdpxq.fsf@lysator.liu.se> <u5tiry50ywy.fsf@lysator.liu.se>
	<7v3bp829zj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 12:03:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Kk1-0006E7-GL
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 12:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbVHQKBp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 06:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVHQKBp
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 06:01:45 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:54206 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751032AbVHQKBo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 06:01:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817100144.CHHX15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 06:01:44 -0400
To: David =?iso-2022-jp-2?B?SxsuQRtOZWdlZGFs?= <davidk@lysator.liu.se>
In-Reply-To: <7v3bp829zj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 17 Aug 2005 02:22:56 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Yes, the patch had some context conflicts with some other patch
> so the patch application was done by hand, and I did a quick and
> dirty cut & paste of the commit message from "cat mbox" output.
>
> I will probably drop future patches encoded in QP.

This was totally inappropriate; sorry, but I was in a bad mood.

A more serious response.

 - I personally consider commit message encoding a per project
   issue (so is blob contents encoding).  If for example a
   project is Japanese only, MS-DOS^WWindows programming
   project, I do not think it is unreasonable if all the commit
   messages and source files are encoded in Shift-JIS.  More
   Unixy projects over there might use EUC-JP in source files
   and maybe ISO-2022 in the log messages (because the latter is
   the standard way to exchange e-mails there).  As long as
   project participants agree to use the same encodings, things
   should work just fine within a project.

 - However, weird people are known to merge projects that
   started out as totally separate into one.  It would be a
   disaster for the commit log viewer when this happens.  For
   this reason, some people recommend using a common deniminator
   encoding, namely UTF-8, for commit logs from day one, even if
   you do not envision such a merge may happen in the future.

   This recommendation also goes to author and committer
   identification (but not blob contents).  But this is just an
   recommendation, and it is still up to the individual project
   what encoding to use in the log messages, and the low-level
   GIT should not dictate nor interfere; "git-commit-tree" and
   "git-cat-file commit" are 8-bit clean.

 - The e-mail patch acceptance machinery found in tools/
   directory is tuned for the established patch exchange
   practice used in the linux-kernel mailing list.  No MIME, no
   QP, no guarantee to pass things outside ASCII.

 - Eventually, tools/mailinfo.c should be taught about MIME to
   do at least:

   - detect whitespace corrupted patch via sending MUA using
     flowed-text and reject it;

   - detect multipart PGP signed message, discard the attached
     signature which is often useless, and unwrap the payload;

   - decode QP and B encodings as necessary, and after splitting
     the message to the info, msg and patch part, transliterate
     the info and msg part from original encoding to UTF-8 (when
     '--utf8' flag is given, perhaps).

   One of the requirement there is that it still needs to be
   _fast_.  Linus needs to be able to make 5 commits per second
   out of his mailbox.

So that is the technical part of the response.  There is one
Project policy part of the response: I would endorse the
application of that UTF-8 recommendation to the git project
itself, at least in principle.

But that in practice would happen only after the above mailinfo
update takes place.  Until then, it is very likely that I will
occasionally fail to spot and to hand-correct people's name left
undecoded the way the patch acceptance machinery passed through
in the log message.  Please live with it (or send such patches
to mailinfo ;-).
