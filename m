From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to keeping track of cherry-pick?
Date: Tue, 20 Jan 2009 17:29:27 -0800
Message-ID: <7vfxjdjvk8.fsf@gitster.siamese.dyndns.org>
References: <497663E4.4000302@telenor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Knut Olav =?utf-8?Q?B=C3=B8hmer?= <knut-olav.bohmer@telenor.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 02:31:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPRvp-0006Uo-0k
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 02:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716AbZAUB3g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 20:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755050AbZAUB3g
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 20:29:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbZAUB3f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2009 20:29:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3187D1CE79;
	Tue, 20 Jan 2009 20:29:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 148031CE75; Tue,
 20 Jan 2009 20:29:29 -0500 (EST)
In-Reply-To: <497663E4.4000302@telenor.com> (Knut Olav =?utf-8?Q?B=C3=B8hm?=
 =?utf-8?Q?er's?= message of "Wed, 21 Jan 2009 00:53:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F4D8B81C-E75A-11DD-A0AE-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106555>

Knut Olav B=C3=B8hmer <knut-olav.bohmer@telenor.com> writes:

> svnmerge.py can give us a list of revisions available for merging. Th=
e
> result is similar to "git log --chery-pick master..dev" The differenc=
e
> is that svnmerge.py operates on revision-numbers, and --chery-pick lo=
oks
> at the diffs. The result of that is that when we get a conflict when =
a
> patch is cherry-picked, it will still show up as "available" when I r=
un
> "git log --cherry-pick master..dev"

I think you are looking at it a wrong way.

Because subversion (at least the older one) does not keep track of merg=
es,
you had to track cherry-picks.  But cherry-pick is not how you usually =
do
things in git.  You keep many topic branches with different doneness, a=
nd
you merge well-cooked ones to the more stable integration branch while
leaving others still cooking.  So what you want to know is not cherry-p=
ick
status, but merge status.

Because git tracks merges, output from "git log master..$topic" gives a=
ll
you need to know about $topic.  The command lists changes that are stil=
l
not merged to master on the $topic branch.  If it is empty, $topic is
already merged fully to master.  Otherwise you still have things to
merge.

To get a list of topics that have been merged (or not merged) to a
particular integration branch, you should be able to use "git branch" w=
ith
its --merged and --no-merged options.  This does not list what commits
each yet-to-be-merged topics have, though.
