From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sun, 13 Jan 2008 17:50:21 -0800
Message-ID: <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>
	<478855B5.9070600@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 02:51:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEETd-0003zj-UH
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 02:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810AbYANBug convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2008 20:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755552AbYANBug
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 20:50:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbYANBue convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2008 20:50:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 76C0D4B06;
	Sun, 13 Jan 2008 20:50:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A02AB4B05;
	Sun, 13 Jan 2008 20:50:28 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 13 Jan 2008 22:27:22 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70432>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I never understood why people want to complicate things by being able=
 to=20
> name default _keys_ differently.  Why not letting "origin" being the=20
> default being pulled from, and be done with it?

That happens to match my personal feeling.

HOWEVER.

We treat 'origin' in a special way when you do this:

	$ git clone somewhere new.git
        $ cd new.git
        $ git checkout HEAD^0
        $ git pull

And we already have "clone -o" and claim to support that option.
I think that it is very reasonable from the consistency point of
view to make sure that the following sequence treats 'frotz' the
same special way the above treats 'origin' specially:

	$ git clone -o frotz somewhere new.git
        $ cd new.git
        $ git checkout HEAD^0
        $ git pull

A purist alternative is to deprecate "git clone -o" and
eventually remove it.

Note that I was agreeing only with this specific aspect of the
argument.  I am not at all interested in getting involved in
refining or re-defining the existing submodule semantics this
late in the cycle before 1.5.4.  But I can very well see that
fixing this specific inconsistency can be separated out from the
rest of Mark's series and viewed as a set of trivially correct
fixes.

> Besides, I _really_ do not understand why we have such a
> discussion in rc phase.  There are _many_ more interesting
> discussions now that _also_ do not belong into a freeze phase.

Currently the ones I looked at and consider possible 1.5.4
material are http-push fixes from Gr=C3=A9goire Barbier and
parse_commit_buffer() tightening from Martin Koegler.

Recently I looked at the following patches and topics but I do
not think any of them belongs to 1.5.4.  None of them is obvious
and trivially correct fix to regressions or serious existing
bugs:

 * compress/decompress abstraction (Marco)

 * crlf (Steffen Prohaska and Dmitry Potapov)

 * whitespace error: "cr at eol is ok" (me)

 * various conflicting submodule changes(Ping Yin, Mark
   Levedahl, Imran M Yousuf)

 * unconfigured ident safety (Stephen Sinclair)

 * gitweb feed from commit to commitdiff (Florian La Rouche --
   Jakub seems to be on top of this so I am not worried about it
   too much).

 * color.ui (Matthias Kestenholz)

 * test scripts to use valgrind (Jeff King, but there was another
   one in the past -- can their efforts compared and coordinated
   better?).

 * various lstat(2) reduction changes (me).

 * pathname safety on insane filesystems (Linus, Robin
   Rosenberg, me).

(yes, some of the above list do not even have any code).

I am hoping that authors will resend the ones they really care
about after 1.5.4, as I do not want to take patches early.

Thanks.
