From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Tue, 06 Dec 2011 10:20:01 -0800
Message-ID: <7vliqph8a6.fsf@alter.siamese.dyndns.org>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
 <CALkWK0mpPoZJWviBesWgy2dZ4xJrNyhED2znFid8iGbSTirPhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 19:20:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXzcl-0004x6-6V
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 19:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab1LFSUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 13:20:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60993 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484Ab1LFSUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 13:20:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75DF36C57;
	Tue,  6 Dec 2011 13:20:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Z9hVGWA7TPp3hMPiAe/Ed5rFvE=; b=vfSqmx
	SgyrlkCf9r7zn88ynlRdl0xRqc96gNSQNxqOwaAO61gnT8JjfZDp5QZJPAEriqpN
	d74ZfqWv5hlpLdZXriXqr6o7CnscfOllavfZuFEhnM2JgJf3v4R46I4/YgxTLNeZ
	UAyQ0mGtFpRvlDy1z8iR6GZ7YVEwmdZfFtu3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oZxRY7DSF9lEgFBqRlnlhD4ta/Fs4Qki
	DvRTvzmVoy6wfYQloGiZqYYSjj40QNrO3xsVSGDo24eQfEovwNooo2MV8HHuRuJ0
	pbayyUaiz2UcduBr7hqViB7YOYXxxn8WuiQn70AGDbJL3SyEhCGWaaUlkH0qtdk1
	/Tykc87ihck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6678B6C56;
	Tue,  6 Dec 2011 13:20:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC0726C54; Tue,  6 Dec 2011
 13:20:02 -0500 (EST)
In-Reply-To: <CALkWK0mpPoZJWviBesWgy2dZ4xJrNyhED2znFid8iGbSTirPhQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 6 Dec 2011 11:05:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA43D25C-2036-11E1-88E6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186365>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> 0. You can merge this into `master` resolving the conflicts: it's a
> fairly straightforward resolution.  As soon as you publish the new
> `master`, I can continue working on `rr/sequencer`.
> 1. I can post the `rr/revert-cherry-pick` to the list, hoping that it
> will make it to `master` without more disruptions.  I can rebase
> `rr/sequencer` on this new series and continue working.  For your
> reference, this [1] is what I'll be posting to the list if we pick
> this option.

Merging

    https://github.com/artagnon/git.git rr/revert-cherry-pick ;# 1b7c2632

and merging rr/revert-cherry-pick currently in 'pu' (6a156fd) to 'master'
results in identical trees, so I think these amount to the same thing.

A few comments and thoughts, all minor.

 * On "revert: simplify getting commit subject in format_todo()"

   The old code used to use get_message() on cur->item, checked its return
   value (if cur->item is not parsed, or has already been used and its buffer
   cleared, cur->item->buffer would be NULL and get_message() returns -1) and
   issued an error. The new code uses find_commit_subject without first
   checking if cur->item->buffer is NULL.

   Does this mean the old code was overly defensive, or is the new code too
   lax?

   I understand that parse_insn_line() uses lookup_commit_reference() which
   calls parse_object() on the object name (and if it is a tag, deref_tag()
   will parse the tagged object until we see something that is not a tag), so
   we know cur->item is parsed before we see it, so I suspect you merely were
   being overly defensive, but I may be missing something.

 * On "revert: make commit subjects in insn sheet optional"

   After finding the verb and advancing the pointer "bol" at the beginning of
   the object name, end_of_object_name variable points at the first SP or LF
   using strcspn(bol, " \n"), but I wonder why we are not grabbing a run of
   hexdigits instead, i.e. strspn(bol, "0123456789abcdef"). Is this so that
   we can allow something like "pick rr/revert-cherry-pick~3"?

   I also wonder if this should be (sorry for pcre) "(pick|revert)\s+(\S+)\s"
   instead, i.e. allow users with fat fingers to use one or more SP or even HT
   to separate the verb and the operand.

   The last test you added to 3510 in this patch runs test_line_count
   unconditionally, by the way.

 * On "revert: allow mixed pick and revert instructions"

   Reporting what we did not understand from parse_insn_line() is a good
   idea, but I think the line number should be reported at the beginning
   of the same line.

I'd say that I'd prefer queuing re-rolled patches posted on the list; I'll
discard the rr/revert-cherry-pick (6a156fd) from my tree.

Thanks.
