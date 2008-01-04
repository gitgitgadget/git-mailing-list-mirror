From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: [PATCH] git-am: Run git gc only once and not for every patch.
Date: Fri, 04 Jan 2008 22:08:58 +0100
Message-ID: <477EA06A.5090606@redhat.com>
References: <20080104185926.GA11912@redhat.com>	<alpine.LFD.1.00.0801041437190.2649@xanadu.home> <7vhchtjphk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 22:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAtwc-0000yB-Pd
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 22:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981AbYADVRd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jan 2008 16:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756157AbYADVRd
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 16:17:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59646 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756162AbYADVRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 16:17:32 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m04L90Zd026517;
	Fri, 4 Jan 2008 16:09:00 -0500
Received: from pobox.stuttgart.redhat.com (pobox.stuttgart.redhat.com [172.16.2.10])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m04L8xkM026790;
	Fri, 4 Jan 2008 16:08:59 -0500
Received: from argon.maulnet (vpn-4-29.str.redhat.com [10.32.4.29])
	by pobox.stuttgart.redhat.com (8.13.1/8.13.1) with ESMTP id m04L8waK001834;
	Fri, 4 Jan 2008 16:08:58 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7vhchtjphk.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69608>

Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
>=20
>> On Fri, 4 Jan 2008, Michael Stefaniuc wrote:
>>
>>> With "too many unreachable loose objects" git gc --auto will always
>>> trigger. This clutters the output of git am and thus git rebase.
>>>
>>> The work flow of the Wine project doesn't include git merge. git re=
base
>>> is therefor used to track the origin. This will produce soon too ma=
ny
>>> loose objects for git gc --auto's taste. Pruning the repository wou=
ld
>>> "fix" it. But we tell Wine developers new to git to NOT prune as lo=
ng as
>>> they aren't confident enough with git; just as a safety net in case=
 they
>>> have thrown away month of work.
>> The safety is the reflog.  What it refers to doesn't get pruned.
>=20
> What Nico said.
Not sure if you read my reply to Nico but the reflog is not there for
deleted branches. Nor for a cleared stash. Common operations where one
can loose work by mistake.

> More importantly, ones who are not confident with git would not
> be able to resurrect unreachables that are left unpruned anyway.
> The unreachables are by definition not connected to anything, so
> they cannot do much better than grepping through droppings left
> by "fsck --lost-found", which they probably even do not know how
> to do yet.
The smarter ones come and ask on irc. We helped a few people with git
problems on the Wine channels. Depending on the amount of time someone
put into his "lost" work grepping through "fsck --lost-found" might be
well worth it.

Nevertheless is there a reason why git gc needs to run after applying
each patch in git-am? Why can't it run just once at the end? git prune
is optional and there's no reason to penalize a user that doesn't feel
safe to run it by cluttering the output of git am/rebase. There is also
a time penalty: git gc --auto on a pruned tree runs so fast that it
isn't measurable but on my unpruned wine it took 1.5 seconds. Waiting
1.5 seconds per am/rebase is acceptable; wasting 1.5 seconds per patch
in the mailbox/rebase isn't that much fun if there are more than a
handful of patches to apply.

bye
	michael
--=20
Michael Stefaniuc                           Tel.: +49-711-96437-199
Consulting Communications Engineer          Fax.: +49-711-96437-111
--------------------------------------------------------------------
Reg. Adresse: Red Hat GmbH, Hauptst=C3=A4tter Strasse 58, 70178 Stuttga=
rt
Handelsregister: Amtsgericht Stuttgart HRB 153243
Gesch=C3=A4ftsf=C3=BChrer: Brendan Lane, Charlie Peters, Michael Cunnin=
gham,
                 Werner Knoblich
