From: Robert Luberda <robert@debian.org>
Subject: Re: [PATCH/RFC] git svn: optionally trim imported log messages
Date: Sat, 25 Aug 2012 00:38:51 +0200
Organization: Debian
Message-ID: <5038027B.4090208@debian.org>
References: <50315ED1.6080803@debian.org> <1345413170-2519-1-git-send-email-robert@debian.org> <7vsjbio2ky.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: Robert Luberda <robert@debian.org>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 01:22:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T53Cd-0007Tf-4H
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 01:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472Ab2HXXWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 19:22:00 -0400
Received: from master.debian.org ([70.103.162.29]:47846 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab2HXXV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 19:21:57 -0400
Received: from localhost ([127.0.0.1] helo=vox.robbo.home)
	by master.debian.org with esmtp (Exim 4.72)
	(envelope-from <robert@debian.org>)
	id 1T53CI-0005mi-0N; Fri, 24 Aug 2012 23:21:50 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by vox.robbo.home (Postfix) with ESMTP id BEFEEE2F7D;
	Sat, 25 Aug 2012 00:38:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.6esrpre) Gecko/20120817 Icedove/10.0.6
In-Reply-To: <7vsjbio2ky.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204240>

Junio C Hamano writes:

Hi,

Junio, for some reason I don't get mails from you, I've just discovered
your e-mails on gmane news list. Anyway many thanks for your comments,
I'll fix them and send updated patch next week.


>> +When committing to svn from git (as part of 'commit-diff', 'set-tree'
>> +or 'dcommit') and '--add-author-from' is in effect, a new line character
>> +is not added before the `From: ` line if the log message ends with
>> +a pseudo-headers section.
> 
> I think it would be saner to call them "trailers" to avoid
> confusion.

Thanks, I haven't got any idea how to call them, especially because
existing git documentation refers to them just by using the word `line',
e.g.:

 git-am.txt:     Add a `Signed-off-by:` line to the commit message,
 git-cherry-pick.txt:    Add Signed-off-by line at the end of the

(The "trailer" keyword appears once in SubmittingPatches and - in a bit
different meaning in technical/pack-format.txt)

> 
> I've seen S-o-b, Cc and Change-Id there, but does anybody actually
> put "From: " there?

Yes, `git svn dcommit --add-author-from' adds such a trailer to the  svn
log message, and then resets or rebases the git index against svn, so
that the message with the trailer appears in git.

> 
> There needs an explanation to the reader why this is an optional
> feature.

OK, I'll add some explanation. Basically it is optional, per Eric
request, for backward compatibility  to make it possible to work on a
centralized clone of svn repository by people using both old and new
versions of git svn.

> 
> The prerequisite mechanism is to allow some tests in an environment
> where they cannot be run (e.g. no SVN available on the platform);
> any code that uses set_prereq unconditionally looks extremely
> strange.  It is OK while the patch is in RFC stage under active
> debugging, but they would want to go away before the polishing is
> done.

OK, I used it merely for checking that the tests work on older version
of git svn, and I didn't break the backward compatibility by accident.
Will be dropped from next version of the patch.

> 
> What does En-El stand for?  We often see (but not in Git where we
> prefer LF for that purpose)
> 
> 	NL='
>         ' ;# newline
> 
> and using $NL to mean "empty" may be misleading to the readers.

NL means newline. The new line characters implicitly added after each
commit message line, that's why the value is empty. But, yes, this can
be misleading. I'd prefer to keep it short, so would EL (i.e.
`empty-line') be an acceptable name?

>> +	N=$((N + 1)) &&
> 

Sorry, it was a typo, I meant to use $(($N + 1)). Thanks for catching this.

> 
> 	next_N () {
> 		N=$(($N + 1)) &&
>                 ...
> 	}
> 
> (the above also has two style fixes).

Just to be sure: shall the `...' line start a new level of indentation
or is it a typo? (I guess that the two style fixes are just after the
function name.)


Thanks a lot,
robert
