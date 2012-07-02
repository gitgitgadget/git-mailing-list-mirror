From: Junio C Hamano <gitster@pobox.com>
Subject: Re: MERGE_RR droppings
Date: Mon, 02 Jul 2012 00:10:07 -0700
Message-ID: <7vmx3i3agg.fsf@alter.siamese.dyndns.org>
References: <CABURp0omkVoLrz29GeOjjoZOpN238Rm6Nu5aOKQyVxFVnPihsw@mail.gmail.com>
 <CABURp0os2no40BW0P-biG_fXyi7MHRcLLYWmCbLTdBv1o1OXcg@mail.gmail.com>
 <7v395ic5kq.fsf@alter.siamese.dyndns.org>
 <CABURp0qr7dZfEJZ7oDfG4ftm+cvQO1A9OG4Cv0wid3Mz8j7-iA@mail.gmail.com>
 <CAJDDKr5w2Q6aJcF48WbVyS=q54+iq=RAu9njJ18Wv8=OEbSrnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 09:10:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlamQ-000399-2J
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 09:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438Ab2GBHK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 03:10:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932428Ab2GBHKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 03:10:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 640E562EE;
	Mon,  2 Jul 2012 03:10:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mhGR4feJ0ratdjA2bAXMGYyQazU=; b=b2MwO/
	/fUEpxGXNsBTpvEcpte0UUbpZ5ywXlyoovA/T+vAdjcDShTx5Ne8lG0xuwlxd4Q/
	zdmgRtjsmueFkoh46JLftGpx52Tm6FIdnT2jpnqqdI3DpMkvF3Wg3cfegPt8Bst2
	Xx/YC26RvE0blPqpp+XHblaRHOSHxlA2WuXBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rdubjO81TmR70ngfdPl5BLDB13sg1FYc
	8DHTrWLLBsYgkgH/yZ7mpOPWp3BV7II4TTkdDpzHfqZL8SRt5xPqox84AdFWaoQp
	A2v61TdYq5TDMg8hRfPC3fMUDY2aEr5JIS2AfnIQtxJqhrgRHJntKDlTBwFTUTBo
	5vnK+jh0BqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A70462ED;
	Mon,  2 Jul 2012 03:10:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C478662EB; Mon,  2 Jul 2012
 03:10:08 -0400 (EDT)
In-Reply-To: <CAJDDKr5w2Q6aJcF48WbVyS=q54+iq=RAu9njJ18Wv8=OEbSrnQ@mail.gmail.com> (David
 Aguilar's message of "Sat, 30 Jun 2012 17:19:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5174948-C414-11E1-B2ED-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200845>

David Aguilar <davvid@gmail.com> writes:

> We can have a "default" unmerged files provider that does the
> `test -s .../MERGE_RR` check since that would probably deal with
> this ugly edge case.
>
> We can then teach this default thing to be smarter and skip text files
> with no merge markers. Junio, is this what you were thinking?
> This sounds like a nice way to me.

I am not sure what I were thinking ;-) so let me think aloud.

In any case, once the user says (either via directly using "git add"
or using the command via the mergetool) the path is resolved,
mergetool would no longer want to touch it, until the user says
"oops, the resolution was a mistake; pleae make it unresolved again"
with something like "git checkout -m".  So in this message, I'll
think only about the case where the index is still unmerged.

The working tree files may be in one of these states:

 1. It may still be the same as the conflicted state after the
    three-way merge proper gave the user, perhaps with conflict
    markers in the text.

 2. rerere or some other mechanism (this includes manual editing or
    previous run of "mergetool") may have resolved the conflict
    fully.

 3. Or such a mechanism may have only half-resolved the conflict.

As far as I can see, the mergetool machinery, once it decides to
feed a path to the mergetool backend, ignores what is in the working
tree file, and uses the stage #2 (i.e. the state before merge
happened) as LOCAL (and stage #1 as BASE, stage #3 as REMOTE) to
redo the entire three-way merge from scratch.

So "ask rerere what it hasn't resolved" would only safely work for
the first kind, where the state in the working tree file is known to
be expendable.

If it can somehow determine paths that have been fully resolved, it
can (and should) skip redoing the three-way merge.  And that is
probably what the "if test -s MERGE_RR; then rerere remaining; fi"
logic under discussion is about.

But that will still risk losing any half-resolution done by external
means (the third category), including manual editing.  Is that a
good thing?

Perhaps there were two conflicting hunks and one of them the user
has resolved manually, and then the other one was a bit more complex
than the user wanted to resolve in the editor and that is why the
user is now running "mergetool" to resolve it in a GUI.  "rerere"
will say "I didn't touch that path", and "mergetool" will happily
ignore user's manual resolution of one hunk in the working tree, and
the user ends up redoing the whole three-way merge for the path, no?

Even if you switch that logic from "asking rerere" to "look for
conflict markers", it wouldn't change the story.  Perhaps "rerere
remaining" was a useless addition, and instead we probably should
have a way to ask "rerere" if the working tree file is different
from what the mergy operation left before "rerere" tried to work on
it?  If it is unchanged, then we know nobody (either the user, any
third-party mechanism, or rerere) touched it and it is safe for a
mergetool backend to redo the three-way merge from scratch (i.e. we
know that is in the first category).

Otherwise, you are risking to stomp on the change that may have been
done between the time the mergy operation was done and "mergetool"
was started.
