From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] git reintegrate v0.3; manager of integration branches
Date: Tue, 20 May 2014 15:47:28 -0700
Message-ID: <xmqqa9acrrsv.fsf@gitster.dls.corp.google.com>
References: <53795175664d5_10da88d308ce@nysa.notmuch>
	<xmqqha4lxyqt.fsf@gitster.dls.corp.google.com>
	<537bc3e1c605c_a6f166b3088f@nysa.notmuch>
	<xmqqtx8krvem.fsf@gitster.dls.corp.google.com>
	<537bcbf7efd4_1d08f2d2f8a7@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 00:47:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmsou-00012i-Eb
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 00:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbaETWrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 18:47:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64557 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbaETWrg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 18:47:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B6F2119D80;
	Tue, 20 May 2014 18:47:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZGNsDvT0kIbxuwsIXdE6HebWA9Y=; b=avr6Cu
	SlGJ4D7dI8qffSBoqJEkdagKemi3G10Z2cw/3BjBj0fFYaJ8+SQQyo7QnBGacZxg
	J6U++5127tP7iL13Losagl0LTM/Ly+npmVHePhk7xihj5GAd1RaMPmvXAVaM2n4l
	B0unEY88WpRmR9ysFIMHIEYWZX99fkb0hWylg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AjN0stOf6p4QbMSnUWYe+b2OOjKM946c
	kn3OZSpNV6ka/jlE8kr1c27kjYvd96WPHicob24veoNneU15mExLOKs6oZlZ5SqA
	Ht1wFwgsjOnqdK3RXdd79i9N6rjIdKg2JUFUaIsn+D4xe4Wof6mpZRMDbI6K4MJH
	NtQ/DklhD6I=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AE28419D7F;
	Tue, 20 May 2014 18:47:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6C1CC19D7C;
	Tue, 20 May 2014 18:47:30 -0400 (EDT)
In-Reply-To: <537bcbf7efd4_1d08f2d2f8a7@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 20 May 2014 16:41:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B981FDEA-E070-11E3-8A83-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249757>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I'm not sure what would be the usefulness of using things like
> 'xx/topic~4'.

As a notation it is not very pretty ;-).

Imagine that xx/topic is about a multistep introduction of a
backward incompatible feature.  The beginning part of the series up
to xx/topic~4 are the step to start warning (i.e. "will change---do
this to keep the old one or do that to live in the future"),
xx/topic~3..xx/topic~1 are the next step to flip the default and
still keep warning (i.e. "have changed---do this to keep the old one
or do that to live in the present"), and the final xx/topic is the
endgame where everybody lives with the new default with no warning,
without having to know what the old default was.

While the topic is being prepared for the next release, the insn
sheet for 'jch' would have xx/topic~4 before "match next" marker,
and then an entry for xx/topic~1 somewhere after it, and finally an
entry for xx/topic (i.e. the tip, final commit).  When the first
step cooked well enough in 'next', selected entries of 'jch' insn
sheet before "match next" ones are used to merge them to 'master'
and the part up to xx/topic~4 (but not later patches on the topic
branch) will be part of the upcoming release.

You could simulate that with multiple branches stacked on top of
each other, but there are times when keeping things together in a
single branch is more handy.

In restrospect, if I found xx/topic~4 too ugly, I might have instead
made "branches stacked on top of each other" easier to manage, but
having Reintegrate support "in the middle of a branch" was simpler.
They are both OK solutions to the same problem, and I didn't have to
solve it both ways ;-)
