From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 12:18:03 -0700
Message-ID: <xmqqvbgdzaqc.fsf@gitster.dls.corp.google.com>
References: <1430343059.14907.18.camel@ubuntu>
	<20150429214817.GA2725@peff.net> <1430346576.14907.40.camel@ubuntu>
	<20150429231150.GB3887@peff.net> <20150430003750.GA4258@peff.net>
	<1430355983.14907.55.camel@ubuntu> <20150430011612.GA7530@peff.net>
	<1430358345.14907.62.camel@ubuntu> <20150430033725.GB12361@peff.net>
	<87383ihqzp.fsf@igel.home> <20150430182659.GB23431@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 21:18:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YntyY-0002a8-Bg
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 21:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbbD3TSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 15:18:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752780AbbD3TSI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 15:18:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C560F4D3DB;
	Thu, 30 Apr 2015 15:18:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0rxtQGsQ2/p/MXp4M/v8ZLoVZ0A=; b=AkFjEO
	C7zJrhqP9lJ0fUpTO83cDlmcAbePt6fP+QuImIheffV6i2gzX3EnVYbY/Fw6njoK
	G/hbSNQTOYFiA7ZYm9eZYizI4Edr3NMCrv2WrgLhf75ETMGTXkUUzOIQXkqlst9u
	G5sl7t3DmU83JOK3MolAESRa+/ItGKg8yWmwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w/at7HkQRb2UEOUGHXlrc6DB+pe/DiU/
	DoNnWhrdu+owxioXe/RrQsdIB9HwOkpUed0m2HlPUmUk9dUci9pR95s/aa6jTNjf
	DRsSIIr5RkMQe5n/N5cY54kiiXzqaS/B/qnXY7nhFeZcYTP1x65ueVZ5LlW67HTt
	xbSxKL72ANQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A838E4D3D9;
	Thu, 30 Apr 2015 15:18:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 206D94D3D8;
	Thu, 30 Apr 2015 15:18:06 -0400 (EDT)
In-Reply-To: <20150430182659.GB23431@peff.net> (Jeff King's message of "Thu,
	30 Apr 2015 14:27:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A11D98B0-EF6D-11E4-8751-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268095>

Jeff King <peff@peff.net> writes:

> Which means that I think this has to be implemented as part of the name
> resolution (i.e., the "^{resolve}") proposal. cat-file could not say:
>
>   get_sha1_with_context("HEAD:foo/bar/baz", sha1, &ctx);
>   if (S_ISLNK(ctx.mode))
>      ... resolve ...
>
> The initial get_sha1 would fail if "foo" is a symlink. Likewise, one
> cannot implement this by querying cat-file repeatedly without asking for
> each leading prefix (so ask for "HEAD:foo", see if it's a link, then
> "HEAD:foo/bar", etc).
>
> Of course it does not _have_ to be part of the normal get_sha1 name
> resolution. But if not, it would have to reimplement the tree-walking
> part of that name resolution.
>
> Thanks for giving another interesting case to consider.

Yup, everything above makes sense, and I think it is an argument for
making this new feature as part of the sha1-name infrastructure, if
only that it has to do some sort of tree-walking already anyway.

Thanks.
