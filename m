From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Mon, 03 Sep 2012 12:03:16 -0700
Message-ID: <7v1uijexor.fsf@alter.siamese.dyndns.org>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de>
 <7vr4qqzsbe.fsf@alter.siamese.dyndns.org>
 <002201cd86ce$285841b0$7908c510$@schmitz-digital.de>
 <7vfw74s3oy.fsf@alter.siamese.dyndns.org>
 <003d01cd8827$34e90180$9ebb0480$@schmitz-digital.de>
 <7vpq64f935.fsf@alter.siamese.dyndns.org>
 <000d01cd89b6$d5ba6c30$812f4490$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, "'Johannes Sixt'" <j6t@kdbg.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Sep 03 21:03:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8bvi-0005fp-J4
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 21:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259Ab2ICTDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 15:03:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40628 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754980Ab2ICTDT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 15:03:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 882818DD4;
	Mon,  3 Sep 2012 15:03:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QbvMF1p/wXhQvZozBN/BgVVDBG0=; b=gjyXhy
	ci1Lv1thQtKyl5qK7EscXO5SApvXET+5plxgHN7gIMwlQWQ9sgvO2a/YtA0GRXyD
	8jsakUinOYQWaInwiOvM+iQ0G6FYvGZecVVjsVERExcI1fBz7NKYe18iyame+UaA
	wqzFDxn6i/G8Tk5ZCMJE/AXYGEKjJNEa4OOzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t7asCUIngJB7kauBxwpurOCZL+2KdDwN
	pvzGceCgff+znQuD1qVuRykVqNIgXaABUKaEru5oXk4fsXsl4B8mDqRq4DdkAVwm
	5C8DCVwz5llUpfvcGyOY/A6laQMrXFecrN8y/8RJuiN/YVnHtpnxpLhYjFmXQcEF
	FBZJIf4NtzY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75BCE8DD3;
	Mon,  3 Sep 2012 15:03:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBD448DD1; Mon,  3 Sep 2012
 15:03:17 -0400 (EDT)
In-Reply-To: <000d01cd89b6$d5ba6c30$812f4490$@schmitz-digital.de> (Joachim
 Schmitz's message of "Mon, 3 Sep 2012 11:31:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 055CCB40-F5FA-11E1-9F85-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204705>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> > 	if (!value ) {
>> 
>> Style: space before ')'?
>
> Will fix.
>  
>> > 		errno = EFAULT;
>> > 		return -1;
>> 
>> EFAULT is good ;-)
>
> That's what 'man setitimer()' on Linux says to happen if invalid value is found.
>  
>> The emulation in mingw.c 6072fc3 (Windows: Implement setitimer() and
>> sigaction()., 2007-11-13) may want to be tightened in a similar way.
>

> Hmm, I see that there the errors are handled differently, like this:
>
>         if (ovalue != NULL)
>                 return errno = EINVAL,
>                         error("setitimer param 3 != NULL not implemented");
>
> Should this be done in my setitimer() too? Or rather be left to the caller?
> I tend to the later.

I don't care too deeply either way.  The above was not a comment
meant for you, but was to point out the error checking when the
newvalue is NULL---it is missing in mingw.c and I think the
condition should be checked.

> On top here SA_RESTART is used, which is not available in HP
> NonStop (so I have a "-DSA_RESTART=0" in COMPAT_CFLAGS).

If you cannot re-trigger the timer, then you will see "20%" shown
after one second, silence for 4 seconds and then "done", for an
operation that takes 5 seconds.  Which is not the end of the world,
though.  It does not affect correctness.

The other use of itimer in our codebase is the early-output timer,
but that also is about perceived latency, and not about correctness,
so it is possible that you do not have to support anything (i.e. not
even setting an alarm) at all.
