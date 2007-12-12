From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Invalid dates in git log
Date: Wed, 12 Dec 2007 01:35:08 -0800
Message-ID: <7vejds8ddf.fsf@gitster.siamese.dyndns.org>
References: <34660cca0712120111k3f11769fk1a8cefda3b82683e@mail.gmail.com>
	<20071212092304.GA20799@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eirik =?utf-8?B?QmrDuHJzbsO4cw==?= <eirbjo@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 10:35:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2O0N-0002bM-MG
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 10:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbXLLJfZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 04:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbXLLJfZ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 04:35:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59511 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbXLLJfZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 04:35:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 686B366DB;
	Wed, 12 Dec 2007 04:35:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A62B66D9;
	Wed, 12 Dec 2007 04:35:15 -0500 (EST)
In-Reply-To: <20071212092304.GA20799@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 12 Dec 2007 04:23:04 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68023>

Jeff King <peff@peff.net> writes:

> On Wed, Dec 12, 2007 at 10:11:12AM +0100, Eirik Bj=C3=B8rsn=C3=B8s wr=
ote:
>
>> My questions are:
>>=20
>> 1) Is this a problem in the Git software?
>
> No. Whoever made the commit probably just didn't have their clock set
> right. Git doesn't generally care about the timestamp for its
> operations; it just records it as a historical note.

"git show -s" with --pretty=3Dfuller and --pretty=3Draw on these two
commiits reveal:

    Author:     Ursula Braun <braunu@de.ibm.com>
    AuthorDate: Thu Jan 1 01:00:01 1970 +0100
    Commit:     Jeff Garzik <jeff@garzik.org>
    CommitDate: Fri Oct 19 23:00:02 2007 -0400

    author Ursula Braun <braunu@de.ibm.com> 1 +0100
    committer Jeff Garzik <jeff@garzik.org> 1192849202 -0400

    Author:     Len Brown <len.brown@intel.com>
    AuthorDate: Fri Apr 5 00:07:45 2019 -0500
    Commit:     Len Brown <len.brown@intel.com>
    CommitDate: Tue Jul 12 00:12:09 2005 -0400

    author Len Brown <len.brown@intel.com> 1554440865 -0500
    committer Len Brown <len.brown@intel.com> 1121141529 -0400

So the former commit was made while seting GIT_AUTHOR_DATE explicitly t=
o
1, which is quite likely a bug in some script Jeff used to create this
commit about two months ago.

I have no idea about the latter, though.  It looks like quite a random
timestamp, and committer timestamp look reasonable, relative to the
other commits around it.

=46or a short while, between Nov 11th to Dec 8th this year on 'next' (a=
nd
between Dec 4th and Dec 8th on 'master'), git-commit-tree accepted an
empty GIT_AUTHOR_DATE and recorded a bogus "0" time in the commit by
mistake, but such a commit would have shown something like:

    author A U Thor <au.thor@example.com>

without any timestamp, and both commits predate the gotcha, so I do not
think they are caused by that recent breakage.
