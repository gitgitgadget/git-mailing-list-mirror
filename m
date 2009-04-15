From: Andreas Ericsson <ae@op5.se>
Subject: Re: Tagging stable releases
Date: Wed, 15 Apr 2009 20:03:45 +0200
Message-ID: <49E62181.6040202@op5.se>
References: <23045562.post@talk.nabble.com> <49E59BC9.5060906@op5.se> <loom.20090415T161255-114@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Stefan_N=E4we?= <stefan.naewe+git@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 20:07:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu9UB-0005GC-GI
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 20:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbZDOSDu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2009 14:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbZDOSDt
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 14:03:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:28790 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbZDOSDs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 14:03:48 -0400
Received: by fg-out-1718.google.com with SMTP id e12so7058fga.17
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 11:03:46 -0700 (PDT)
Received: by 10.86.81.15 with SMTP id e15mr391324fgb.2.1239818626785;
        Wed, 15 Apr 2009 11:03:46 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d4sm75958fga.18.2009.04.15.11.03.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Apr 2009 11:03:46 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <loom.20090415T161255-114@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116641>

Stefan N=E4we wrote:
>=20
> You've been talking about using git at your $dayjob quite often.
> Any chance to share some of your 'infrastructure' (like hooks, e.g.) =
?
>=20

I could, but it would largely be a waste of time. We're still using a
more or less the original example update hook (which I wrote) at work,
and that's pretty much it. Fortunately, we've never run into "out of
diskspace" error or something like that, so it's always worked
perfectly for us.

The, for us, major addendum is a part of the script which appends
the latest pushed commit to a file. We have a build-bot cron-script
triggered every 5 minutes which builds tarballs and RPM's from the
triggering commit and sends email to developers on errors or on
error recovery (a sort of poor man's continuous integration), but
highly effective all the same.

Apart from the tag-dance, we also try to keep our history as
bisectable as possible, which means we rebase a lot and resolve
conflicts in single-parent commits as far as is humanly possible.
This stems from the fact that bisection is really only complicated
when it happens to land on a multi-parent commit where neither of
the parent-chains introduced the breakage (ie, the resolution of
the merge-conflicts is at fault). I was interviewed about this
in some online magazine or other, though I can't quite recall the
URL right now. What with us having a partner-event with free beer
and wine at the office atm, I'm surprised I haven't added a ton
of spelling errors already :P

The fact that I'm at the same time a development spider (looking
at everything) and at the same time one of the top 100 or so
people in the world that knows how and why git works the way it
does helps things a lot in our end, and made it possible for us
to adopt git early (around february 2006, afair) as the company
scm of choice.

Sorry, but we're not a large enough in-house development team
to have communication problems. I resolve most of the merge
conflicts (for small changes, usually by telling the person
who tried to push that he needs to re-do his/her changes on top
of the latest pushed development branch).

We do use topic-branches extensively, but only for multi-commit
fixes. Otherwise it's usually committed straight to 'master' or
whatever our 'hackaway' branch is named. I cherry-pick or merge
bugfixes back to our equivalence of 'maint' (which differs from
repo to repo, as we have nearly 300 of the little buggers).

Testing is used rather extensively, but nearly all our tests
have grown from the need to bisect. In other words, our tests
make sure the API they're trying to test actually exist before
they attempt to use them. If they don't, they respond "git
bisect bad". If we didn't ask for that test implicitly, it
responds in a way that makes test pass but the testsuite fail
for builds. It's not complicated, but it is rather tailor-made.

Ah well. Without a more specific question I'm afraid I won't=20
be able to give a better answer. If you're working for a
company that produces products from a multitude of different
software projects (like we do) and your product is largely
RPM-based, I'll send you our build-scripts and whatnot.
Unless I get a specific question about it though, I won't
bother the rest of the list with a bunch of junk they'll
never bother about.

Happy gitting :)

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
