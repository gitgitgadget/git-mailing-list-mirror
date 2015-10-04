From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Sun, 04 Oct 2015 09:59:50 +0200
Message-ID: <vpq1tdb83nt.fsf@grenoble-inp.fr>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
	<CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	<vpq7fnc83ki.fsf@grenoble-inp.fr> <vpq4mie1m3n.fsf@grenoble-inp.fr>
	<xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
	<CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
	<CAPc5daXkn=C-D5RQCw2w+JrHn7XZA6X-P4F-PugRe-S4Z2RO0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Roberto Tyley <roberto.tyley@gmail.com>, Jeff King <peff@peff.net>,
	Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 10:00:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZieDQ-0005vu-6X
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 10:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbbJDIAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 04:00:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49017 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbbJDIAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 04:00:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t947xo8K003042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 4 Oct 2015 09:59:50 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t947xolk011133;
	Sun, 4 Oct 2015 09:59:50 +0200
In-Reply-To: <CAPc5daXkn=C-D5RQCw2w+JrHn7XZA6X-P4F-PugRe-S4Z2RO0g@mail.gmail.com>
	(Junio C. Hamano's message of "Sat, 3 Oct 2015 18:27:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 04 Oct 2015 09:59:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t947xo8K003042
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444550393.67461@KJCsVPJS3Eags1D3kD/Klw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278995>

Junio C Hamano <gitster@pobox.com> writes:

> On Sat, Oct 3, 2015 at 3:23 PM, Roberto Tyley <roberto.tyley@gmail.com> wrote:
>>
>> Given this, enabling Travis CI for git/git seems pretty low risk,
>> are there any strong objections to it happening?
>
> I still don't see a reason why git/git needs to be the one that is
> used,

The very nice thing with Travis-CI is that it does not only test the
repository's branches, but also all pull-requests. So, if it is
activated on git/git, it will become possible to have a flow like

1) User pushes to his own repo, sends a pull-request,

2) Travis-CI notices the pull-request and builds it (no action needed
   from anyone),

3) Once the build is finished, the user can use e.g. SubmitGit to
   actually submit the code.

This has real benefits for the submitter (know if your code is broken
early), for the reviewers (things like "you have a def-after-use" would
be noticed by a computer before human beings start spending time on the
review), and for you (some issues noticed before a topic enters pu).

There's no extra work for the user at all compared to the standard
pull-request flow (nothing to do, just submit a PR), and a one-time
setup for the project.

Currenty, to mimick this flow, we would need something like

1) User activates Travis-CI on his repo (each user would have to do
   this, not just once)

2) User commits .travis.yml on top of the code to submit

3) User pushes to his repo

4) Travis-CI triggers a build

5) User removes the commit introducing .travis.yml, force-pushes

6) User submit the resulting code.

This is much more work for the user (read: nobody will do it, actually
nobody do it currently) and less convenient for reviewers (who have no
way to check whether the build passed).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
