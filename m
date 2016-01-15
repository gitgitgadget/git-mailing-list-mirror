From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit message
Date: Thu, 14 Jan 2016 17:29:30 -0800
Message-ID: <xmqqegdjk4ud.fsf@gitster.mtv.corp.google.com>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
	<20151220074559.GF30662@sigill.intra.peff.net>
	<xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com>
	<20160115021237.Horde.J6jJsRTdZiG5URajzd8kKsn@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jan 15 02:29:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJtD7-00067Z-Ky
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 02:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbcAOB3d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2016 20:29:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750723AbcAOB3d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2016 20:29:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E4A13CCEE;
	Thu, 14 Jan 2016 20:29:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2XOWE7MPa4se
	bndJkcr+8HLRAY4=; b=ee4gpwBSH/8wzdIw7ZuXIXXa8jEJJauvO1BviufogC9M
	ebMVlt8LJvptkTQo+8a0ZY42pTa2mE2AiEHV6WJIRGjygVra5Mg2YbXVNjYBDaW+
	HBfaQZ4te3rDzA1bgzAi+XOihuEH6QEZKwwg3P+IO13PCuYNv0zaKoNKFKZmqPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MWapyO
	j+5XpgNbATfCzfBhEWZGXmoFj5VSV80HNDud6ayrija33JPbeaNDVcHFVts0jG52
	dwjyeE7Ej2JBgjb3NWM0AzhrsP/zbkCJHF9bPQsdQCT42fGdaK8dmGp2KWCC4p5B
	T/ZN94MbkGaVRyeYHC/ol1zOCRYvOhQ85d2Tg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 357473CCED;
	Thu, 14 Jan 2016 20:29:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9A2A23CCEC;
	Thu, 14 Jan 2016 20:29:31 -0500 (EST)
In-Reply-To: <20160115021237.Horde.J6jJsRTdZiG5URajzd8kKsn@webmail.informatik.kit.edu>
	("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 15 Jan 2016 02:12:37
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D560DB0-BB27-11E5-A650-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284130>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> Actually, we do not even _need_ a sharedness for this ephemeral
>> file.  The additional "adjust-shared-perm" is merely a workaround
>> for the fact the next person cannot write into it when it is left
>> behind, and because we do not want to remove it when we are done.
>
> Do we really want to keep such a file after we are done?

There is no strong reason we should want to remove them, either.

As long as the lazy garbage collection works, there is no incentive
to change things.  I do not have strong objection against such a
change, as long as you do not break people's existing practices,
either, though.

Whoever is designing such a change must carefully define what "after
we are done" exactly means.  Removing such a file immediately after
the command read from it is likely to be a bad idea, for example, if
the command supports hooks that are invoked after the command reads
and uses the contents of it, as the hooks may be depending on the
presence of it and the ability to read from it.
