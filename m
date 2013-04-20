From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] Add new git-cc-cmd helper to contrib
Date: Sat, 20 Apr 2013 13:22:22 -0700
Message-ID: <7vip3hx88x.fsf@alter.siamese.dyndns.org>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
	<1366348458-7706-2-git-send-email-felipe.contreras@gmail.com>
	<7vfvym30t8.fsf@alter.siamese.dyndns.org>
	<CAMP44s3YAq66MrOR5a4ydujKR5+ZNMVV4i=JzPCxLXC244b52g@mail.gmail.com>
	<7v8v4e1fyz.fsf@alter.siamese.dyndns.org> <5171A387.808@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Apr 20 22:22:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTeIy-0006kp-US
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 22:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599Ab3DTUW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 16:22:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59284 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314Ab3DTUWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 16:22:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2016C18B70;
	Sat, 20 Apr 2013 20:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HyxQtvk+FmCo2xkxFJvB+xCY2HA=; b=m2d42+
	CDoXB4K+qXTNtLUXS8ZNw53HpPBvZhQ9tOJ/96l5Q8WvEk+/8gUpffF08O4c7YBn
	/GVN2vlkf9pRvVMYLYZUHkNtM8J78uBkup31Fo3+pWozPvQIFkLxM7mhjwmNJlxF
	yYTQZ0MeOQeeXgkTlaoaEurRK6bbh4dqJKnew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lxvPiOJdyKghijoKZTtWMT3Tw+WkGFPW
	HxcltheIWIXBVDfJo9o8ZiHZoYMjs8Ev3XSyqnz3KJ7VzbRfG64jcfYnilXDUQ+Z
	Avu28aW5ct/WAtSfd1LK68WKwxVJ1apba89ShZPkq4EppevOm84e7o0hMrajWiRR
	xVvy1iVrGIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17D2618B6F;
	Sat, 20 Apr 2013 20:22:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72D0918B6E;
	Sat, 20 Apr 2013 20:22:23 +0000 (UTC)
In-Reply-To: <5171A387.808@kdbg.org> (Johannes Sixt's message of "Fri, 19 Apr
	2013 22:05:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 029499C6-A9F8-11E2-9027-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221873>

Johannes Sixt <j6t@kdbg.org> writes:

>> But I think it can be useful outside the context of send-email as
>> well, and having one independent tool that does one single job well
>> is a better design.  Perhaps it is better to name it less specific
>> to send-email's cc-cmd option.  "git people"?  "git whom"?  "git
>> reviewers"?  I dunno, but along those lines.
>
> Would it make sense to integrate this in git shortlog, which already
> does something similar?

Conceptually, yes, but the end result will be much larger in scope.
I am not sure if "shortlog" is still a good label for it.

"shortlog", when it internally runs "log" [*1*], is still about the
commits within the range given to the command; "shortlog A..B" talks
only about commits within A..B range.  This new thing is about what
happened to the part of the code A..B touches in the past
(i.e. before A happened), which feels a bit different.


[Footnote]

*1* It can be used as a filter to "git log" output, which is a bit
    different animal, but it still is about shortening that incoming
    log, not about independently digging the history using the input
    as a starting point.
