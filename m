From: Junio C Hamano <gitster@pobox.com>
Subject: Re: AW: [PATCH 1/2] stash--helper: implement "git stash--helper"
Date: Mon, 01 Feb 2016 15:40:11 -0800
Message-ID: <xmqqa8nkt2xw.fsf@gitster.mtv.corp.google.com>
References: <BLU436-SMTP27D65F59A444FA678FFD8AA5DA0@phx.gbl>
	<0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>
	<xmqqr3h1l2x8.fsf@gitster.mtv.corp.google.com>
	<BLU436-SMTP10996033F3EBFE2E8639F96A5DB0@phx.gbl>
	<xmqqlh78ximf.fsf@gitster.mtv.corp.google.com>
	<CAO2U3QhvibfEexCUuDJyj=4P+bebnrQhMaVq3VrgNBLbiTDNaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Git List <git@vger.kernel.org>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 00:40:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQO4z-0003px-Lj
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 00:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbcBAXkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 18:40:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750877AbcBAXkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 18:40:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 83C02414FC;
	Mon,  1 Feb 2016 18:40:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uUCH1+vCm6hA63cNA1czAm1Yhrs=; b=TrPR4c
	qpYmWPaN+X1+o+nS8MhtDfO9oRKYgfrmGp29UfY5Qu1Tvo0w2ZTGt5xskAGbCV/a
	wZCsomeBRiWXfxbQXUECERP+z4ySf3X96ZEbQ41UwDR/Xp5+jqKAk+U6eIa5Qg1z
	D3hzlqNoRUhxRwSDunEJQfo7nIK73+TCnqhaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cej8ftBVR6ujU6f4xXQ+XPMPSqylzGyU
	pSG7xSXkJX/0HybfUn1adhR77zgk03yisY8kndt5QyccwdwDi8rBoRF/l7Tx62iI
	hN1KrQGxCuIXasOSmq+RK59U/3qPmtyv1OzX8m49CPSBLdpoGT4ejOq+mQlvpHzX
	Mx2Y5yNmvGE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B7C2414FB;
	Mon,  1 Feb 2016 18:40:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E29AA414F9;
	Mon,  1 Feb 2016 18:40:12 -0500 (EST)
In-Reply-To: <CAO2U3QhvibfEexCUuDJyj=4P+bebnrQhMaVq3VrgNBLbiTDNaA@mail.gmail.com>
	(Michael Blume's message of "Mon, 1 Feb 2016 15:36:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 237B49DE-C93D-11E5-AAC2-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285227>

Michael Blume <blume.mike@gmail.com> writes:

> Maybe this isn't important given that it looks like the patch is going
> to be rewritten, but I have
>
> stash.c:43:18: warning: incompatible pointer types assigning to 'const
> char *const *' from 'const char *'; take the address with &
> [-Wincompatible-pointer-types]
>                 write_tree.env = prefix;

The way posted patch tries to use the .env field when using the
run-command API is totally bogus and this compilation error is a
manifestation of that.

But the good news is that this should become irrelevant when the
patch is done by using internal calls ;-).
