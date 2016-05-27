From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] worktree: allow "-" short-hand for @{-1} in add command
Date: Fri, 27 May 2016 11:01:31 -0700
Message-ID: <xmqqr3cnqt1g.fsf@gitster.mtv.corp.google.com>
References: <vpqshx5cb51.fsf@anie.imag.fr>
	<1464263662-1290-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<xmqqshx4vedr.fsf@gitster.mtv.corp.google.com>
	<9975E0C6-7BCC-4D80-BBC6-2C0BAB13D3E6@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Samuel Groot <samuel.groot@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	Matthieu.Moy@grenoble-inp.fr
To: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Fri May 27 20:01:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6M4q-0000pP-3J
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 20:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbcE0SBg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2016 14:01:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750927AbcE0SBf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2016 14:01:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97F721E301;
	Fri, 27 May 2016 14:01:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=asxVbjc1FPrl
	U44jcByrMD/plaQ=; b=RrZgRalbV+8hNGWCUf3AgvqgHMpCOqmCLPhnocbUmADr
	OBPOWvzqUc3zLjxyY7ELMjOvic2jfS1n5ZZ1JGc8euU96WAh7N+vugLzuK5g0Jlr
	xRShDzq3MEamlr7EwwKjSAg/JBSDRA0bvLKbLYZouxNEvDA+VI+OwYYbaQLUyAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yjr35q
	p19LbhKtgBdDegrkoVq0XSrIZRPP4rnJ8ZT2jQxLoXTta8kzc9Qm7g+swnTeKZeJ
	CiVG9g+qupM4pf1L72SSTH0SF9mz6yV2IXuVx1JGRsKN/0DlHwRB0EhI4V5sxsjP
	nG4aXx8e7cFBsk81+1w8gaS8at9SGNBwnb40A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EC911E300;
	Fri, 27 May 2016 14:01:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03C971E2FF;
	Fri, 27 May 2016 14:01:34 -0400 (EDT)
In-Reply-To: <9975E0C6-7BCC-4D80-BBC6-2C0BAB13D3E6@grenoble-inp.org> (Jordan
	DE's message of "Fri, 27 May 2016 14:43:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C612CF2-2435-11E6-8B85-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295780>

Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:

>>> +test_expect_success '"add" using shorthand - fails when no previou=
s branch' '
>>> +	test_must_fail git worktree add existing -
>>> +'
>>=20
>> Just an observation, but the error message we would see here might
>> be interesting.
>
> Of course, that=E2=80=99s useful to be sure of the error, I will do i=
n next preroll.

That was not what I meant.  The exit status being non-zero is what
we primarily care about.  The exact phrasing of the error message is
much less important and in general we shouldn't enforce "the error
message must remain so" in the test.

If you observe the error message from this test, e.g. by running it
with "-v", I suspect that you would see the message would complain
about "@{-1}".

I just wanted to make sure that you saw it and thought about its
ramifications.

It is perfectly fine by me (others might disagree, though) if your
conclusion after thinking about it is "Even though the user may be
surprised to get complaints for "@{-1}" that she never gave to the
command (she gave "-"), because we clearly document that "-" is a
mere synonym/short-hand for @{-1}, it is OK".  I still want to see
that behaviour justified in the proposed commit log message.

And that is why I said it "might be interesting".
