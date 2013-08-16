From: Mattias =?UTF-8?B?QW5kcsOpZQ==?= <maandree@member.fsf.org>
Subject: Re: [PATCH] Add command `git bisect state` that checks if the
 current bisection process has reached the first bad commit.
Date: Fri, 16 Aug 2013 06:54:10 +0200
Message-ID: <20130816065410.56665c03.maandree@kth.se>
References: <1376606112-1712-1-git-send-email-maandree@operamail.com>
	<CAPig+cTfdnMRT61NQoHcF9-tt-wHABKPHi8HBXijQeB-jb1VyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>, maandree@member.fsf.org
X-From: git-owner@vger.kernel.org Fri Aug 16 06:54:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAC3R-0001S9-Jj
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 06:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199Ab3HPEyZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 00:54:25 -0400
Received: from smtp-3.sys.kth.se ([130.237.48.192]:36074 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3HPEyY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Aug 2013 00:54:24 -0400
Received: from mailscan-1.sys.kth.se (mailscan-1.sys.kth.se [130.237.32.91])
	by smtp-3.sys.kth.se (Postfix) with ESMTP id 8385F233C;
	Fri, 16 Aug 2013 06:54:18 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at kth.se
Received: from smtp-3.sys.kth.se ([130.237.48.192])
	by mailscan-1.sys.kth.se (mailscan-1.sys.kth.se [130.237.32.91]) (amavisd-new, port 10024)
	with LMTP id wJbOCsjmOWD2; Fri, 16 Aug 2013 06:54:16 +0200 (CEST)
X-KTH-Auth: maandree [193.150.208.92]
X-KTH-mail-from: maandree@member.fsf.org
Received: from localhost.localdomain (c193-150-208-92.bredband.comhem.se [193.150.208.92])
	by smtp-3.sys.kth.se (Postfix) with ESMTPSA id A7037233A;
	Fri, 16 Aug 2013 06:54:12 +0200 (CEST)
In-Reply-To: <CAPig+cTfdnMRT61NQoHcF9-tt-wHABKPHi8HBXijQeB-jb1VyQ@mail.gmail.com>
X-Mailer: Claws Mail 3.9.2 (GTK+ 2.24.20; x86_64-unknown-linux-gnu)
X-Awesomeness: 120 %
User-Agent: Claws Mail
X-Operating-System: GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232399>

On Fri, 16 Aug 2013 00:17:27 -0400
Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Thu, Aug 15, 2013 at 6:35 PM, Mattias Andr=C3=A9e
> <maandree@operamail.com> wrote:
> > This can be used for automated bisection without a
> > check script.
> >
> > Signed-off-by: Mattias Andr=C3=A9e <maandree@operamail.com>
> > ---
> >  Documentation/git-bisect.txt | 13 +++++++++++++
> >  git-bisect.sh                | 11 ++++++++++-
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-bisect.txt
> > b/Documentation/git-bisect.txt index f986c5c..ca8c09d
> > 100644 --- a/Documentation/git-bisect.txt
> > +++ b/Documentation/git-bisect.txt
> > @@ -25,6 +25,7 @@ on the subcommand:
> >   git bisect visualize
> >   git bisect replay <logfile>
> >   git bisect log
> > + git bisect state
> >   git bisect run <cmd>...
> >
> >  This command uses 'git rev-list --bisect' to help
> > drive the @@ -104,6 +105,18 @@ For example, `git bisect
> > reset HEAD` will leave you on the current bisection
> > commit and avoid switching commits at all, while `git
> > bisect reset bisect/bad` will check out the first bad
> > revision.
> >
> > +Bisect state
> > +~~~~~~~~~~~~~~~~
> > +
> > +To see the bisection process has finnished, issue the
> > following command:
>=20
> s/see the/see if the/
> s/finnished/finished/

Oh, I should have proofread the text. However,
the command name =E2=80=98state=E2=80=99 may not be the best,
but I could not think of anything better, so
I am open for comments on a better name.



The purpose of this patch is to provide an
issue what to do an automated `git bisect`
without having to write an script file.

This patch allows you to an automated by section
by just like if it was a manual, i.e. stating
with `git bisect start && git bisect bad &&
git bisect good <commit>` but then type:

while ! git bisect state; do
<test command> && git bisect good || git bisect bad
done

I think this is useful to lower the barrier
of entry for `git bisect`, as well as making
it easy to create regression testing scripts
that do not have to be run with `git bisect run`.

=46or example if you have a lot of regression tests,
you can have a script for each that tests if
if their is a bug and if so bisect it, and print
information about what is testing, all from with
script for each regression test. This way, you
can have a directory of regression tests that
are invoked just as normal script files and have
a master script that runs all of them.
So other developers on the project does not even
need to know how to use `git bisect`.



>=20
> > +
> > +------------
> > +$ git bisect state
> > +------------
> > +
> > +Exit successfully (i.e., with return code 0), if and
> > only if the current +bisection has reached the first
> > bad or possible first bad commit. +
> >  Bisect visualize
> >  ~~~~~~~~~~~~~~~~
> >
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 9f064b6..6ddda34 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -1,6 +1,6 @@
> >  #!/bin/sh
> >
> > -USAGE=3D'[help|start|bad|good|skip|next|reset|visualize|replay|log=
|run]'
> > +USAGE=3D'[help|start|bad|good|skip|next|reset|visualize|replay|log=
|run|state]'
> >  LONG_USAGE=3D'git bisect help
> >         print this long help message.
> >  git bisect start [--no-checkout] [<bad> [<good>...]]
> > [--] [<pathspec>...] @@ -23,6 +23,8 @@ git bisect log
> >         show bisect log.
> >  git bisect run <cmd>...
> >         use <cmd>... to automatically bisect.
> > +git bisect state
> > +       check if the bisection is complete.
> >
> >  Please use "git help bisect" to get the full man page.'
> >
> > @@ -491,6 +493,11 @@ bisect_log () {
> >         cat "$GIT_DIR/BISECT_LOG"
> >  }
> >
> > +bisect_complete_state () {
> > +       cat "$GIT_DIR/BISECT_LOG" | tail -n 1 | grep -E
> > '^# (possible |)first bad commit:' > /dev/null
> > +       exit $?
> > +}
> > +
> >  case "$#" in
> >  0)
> >         usage ;;
> > @@ -519,6 +526,8 @@ case "$#" in
> >                 bisect_log ;;
> >         run)
> >                 bisect_run "$@" ;;
> > +       state)
> > +               bisect_complete_state ;;
> >         *)
> >                 usage ;;
> >         esac
> > --
> > 1.8.3.4
> >
> > --
> > To unsubscribe from this list: send the line
> > "unsubscribe git" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
