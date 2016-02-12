From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of for-each-ref
Date: Fri, 12 Feb 2016 15:37:30 -0800
Message-ID: <xmqqk2m9ts91.fsf@gitster.mtv.corp.google.com>
References: <56B32953.2010908@gmail.com>
	<20160204111307.GA30495@sigill.intra.peff.net>
	<xmqqsi0xu2ac.fsf@gitster.mtv.corp.google.com>
	<20160212224048.Horde.IpOeDKLAMM4a11F2xyIeY4M@webmail.informatik.kit.edu>
	<20160212221639.GA27974@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, tr@thomasrast.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 00:37:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNHN-0007KL-Lw
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbcBLXhe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 18:37:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750977AbcBLXhd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2016 18:37:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B7D7443598;
	Fri, 12 Feb 2016 18:37:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vVZe579G0UEo
	tX8q0mx34Aws7Lk=; b=qZDCha308peaYS9KFBZgP1+bi5VFSmxsk+8OSKAf1ni1
	t1faS9lOvsr31/7wfBwuyZWjDalNAryTP1WgNVovSZPOGwW+hrOAiCdxd6kUQL8t
	Fi9sxxGw/jeBwbbNhLfK34UvsFVwB465xw3USP6YeIqZMbZxjAO8tbkejGNo+34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SzAgEf
	edueAC9LPwqs/vW9Z0TTKaqgLY14Wsja+LI3SQXwN9c/In+qZqQM1+Da2ForB6kz
	znbT8OJzJefBwgw6mwQNy8LB5g4oNxf0+DuE7jxN8bzI0nDDUu+aH6+MERPnebkb
	xhmHtK4DLRW6QSUlUUx2REoVI0Sb12F5e2t98=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AFC8C43597;
	Fri, 12 Feb 2016 18:37:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 31F7643592;
	Fri, 12 Feb 2016 18:37:32 -0500 (EST)
In-Reply-To: <20160212221639.GA27974@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 12 Feb 2016 17:16:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 962F19D6-D1E1-11E5-BB06-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286091>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 12, 2016 at 10:40:48PM +0100, SZEDER G=C3=A1bor wrote:
>
>>  * It would swallow even those errors that we are interested in,
>>    e.g. (note the missing quotes around $foo):
>> [...]
>>  * I often find myself tracing/debugging the completion script
>>    through stderr by scattering
>>=20
>>       echo >&2 "foo: '$foo'"
>
> One alternative to deal with these would be to add a flag to
> conditionally turn off stderr, and then leave it on during normal
> operation and disable it (letting everything through, including whate=
ver
> random cruft git commands produce) for debugging.
>
> But...
>
>>  * I have a WIP patch series that deals with errors from git
>>    commands.
>
> I'm happy to wait and see what this patch looks like (and generally
> happy to defer to you on maintenance issues for completion, as you ar=
e
> much more likely than me to be the one fixing things later on :) ).
>
> -Peff

Likewise on both counts.
