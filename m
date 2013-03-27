From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rename conflicts in the index
Date: Wed, 27 Mar 2013 12:44:57 -0700
Message-ID: <7v38vgmxty.fsf@alter.siamese.dyndns.org>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com> <7va9q72n1u.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0AA7A@TK5EX14MBXC253.redmond.corp.microsoft.com> <7vboa6t14w.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0BA54@TK5EX14MBXC253.redmond.corp.microsoft.com> <7vk3osn3vs.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0BB93@TK5EX14MBXC253.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Edward Thomson <ethomson@microsoft.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 20:45:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKwHv-0004jr-BZ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 20:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129Ab3C0TpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 15:45:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64034 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907Ab3C0TpC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 15:45:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 774EAAFE9;
	Wed, 27 Mar 2013 15:44:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b2fWDchYazlwlh7pZsGJfNYZpNU=; b=EiiYu6
	tvQYoIB00ghKYqqh9U/k67+P26B84ZM3fc0p6fu2Me5I+mLZl8plOmHSyNl2j4gV
	a5yOxLdAtN88IldYW3ODNghjFxRWXFTOp9ttU7MQCio5iZe4zU3Y+bYY1yJYWZ1F
	SD+psWN6vIr5LJAut9JXNe156JINQh1gUL27A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IvING6EPSVhy0pYWeBqyEIJYFfBjj2pE
	wjj5maKLZtLfk271zgYh8eOn4CB+YFo4zwE+SzfVXbok/3MZplJ1m3bncb7xXFxx
	kspGn2d9mN4+w0jV+BXW1nvVyMx7Aflx+RDy31I1uhDJS+7/B1qxV94fhAI2vLsl
	BDxWK46LG3o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BDCEAFE8;
	Wed, 27 Mar 2013 15:44:59 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADE50AFE6; Wed, 27 Mar 2013
 15:44:58 -0400 (EDT)
In-Reply-To: <A54CE3E330039942B33B670D971F857403A0BB93@TK5EX14MBXC253.redmond.corp.microsoft.com> (Edward Thomson's message of "Wed, 27 Mar 2013 18:53:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEAF2084-9716-11E2-AB4A-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219311>

Edward Thomson <ethomson@microsoft.com> writes:

> Junio C Hamano [mailto:gitster@pobox.com] wrote:
>> We do not gratuitously break existing implementations.  If no conflict is stored
>> as higher-stage index entries in an index that has your index extension, no
>> existing implementation can read a conflicted index written by your
>> implementation and have users resolve conflicts.
>
> I'm not suggesting that anybody stop writing >0 stage entries.

Ah, OK, then I misread your original message.  You said

> Having a single canonical location is preferable - if the index
> contains a CONF section (and the client supports it), it would use
> that.  Otherwise, the client would look at stage >0 entries.

which I read as "an index with this extension would not have higher
stage entries, an index without the extension records higher stage
entries".  As long as the format will be backward compatible to
allow existing users use existing tools to deal with cases the
existing tools can handle, then that is OK.  I didn't get that
impression which is where my "non starter" came from.

> What you've described is true only for a certain class of rename conflicts,
> for example the rename/edit conflict you've described above.

As you asked me to explain why it was a non starter, I only
illustrated with a "renamed trivially, with content level conflict"
example that shows why dropping higher-stage entries in the main
index would not be acceptable.  The previous message did not even
mean to cover any cases the *new* feature you have in mind is trying
to address.  Again, if it hurts existing users handling cases
existing tools used to handle, that makes it a non starter.

How new feature is designed, and extension is added to help that new
feature, is a different matter.  My original "That's a non starter"
message didn't even go that far.

In any case, the principle of "always record the state 'merge'
stopped to ask for help as higher stage entries to give existing
tools and users a chance to manually resolve, and augment with
optional extension to record additional information that might help,
but do not gratiutously waste bytes on redundant information" would
apply to other exotic cases you would want to tackle with the new
feature, I would think.

If one branch moves path A in the original to path B and the other
one moved it to path C, for example, we can record it in different
ways, even in the main index.

 * Path A may have only stage #1, while path B and C has only stage
   #2 and stage #3 (the user would have to notice these three
   correspond to each other, and resolve manually).

   You would want to annotate "B at stage #2 seems to have been at A
   in the original" (similarly for C#3) if you choose to do so.

 * You can choose to favor "our" choice, and have path B with three
   stages (if we guessed wrong and the user wants to move it to C,
   the user can resolve and then "git mv" the path).

   You would want to annotate "the other side wanted to have B at
   stage #3 at C" in that case.

 * Or you may want to have in the main index both B and C (but not
   A) with all three stages (the user would have to choose which
   one survives, but discarding the other side with "git rm" would
   be easy).

   You would want to annotate the origin of the stage #1 for path B
   and C (these were originally at A), stage #2 for B (the other
   branch wants to have it at C), stage #3 for C (we want to have it
   at B).

There may be other ways, and I do not offhand know what the current
merge-recursive implementation does, but both of the latter two
sound equally usable and reasonable ways, even without the
annotation.  And with your annotation that records different paths,
the conflict may become even easier to resolve.

I still do not need to duplicate <mode, SHA-1> in the extensions to
do the above, or do I?

If the original path A was removed and a new path B was added, with
contents that are modified from A beyond recognition, at the merge
time you wouldn't know where B it came from or where A went, so
annotating A at stage #1 to say "it went to B" is a nonsense.  If
you have algorithm to do so [*1*], you would be better off detecting
it as a rename.


[Footnote]

*1* Instead of a three-way merge that inspects only the endpoints,
    you might get a better rename trail if you looked at the
    histories of both branches.  It would be a lot more expensive
    than the simple three-way, but burning CPU cycles is better than
    burning human neurons.
