From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bypassing hooks while cherry-picking
Date: Thu, 03 Mar 2016 14:55:34 -0800
Message-ID: <xmqqk2lj189l.fsf@gitster.mtv.corp.google.com>
References: <56D576A1.3020202@greg0ire.fr>
	<xmqqwppj1c83.fsf@gitster.mtv.corp.google.com>
	<56D8B895.9030308@greg0ire.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Gr=C3=A9goire?= PARIS <postmaster@greg0ire.fr>
X-From: git-owner@vger.kernel.org Thu Mar 03 23:55:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abc9l-0006hH-Ko
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 23:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbcCCWzi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2016 17:55:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758665AbcCCWzh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2016 17:55:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 491B849C61;
	Thu,  3 Mar 2016 17:55:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TAhNI6ZMAdlq
	glrR+0pvwWvb1b4=; b=muiK2HniZC3Y2E1vIqKObemUxpaBJtukF6YvgygRTVZZ
	qJo/DDxJnTWecyyMmNSv9oAI4cntYLbQU8ZZWZZ2sIS18c5MoRRTwDJYTQVkODGz
	wVus2K+4DZrxsIXZXluX3cDuAJkGEyYaIucwAnK+KpqziBQqaDHiYrqeGnKlAbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VqSx7H
	qKNIlikGdDUvndZE1+A/U0wjeNnk8ZUKAwxw/sBN7pLMg6lscsmxAHX71cjMQV02
	hIxKmgLwbfHDlGPAQb0AvwpGVzbXoyjY4DT4YL7OQfQt7Tvvp9TSfR5mN7fghPYb
	Y+fPxodQWE41N16tcYX6V+OZEIcpuMb1LlNSY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 40D7A49C60;
	Thu,  3 Mar 2016 17:55:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B973849C5F;
	Thu,  3 Mar 2016 17:55:35 -0500 (EST)
In-Reply-To: <56D8B895.9030308@greg0ire.fr> (=?utf-8?Q?=22Gr=C3=A9goire?=
 PARIS"'s message of
	"Thu, 3 Mar 2016 23:20:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0A86D9E8-E193-11E5-8259-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288221>

Gr=C3=A9goire PARIS <postmaster@greg0ire.fr> writes:

> Not sure how cherry-picking is managed, and whether commit is able to
> see that we are doing a cherry-pick, and end it up properly. Anyway,
> with Kevin's patch, we should be able to happily use cherry-pick

[Please do not top post]

It is somewhat sad to see such a response as that is backwards.

"cherry-pick --continue" originally was "I am done with the commit I
was asked to deal with, so please replay the next one", and in order
to "be done with" the commit, you would used "git commit" yourself,
with whatever necessary options (e.g. --no-verify, -s, -c) you want
to affect the behaviour of the "git commit".

It is a later invention that "cherry-pick --continue" additionally
creates a commit when the user, even though she claims to "be done
with", hasn't actually made the commit before going on to replay the
next one.  It was accepted as a short-cut as most of the time you do
not give any option to your "git commit" invocation, but probably
was a misguided invention--it made new people somehow think that
they are not allowed to run "git commit" to conclude the conflict
resolution, when in reality that is an acceptable and primary way
to do so and "--continue" is a mere short-hand.

As "git commit" does have options other than "--no-verify" that
affects the way it behaves, and can gain more such options in the
future, having to keep adding corresponding options to "cherry-pick
--continue --more-options" will not be a good solution in the longer
run.
