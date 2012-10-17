From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: mention --notes in more places
Date: Wed, 17 Oct 2012 14:50:06 -0700
Message-ID: <7vsj9cn4z5.fsf@alter.siamese.dyndns.org>
References: <1350443975-19935-1-git-send-email-eblake@redhat.com>
 <20121017055136.GA12301@sigill.intra.peff.net> <507EB310.8020904@redhat.com>
 <20121017190507.GA17648@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <eblake@redhat.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 17 23:50:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TObVQ-0003te-UF
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 23:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab2JQVuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 17:50:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61936 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407Ab2JQVuK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 17:50:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 653A881EE;
	Wed, 17 Oct 2012 17:50:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jvnp+f0SHDWTpbF+H6vFHRSujhM=; b=O4HhhL
	exLYrkLt/swzCYyOvd76Y8gKwLs3B9T/3ARiLJ+R3dRHruexZcwBN8ZZb542rP0r
	NgzVnE+leSdp8BQHu0yas5+pym17b12GU8eODfmjMOom4/bWdEtwul3/BWyGJx3Y
	Mx93xCCDKlIfpglhYYlrX+AG8JAP5ig1EmN1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H9naYctrj4aPEwcPmZDBvkisc1l+K+/J
	k3HoHTVv2euSL0G3vo+WQeObBS2pXIYmUr+jdw4CvKdMocMdi4P9MK6tO/OQXQet
	VzFICKI5jPVgFiL7/CJiBQ+zJfjrlSYkZt1XI6tzp1wgBBAifzoS8buHEhJryUiG
	e1ToeKlbzm8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5349C81EC;
	Wed, 17 Oct 2012 17:50:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD37581E8; Wed, 17 Oct 2012
 17:50:07 -0400 (EDT)
In-Reply-To: <20121017190507.GA17648@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 17 Oct 2012 15:05:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DE3A402-18A4-11E2-AC97-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207942>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 17, 2012 at 07:30:56AM -0600, Eric Blake wrote:
>
>> > We've talked about it several times, but it's never happened (probably
>> > because most people don't actually use notes).
>> 
>> And people (like me) don't use notes because they aren't documented.
>> Catch-22, so we have to start somewhere.
>
> Oh, I definitely agree your patch is the right direction. I was just
> explaining why it hasn't happened, even though people think it's a good
> idea.
>
>> I'll submit a v2 with the non-controversial edits, and spend some time
>> trying to figure out how to isolate the portion of pretty-options.txt
>> that is relevant to format-patch.  If it's easy enough, I can also
>> consider using --- instead of Notes: as the separator when using
>> format-patch.
>
> Hmm. After digging in the archive, it seems we (including both you and
> me!) have discussed this several times, and there are even some patches
> floating around. Maybe one of them would be a good starting point for
> your submission (I did not read carefully over all of the arguments for
> each):

Thomas's oldest one looked like a good starting point but we've
gained a codepath to spit out the contents of notes since then, which
probably needs to be killed at least for this codepath.

A few problems I noticed while looking at log-tree.c and pretty.c

 * pretty_print_commit() shows notes at the end of existing
   message.  There is no provision for the callers to affect what
   comes between the existing log message and the notes text.

 * show_log() has the "add-signoff" that appends a sign-off after
   whatever pretty_print_commit() gives.

Taken together, they make it unnecessarily cumbersome to inject a
new sign-off and "---" between the log message and notes.

The easiest is to add another parameter to pretty_print_commit that
is inserted immediately after the log message before notes are
appended.  That way, we can update show_log() to first format
additional sign off (if needed) and then "---\n" (again, if needed)
to a new strbuf and pass it as the new argument when calling the
pretty_print_commit() function.
