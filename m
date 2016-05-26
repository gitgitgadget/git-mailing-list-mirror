From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug?] log -p -W showing the whole file for a patch that adds to the end?
Date: Thu, 26 May 2016 10:05:02 -0700
Message-ID: <xmqqr3cowy0x.fsf@gitster.mtv.corp.google.com>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
	<xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com>
	<5740AC28.6010202@web.de>
	<xmqq7fej5njv.fsf@gitster.mtv.corp.google.com>
	<5746B9AE.5050307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu May 26 19:05:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5yig-0003Cr-M3
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 19:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbcEZRFI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2016 13:05:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751497AbcEZRFH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2016 13:05:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD6201E0EB;
	Thu, 26 May 2016 13:05:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MeL041bxlzkk
	m6Y9Wfz0LBfljZI=; b=DbxmzbplE7bO7vNXvtYvDIfIvr8rKT9gTwJV9nVgZwVw
	wVMgxRZdHBz/K9wHXHp0u9Gq+OjtvMqPoddeVc6hzfiv6Fmmlob1AAJJ7RYqsWDJ
	wsn6P0bF1cXV5z3fkBQ087ShO2F5+DnMIZdxWM5r8ntCDFjrQ4jElaV0mhl/Vi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Oo7BBp
	UpUKQji2qg2CKiV3EjltlaozPynyQuybzoC4/rKiYtmk0Cpuh6Ckaehfk/Md4M5p
	mdJPJql/vlV89kY9iJ0YzOJe0UwagxjM3bDOyX62z+rufTSqZ5YmcTmReV6ip/dz
	oMff5rS6vOUTy+sp7MMd+jkkNMl9R2Lvq59Go=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C2E591E0EA;
	Thu, 26 May 2016 13:05:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA2941E0E8;
	Thu, 26 May 2016 13:05:04 -0400 (EDT)
In-Reply-To: <5746B9AE.5050307@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Thu, 26
	May 2016 10:54:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FDE4F982-2363-11E6-998E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295675>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 24.05.2016 um 20:16 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>>    diff: factor out match_func_rec()
>>>    diff: handle appended chunks better with -W
>>>    diff: ignore empty lines before added functions with -W
>>>    diff: don't include common trailing empty lines with -W
>>>    grep: don't extend context to trailing empty lines with -W
>>>
>>>   grep.c        | 28 ++++++++++++++++++++++++--
>>>   xdiff/xemit.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++-------
>>>   2 files changed, 82 insertions(+), 9 deletions(-)
>
>> It is curious that this much behaviour change does not need any
>> changes in the test scripts.  We do not have sufficient coverage,
>> perhaps?
>
> Well, -W is not tested at all.  I'll include some in the next round.
> No need to hurry, it's too late to land in 2.9.0 anyway.

True.

I'd say that these patches are fine as they are, and follow-up patch
for adding -W tests (instead of rerolling them) is sufficient,
though.
