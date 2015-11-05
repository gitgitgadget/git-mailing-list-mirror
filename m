From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] run-parallel: rename set_nonblocking to set_nonblocking_or_die
Date: Wed, 04 Nov 2015 22:19:43 -0800
Message-ID: <xmqq8u6d7ytc.fsf@gitster.mtv.corp.google.com>
References: <563A63BA.9020407@web.de>
	<1446677029-10745-1-git-send-email-sbeller@google.com>
	<1446677029-10745-2-git-send-email-sbeller@google.com>
	<563AF229.1060302@web.de>
	<xmqqfv0l7z2r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>, j6t@kdbg.org,
	git@vger.kernel.org, johannes.schindelin@gmx.de,
	Jeff King <peff@peff.net>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 05 07:19:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuDtn-0004J2-9V
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 07:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564AbbKEGTq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2015 01:19:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756532AbbKEGTp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2015 01:19:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E49EA1C8E1;
	Thu,  5 Nov 2015 01:19:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0EFUdJhzmdmF
	SH83tpG27qYInG4=; b=KKPvVYJAI0IEUQRaKeznqcryIWR/7doG/FZheSG8Q2Lc
	w3VHEleMwH2k152J4jpL+5iKsvG7mb1Jeejs32SM0HCJkjicqg+RrKcsfqkAAcZ3
	ZV+XXb+tOz0zNX1hSnQ1IspcX69BibC8BCLKlCgEN6+jxvtQYuxYhkx6l3Q2ifs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XJySuV
	nLQzGh1qaHy4QM6AVj/k+S49sBlQmrUd8OqOiCQkPJKndOiyGHvIm8l+4UUzrzxD
	gTOsJjPp09bfUoONrybq6Fqi4xIUJ+Qw1e8jx5ZA0lRnDcUu0ICO/WGSuY5kv1K9
	nXxee4Q6KBsEA4msex27rmatmIuipdOfht70g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DBC371C8E0;
	Thu,  5 Nov 2015 01:19:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5F8981C8DF;
	Thu,  5 Nov 2015 01:19:44 -0500 (EST)
In-Reply-To: <xmqqfv0l7z2r.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 Nov 2015 22:14:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34D18D72-8385-11E5-8EB2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280906>

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> (Jumping into an old discussion, I may be off topic)
>
> I think this is exactly the latest "I wonder" from Peff, to which I
> said "well, perhaps we didn't need nonblock after all from the
> beginning".
>
>> And this work regardless if the fd blocking or not, so from that poi=
nt of view,
>> the set_nonblocking() is not needed at all.
>>
>> The major question is, if the poll() works under Windows, (and I
>> haven't found time to dig further)
>
> ;-)

Having read your message, I notice these disturbing passages in my
copy of manual pages.

poll(2) has

    BUGS
           See the discussion of spurious readiness notifications under
           the BUGS section of select(2).

and then select(2) has

       Under Linux, select() may report a socket file descriptor as
       "ready for read=E2=80=90 ing", while nevertheless a subsequent r=
ead
       blocks.  This could for example happen when data has arrived
       but upon examination has wrong checksum and is discarded.
       There may be other circumstances in which a file descriptor
       is spuriously reported as ready.  Thus it may be safer to use
       O_NONBLOCK on sock=E2=80=90 ets that should not block.

The world is not all Linux, so there may be systems that we do not
have to worry about the bug described here, but there still are some
Linux systems in use in the world, so we cannot assume the bug
described above will not matter, either.

So I am not convinced that set_nonblocking() is unnecessary X-<.
