From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: Introduce --patience config variable
Date: Wed, 07 Mar 2012 09:24:18 -0800
Message-ID: <7vobs8nx31.fsf@alter.siamese.dyndns.org>
References: <a87ed689ddfb06601dd639541199fc72d829bdaf.1331031473.git.mprivozn@redhat.com>
 <20120306114914.GB6733@sigill.intra.peff.net>
 <7vlindp17d.fsf@alter.siamese.dyndns.org>
 <20120307114714.GA14990@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Privoznik <mprivozn@redhat.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 18:24:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5KbL-0003Ef-D9
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 18:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403Ab2CGRY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 12:24:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34616 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932246Ab2CGRYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 12:24:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C91C36AC0;
	Wed,  7 Mar 2012 12:24:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/OXLXTjrBj+KDJ/rETOsx4Iljtw=; b=jUbj4O
	9LK5cjaswAmTuGKJD7mb/B8PKEfPlvar92zT2M28je1SvrxNwEyYK+Dl8rKlzWW3
	LtqbBMno4dNFCmepFwOmG6C8wG11w4J2Luc+q5ioer5TgHHkYVX9ItbQ+S40oliF
	81aQPeeHARDoSAUNdlAYnEovZReQvudntTAiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jPAWYUfvHhJFKAmOJKhUHCD90XP5Xwyl
	fvDVoIMz7fIjYmqOb1DIDHXSR4RUR3cnB2bLbpMovDuDxK7TaOhp0gT5JuQCNd3L
	U4a9ZGj9ELsRJFvh0eoc8DGHMbTb+abMgAGnIXwNFm1rdr1cPw4mHCbsM/Jh3qzP
	g1Ymbne+YBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFE3E6ABE;
	Wed,  7 Mar 2012 12:24:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DEAA6ABB; Wed,  7 Mar 2012
 12:24:20 -0500 (EST)
In-Reply-To: <20120307114714.GA14990@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 7 Mar 2012 06:47:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FF965B2-687A-11E1-9AAB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192465>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 06, 2012 at 06:57:42PM -0800, Junio C Hamano wrote:
>
>> > The idea of turning on patience diff via config makes sense to me, and
>> > it is not a problem for plumbing tools to have patience diff on, since
>> > patience diffs are syntactically identical to non-patience diffs.
>> 
>> Even though I do not strongly object to the general conclusion, I
>> have to point out that the last line above is a dangerous thought.
>>
>> If you change the default diff algorithm, you will invalidate long
>> term caches that computed their keys based on the shape of patches
>> produced in the past.
>
> I see your point, though I don't think I'd use the word "dangerous" to
> describe the invalidation of a cache.

I probably was not writing clearly enough to avoid getting misread.
The "dangerous" does not refer to "invalidation of a cache".  What I
meant was that "The output is syntactically identical, so it is OK"
is a dangerous way to think when assessing the risk of regression,
because applying to a given preimage and producing the same
postimage is not the *only* way the output is used.

I think the executive summary is that we are in agreement; your
analysis of potential regression coming from differences of the
shape of the patch output (not applicability to a given preimage to
produce the same postimage) seems to match what I said in the
previous message.

Especially in the kup case, it is a minority tool used by people who
knows or can be easily taught in a tightly controlled environment,
and it is fine as long as the users have a way to make sure two
diffs run on both ends of the communication produce the same result
(in an earlier discussion on k.org users list where kup was first
discussed, the limitation of users having to use the same version as
k.org has was noted and the users are already aware of it).
