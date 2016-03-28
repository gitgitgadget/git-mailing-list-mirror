From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Mon, 28 Mar 2016 07:50:30 -0700
Message-ID: <xmqq60w61wsp.fsf@gitster.mtv.corp.google.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
	<1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
	<20160325095923.GB8880@sigill.intra.peff.net>
	<CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
	<20160325175947.GC10563@sigill.intra.peff.net>
	<CAKqreuzNeY7HryZvMgLKpPAbXOQ_qLfX63YOj57Wo+KrHJbtMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Your friend <pickfire@riseup.net>
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 16:50:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akYV4-0002RS-O9
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 16:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbcC1Oue convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2016 10:50:34 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752386AbcC1Oud convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2016 10:50:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 505914F369;
	Mon, 28 Mar 2016 10:50:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pEejFqM9pMlO
	yDFQwGyvEdrfDQA=; b=TIWUVXAP3CeX/hb/4rBgGZ3Dsyp2RBWwLay3GDNMSUpH
	Q65czWlqvmMOLon/XmOAgjjBN73q2IJkl4F1dmFlMioSuD1M+tRoC7gMsC2HkwvT
	6oHey5T2hwVsefTnO+2ZQxli9D0WEhu6s3Hvp2/Cy9UUQfjWMD3aq4j3Jg3Ur2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lyHJbT
	5NQbczYl31toElVcOwS4TCw38+bgPVg2zOvUQXgqgPYPRHVuwNLvpQwGC5nq3VKu
	LbGLdc6guyd0pFzHUuW7F7gcYdY7byXtATUtmvsXa0oBVnxUWL8mNvjsgt0R0KE1
	IEcH/XVO5DyMYXiFv9hXBztfd+KjFtm0W+QEA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 468D94F368;
	Mon, 28 Mar 2016 10:50:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A83B54F367;
	Mon, 28 Mar 2016 10:50:31 -0400 (EDT)
In-Reply-To: <CAKqreuzNeY7HryZvMgLKpPAbXOQ_qLfX63YOj57Wo+KrHJbtMA@mail.gmail.com>
	(=?utf-8?B?IuaDoOi9tue+pCIncw==?= message of "Mon, 28 Mar 2016 22:12:09
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B7AABF2-F4F4-11E5-8900-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290037>

=E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:

> After read the source code of strbuf more carefully, I get the conclu=
sion
> that if a strbuf is initialized with STRBUF_INIT but is not used, the=
re is
> no need to release it. Is it true?

If it is initialized with STRBUF_INIT and never used, there is no
reason for the variable to exist ;-)

Leaving the variable in the code, and not calling release on it at
the end, would be OK (i.e. there is no leak) today, but may invite
future bugs (e.g. people may use the variable to tentatively build
their string before the function returns to leave the scope of the
variable without adding _release() themselves).
