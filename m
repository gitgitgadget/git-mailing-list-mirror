From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Fri, 04 Feb 2011 14:39:08 -0800
Message-ID: <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net>
 <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Feb 04 23:39:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlUJR-0006bO-DC
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 23:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085Ab1BDWj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 17:39:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab1BDWj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 17:39:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A38C94ACB;
	Fri,  4 Feb 2011 17:40:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6lTEUACbqnwHHyZvRYYrNpW8GPE=; b=jiSwj/
	hg1vxvZAd++O3p6xX8E4t3eVj3fG5kKhK8S8cPn/3Zm4EACJAjF8+q8IccFssy1L
	fZ0LKC5XAqfs8lisYMXZL2f3z2SPvoLHqcKbTrhHEDE6wAXFW7tXQGfrmLS1oJxL
	u3Tw/mzKgNNdQvIH/fAroUemAyVi1q29QhVhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hIz/qAgOMuK5pmqB426Mqfc8VeRfG7vr
	2XRJHGeyXqPGg70+FPrBwGEJ1at2sU9R0yF73WOsHA1+DCSOGpWc9bBH9210geOI
	xJojOj8ktx9JdTrIig+Qi4dHnCnPPLDBfi1kOGqD6PoD/HlnXhsBU+zolwpt6SlY
	M8OzDGufbic=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4148D4ACA;
	Fri,  4 Feb 2011 17:40:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5119A4AC2; Fri,  4 Feb 2011
 17:40:05 -0500 (EST)
In-Reply-To: <201102020322.00171.johan@herland.net> (Johan Herland's message
 of "Wed\, 02 Feb 2011 03\:21\:59 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BAC8DD32-30AF-11E0-869E-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166062>

Johan Herland <johan@herland.net> writes:

> - Remote tags are now stored separate from local tags. When looking up a 
> shorthand tag name (e.g. v1.7.4), we should consult local tags 
> (refs/tags/v1.7.4) before remote tags (refs/remotes/*/tags/v1.7.4 [1]). See 
> [2] for more details.

> - Remote heads have moved into refs/remotes/$remote/heads/*, hence 
> invalidating shorthand remote head names, like "origin/master". We should 
> change the lookup code, so that a shorthand ref of the form "$remote/$head" 
> where "$remote" happens to match a configured remote is eventually expanded 
> into lookup for "refs/remotes/$remote/heads/$head" [3].

Keeping 'origin/next' usable is a _must_, _if_ we were to go this route.

> - We might want to generalize the handling of "$remote/$head" into allowing 
> shorthands like "$remote/$tag", "$remote/$replace" and "$remote/$note" as 
> well (provided, of course, that they match unambiguously).
>
> - All fetch refspecs should be given explicitly.

What do you mean by this?

> Sub-proposal: While we are changing the default refspecs, we should also 
> consider whether we want to keep the auto-following behavior that Git 
> currently does for tags (don't fetch tags that refer to objects not 
> otherwise fetched by another refspec). If we simply make an explicit 
> "+refs/tags/*:refs/remotes/$remote/tags/*" refspec, we will lose the auto-
> following behavior. If we do want to keep the auto-following behavior, we 
> could for example add a "~" prefix to the refspec to trigger auto-following 
> behavior (i.e. this refspec only applies to refs that happen to point at 
> objects fetched by way of a different refspec). See 
> http://thread.gmane.org/gmane.comp.version-control.git/160503/focus=160795 
> for more details.

You seem to envision "auto-follow" to slurp remote tags in remotes/origin/$tag
namespace.  What should "git fetch --tags $from_there" do?

For some reason, many people seem to be enthused about splitting the tag
namespace, but I am not sure if that is a good thing in general.  Branches
are moving pointers for people to flip around in their local repositories,
and it makes sense to say "My master is a bit ahead of the public one",
but what would we gain by making it _easier_ to add and exchange many tags
with the same name (e.g. refs/remotes/*/tags/v1.7.4 vs refs/tags/v1.7.4),
other than the extra confusion?

While you are talking about drastic reorganization (and rewriting the ref
code to support it), another possible Sub-proposal we may want to consider
is to allow "next" and "next/foo" at the same time.
