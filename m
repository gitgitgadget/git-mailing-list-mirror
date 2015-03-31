From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Tue, 31 Mar 2015 12:58:08 -0700
Message-ID: <xmqqd23pq6r3.fsf@gitster.dls.corp.google.com>
References: <20150302092136.GA30278@lanh>
	<1425685087-21633-1-git-send-email-sbeller@google.com>
	<xmqqr3t1vefz.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZBYFSwR6E86BF6Dt7xdh0zs07tkGnQAKfEJpSduTK-aw@mail.gmail.com>
	<xmqqr3szql9r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 21:58:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd2Ij-0000R5-IK
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 21:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbbCaT6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 15:58:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751587AbbCaT6K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 15:58:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB57E44CCB;
	Tue, 31 Mar 2015 15:58:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G5UCMJehaEoj67sFJT2bBTTxoXE=; b=fE4UtE
	eOKHtoGYVsRkI95QX88ohEQSh1aeBKuu0VvdHD7LuDmvS6/2Xy/HA4fYnOuc7Ulq
	07JEQXVjrcMMQuXriDXNfN+iHkrAdnyGQ1k9seoBu1LY8pFMKz/lwfip7bRY4X/v
	DuNXZMb9SswYk9Twot7ZZ6eDm5D/qz0UCTIg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eS+LMUHdCIiUvdWqzvNo/HynJzZMz5xl
	aRLHu429MsJg+wEsgFw5qw6wt2IYF0Z/dJjTJPZg0mwZjTK/2jmvRHai8R3sygo1
	eyurQVW/KuVdTQXeH1HmW5HX2rMbMfhb7sz77JVblfMtbtAwBkBthCzkfhZ2D7Ji
	CN8fn95upUk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3AE444CC9;
	Tue, 31 Mar 2015 15:58:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2762E44CC8;
	Tue, 31 Mar 2015 15:58:09 -0400 (EDT)
In-Reply-To: <xmqqr3szql9r.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 08 Mar 2015 13:36:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4109C312-D7E0-11E4-AD56-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266551>

Junio C Hamano <gitster@pobox.com> writes:

> I have a feeling that it is a bit too premature to specify the
> details at such a low level as "capaiblities are announced by
> prefixing four-byte 'c', 'a', 'p', ':' in front" and "a multi-record
> group has its element count at the beginning (or an end marker at
> the end, for that matter)", and it may be a better idea to outline
> all the necessary elements at a bit higher level first---that would
> avoid needs for useless exchanges like what we are having right now.
>
> ....  If you keep the
> discussion at the level like "fetch first asks capabilities it wants
> upload-pack-2 to enable, optionally gives the current shallow
> boundaries when the capaibilty says the other side supports it, and
> then starts showing what it has" while we are trying to achieve
> concensus on what kind of protocol elements we would need, and what
> information each element would carry, the discussion will help us
> reach a shared understanding on what to write down in EBNF form
> exactly faster, I would imagine.

And I see we went silent after this, so let's try to stir the pot
again to see if it simmers.

This is a follow-up on $gmane/264553, which is a continuation of
$gmane/264000, but instead of giving two required readings to
readers, I'll start with reproduction of the two, and add a few more
things the current protocol lacks that I would want to see in the
updated protocol.



The current protocol has the following problems that limit us:

 - It is not easy to make it resumable, because we recompute every
   time.  This is especially problematic for the initial fetch aka
   "clone" as we will be talking about a large transfer. Redirection
   to a bundle hosted on CDN might be something we could do
   transparently.

 - The protocol extension has a fairly low length limit.

 - Because the protocol exchange starts by the server side
   advertising all its refs, even when the fetcher is interested in
   a single ref, the initial overhead is nontrivial, especially when
   you are doing a small incremental update.  The worst case is an
   auto-builder that polls every five minutes, even when there is no
   new commits to be fetched.

 - Because we recompute every time, taking into account of what the
   fetcher has, in addition to what the fetcher obtained earlier
   from us in order to reduce the transferred bytes, the payload for
   incremental updates become tailor-made for each fetch and cannot
   be easily reused.

 - The semantics of the side-bands are unclear.

   - Is band #2 meant only for progress output (I think the current
     protocol handlers assume that and unconditionally squelch it
     under --quiet)?  Do we rather want a dedicated "progress" and
     "error message" sidebands instead?

   - Is band #2 meant for human consumption, or do we expect the
     other end to interpret and act on it?  If the former, would it
     make sense to send locale information from the client side and
     ask the server side to produce its output with _("message")?

 - The semantics of packet_flush() is suboptimal, and this
   shortcoming seeps through to the protocol mapped to the
   smart-HTTP transport.

   Originally, packet_flush() was meant as "Here is an end of one
   logical section of what I am going to speak.", hinting that it
   might be a good idea for the underlying implementation to hold
   the packets up to that point in-core and then write(2) them all
   out (i.e. "flush") to the file descriptor only when we handle
   packet_flush().  It never meant "Now I am finished speaking for
   now and it is your turn to speak."

   But because HTTP is inherently a ping-pong protocol where the
   requestor at one point stops talking and lets the responder
   speak, the code to map our protocol to the smart HTTP transport
   made the packet_flush() boundary as "Now I am done talking, it is
   my turn to listen."

   We probably need two kinds of packet_flush().  When a requestor
   needs to say two or more logical groups of things before telling
   the other side "Now I am done talking; it is your turn.", we need
   some marker (i.e. the original meaning of packet_flush()) at the
   end of these logical groups.  And in order to be able to say "Now
   I am done saying everything I need to say at this point for you
   to respond to me.  It is your turn.", we need another kind of
   marker.

 - The fetch-pack direction does the common-parent discovery but the
   push-pack direction does not.  This is OK for the normal
   fast-forward push, in which case we will see a known commit on
   the tip of the branch we are pushing into, but makes forced push
   inefficient.

 - The existing common-parent discovery done on the fetch-pack side
   enumerates commits contiguously traversing the history to the
   past.  We might want to go exponential or Fibonacci to quickly
   find an ancient common commit and bisect the history from there
   (or it might turn out not to be worth it).

 - We may want to revamp the builtin/receive-pack.c::report() that
   reports the final result of a push back to the pusher to tell the
   exact object name that sits at the updated tips of refs, not just
   refnames.  It will allow the server side to accept a push of
   commit X to a branch, do some "magic" on X (e.g. rebase it on top
   of the current tip, merge it with the current tip, or let a hook
   to rewrite the commit in any way it deems appropriate) and put
   the resulting commit Y at the tip of the branch.  Without such a
   revamp, it is currently not possible to sensibly allow the server
   side to rewrite what got pushed.

 - If we were to start allowing the receiver side to rewrite pushed
   commits, the updated send-pack protocol must be able to send the
   new objects created by that "magic" back to the pusher.  The
   current protocol does not allow the receive-pack to send packdata
   back to send-pack.

I'd like to see a new protocol that lets us overcome the above
limitations (did I miss others? I am sure people can help here)
sometime this year.
