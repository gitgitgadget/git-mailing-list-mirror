From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH]: reverse bisect v 2.0
Date: Mon, 03 Oct 2011 10:00:25 -0700
Message-ID: <7vfwjaggd2.fsf@alter.siamese.dyndns.org>
References: <20110929142027.GA4936@zelva.suse.cz>
 <20110930114220.GA742@zelva.suse.cz>
 <7v62k9q4oq.fsf@alter.siamese.dyndns.org>
 <20111003104112.GE16078@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Vyskocil <mvyskocil@suse.cz>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 19:00:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAlsY-0002eb-VP
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 19:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756949Ab1JCRAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 13:00:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46677 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456Ab1JCRA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 13:00:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12C065044;
	Mon,  3 Oct 2011 13:00:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=omXmFJX7Untw+EtQNMGIz/yPdQ8=; b=eepeea
	1tbfYW4vBLT/l1T1QA1VIttpz9S30OFhNyLUFzonV76y4A9CZngV0Id4OaO6WnBj
	HOKJP5mGY3WWW+2d8C7BIjj8+Mxh6Z8Ov9w6C594YhypgDtLqkCmKD6AlB322TmJ
	AfJz63h/JyCzolgjzHzLlXQKiRL3eHEl83vxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dDCtxJZJCKN0LeEMwOsqo1BW4spwZ7bC
	wfXNmdxHaROOeGXYsApKHJaCm0u7WaQSrPUWuwWHeXGRgCuHL6loD8Qx6sLJOKIC
	8AZVyobVs+spEXC08sDTpDCPIq+FnEkqkIjblq9Flm1vkPxbCWquYwy5BY/n+1wh
	KTLgfDNOtkI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 095CC5043;
	Mon,  3 Oct 2011 13:00:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64F9B5038; Mon,  3 Oct 2011
 13:00:27 -0400 (EDT)
In-Reply-To: <20111003104112.GE16078@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 3 Oct 2011 06:41:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31746A02-EDE1-11E0-8442-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182672>

Jeff King <peff@peff.net> writes:

> On Fri, Sep 30, 2011 at 11:13:25AM -0700, Junio C Hamano wrote:
>
>> I wonder if something along the following line would make the usage more
>> pleasant and self-explanatory:
>> 
>>     $ git bisect start --used-to='git frotz says xyzzy' v0.99 master
>>     Bisecting: 171 revisions left to test after this (roughly 8 steps)
>>     $ ... build and then test ...
>>     $ git bisect tested
>>     You are trying to check: git frotz says xyzzy
>>     Does the result satisify what you are trying to find [y/n]? yes
>
> I like this idea a lot. My "yes/no" thing was a "if I were designing
> bisect from scratch today..." suggestion, but having something like
> --used-to makes it a natural addition to the regular good/bad interface.
> And I really like the prompt to help people remember what it is they're
> declaring each time.

I forgot to clarify that "tested" was only to help users who wanted
reminder; if the user is confident with the usual "yes/no", the
interactivity is not required.

> However, --used-to feels a bit backwards to me. I think of it as
> "--has-property" or something similar.

I do not think --used-to='frotz says xyzzy' is a good phrasing at all; it
is grammatically incorrect. But --has-property has one large downside.  At
least --used-to makes it clear that the user is supposed to decribe the
property of the tree in the past.

Let's step back a bit to understand why I think this is not optimal.

The low-level "bisect" machinery is about bisecting a history whose
ancient commits have a property (e.g. "used to work" or "used to be
broken") and more recent ones does not have the property to find one
commit where the property is lost. Conceptually, this "property" does not
have any value judgement associated with it, but historically, we called
that property "good" (and lack of it "bad"), which caused confusion at the
surface level when looking for a recent fix. The user has to say "ah, this
is still broken and does not contain the fix---good" with a twisted mind.

To dissociate the value judgement from the "property", it is a good idea
to allow users to operate the bisect machinery without using "good/bad",
and "yes/no" is a good pair of words to use. However, the user still needs
to be aware of the fact that the "property" must exist in older history
and must be lacking in newer history.

"--has-property" strips the value judgement but does not surface this
crucial point to the UI. When the user wants to find a recent fix, the
property can be spelled in various ways: "it is broken", "it no longer is
broken", "it is fixed", "it works", etc.. We need to map the 'yes' answer
to 'bad' if --has-property=works is given and the user is looking for a
fix, not a regression. But --has-property does not explicitly tell the
user that the property must exist in the past and absent in the present.

My --used-to was an attempt to surface this "we are looking for a commit
that changed the condition that used to hold, but no longer holds for
recent commits" to the UI level and force "yes == observation consistent
with the older tree" and "no == new tree" interpretation, without a need
to map yes/no to good/bad or bad/good depending on what is hunted.

The alternative approach of "bisect start --reverse" was an attempt to
allow swapping this mapping. When reverse is in effect, "good" maps to
"observation consistent with the newer tree". I do not _mind_ mapping if
it turns out to be absolutely necessary, but I wanted to see if we can do
this without one.

> something appeared (be it a bug, a feature, or whatever). But I guess it
> depends on what you are bisecting. In my case, "yes" would be the
> current "bad", and "no" would be the current "good".

I think we are aiming for the same thing, but I think you are assuming
that a naive user would always describe the condition that used to hold
with --has-property without being told; I do not think that assumption
holds.
