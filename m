From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 12:46:54 -0800
Message-ID: <7vk5ni1fwh.fsf@gitster.siamese.dyndns.org>
References: <20071213055226.GA3636@coredump.intra.peff.net>
	<20071213090604.GA12398@artemis.madism.org>
	<20071213091055.GA5674@coredump.intra.peff.net>
	<20071213093536.GC12398@artemis.madism.org>
	<7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>
	<20071213180347.GE1224@artemis.madism.org>
	<1197570521.28742.0.camel@hinata.boston.redhat.com>
	<1197571656.28742.13.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 21:47:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2uy9-0005Ux-Qz
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 21:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757409AbXLMUrW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 15:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757399AbXLMUrV
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 15:47:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897AbXLMUrU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2007 15:47:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0075B81B6;
	Thu, 13 Dec 2007 15:47:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BBF58199;
	Thu, 13 Dec 2007 15:47:03 -0500 (EST)
In-Reply-To: <1197571656.28742.13.camel@hinata.boston.redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Thu, 13 Dec 2007 13:47:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68189>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> Oops, sorry about that.  I just wanted to say we shouldn't jump throu=
gh
> all these hoops to make the option parser support every type of optio=
n
> there ever was in the git command line ui.  A lot of these were proba=
bly
> decided somewhat arbitrarily by whoever implemented the command.
> Instead it's an opportunity to retroactively enforce some consistency
> and predictability to the various option-styles that have been
> hand-rolled over time in different git commands.

That principle is fine, but I do not think it is relevant to what is
being discussed.  The issue is what to do with a flag that can
optionally take a parameter but works fine without because it has a
default.

 * You can obviously disallow such a flag, and call the result
   "consistent".  I do not think we want to go that route.  --abbrev, -=
M
   (to diff) and -w (to shortlog) are good examples why this is a good
   thing.  You want to use the default most of the time, but want to be
   able to tweak the value sometimes.

 * You can alternatively require parameters to such a flag always stuck
   with the flag, which is what Pierre did.  I suspected that is
   introducing an inconsistency and may be confusing to the users ("I
   can write -n=3D1 or -n 2, but why not --abbrev 7???") and wanted to =
see
   if somebody can come up with a better alternative.

 * You can try to make the parser a bit more context sensitive by
   looking at the possible parameter and see if it is plausible, which
   hopefully would work for most of the real life cases (e.g. "--abbrev
   7 HEAD" vs "--abbrev HEAD").  I however agree with Pierre that "DWIM
   works most of the time" is not good enough if there is no way to
   disambiguate in cases that fall outside.
