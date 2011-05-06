From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] status: display "doing what" information in git
 status
Date: Fri, 06 May 2011 11:24:03 -0700
Message-ID: <7vaaez1yd8.fsf@alter.siamese.dyndns.org>
References: <7vr58c4sip.fsf@alter.siamese.dyndns.org>
 <1304667535-4787-1-git-send-email-madcoder@debian.org>
 <7vei4b20we.fsf@alter.siamese.dyndns.org> <20110506173656.GA2872@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri May 06 20:24:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIPhJ-0003BP-IY
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 20:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602Ab1EFSYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 14:24:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280Ab1EFSYL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 14:24:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8DD54910;
	Fri,  6 May 2011 14:26:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zNeHbWEMdf/UhBrPNLjXu/a2LVc=; b=J9rN13
	cL/ODJyP668sV56SzmN1fxv9lSqBbaxsifU35phHgqC0BZG/yGuDtMoRVaYQBKSf
	ijfgZHGvM08lUJek5ZN3n2SR6Wi3XnJTBpQav88MhlxelqGEXTgEY3kMw0MGJAdL
	6aAaIG+hSa+WqyxKxlnW4OJTwpVHkpW8EzXH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JRXTL3o7SRL4ERiMH0muy57uSwcAgtF3
	HmPjGRXXkdRdp539ztWokCPkhXM5AeWnhAoC3rumu/9XJ3X2BfaWleIFBVLhworD
	v+SsgJjIXfHBS0KNrrZ26OURzl/FKcJfUXfN/aDHjiQZigijo2yJGxb58xKDGW/N
	4JCwsdJr4oM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 84C92490C;
	Fri,  6 May 2011 14:26:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D1134908; Fri,  6 May 2011
 14:26:08 -0400 (EDT)
In-Reply-To: <20110506173656.GA2872@madism.org> (Pierre Habouzit's message of
 "Fri, 6 May 2011 19:36:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51936B4C-780E-11E0-9818-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172996>

Pierre Habouzit <madcoder@debian.org> writes:

>> > +	const char * const rebase_advice =
>> > +		_("use \"git rebase --abort\" to abort current rebase or proceed");
>> > +	const char * const am_advice =
>> > +		_("use \"git am --abort\" to abort current mailbox apply or proceed");
>> 
>> If the reader does not even know that the "--abort" option is used to
>> abort, " or proceed" needs to be followed by "by doing $this", if it wants
>> to have any practical value.  I would suggest dropping it.
>> 
>> > +	const char * const merge_advice =
>> > +		_("use \"git reset --hard\" to abort, or resolve conflicts and commit");
>> This codepath being in wt-status.c, I wonder if any of these advices could
>> trigger to appear in the log message editor when the user tries to run
>> "git commit".  If so, I suspect any of the above is too late to help the
>> user, no?
>
> Well I'm not very happy with the advices, feel free to reword them in a better
> way.

I already suggested dropping it ;-)  Rewording to emptiness would be the
simplest and cleanest.

>> Also, should we make these conditional upon advice.status or something?
> they are
>                           vvvvvvvvvvvvvvvvvvv
>     +       if (advice && advice_status_hints) {
>     +               status_printf(s, color(WT_STATUS_HEADER, s), "");
>     +               status_printf_more(s, status_nobranch, "  (%s)\n", advice);
>     +       }

By the way, this change also breaks t7060, at least.
