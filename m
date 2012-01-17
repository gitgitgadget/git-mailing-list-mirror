From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: add the test_pause convenience function
Date: Tue, 17 Jan 2012 11:15:34 -0800
Message-ID: <7vboq2rvhl.fsf@alter.siamese.dyndns.org>
References: <4F133069.10308@web.de>
 <20120115232413.GA14724@sigill.intra.peff.net>
 <7vk44ruupe.fsf@alter.siamese.dyndns.org> <4F152F7C.9020902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Pete Wyckoff <pw@padd.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 17 20:15:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnEVS-0002No-NW
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 20:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab2AQTPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 14:15:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598Ab2AQTPh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 14:15:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFA7E6A62;
	Tue, 17 Jan 2012 14:15:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gxY07Dko6I0krTFEF2MDSEht/Y0=; b=umvsTc
	3pDEAtK8M0yTALmx00FYfEq6tl//uZWAj19tjTXJaW6T7LxYlNaC1e9fptO1VcNp
	zVGShUpyjvzlAqDFficB2XoOsQhtGzQWfe/bud0er+UNHwBr2fKvnVOylQ8QmVrx
	MiNdoIJrni34MGdUjuR1xS50/v4lVw1E9Zm94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hYvTGPpceHEhsgPR8J7rbTPRcwwZYBt/
	0bk0QsMtjR4vZrTf9QuhsxKN93veK1iaQlUDDErT1tHyUhbO5LY5WdV6iIrgbkj+
	9vHV6dOtEPSkzyjg7ZhCf740aLlxfZAMrfq8vWwg6RE/bbnamzIc1n38teoGJwZV
	qaZ7U5+L33s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E66B16A61;
	Tue, 17 Jan 2012 14:15:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 485576A60; Tue, 17 Jan 2012
 14:15:36 -0500 (EST)
In-Reply-To: <4F152F7C.9020902@web.de> (Jens Lehmann's message of "Tue, 17
 Jan 2012 09:21:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A283590E-413F-11E1-B5C1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188712>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> I really don't care deeply about the name, so test_pause is absolutely
> ok for me. I added some documentation in t/README too and made it an
> error when --verbose is not used.

I don't care about the name at all, either.

What I cared was more about the hardcoded "bash". Believe it or not, there
are boxes that lack it, and there are people who prefer other shells for
their interactive work. At the very least, invoke "$SHELL_PATH" instead of
bash there, perhaps?

If we wanted to allow an ad-hoc debugging of test scripts to sprinkle
"test_pause $cmd", we might need to do something like:

> +test_pause () {
> +	if test "$verbose" = t; then
> +		bash <&6 >&3 2>&4
		${1-"$SHELL_PATH"} <&6 >&3 2>&4
> +	else
> +		error >&5 "test_pause requires --verbose"
> +	fi
> +}

but I do not think that is worth it. The debugging developer should easily
be able to run gdb or whatever from the interactive shell you are giving
here.
