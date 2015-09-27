From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Sun, 27 Sep 2015 14:11:25 +0200
Message-ID: <vpq7fnc83ki.fsf@grenoble-inp.fr>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
	<CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Sep 27 14:12:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgAoQ-000770-0Q
	for gcvg-git-2@plane.gmane.org; Sun, 27 Sep 2015 14:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbbI0MLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2015 08:11:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56119 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864AbbI0MLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2015 08:11:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8RCBOGO001656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 27 Sep 2015 14:11:25 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8RCBPNv010174;
	Sun, 27 Sep 2015 14:11:25 +0200
In-Reply-To: <CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	(Luke Diamand's message of "Fri, 25 Sep 2015 09:05:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 27 Sep 2015 14:11:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8RCBOGO001656
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443960686.72457@4vBU4FW3X0Oo751zb0dPPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278702>

Luke Diamand <luke@diamand.org> writes:

> It would be less intrusive for the CI system to have a fork. Otherwise
> other people using git with the same CI system will get annoying merge
> conflicts,

What conflicts are you talking about? The ones in .travis.yml? The point
is to share this file so that people using the same system do not have
to change anything.

And, we're talking about a straightforward 28-lines long file, set up
essentially once and for all. Even if people ever modify it, I don't
forsee conflict resolution in such a simple file as a real problem.

> and we'll also end up with a repo littered with the control files from
> past CI systems if the CI system is ever changed.

Again, we're talking about a short and simple configuration file.

Sure, when we change something, we either get old files lying around or
have to remove the old files. But would we say "Git shouldn't have a
Makefile, because having a Makefile would mean we'd end up with a repo
littered with Makefiles the day we migrate to another build system"?

> From past experience, if it's configured to email people when things
> break, sooner or later it will email the wrong people, probably once
> every few seconds over a weekend.

Are you talking about your experience with Travis-CI in particular, or
with CI systems in general? Is the scenario where Travis-CI sends email
based on actual facts, or only speculation?

My experience with Travis-CI is that it just works (my experience is
limited, but I'm using it for git-multimail, and it's a really
convenient tool). It does send emails by default, but with a very
reasonable policy:

  http://docs.travis-ci.com/user/notifications/

  "By default, email notifications are sent to the committer and the
  commit author, if they are members of the repository (that is, they
  have push or admin permissions for public repositories, or if they
  have pull, push or admin permissions for private repositories)."

In short:

* If the tests always pass, nobody ever get any email from Travis-CI.

* When someone sends a pull-request that fails tests, that someone gets
  an automatic email about the failure. This saves one email round-trip
  "X sends a patch series, Junio notices the failure, Junio sends an
  email about the failure", and shortcuts this as "X sends a PR, and
  gets an email, possibly even before Junio notices".

> Automated testing is a Good Thing, but it's still software, so needs
> maintenance or it will break.

The point of using Travis-CI is precisely to use an externally
maintained system. It's not just software, it's a service (based on
software, obviously).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
