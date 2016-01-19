From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there interest in a n-sect tool?
Date: Mon, 18 Jan 2016 19:54:21 -0800
Message-ID: <xmqqziw2b4wi.fsf@gitster.mtv.corp.google.com>
References: <20160118075653.GA13911@glandium.org>
	<xmqq1t9fe0qw.fsf@gitster.mtv.corp.google.com>
	<20160118085835.GA15642@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 04:54:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLNNE-0007Nj-Ej
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 04:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbcASDyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 22:54:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755740AbcASDyY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 22:54:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 786D23D511;
	Mon, 18 Jan 2016 22:54:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=aaoh0WYtycwbgSlXLaJcaWStIe8=; b=mZ/WKEFhO6blp8NpQQrx
	TA7tHWEDpbd1xOMI5YQpZjPu21ocLTEFwyNw+St29HNZ+bfDBfuxMoFS3EzduMmC
	L6KdmVYVLY8gp4HcfYr3fk11vsKscADUZbE+nmE1Gsr1u87HIoPms5IbDOkKc/te
	EvwrY7+FcB3U1BUNnzmHMXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oy4c77GT8dJk9gC6WWgm58rNTnYz9pbvgpmB9iv/T6U+OY
	AbAnJaKznXd7cDQ7kphVOe4TkmXOubNkMbfKH6F/zuqePUbuxLkvi/lTcA85k/LK
	BsWYUrZk863LAphIJLzXSvqGDGFbZGpeXjjqE4WXTqO48633aRdJ6izMbW52I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70B333D510;
	Mon, 18 Jan 2016 22:54:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DB2AA3D50F;
	Mon, 18 Jan 2016 22:54:22 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 53585350-BE60-11E5-8268-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284345>

Mike Hommey <mh@glandium.org> writes:

> On Mon, Jan 18, 2016 at 12:43:35AM -0800, Junio C Hamano wrote:
> ...
>> two).  If you have three states, black/gray/white, that linearly
>> transitions states twice (i.e. one part of the history is
>> continuously black, and at one boundary it turns gray and continues
>> to be gray, until at another boundary it turns white and continues
>> to be white to the other end), you would still "bi"-sect to find
>> these two transition points....
>> ...  Is that the kind of search you are talking about?
>
> Yes, it is. Somehow, I was thinking of the result once you're done
> bisecting, not the process itself of cutting history in two parts.

I am not sure what you meant by "Yes it is"; is the above (i.e. in a
history whose one part is painted continuously in black, one part
continuously in gray and the remainder in white where white and
black never touch, find the transition between black and gray and
the transition between gray and white) the kind of search you are
talking about?  Judging from the remainder of your message, I had an
impression that you are solving a different problem where you want
to find transitions for N distinct traits (i.e. 2^N combinations,
not N distinct colors like black-gray-white).

> That being said, while I can do these things locally with my own
> scripts, as a user, I would have found it useful if git bisect (and
> especially git bisect run) would support this out of the box. The
> question remains whether it would be useful to more people than
> just me.

Hmm, sorry.  For the two-trait example I gave (that can be extended
to N-trait), I can sort of see how the UI might look and I can say
it might be useful [*1*], but not with this, and especially that you
do not necessarily know all the traits whose transition points you
might be interested in a-priori--all of that makes the problem
definition fuzzy to me, and I cannot imagine what kind of user
interaction you would be envisioning to solve what kind of problem,
so I cannot even say it is a good idea or a bad idea.


[Footnote]

*1* I suppose a possible UI for the N-trait bisection might go like
    this.  You start from just a single trait (good for your test #1
    passing, bad for your test #1 failing).  You start with:

    $ git bisect start
    $ git bisect good A
    $ git bisect bad Z

    and Git would give you a commit (let's call it M) to test.  You
    test and find that test #1 passes, but at the same time you find
    that test #2 does not pass.  You do not know if test #2 passes
    or fails at A nor Z.  At this point, you would decide to call
    "test #2 passes" as good2, "test #2 fails" as bad2.  We now have
    two independent traits (good/bad and good2/bad2), and mark M as
    good and bad2:

    $ git bisect add-trait new/old/unknown=good2/bad2/unknown2
    $ git bisect state good bad2

    Then Git would check out another one (let's call it G) for you
    to test and you record the result from two tests.

    $ git bisect state good good2

    As you continue, Git will find the transition between good to
    bad (or it may find the transition between good2 to bad2
    earlier) and would tell you things like "commit F is the first
    bad commit" or "commit K is the first bad2 commit".

    If that is the kind of "out-of-box" behaviour for finding state
    transitions for N-traits simultaneously, I can say that may be
    interesting (note that interesting and useful are two different
    things ;-).

    If the cost to _prepare_ a revision to be tested is far greater
    than an incremental cost to perform one more test after the
    revision is already prepared to be tested, allowing a session
    like that might be an overall win and it could even be a huge
    win (i.e. imagine that compilation of the whole system to be
    tested takes very long, but once the binary to be tested is
    built, the time it takes to run each individual test is
    negligible---if you have ten tests in your test suite, even if
    you start out to find breakage in your test #1 like the above
    example, it may be more efficient if you test all ten tests, not
    just test #1, once you built the system to run test #1 for the
    purpose of bisecting to find the breakage of that particular
    test).

    But I am not sure that is the kind of problem you are trying to
    solve in the first place, so...
