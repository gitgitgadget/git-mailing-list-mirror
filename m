From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] commit: Show the committer ident when is different
 from the parent
Date: Thu, 01 May 2008 12:02:51 -0700
Message-ID: <7vd4o5zw2s.fsf@gitster.siamese.dyndns.org>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com>
 <1209545236-4266-4-git-send-email-sbejar@gmail.com>
 <20080430145017.GA922@sigill.intra.peff.net>
 <20080430163701.GA6544@sigill.intra.peff.net>
 <8aa486160804301223w574fe425n5d0678020ff1e7b4@mail.gmail.com>
 <20080430192639.GC30344@sigill.intra.peff.net>
 <8aa486160805010134l4746f9afhec546a9d49fd7a6d@mail.gmail.com>
 <20080501135109.GA10135@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 01 21:04:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jre4Q-0006tU-4a
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 21:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762863AbYEATDG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2008 15:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762800AbYEATDG
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 15:03:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762575AbYEATDF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2008 15:03:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A779449B9;
	Thu,  1 May 2008 15:02:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BC86649B2; Thu,  1 May 2008 15:02:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 37610C90-17B1-11DD-AF01-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80931>

Jeff King <peff@peff.net> writes:

> On Thu, May 01, 2008 at 10:34:44AM +0200, Santi B=C3=A9jar wrote:
>
>> >  > 1) the committer ident is different from the parent
>> >  > 2) the committer ident is set automatically
>> >
>> >  Honestly, I think just "2)" is probably fine (where automatically
>> >  presumably means "from GECOS"). I see what you are trying to acco=
mplish
>> >  with "1)", but it's so workflow specific as to be useless.
>>=20
>> I don't see "1) as workflow specific, it is there to minimize the
>> number of time it is shown, ie somebody might prefer the automatic
>> ident, so as long as it does not change it is not shown.
>
> Yes, but whether it actually succeeds in minimizing is dependent on t=
he
> workflow of the user. I.e., it works great if I tend to build on smal=
l,
> personal repositories (or topic branches), or if I tend to receive ot=
her
> people's work by patches that I commit myself. But if I am pulling fr=
om
> somebody else's repo (as many of us do from git.git), or if I use a
> shared repo with the other committers, then I am very likely to be
> building on a parent that was committed by somebody else (and
> consequently will see the committer mentioned way more often than was
> intended).

The goal of the patch as I understand it is to prevent mistakes of
committing under a wrong committer ident, isn't it?  Why does "minimizi=
ng"
come into the picture?

Once you have a good algorithm to see when to trigger the warning that =
the
user might be using an unintended committer identity, I do not think yo=
u
should refrain from issuing the warning when you see the offending
committer ident and whose commit you are building on top of should not
affect it.  Otherwise, the user will get the warning once (or not even =
get
the warning because the commit was made with a "commit -s -m 'typofix'"
one liner), and keep using the wrong ident without noticing before
building up a long chain of commits.  If the identification algorithm i=
s
bogus, that would result in too many false hits to be annoying, and in
that case, (1) I would not apply such a bogus algorithm until it gets
into reasonable shape, (2) we would improve it after it gets applied an=
d
if still makes noise on a hopefully rarer false positive cases, and/or =
(3)
the warning will be accompanied with a suggestion to explicitly use
user.name and/or user.email in the configuration file to allow the user=
 to
squelch it.

I think the other patch about showing the author when you are committin=
g
other's changes is a good move, by the way.
