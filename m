From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: "negative" dirstat
Date: Mon, 18 Apr 2011 21:51:13 -0700
Message-ID: <7vtydu6dz2.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=it7r7UsAZGYJC1mntL6wtFipB9g@mail.gmail.com>
 <7vzknn6y7y.fsf@alter.siamese.dyndns.org>
 <BANLkTimEUSb9Na7Z+tnmytsqeeKLkQb9xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 06:51:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC2uQ-0001Rs-8Q
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 06:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab1DSEvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 00:51:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37448 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab1DSEvY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 00:51:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B448B5471;
	Tue, 19 Apr 2011 00:53:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OYJ25Ifq+XNPxgSjHVL5h9b4Z4g=; b=hunxPD
	dEPQ4wjUN18Hv/p348vPxm7LYUCQ3YMTMnH5QtAJ2dMa3/ARRLILZR6LF70/RoLL
	Q7pi15t8m5d8Tz0Foalvu0fQ/ibFcSY3OGMQapRRTf7lSRXJyjL5spqto4D8zJAg
	T1n6wnSh5hFVvb2wYWrIekKvyOQj89m7fdTII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qMYUX5ir8Rlx3TuMkTZUHkK7/K9xQRGg
	2jwuBzllXkHK3Gn0o7X0wdJDCqr7DT0RgooKDosSLKhN/ONMyTRR8OV5u0Htl0o4
	8RmR5R6B8sHDcxj83EF3PInZxZs21M+rctP2wAfemDPZU80ocRg0La4dv7W6W8ju
	mcEe9m4kzAE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8447F5470;
	Tue, 19 Apr 2011 00:53:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 58E2F546F; Tue, 19 Apr 2011
 00:53:15 -0400 (EDT)
In-Reply-To: <BANLkTimEUSb9Na7Z+tnmytsqeeKLkQb9xA@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 18 Apr 2011 14:46:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F22CA806-6A40-11E0-9C93-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171774>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Apr 18, 2011 at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> I guess what it boils down to is what you are trying to measure as the
>> "goodness" value of a change.
>
> Yes.
>
> Yes. If I see a lot of lines added in Documentation/, I really don't
> mind at all. And if I see a diffstat that says something like
>
>    1057 lines added, 2901 lines deleted
>
> I'm extremely happy. It's very different from one that would say
>
>    2958 lines added, 0 lines deleted
>
> even though --dirstat might consider the two equivalent right now.

I am afraid that this is ultimately "how to compare apples and oranges"
(or "which is juicier, oranges or squirrels?") question.

If you are willing to say

    1000 lines added, 700 lines deleted

means "It changes 700 lines (removing the original 700 and replacing them
with the new 700) and then adds 300 lines of new material", then you could
simply use the max(added, p->one->size - copied) instead of using the sum
of them as the damage count.  Of course, depending on the nature of the
change, the above interpretation does not apply in general.

>> At least, if you count literal-added vs src-copied across the files
>> within the subarch, instead of doing it per-file, you would be able to
>> detect the "moving" part more accurately.
>
> Yes. However, "moving" is in many ways still not as interesting as
> "actually removed".  Moving, on it's own, is a pretty neutral operation.

I think I was unclear, but I was shooting for the same thing.

I meant "by doing the added/copied computation across all files, the real
additions and deletions would reflect in the result without the noise from
the 'moving' part."
