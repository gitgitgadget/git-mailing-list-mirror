From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Fri, 24 Aug 2007 23:10:05 -0700
Message-ID: <7vejhs6t6q.fsf@gitster.siamese.dyndns.org>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
	<20070823203246.GB3516@steel.home>
	<6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
	<20070824223338.GA13209@steel.home>
	<133074BD-C29D-437A-8533-96A601AFC294@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?VsOkaW7DtiBKw6RydmVsw6Q=?= <v@pp.inet.fi>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:10:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOoqe-0006oC-Vb
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 08:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbXHYGKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 25 Aug 2007 02:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbXHYGKM
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 02:10:12 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbXHYGKL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2007 02:10:11 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5EA9E127D10;
	Sat, 25 Aug 2007 02:10:29 -0400 (EDT)
In-Reply-To: <133074BD-C29D-437A-8533-96A601AFC294@pp.inet.fi>
 (=?utf-8?B?VsOkaW7DtglKw6RydmVsw6Qncw==?= message of "Sat, 25 Aug 2007
 08:37:36 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56621>

V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4 <v@pp.inet.fi> writes:

> On Aug 25, 2007, at 01:33, Alex Riesen wrote:
>
>>> That line will result in duplicate entries, if files are staged, an=
d
>>> the output of git-status is neater (but longer) in my opinion.
>>
>> That is because it _is_ two times different: between working directo=
ry
>> and the index, and between index and HEAD. git-status _will_ show yo=
u
>> the same for the same reason.
>>
>> Besides, why do you want to hide this "duplication"? It shows how th=
e
>> matters really are.

The whole argument of "two entries are dups" is showing that you
might be repeating past mistake of Cogito where hiding the index
from the user would make git somehow more user friendly.  It was
a laudable attempt, but did not really fly well in practice.

But the --only-tracked has a bigger issue.

Letting the user know about untracked files that should be
tracked is really important to avoid mistakes.  If the status
output is so cluttered for you to want an option like this, it
is hard to spot such a file.  I do not think disabling the
untracked output is a solution to the real problem.

You earlier said that you may not be able to add certain
untracked files to .gitignore --- can you elaborate?

I do not think the reason is you are too lazy to do so, nor you
are incompetent to understand the ignore pattern.  There is
something else, which might show that the current ignore
facility needs to become easier to use for _your_ use of _your_
repository.  I still do not see in the thread what it is yet.

=46or example, maybe the reason why you do not want to place them
in the .gitignore file is because the clutter are your random
wip temporary files, whose naming convention is personal to you
and does not apply to others.  Naturally, you do not want to put
such patterns to the tracked .gitignore file, which is for all
participants of the project.  In such a case, you would want a
facility to allow you to specify your personal ignore patterns
that is used in addition to the .gitignore file [*1*].

The particular example use case above is covered by an existing
facility, but there might be other valid reasons that you cannot
express your ignore patterns easily with existing facilities.
In which case, we need to know that, so that you and people in
similar situation as you are in can express the necessary ignore
patterns more easily, in order to reduce the risk of forgetting
to add new files.


[Footnote]

*1* Which already exists.  Put them in .git/info/exclude file.
