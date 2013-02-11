From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segfault for git log --graph --no-walk --grep a
Date: Mon, 11 Feb 2013 12:55:51 -0800
Message-ID: <7vr4kmlgdk.fsf@alter.siamese.dyndns.org>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
 <7va9rexqii.fsf@alter.siamese.dyndns.org>
 <20130211191607.GA21269@sigill.intra.peff.net>
 <7v621ymxfv.fsf@alter.siamese.dyndns.org>
 <7vvc9ylh97.fsf@alter.siamese.dyndns.org>
 <20130211204142.GA28248@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Haller <thom311@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 21:56:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U50QG-0005pc-Ex
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 21:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416Ab3BKUzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 15:55:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34819 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932184Ab3BKUzy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 15:55:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 884F9B280;
	Mon, 11 Feb 2013 15:55:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tE/VzT+/D0Su56HiiSHYVkOlasI=; b=WR0Pgd
	mVhmdgnG6biTuVPFQDvbQSL3ZKTj+LSIAVi93CPd8Qqz3my0u5SjbIS7kSiv+4+8
	prJX931X2QyrGQ/te7j4iC27AXUJ0YYKWui0jeTJNOUpIU/U300s9pVo1cxc5c++
	0NV1xFeFBs0fM7ArK6ZG6TZMfA05Ji5UlPPRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YwcCKqw5Htd0wR2F2oHnGJeBHqLPFyDV
	wmbL3ZtK+wmYJ6dnL7bXa4n8c0h5TVo+Amv5zZJp9PQNDkqiJAdgTFg6iCXDVwls
	cs18W0YSjhhxFRzJeM8dwKY8cvJwwV7n+2fViLDvhu+NDV0EZB2Pu52e484pXTjg
	yMEjpEWPE9M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CC0FB27F;
	Mon, 11 Feb 2013 15:55:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9644B27D; Mon, 11 Feb 2013
 15:55:52 -0500 (EST)
In-Reply-To: <20130211204142.GA28248@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 11 Feb 2013 15:41:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C284CDE-748D-11E2-92AB-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216085>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 11, 2013 at 12:36:52PM -0800, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Jeff King <peff@peff.net> writes:
>> >
>> >> On Fri, Feb 08, 2013 at 04:47:01PM -0800, Junio C Hamano wrote:
>> >>
>> >>> > Yeah, that actually is a good point.  We should be using logmsg_reencode
>> >>> > so that we look for strings in the user's encoding.
>> >>> 
>> >>> Perhaps like this.  Just like the previous one (which should be
>> >>> discarded), this makes the function always use the temporary strbuf,
>> >>> so doing this upfront actually loses more code than it adds ;-)
>> >>
>> >> I didn't see this in What's Cooking or pu. We should probably pick an
>> >> approach and go with it.
>> >>
>> >> I think using logmsg_reencode makes sense. I'd be in favor of avoiding
>> >> the extra copy in the common case, so something like the patch below. If
>> >> you feel strongly about the code cleanup at the minor run-time expense,
>> >> I won't argue too much, though.
>> >
>> > Sounds good to me.  Care to do the log message while at it?
>> 
>> Heh, how about this?  I still need a sign-off from you.
>
> I'm working on the log message and tests right now. There's also a minor
> code fixup needed to compile with -Wall.

Thanks; I noticed the constness issue around the message variable as well.

>
>>     log --grep: look for the given string in log output encoding
>>     
>>     We used to grep in the raw commit buffer contents, possibly pieces
>>     of notes encoded in log output encoding appended to it, which was
>>     insane.
>>     
>>     Convert the contents of the commit message also to log output
>>     encoding before looking for the string.  This incidentally fixes a
>>     possible NULL dereference that can happen when commit->buffer has
>>     already been freed, which can happen with
>>     
>>     	git commit -m 'text1' --allow-empty
>>     	git commit -m 'text2' --allow-empty
>>     	git log --graph --no-walk --grep 'text2'
>>     
>>     which arguably does not make any sense (--graph inherently wants a
>>     connected history, and by --no-walk the command line is telling us
>>     to show discrete points in history without connectivity), and we
>>     probably should forbid the combination, but that is a separate
>>     issue.
>
> I'll use bits of that. I had sort of punted on the "how to reproduce the
> segfault" issue entirely because you had noted that it was not a sane
> thing to do. Still, I think it makes sense to mention it with the caveat
> you give here.
>
> -Peff
