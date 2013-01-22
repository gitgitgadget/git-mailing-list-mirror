From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Instruct git-completion.bash that we are in test mode
Date: Tue, 22 Jan 2013 08:31:28 -0800
Message-ID: <7vham9b2n3.fsf@alter.siamese.dyndns.org>
References: <201301212330.10824.jn.avila@free.fr>
 <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
 <20130122003954.GA23297@sigill.intra.peff.net>
 <7vham9dej2.fsf@alter.siamese.dyndns.org> <50FE47F4.20104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	git@vger.kernel.org
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 17:32:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxglR-0000va-3w
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 17:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894Ab3AVQbf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2013 11:31:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35813 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539Ab3AVQbe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2013 11:31:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4432CCE2;
	Tue, 22 Jan 2013 11:31:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UXROgJSuNX/o
	0obDmC7n/FroctU=; b=BjYHvvw2JYKMOO0z/VPIyrTKGhy5cOHP08BzsoKufY6I
	6iB8Xwk9oPBJkBzw63hNXRRHfhpKhr51s9WfHv38ArfmW7eyO6dUHzgeJSkxZ2zc
	PDLCZNDBcSCeLyNG5sr3rMuOuKmZYvzhd8rt0FzqpcRRpI8SO8+t+gaBnji+F5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ICRbw8
	iXEMeCkZFmJMt8Tr8FUPSQMQ4PMtVUXvRIxLmbLxqJF4n1r+xUb0ghgjY0kmfogv
	gC6R7TejEaeOzNxTgm2P1sB8ZeInh333gRXvH7hWlMde7PyDqDbBpAz7tDQQMvRD
	2Q2TxwUr/EYExzOENfRX/9NxnJVP9lu4F0Hk0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7BDDCCE1;
	Tue, 22 Jan 2013 11:31:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39F34CCDF; Tue, 22 Jan 2013
 11:31:30 -0500 (EST)
In-Reply-To: <50FE47F4.20104@gmail.com> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 Avila"'s message of "Tue, 22 Jan 2013 09:04:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D0E9EE0-64B1-11E2-9809-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214236>

Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:

> Le 22/01/2013 05:31, Junio C Hamano a =C3=A9crit :
>> Jeff King <peff@peff.net>  writes:
>>
>>> I really hate to suggest this, but should it be more like:
>>>
>>> if test -z "$FAKE_COMMAND_LIST"; then __git_cmdlist() { git help -a
>>> | egrep '^ [a-zA-Z0-9]' } else __git_cmdlist() { printf '%s'
>>> "$FAKE_COMMAND_LIST" } fi
>>>
>>> That gives us a nice predictable starting point for actually
>>> testing the completion code. The downside is that it doesn't let
>>> us test that we remain compatible with the output of "help -a".
> ...
> Instead of imposing the list of command, we could use the command
> list argument to filter the ouput of git help -a. This would ensure t=
hat the
> completions we want to test are still present in the installation whi=
le
> still restricting them to the test case.

In order to "filter the output", you still need to know how output
from "git help -a" looks like, and adjust the code to filter when
the shape of the output changes.  The effort to do so is pretty
similar to the amount of effort needed to maintain FAKE_COMMAND_LIST
to look like the output from "git help -a".  It is of dubious value
compared to the simplicity of "printf" FAKE_COMMAND_LIST approach, I
think.
