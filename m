From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/8] upload/receive-pack: allow hiding ref hierarchies
Date: Tue, 05 Feb 2013 07:45:01 -0800
Message-ID: <7vwqumvk76.fsf@alter.siamese.dyndns.org>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <1359571542-19852-4-git-send-email-gitster@pobox.com>
 <20130205085047.GA24973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 16:45:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2ki9-00079P-UJ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 16:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805Ab3BEPpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 10:45:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55908 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755302Ab3BEPpE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 10:45:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ECA6BC78;
	Tue,  5 Feb 2013 10:45:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BP9V7BrybqEDf0qsibdCl1Z6pqs=; b=G4I48o
	xO4nfF03s0NehMsXYlTML96noivNalo566FrEa5MFTH/1Vhdrty7AdejN1hl5VZt
	pJqFO1yULeWqdtQdFG97dpMV9mGyWyomB1EQtkaoCF62gpLAaaSpr9KhjyzYtOmP
	yy59ovhjZ6Yeb6JVmWggrfzUeqLUngngROhjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U3umhJo//Pqozi1+N1XHAaERP63TEgZM
	6KvOWQJfg4WWOkA23OR/214BXPZk5FtB+U/vgtfLPetQuZSIaui13yH5ewQXYbZO
	2Fo1AUxJipGZcaQo7DnEDXcPSTFZfoRLSnF9W2bQvu6jfgMgbnK+sNUSDLGuyDsM
	IEIXCqnhjzQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 743D7BC77;
	Tue,  5 Feb 2013 10:45:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADC42BC76; Tue,  5 Feb 2013
 10:45:02 -0500 (EST)
In-Reply-To: <20130205085047.GA24973@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Feb 2013 03:50:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 015886EE-6FAB-11E2-9FEC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215505>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 30, 2013 at 10:45:37AM -0800, Junio C Hamano wrote:
>
>> Teach upload-pack and receive-pack to omit some refs from their
>> initial advertisements by paying attention to the transfer.hiderefs
>> multi-valued configuration variable.  Any ref that is under the
>> hierarchies listed on the value of this variable is excluded from
>> responses to requests made by "ls-remote", "fetch", "clone", "push",
>> etc.
>> 
>> A typical use case may be
>> 
>> 	[transfer]
>> 		hiderefs = refs/pull
>> 
>> to hide the refs that are internally used by the hosting site and
>> should not be exposed over the network.
>
> In the earlier review, I mentioned making this per-service, but I see
> that is not the case here. Do you have an argument against doing so?

Perhaps then I misunderstood your intention.  By reminding me of the
receive-pack side, I thought you were hinting to unify these two
into one, which I did.  There is no argument against it.

> And I
> have not seen complaints about the current system.

Immediately after I added github to the set of places I push into,
which I think is long before you joined GitHub, I noticed that _my_
repository gets contaminated by second rate commits called pull
requests, and I may even have complained, but most likely I didn't,
as I could easily tell that, even though I know it is _not_ the only
way, nor even the best way [*1*], to implement the GitHub's pull
request workflow, I perfectly well understood that it would be the
most expedient way for GitHub folks to implement this feature.

I think you should take lack of complaints with a huge grain of
salt.  It does not suggest much.

> Gerrit's refs/changes may be a different story, if they have a large
> enough number of them to make upload-pack's ref advertisement
> overwhelming.

This is probably a stale count, but platform/frameworks/base part of
AOSP has 3200+ refs; the corresponding repository internal to Google
has 60k+ refs (this is because there are many in-between states
recorded in the internal repository, even though the end result
published to the open source repository may be the same) and results
in ~4MB advertisement.  Which is fairly significant when all you are
interested in doing is an "Am I up to date?" poll.


[Footnote]

*1* From the ownership point of view, objects that are only
reachable from these refs/pull/* refs do *not* belong to the
requestee, until the requestee chooses to accept the changes.

A malicious requestor can fork your repository, add an objectionable
blob to it, and throw a pull request at you.  GitHub shows that the
blob now belongs to your repository, so the requestor turns around
and file a DMCA takedown complaint against your repository.  A
clueful judge would then agree with the complaint after running a
"clone --mirror" and seeing the blob in your repository.  Oops?

A funny thing is that you cannot "push :refs/pull/1/head" to remove
it anymore (I think in the early days, I took them out by doing this
a few times, but I may be misremembering), so you cannot make
yourself into compliance, even though you are not the offending
party.  Your repository is held responsible for whatever the rogue
requestor added.  That is not very nice, is it?

In an ideal world, I would have chosen to create a dedicated fork
managed by the hosting company (i.e. GitHub) for your repository
whose only purpose is to house these refs/pull/ refs (the hosting
site is ultimately who has to respond to DMCA notices anyway, and an
arrangement like this makes it clear who is reponsible for what).

The e-mail sent to you to let you know about outstanding pull
requests and the web UI could just point at that forked repository,
not your own (you also could choose to leave the outging pull
requests in the requestor's repository, but that is only OK if you
do not worry about (1) a requestor sending a pull request, then
updating the branch the pull request talks about later, to trick you
with bait-and-switch, or (2) a requestor sending a pull request,
thinks he is done with the topic and removes the repository).
