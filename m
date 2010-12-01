From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: Remove backward goto in read_craft_line()
Date: Wed, 01 Dec 2010 13:19:32 -0800
Message-ID: <7vwrnttcm3.fsf@alter.siamese.dyndns.org>
References: <1291230959-3894-1-git-send-email-ralf.thielow@googlemail.com>
 <20101201194441.GB27347@burratino> <7vaakputxs.fsf@alter.siamese.dyndns.org>
 <20101201203132.GB27845@burratino>
 <AANLkTinLuF74UKaTMNX84FJt+PNoKkkOr3LaXDSCFqdz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 22:19:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNu5h-0008Ei-U8
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 22:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553Ab0LAVTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 16:19:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab0LAVTn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 16:19:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D71C239A9;
	Wed,  1 Dec 2010 16:20:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5qwT7sA0+9z8fHHcNWjTPPo2ZJA=; b=LqWLA9
	Q72FzFUhtaB3DeDJs35HnoKoBJU8sW5Tr671V9r+JFqtD+aiFYPFdPr3keUoKZEJ
	XHuwUMCzPW7N5Jae31JlcQpnhZje/WQkJIum900HHCpRD4K/AP8PxoI994mmtMQ1
	nRQvjXsGlLKxqed02Bmh6QySqSn98iQF4XrHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FEolUoDiPwbv48JRYcogNxgauMXFQ+kL
	7QfcbPiMp4eej4dIEyw5o/gARYVNd1fonn4TNJOY9rK9abJpfsZVWFUsHcxhaqv/
	u8vV7IWg1L8WuL2Wlo0bziplcdDzn1ouBaltuBuJR2rd0SUTlF6KNFdzAK6LRnkW
	34HhjQ/sydI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C7C339A8;
	Wed,  1 Dec 2010 16:19:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 53EC939A6; Wed,  1 Dec 2010
 16:19:53 -0500 (EST)
In-Reply-To: <AANLkTinLuF74UKaTMNX84FJt+PNoKkkOr3LaXDSCFqdz@mail.gmail.com>
 (Ralf Thielow's message of "Wed\, 1 Dec 2010 21\:44\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BF8F77C4-FD90-11DF-B4DA-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162616>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

>> If "--show-c-function" output is the problem, perhaps we should know a bit
>> better about what C function header looks like?
>
> In fact the "--show-c-function" output is the problem. But I think that
> a change can't be rejected because of another issue.

Well, I never said anything about rejection nor acceptance.

> The style of placing "goto"-statements, which leave a function to the
> end of that is used in many other projects. And I think
> it's very usefull.

It is a good discipline to follow in general to place an exceptional case
at the end if you jump out of the general flow.  But because the affected
function was so small, its readability doesn't benefit very much from the
discipline (in other words, you knew about a good discipline, but applied
it to a wrong function).  The patch was small and obviously correct, so it
will not hurt, but it will not make the world greatly a better place,
either.

IOW, it was a "Meh" topic for me.

It was more important to discuss Jonathan's "leave SP at the beginning of
a goto label to please --show-c-function" from the maintainer's point of
view, as people may remember it as a rule and start sending patches that
follow it, which I will need to deal with in the future.  I do not think
that one is a good rule.

Now that we have dealt with that more important business of letting people
know that protecting goto labels with a leading SP is _not_ the rule ;-),
I am happy with this discussion.

And often I forget about the original issue when a discussion reaches this
stage of happiness.  So thanks for reminding me.

As I said, even though I do not think the particular function you touched
badly needs the discipline applied, it would not hurt, and it obviously is
the right thing to do (iow, if the function were written from day one in a
way your patch reorganized it, we would never accept a patch to change it
into today's shape of jumping backwards).  For one thing, it would remove
an example from the codebase people can point at to make excuses when
responding to a review of their patch that adds a backward goto to a much
larger function.

Will queue after massaging the log message somewhat.  Thanks.
