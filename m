From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there interest in a n-sect tool?
Date: Mon, 18 Jan 2016 00:43:35 -0800
Message-ID: <xmqq1t9fe0qw.fsf@gitster.mtv.corp.google.com>
References: <20160118075653.GA13911@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jan 18 09:43:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aL5Pb-0000vl-He
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 09:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbcARInk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 03:43:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752489AbcARIni (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 03:43:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5FE9C3608F;
	Mon, 18 Jan 2016 03:43:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OcehZgKp12FGriLJAqdLC+BMc3w=; b=DoVSo5
	NuWaVw80IPnjfgGaeyoq7b2pipekKtLyfe1jtYJAaQ24R6FT+vVAPcQVyi2sxGBf
	cVeyAQDTJrYyJNoHCqhqTpAajoGhMtWJCEaCB8aljHXlrserorKrvHtM28GglIlm
	Ppa20bGZgNE+BdkXFheqMWZE91dxI9LTKm00s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WK08fRsyMhF3J+Vzqccv4UDruEaKoDzA
	I4rVPW+O+MAeh3m3DYwDEWebnXePsXkMR5GDLA+o8TiKwEluClCc3ktlc2dI7ikJ
	P6J/SFVQC2BxejnAzmBAnrjt+qNNZRz703DTt6vzfpzdHweX8XZCbEMHx1KK53wW
	kKLINGwoogQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 56E2C3608E;
	Mon, 18 Jan 2016 03:43:37 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CCB613608D;
	Mon, 18 Jan 2016 03:43:36 -0500 (EST)
In-Reply-To: <20160118075653.GA13911@glandium.org> (Mike Hommey's message of
	"Mon, 18 Jan 2016 16:56:53 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 90AFDB34-BDBF-11E5-B0B7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284281>

Mike Hommey <mh@glandium.org> writes:

> - I have a script that, for a given git-cinnabar commit, clones
>   those four mercurial repositories, and determines a global state
>   for the resulting repositories. (for example, the sha1sum of all
>   the sha1s of the remote refs for all repositories)
> - The script is run for the earliest commit and gives a sha1.
> - Then I bisect run with a script wrapping the other, returning 0
>   when the state is the same as the one for the earliest commit,
>   or 1 otherwise.
> - The result of that first bisection is the first state change.
> - Then I bisect run again, using the state of the result of that first
>   bisect instead of the earliest commit.
> - The result of that second bisection is the second state change.
> - And so on...
>
> I do, in fact, cache the states for each iteration of each bisect,
> so that I can do some smarter decisions than just start from the last
> bisection for the next one.
>
> I don't have that many state changes to track, but I do have different
> kind of states that I want to track down, so I will be running this
> a couple more times.
>
> The question is, is there sufficient interest in a generic n-sect tool
> for me to justify spending the time to do it properly, vs. just doing
> the minimalist thing I did to make it work for my use case.

After reading the above a few times, I still am not sure what you
mean by n-sect (as opposed to bi-sect), especially given that you
sounded as if you consider the straight "bisect" is about having
only two states, bad/good, new/old, or black/white.  "Bi" in the
word "bisect" refers to the search going by dividing the space into
two to find state transition, and does not necessarily mean there
are two states (hence implying a single state transition between the
two).  If you have three states, black/gray/white, that linearly
transitions states twice (i.e. one part of the history is
continuously black, and at one boundary it turns gray and continues
to be gray, until at another boundary it turns white and continues
to be white to the other end), you would still "bi"-sect to find
these two transition points.  You start from a black A and a white
Z, pick a midpoint M that tests to be gray and know the transition
point from black to gray exists somewhere between A and M, while the
other transision point from gray to white exists somewhere between M
and Z.  Is that the kind of search you are talking about?

Or you may be talking about a search where there are multiple (as
opposed to 1) independent bistate traits.  E.g. if you have two such
traits, perhaps you have four states in total: both bad (BB), the
first trait is bad and the second trait is good (BG), good and bad
(GB) and both good (GG).  You can tell which one of these four state
a given commit is in by running your test once.  You start from two
endpoints, one commit that used to give you GG (i.e. the system
wasn't broken for both) and the other that gives you BB (i.e. the
system is broken for both).

In such a case, in order to find a transition for the first trait to
go from good to bad (GG goes to either BG or BB), you can do the
straight bisection, but after finishing the first bisection, it
feels wasteful to do a similar bisection to find a transition for
the other trait to go from good to bad (GG goes to either GB or BB),
without taking advantage of what you already have learned from the
first bisection session.

Is that the problem you are solving?

If that is the problem you are solving, I think you actually can
reuse what learned in the first bisection directly when you start
your second bisection without changing the current system.  "git
bisect good" and "git bisect bad" takes zero or more commit object
names to mark that commit to be good or bad (they default to HEAD if
you do not give any), so when you start the second bisection run for
the second variable, you can tell "git bisect good" all the commits
that was good for the second trait you tested in the first bisect
run you did to find the breakage for the first trait, and similarly,
you can tell "git bisect bad" all the ones that you know are broken
with respect to the second trait.  After that, you would do the
straight bisection for the second trait.  If you have more than 2
traits that are independent and you can test at once, you would be
walking the graph painted in 8 colors, but the principle would be
the same.  The bisection run for the third trait would take
advantage of the knowledge you already have for many commits that
you have visited during the two previous bisection you did for the
first two traits.

I wouldn't call that n-section, though.  That's just n independent
bisections running in parallel.
