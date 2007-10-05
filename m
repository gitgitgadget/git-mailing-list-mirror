From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Question about "git commit -a"
Date: Fri, 05 Oct 2007 18:33:38 +0200
Message-ID: <vpq641led25.fsf@bauges.imag.fr>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
	<545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>
	<fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>
	<Pine.LNX.4.64.0710042209410.4174@racer.site>
	<4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
	<4705FB52.3030208@op5.se>
	<1191599763.7117.18.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 18:34:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idq8H-0000sw-PW
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbXJEQeZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2007 12:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197AbXJEQeY
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:34:24 -0400
Received: from imag.imag.fr ([129.88.30.1]:34777 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666AbXJEQeX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 12:34:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l95GXcAp020316
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 18:33:38 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Idq7O-0002l3-Ht; Fri, 05 Oct 2007 18:33:38 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Idq7O-0003Vj-FS; Fri, 05 Oct 2007 18:33:38 +0200
In-Reply-To: <1191599763.7117.18.camel@hinata.boston.redhat.com> ("Kristian
 =?iso-8859-1?Q?H=F8gsberg=22's?= message of "Fri\, 05 Oct 2007 11\:56\:03
 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 05 Oct 2007 18:33:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60107>

Kristian H=F8gsberg <krh@redhat.com> writes:

> I understand why people like staging and commit without -a, seeing ho=
w
> it's faster and all,

Actually, commit without -a is not much faster, since it runs "status"
internally, to show it to the user when launching the editor. So, it
still checks for changes in the working tree.

> but I have a serious problem with this practice that I haven't seen
> brought up on the list. How do you know what you commit actually
> works or even compiles?

That's a general problem with partial commits, and that's why I
personnaly don't like partial commits in general ($scm commit file1
file2 has the same problem, \forall $scm).

To me, the right approach to partial commit is to stash the unwanted
changes, test, commit, and unstash.

(side note: it would be cool to have a "git stash --unstaged" command,
to put the unstaged changes aside, and match the tree to the index. A
good approximation for that is:

$ git stash                  # put all aside
$ git reset --mixed stash^2  # get back what the index used to be
$ git add -u                 # and put it back into the index.
)

*But*, the cool thing with git is that you can view rather easily not
only what you're about to commit (git diff --cached), but also what
you're about _not_ to commit (git diff). So, if the unstaged changes
are trivial enough, it can be OK (for example, Linus changes the linux
version in a Makefile a few commits before the release, and doesn't
add it to the index, to keep it as a reminder).

But I agree with your that splitting a huge patch into smaller ones
using just the index is bad practice, except if you intend to come
back to each commit and test it later.

--=20
Matthieu
