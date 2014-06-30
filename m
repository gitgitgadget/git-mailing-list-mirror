From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature verification
Date: Sun, 29 Jun 2014 23:14:43 -0700
Message-ID: <xmqqzjguzzxo.fsf@gitster.dls.corp.google.com>
References: <20140613080229.GJ7908@sigill.intra.peff.net>
	<539ACA8A.90108@drmicha.warpmail.net>
	<20140613110901.GB14066@sigill.intra.peff.net>
	<xmqqbntw4u4d.fsf@gitster.dls.corp.google.com>
	<20140616195428.GB24376@sigill.intra.peff.net>
	<xmqqk38gpp9v.fsf@gitster.dls.corp.google.com>
	<20140616203956.GA3546@sigill.intra.peff.net>
	<53AD640A.9060006@drmicha.warpmail.net>
	<53AD685A.1030401@drmicha.warpmail.net>
	<xmqqwqc219og.fsf@gitster.dls.corp.google.com>
	<20140628003246.GA13228@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 30 08:15:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1Url-0006EZ-2F
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 08:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbaF3GO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 02:14:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61349 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbaF3GO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 02:14:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ADC611D1B9;
	Mon, 30 Jun 2014 02:14:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p5gHIQtWIWR8WRG2RwOceKRvmGs=; b=j65rE5
	TIqWXEYi/Zih6+2BlCTajBvoOHiet3VWjImPCuZljcxJNcaWs+lamwJSG2APG9aD
	X9AUuC0SDvIRlaazzwx1eXWp7IAaV1yk1ZvQ3jeb/5i9NObS8bjeqvDxbh3+4lPS
	f8LaCdnp48jTChaGDlNhgqm7N/19Z6L3hg42o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mtfmihWwwBm2W7lZ7owgeGYLBiiE1L02
	Lk5f16pTLyHRQV4Wqt4au/7Eb9euno00OPF+xn7A8xIZrmBUKX7rDtqa2D3XzkB8
	60Xug1sk5szDU1E2i2HVfpQWjaWUwWHwD/8Q5zLad7cL5JMz5CuBcaWFqDMpa7Jj
	nQ+VfF66bGQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A300A1D1B8;
	Mon, 30 Jun 2014 02:14:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C13081D1B4;
	Mon, 30 Jun 2014 02:14:36 -0400 (EDT)
In-Reply-To: <20140628003246.GA13228@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 27 Jun 2014 20:32:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CFC88822-001D-11E4-9EE2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252652>

Jeff King <peff@peff.net> writes:

> First off, I agree that "verify-tag" is probably not the right place.
> There _is_ no tag object to verify anymore (the only reason it is a tag
> at all is that the signature came out of what once was a tag).

Yes, if we imagine that the header were called "mergesig", it may be
more apparent what it is.  Similar to the commit signature itself
(which gives GPG protection over the commit itself), a "mergesig"
covers one of the parent commit object name recorded in the commit.

You could look at it as one aspect of the child commit object being
verified, and that is why I would suggest it is the responsibility
of verify-commit that is run on the child commit (I saw suggestions
to verify other aspects such as "author ident matches the GPG signer
of the signature on the commit itself", etc.)

> Let us imagine that we have a "verify-commit" that verifies commit
> signatures made by "commit -S". If I run "verify-commit foo", that
> implies to me two things:
>
>   1. I am verifying the signature over the contents of "foo".
>
>      But the mergetag is _not_ a statement about "foo"; the person who
>      signed it never saw "foo". It is a statement about foo^2 at best,
>      or possibly about the whole history of foo^1..foo^2.
>
>   2. I am verifying _only_ the contents of foo. That is, I expect people
>      to use "commit -S" to cryptographically claim authorship of a
>      commit. Whereas with tags, I think we have typically taken them to
>      mean "I have signed the tip of a segment of history, and I am
>      taking responsibility for the final state" (e.g., signing release
>      tags).

I think you are making it too hard ;-).  Fundamentally, a signature
on a commit object itself _can_ be used to attest _some_ property
about the whole history behind it by the signer, but it does not
prevent a project from adopting a lot looser convention.  If a
project's stance is "commit signature in this project is about the
contents of the tree" (i.e. the signer does not have much confidence
in his memory on how he got there), the result from verify-commit on
the signature of the commit itself should be interpreted in the
context of such a project as such---the signer is confident that the
tree matches what he signed and the signature wouldn't mean any more
than that.

>      I realize that this claim is somewhat tenuous. It's not something
>      inherent in the crypto, but rather in the social convention of what
>      it means to sign a commit.

Yup, I think we are on the same page.

>      But I would ask, then: what
>      is the point of signing a commit versus signing a tag?  I think
>      that people who wanted commit signatures wanted them to give a
>      stronger guarantee of authorship of individual commits.

There are practical concerns.

 - tags are easier to manage because you can make a commit, give it
   out for trials by guinea pigs and then after it proves good, you
   can add a signed tag after the fact without rewriting the commit
   itself.  Incidentally, this is the primary reason behind the
   design of mergetags that were introduced after the k.org break-in
   fiasco.

   Theoretically you could have argued that lieutenants can sign the
   commits they want Linus to pull and we wouldn't have had to add
   anything to the system to support the new "not only we can use
   third-party publishing sites that we do not know how much we can
   trust, such as GitHub, we do not even have to trust k.org blindly"
   workflow.  But they really wanted to be able to commit first,
   let time pass and then sign to request pulling.

 - tags are a lot more cumbersome if you want to sign each and every
   commit (which some of us view as pointless, given the chain of
   SHA-1 hashes our history storage is based on), because you end up
   having to name, keep and transfer O(n) refs to represent them for
   the history of project of size n.  Embedding signature in each
   commit would be the only workable way if somebody wants to sign
   each and every commit.

>      Git has largely stayed agnostic about what such signatures mean.
>      But if we accept that some projects _are_ going to make that
>      distinction, I think conflating verification of the two within the
>      same command leads to a potential for confusion.

I agree that the users and scripts must be able to inspect the
validity of "gpgsig" and "mergetag"(s) separately.  When you inspect
a merge commit, if gpgsig verifies but mergetag does not, we know
that the integrator created and signed the merge but we do not know
if the lieutenant whose name appears on the mergetag really asked
the side branch to be pulled, or if the merge was made in response
to a request by an imposter.  For that matter, when verifying an
octopus merge, we must be able to see the validity of "mergetag" for
each parent separately.  We can do that by having two separate
commands (one to verify "gpgsig", the other to verify "mergetag"),
or we can do that with a separate command line options to a single
command ("verify-commit --gpgsig" and "verify-commit --mergsig <n>")
or a single "verify-commit" may report multi-values to its output
for scripts to parse.  I do not have a strong opinion.
