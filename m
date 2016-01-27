From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] merge-file: let conflict markers match end-of-line style of the context
Date: Wed, 27 Jan 2016 11:32:50 -0800
Message-ID: <xmqq8u3a95st.fsf@gitster.mtv.corp.google.com>
References: <cover.1453709205.git.johannes.schindelin@gmx.de>
	<cover.1453819314.git.johannes.schindelin@gmx.de>
	<13379804ad901b53d78d741156677664924fc50d.1453819314.git.johannes.schindelin@gmx.de>
	<xmqqoac8ci8o.fsf@gitster.mtv.corp.google.com>
	<xmqqsi1kavr2.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601270856150.2964@virtualbox>
	<xmqqio2e996c.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601272011570.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 27 20:33:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOVps-0007cS-Id
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 20:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965291AbcA0Tc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 14:32:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934864AbcA0Tcx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 14:32:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 53A4E3CBEF;
	Wed, 27 Jan 2016 14:32:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XXQDUgEKK0cqc6ZRKTe3cKUrRgI=; b=v0cqzD
	2Uub7Jw9DAUx/qFox4vdqhj3Ali7qpGm1NKRwZnN+K9e9ktlFf78oGtGBbvbXA6X
	7FHga7SU/AsJLnoTlflLDOyF8RDimjMKvpRlGLI5sX57hGf6EdDxPfyY3SVJBvp3
	pGfHAtd1P7PNRypi6QIic9pqgPu+nOBQM62Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GWNMrrgs57bziHT5Y9Ep+3SSCvTDGNES
	5ncB3URqxXex/EcCBXvTun4u5cgdBzqLCdKZRWiBJ2gU2MsnBld3pHnhVEshHktk
	j4vgiGG7eI65DrQVk2813/qqd6T8i/KNXoq1PP0mjoBlA9UQtyrdP6W9NNLRfBz9
	f7HcNRsOnFk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4BA973CBED;
	Wed, 27 Jan 2016 14:32:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B972C3CBEC;
	Wed, 27 Jan 2016 14:32:51 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601272011570.2964@virtualbox> (Johannes
	Schindelin's message of "Wed, 27 Jan 2016 20:12:38 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C163A548-C52C-11E5-814A-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

[administrivia: I finally managed to correct e-mail address of peff@,
which has been giving me bounces for all the previous messages in
the thread]

> Your response is also an indicator to me that future myself will find the
> same code just as confusing as you did, though.
>
> Maybe need_cr -> eol_is_crlf?

The crucial question is how well the variable conveys its meaning
when it has -1 as its value.  "need_cr? -- I don't know yet" is as
clear as "eol_is_crlf? -- I don't know yet", if not clearer.  I
personally do not think "eol_is_crlf" is an improvement.  It makes
it unclear _whose_ eol the variable is talking about.  It can be
misread as talking about one or more of the files that are being
merged and mistaken as a statement of a fact (i.e. "we inspected
and know the input file's eol is CRLF").

Compared to that, it is clear that "need_cr" is talking about what
the EOL convention the resulting file should be.

I briefly wondered if the if/if (need_cr)/... cascade that inspects
(conditionally up to) three variants might become cleaner if the
polarity of that variable is flipped (we are allowed to use CRLF
only when we know that among all of the three variants that we can
determine the line termination convention used, all of them use
CRLF), but I didn't think it through seriously.
