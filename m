From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Tue, 09 Nov 2010 07:59:03 -0800
Message-ID: <7v4obqo5dk.fsf@alter.siamese.dyndns.org>
References: <9D675671-693D-4B59-AF2A-0EFE4C537362@sb.org>
 <7vpqufpr7f.fsf@alter.siamese.dyndns.org>
 <4F75AA0C-B68A-4ABB-B67A-D7F62D989655@sb.org>
 <20101109051631.GA19867@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 09 16:59:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFqbQ-0006qF-K1
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 16:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320Ab0KIP7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 10:59:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0KIP7O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 10:59:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D089383D;
	Tue,  9 Nov 2010 10:59:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XUHION68VVqwNdTu9iDBgaJjHDM=; b=fixJ1G
	DmzYHepUjcjzh1CRaKIebNuuHv931TRfQuw0crxyKcZoBhCIOZRA+q12ep0G99vV
	LUoTrfFgZhRYPz9L5Z9A9qVcLPW6ENhyPKccQ7lWfOxYgDERKxDYRBPoFvvvcjmS
	X7GvpgckP2YvOeHV0sNhnBkHIB7mgbAVtvbZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nnfkx0nE74cg/eE8i97ZHgAfVC7XgMdX
	hj+VWI3qEVZ5IrKdhYEP7LxDWOwNkqL2rDuGvaWLpoByr0IA9/P6ESSUlJ6Tm5nb
	OBySo8MByG7BMNnS7NKC/BT+8o6N7cE9Sighcu9704mAEWGJnlMcM4QTaU3aejkz
	EnO8GJxAwBU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B595383C;
	Tue,  9 Nov 2010 10:59:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 10428383A; Tue,  9 Nov 2010
 10:59:07 -0500 (EST)
In-Reply-To: <20101109051631.GA19867@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 9 Nov 2010 00\:16\:31 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B660E4E-EC1A-11DF-A42F-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161055>

Jeff King <peff@peff.net> writes:

>> Any comments on my suggestion to specify the ref to search from, e.g.
>> origin/pu:/"Merge 'kb/blame-author-email'"? As I stated before, I believe
>
> It seems to me the natural way to do that would be to use our existing
> generic "start at this ref and follow some chain" syntax, which is
> ref^{foo}. For example: origin/pu^{:Merge 'kb/blame-author-email'}.
>
> We already use it for "follow tree link" and "peel tag objects", and it
> is syntactically similar to the usual "follow the ancestry chain" syntax
> ("ref^"). And I believe it should be unambiguous, as nothing that could
> go in ^{} could start with ":". And presumably one would have to
> backslash-escape embedded closing curly braces.

Yeah, that may make more sense but I think the operation specifier should
be '/', not ':', no?

We chose ':' as a "funky SHA-1 expression introducer" that can be followed
by other letters to specify what kind of funkiness is being summoned (in
the case of ':/string', you are asking for "search" funkiness), so that we
can extend it with different kind of funkiness later.  That is where my
earlier ':(...)' came from.

> We also have ref@{upstream}. The analogue here would be
> origin/pu@{:Merge 'kb/blame-author-email'}.
>
> I don't recall whether we put any conscious thought into ref@{upstream}
> versus ref^{upstream}.

I think that is because it is nonsensical to say sha1@{u} for an arbitrary
SHA-1 expression (i.e. the operator only makes sense for a branch ref we
can find branch.*.merge for).  So from that perspective, you are right
that "Start from this commit and find an ancestor whose log message
contains this string" goes well with "sha1^{/some string}"
