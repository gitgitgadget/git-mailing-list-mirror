From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] reject @{-1} not at beginning of object name
Date: Thu, 28 Jan 2010 12:02:53 -0800
Message-ID: <7vsk9qknf6.fsf@alter.siamese.dyndns.org>
References: <20100128094446.GA14244@coredump.intra.peff.net>
 <20100128095643.GC14253@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 28 21:03:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaaaP-0008IO-Td
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 21:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370Ab0A1UDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 15:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754369Ab0A1UDH
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 15:03:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357Ab0A1UDF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 15:03:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CB7795453;
	Thu, 28 Jan 2010 15:03:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DcGjvqZ6w2LYqMr+Is8fTX7nZTw=; b=pHz5JS
	R/jdtSqdXHfvWM/73SnGjGcKvUC9eK6Oq5GIeNKAN/RvIwAMZEmBysmzdMUY3gt1
	Kq9Xo1Eheudla1IfCXNid6Rj0AnNc4ld1IExYeQSSnbHZLQ5NDb1F4ifnnZ1Cupz
	JAyQxxB/W/FUmcW9r4F0CSBEUVgXtzSkJlZsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FH693BkP7PSiGjgqCqRKpxxEeWXXWdR3
	v4RxztSmc+CZDxK3gmKVtWvTTpVJ3OwFDdFDzpK30k0+nTHxS0vYhiqyCMRbV6C0
	5vzIUIaSaHli3BBpZaVq6Uw0pa4wWCZ5Y9nP2ANSPgfhC85wlx/pbQTHaJiVbSzk
	fb7ieLopaJc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F10649544F;
	Thu, 28 Jan 2010 15:02:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D963D9544C; Thu, 28 Jan
 2010 15:02:54 -0500 (EST)
In-Reply-To: <20100128095643.GC14253@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 28 Jan 2010 04\:56\:43 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2272D394-0C48-11DF-BA0E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138264>

Jeff King <peff@peff.net> writes:

> Something like foo@{-1} is nonsensical, as the @{-N} syntax
> is reserved for "the Nth last branch", and is not an actual
> reflog selector. We should not feed such nonsense to
> approxidate at all.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> We didn't discuss this one, but I came across it while trying to be
> complete in testing the combinations. Right now "foo@{-1}" is
> interpreted as a reflog entry at approxidate "-1". Approxidate doesn't
> signal an error because it thinks it has found something useful. But
> AFAIK we have declared all @{-...} to be Nth last branch, so it is
> simply a semantic error.
>
> Let me know if that is not the case (that is, if it was intentional to
> leave foo@{-1} as the reflog at date "-1" because it has some meaning
> that I am missing) and we can drop this patch.

I think the patch is fine as is.

We might want to use @{-some string that has non digit} for other purposes
and it may be a safer change to tweak the "do we only have digits" check
in the post-context to detect and reject only @{-<all digits>}.

But what I am puzzled by the code structure of get_sha1_basic(), which
looks like this:

    get_sha1_basic() {

     - do we have @{...} at end?  If so, and if it is not a magic like
       @{u}, set "len" (points at the end of stuff that should name a ref)
       and "reflog_len" (the length of the reflog time/num specifier that
       is applied to that ref).

     - did we find @{...} in the above check, and is it at the beginning?
       Then it is not a reflog syntax, but is a N-th branch switch.
       Substitute that @{...} with the real refname and retry.  If it is
       not @{-N}, then that @{...} reflog derefence should apply to the
       current branch, so set it to real_ref and go to "reflog" part.

     - if we have @{...} at the end, get the canonical name of the ref the
       reflog notation is applied to.

     - otherwise, get the canonical name of the ref; in this case,
       there is no @{...} at the end, si this is what is eventually
       returned.

     - "reflog" part:
       by now, real_ref holds the ref @{...} is being applied to.  Read
       from its reflog.

   }

And the place that parses @{-1} and @{u} are different, even though both
dwim_log() called by the third one and dwim_ref() called by the fourth one
call substitute_branch_name() and they are perfectly capable of resolving
@{-1} and @{u} (and even nested stuff like @{-1}@{u}@{u} with your patch).

But somehow we kept the special case code to parse @{-1} in the second
one.

    Side note.  I am wondering if dwim_log()'s current implementation is
    even correct in the first place.  When you have two "ambiguous" refs,
    it appears to me that you will get a warning from dwim_ref(), but if
    only one of them has a reflog associated with it, dwim_log() won't
    complain.  Why isn't the function be (1) dwim_ref() to find the ref
    from abbreviated refname given in str; and then (2) check if the log
    exists for that ref?

It might be cleaner if the logic went like this instead:

    - find the last @{...} in the string that is not what i-b-n should
      resolve (i.e. @{-1} and @{u}); that is @{time/num} reflog
      reference.  You can have at most one reflog reference and it always
      has to come at the end.

    - feed the remainder to (an updated) i-b-n that knows how to grok:

      - @{-N} is nth-priour checkout; it has to come at the beginning and
        you can have at most one.  If you find it, substitute it with the
        real branch name and continue. (e.g. @{-1}@{u} becomes master@{u})

      - does it begin with @{...}?  If not, the part before @{...} is the
        name of the ref (e.g. "next" in "next@{u}@{u}") the later magic
        sequence (e.g. "@{u}@{u}") is applied to; otherwise apply the
        magic to what HEAD points at (e.g. "@{u}" applies @{u} to the
        current branch).  Remember that ref and strip it away from the
        input.

      - while we see sequence of @{...}, apply the magic to the ref
        repeatedly (e.g. "next@{u}@{u}" has remembered "refs/heads/next" in
        the previous step, and @{u} is applied to produce "master" if next
        follows master, and then applying @{u} to that result will tell us
        that it follows "refs/remotes/origin/master").

    - now we have what ref the caller was talking about with the beginning
      part of the input (i.e. without "@{time/num}" at the end).  If we
      had @{time/num} in the original input, open the reflog and find an
      appropriate entry in it.  Otherwise what we received from (the
      updated) i-b-n is what we found.  Find out what object the ref
      points at.

But that is a kind of code churn that may not be worth doing.  I dunno.
