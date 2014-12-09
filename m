From: Junio C Hamano <gitster@pobox.com>
Subject: Re: no-xmailer tests fail under Mac OS
Date: Tue, 09 Dec 2014 11:45:33 -0800
Message-ID: <xmqqy4qgli8y.fsf@gitster.dls.corp.google.com>
References: <CAO2U3Qg3KsjvWJFza4MfiQDa2LbCpOy1Nxf9Vt3NSgXc7Bee9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Luis Henriques <henrix@camandro.org>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 20:45:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyQj8-0004G9-NB
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 20:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbaLITpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 14:45:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61550 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752249AbaLITph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 14:45:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0519524752;
	Tue,  9 Dec 2014 14:45:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3oMZ+YdL3JHht+h2klDpa1KBVu0=; b=KM2DLh
	fc1SCi4pqWE0HhlyYocN8G1cTpJNUDpJc0KB8R+llQHsqOzCrHE3MK6IeNFikesM
	6BsxQuMbUGc8UC4d4LAPrxqiGEhQrj7SvNjEqS+/sgSZuFNSuVqcKIvHq5rd+pp+
	L82IYLFT0i2m/RakGbRn7rbZonbj0lOYX01Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VvjfDtUxAPP0aV9jL2AyyklOdjqN1bWp
	yqHvKeK81GJtfXgRS+KWg343WWIK2cFAldIDr5hStPARcJTZ1Y/OGdOLJ/klO3Rw
	+atblelKZXZ1RVqHDWhT4NDeVBFugohrpvgrKFzMXNOIwCC9auewDqMXfZ1pHES5
	FiI6bl3auJA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED3D524751;
	Tue,  9 Dec 2014 14:45:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7862E2474F;
	Tue,  9 Dec 2014 14:45:34 -0500 (EST)
In-Reply-To: <CAO2U3Qg3KsjvWJFza4MfiQDa2LbCpOy1Nxf9Vt3NSgXc7Bee9g@mail.gmail.com>
	(Michael Blume's message of "Fri, 5 Dec 2014 18:05:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F0F3D7A2-7FDB-11E4-83B3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261146>

Michael Blume <blume.mike@gmail.com> writes:

> Failures start from
>
> commit d2384abff7a6181fd7b9a51af7e780aa21e5cb8d (refs/bisect/bad)
> Author: Luis Henriques <henrix@camandro.org>
> Date:   Thu Dec 4 19:11:30 2014 +0000
>
>     test/send-email: --[no-]xmailer tests
>
>     Add tests for the --[no-]xmailer option.
>
>     Signed-off-by: Luis Henriques <henrix@camandro.org>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> but continue with Junio's SQUASH??? commit at b728d078

I missed this bit in the patch you pointed out:

+       test "z$(grep ^X-Mailer: out | wc -l)" = "z$expected"

which depends on "wc -l" not to add any extra whitespace around its
count.  We know that some implementations do, and we should be using

	test $(grep xxx | wc -l) -eq $expected

or something, or test_line_count.

Thanks for noticing.
