From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Mon, 22 Dec 2014 14:34:39 -0800
Message-ID: <xmqq38878gao.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:34:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3BYs-0004yr-Mb
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbaLVWem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:34:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751753AbaLVWel (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:34:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D169B29BD4;
	Mon, 22 Dec 2014 17:34:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4nJpiE+MduwuPgzsgmAWR1jHZgk=; b=dsz0JQ
	jzebKN0i3pTv99y2fH/7CGKtmY86yca+cHzinc8/Auv758b+Be/zy16wtCZ7rP2g
	xpROL+/t/BEFC6CGKek+WLi75CpxY/tCchopRQJe1hYIHcr2Jt03ITzCMhFIsMev
	PuuLmKeq1Bl8v9lQqzjO8nkI0QOOaZCi8C5NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uExceMeNae9edOU54yDzyGrNON/P+srt
	Og2pJsJ4cFKXKkgLTXUFzwR3aYd0rocoi5MiWyHd3igviYqMn9yjqj1cvpeMYQxn
	5igI+YPz2tXGb3p3qHCn/i0UilsW5uW08loa7LaJDsgKoSBadRfZHiRlzH77BbZD
	1Jk1tYLUQ98=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C74C229BD3;
	Mon, 22 Dec 2014 17:34:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49CBD29BD2;
	Mon, 22 Dec 2014 17:34:40 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Mon, 22 Dec 2014 23:25:08 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7B288E0-8A2A-11E4-9075-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261687>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Or do you want the error messages to also use camelCased IDs, i.e.
>
> 	warning in tag $tag: missingTaggerEntry: invalid format ...
>
> instead of
>
> 	warning in tag $tag: missing-tagger-entry: invalid format ...
>
> ? It is easy to do, but looks slightly uglier to this developer's eyes...

Do you really need to know what I think?  Can I say "The latter is
probably slightly better, but both look ugly to me"?

If we want a human readable message

    "warning: tag object lacks tagger field '$tag'"

would be my preference.

But I personally think it may not be necessary to give a pretty
message that later can go through l10n here.  If we take that
position, it is just a machine-readble error token, so I'd say
whichever way you find more readable is OK.

>> Should these be tied to receive-pack ones in any way?  E.g. if you
>> set fsck.missingEmail to ignore, you do not have to do the same for
>> receive and accept a push with the specific error turned off?
>> 
>> Not a rhetorical question.  I can see it argued both ways.  The
>> justification to defend the position of not tying these two I would
>> have is so that I can be more strict to newer breakages (i.e. not
>> accepting a push that introduce a new breakage by not ignoring with
>> receive.fsck.*) while allowing breakages that are already present.
>> The justification for the opposite position is to make it more
>> convenient to write a consistent policy.  Whichever way is chosen,
>> we would want to see the reason left in the log message so that
>> people do not have to wonder what the original motivation was when
>> they decide if it is a good idea to change this part of the code.
>
> Hmm. I really tried very hard to separate the fsck.* from the receive.*
> settings because the two code paths already behave differently:...
>
> If you agree, I would rephrase this line of argument and add it to the
> commit message. Do you agree?

Yeah, that reasoning sounds sensible.

Thanks.
