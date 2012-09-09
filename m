From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] absolute_path(): reject the empty string
Date: Sat, 08 Sep 2012 21:59:51 -0700
Message-ID: <7vbohfu6yg.fsf@alter.siamese.dyndns.org>
References: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
 <1346971264-23744-4-git-send-email-mhagger@alum.mit.edu>
 <7vy5kmzr3e.fsf@alter.siamese.dyndns.org> <504C1F86.4060608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 09 07:01:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAZdj-0000Nm-Mm
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 07:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411Ab2IIE7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 00:59:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45390 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502Ab2IIE7y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 00:59:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23CBA40BF;
	Sun,  9 Sep 2012 00:59:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oYFnuW7tXiqVwMnsp094N3APjj0=; b=CayMww
	P8MmMhYftdTogF2awq/FzGJESUgZaYw5LKg7QJKhdkUEMQ13WDcojakVxOdXZwDY
	1Yt9dfPlodA5d3j9cK/5zoksO4SMQBocdQNZoAEOw/h/4QxHRvcyhhJeMq6xCFs6
	7Hulq0m3BVy1ZarfcYBOCGjRrVvSkBawjo2YQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CHcCb//QzD2I41/31wRXkfhSS3U1AK0D
	7yti7FFZmgsmt31gxWRkaVcH1AGsE4nw+zKn6Xtd4Mid1lRupMJ2xmN1O5HYpf4w
	vM0F3IjKACnSl2JPK8xk7Ajr2fGLNaOz3qAdzhLcNFIs1hwE0EoqNQYtLuZtVFmg
	Z/jt+8I5sf4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 117BE40BE;
	Sun,  9 Sep 2012 00:59:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 662C140BD; Sun,  9 Sep 2012
 00:59:53 -0400 (EDT)
In-Reply-To: <504C1F86.4060608@alum.mit.edu> (Michael Haggerty's message of
 "Sun, 09 Sep 2012 06:48:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31424C04-FA3B-11E1-95B3-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205043>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 09/07/2012 01:09 AM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>>> ---
>> 
>> I think I asked why this matters (iow, why it is the right thing to
>> do to reject an empty string, instead of treating it as "the current
>> directory") in the previous round.  I would have expected to find
>> the answer be above the S-o-b line here.
>
> The reasons that the change is desirable:
>
> 1. The empty string is not a legitimate path according to POSIX; e.g.,
> see Linux's path_resolution(7):
>
>    Empty pathname
>        In the original UNIX, the empty pathname referred to the current
>        directory.   Nowadays  POSIX  decrees  that  an  empty  pathname
>        must not be resolved successfully.  Linux returns ENOENT in this
>        case.
>
> Accordingly, comparable standard functions like realpath(3) reject the
> empty string.
>
> 2. The functions did not handle the empty path consistently with the way
> they handled other paths (namely, the return value contained a trailing
> slash).
>
> 3. This unusual behavior was undocumented.
>
> The above points let me to the conclusion that the anomalous handling of
> the empty string was a bug in the implementation rather than an intended
> behavior.  Moreover, a quick check of callers didn't turn up any that
> seemed to rely on the strange behavior.
>
> Do you want a re-roll with this verbiage added to the commit messages of
> the two relevant commits?

What the function used to do does not really matter when we are
trying to see if the behaviour of the new implementation makes
sense, even though it is a good supporting argument to help us judge
that this change will not cause regressions to existing callers.

A two sentence paragraph, with "realpath(3) from POSIX.1 rejects an
empty string as input" as the primary justification, with "no
existing callers passes an empty string and expects to get the
current directory" as a supporting argument, should suffice, I would
think.
