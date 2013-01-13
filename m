From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Sun, 13 Jan 2013 14:38:54 -0800
Message-ID: <7v4nikiu81.fsf@alter.siamese.dyndns.org>
References: <201301120650.46479.tboegi@web.de>
 <7vvcb37xfe.fsf@alter.siamese.dyndns.org> <50F28BB5.9080607@web.de>
 <20130113173207.GC5973@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 23:39:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuWCz-000325-Bf
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 23:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132Ab3AMWi5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 17:38:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60736 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756093Ab3AMWi5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2013 17:38:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86731B4D1;
	Sun, 13 Jan 2013 17:38:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eJhoH88KonUM
	sm5kjp6Mz0QuxAU=; b=vWzdwj8mOhK5tcVHc0qVXDE7/NK8sZeD8uwrBbXRKL15
	mdBevcmdmKXEcslTijpflX6gG4hKxSdpt4YS+50QNPW51UOiiUxj33MRpmyhG6sp
	0HOO8k1x8TryER1EI9y8y/VTvGVd6SVQxsncc3JK5bAuvQ3ZElV7fgHYSRbhhls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=r8fhqj
	uIbNOHk/FSAww0TigMFwKeePT2K/5/DbwCCIugTOzZgwQInOBaZa67fvFFbAHv+C
	Tgq4lPHv48mb2GFAM3ZbYBlz5yfJIRTnOhg/ktLL58Yo+uYE/F/mRYl6+lh0vefK
	TIdF2ufOiVdvI+2GtJ0M9qm5Cs01FDylQnnSc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A002B4D0;
	Sun, 13 Jan 2013 17:38:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0ECD6B4CA; Sun, 13 Jan 2013
 17:38:55 -0500 (EST)
In-Reply-To: <20130113173207.GC5973@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 13 Jan 2013 09:32:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03AC8C28-5DD2-11E2-B8F7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213403>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Torsten B=C3=B6gershausen wrote:
>
>> -	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use ty=
pe)';
>> +	/^\s*[^#]\s*which\s+[-a-zA-Z0-9]+$/ and err 'which is not portable=
 (please use type)';
>
> Hmm.  Neither the old version nor the new one matches what seem to
> be typical uses of 'which', based on a quick code search:
>
> 	if which sl >/dev/null 2>&1
> 	then
> 		sl -l
> 		...
> 	fi
>
> or
>
> 	if test -x "$(which sl 2>/dev/null)"
> 	then
> 		sl -l
> 		...
> 	fi

Yes, these two misuses are what we want it to trigger on, so the
test is very easy to trigger and produce a false positive, but does
not trigger on what we really want to catch.

That does not sound like a good benefit/cost ratio to me.
