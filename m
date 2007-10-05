From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Question about "git commit -a"
Date: Fri, 05 Oct 2007 14:45:40 +0200
Message-ID: <vpq641livbf.fsf@bauges.imag.fr>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
	<545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>
	<fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>
	<Pine.LNX.4.64.0710042209410.4174@racer.site>
	<4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
	<4705FB52.3030208@op5.se>
	<4d8e3fd30710050206h7a177472x7c92f91204b15aa4@mail.gmail.com>
	<47060BB3.3030208@op5.se>
	<4d8e3fd30710050519k7a3db02dk5ba9750fd8e9705f@mail.gmail.com>
	<47062CD7.70400@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 05 14:46:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdmZP-0002Q8-Uz
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 14:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003AbXJEMqJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2007 08:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755605AbXJEMqI
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 08:46:08 -0400
Received: from imag.imag.fr ([129.88.30.1]:38289 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbXJEMqH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 08:46:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l95CjeSE022865
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 14:45:40 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IdmYm-0003sn-Ab; Fri, 05 Oct 2007 14:45:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IdmYm-0002fJ-84; Fri, 05 Oct 2007 14:45:40 +0200
In-Reply-To: <47062CD7.70400@op5.se> (Andreas Ericsson's message of "Fri\, 05 Oct 2007 14\:23\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 05 Oct 2007 14:45:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60077>

Andreas Ericsson <ae@op5.se> writes:

> He. It's like comparing a duracell battery to the sun, but yes, that'=
s
> one of the operations where the index is involved. But after doing yo=
ur
> git-add thing above, you could also have continued hacking on A B C D=
,
> and git would only have committed the state where you did "git add".
> When you stop to think about this, you'll realize that it's a really
> powerful thing, as it lets you keep on hacking even when you don't
> really know where you'll end up.

That usage is indeed very close to a micro-micro-throwable branch.

Instead of doing:

<hack>
<diff>
<commit>

<hack>
<diff>
<commit>

# Oh, gosh, I didn't want that! | # Yes, _this_ is what I want
$ git reset --hard HEAD^^       | $ git checkout HEAD^^
                                | $ git merge --squash HEAD@{1}
                                  (untested)

You'd do:

<hack>
<diff>
<add>

<hack>
<diff>
<add>

# Oh, gosh, I didn't want that! | # Yes, _this_ is what I want
$ git reset --hard              | $ git commit

The two flows are both similar and different. In the first case, you
can't come back to an arbitrary step within your development, but
since you didn't actually commit, and just ran "add", it's precisely
because you thought this state was not one you wanted to come back to
later. And at the time you commit, you don't have to tell git to
forget about the temporary branch, the succession of "git add" was
just for you, not to keep in history.


Actually, most of the time, I commit only when my index matches the
working tree (i.e. when status shows me only green, with color.status
=3D auto), so "commit" or "commit=A0-a" don't change the result, but I
validate my own changes with "add", and give the whole thing a
descriptive message with "commit".

--=20
Matthieu
