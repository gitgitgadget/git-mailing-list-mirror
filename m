From: Junio C Hamano <gitster@pobox.com>
Subject: Re: AW: [PATCH 1/2] stash--helper: implement "git stash--helper"
Date: Fri, 29 Jan 2016 11:58:48 -0800
Message-ID: <xmqqlh78ximf.fsf@gitster.mtv.corp.google.com>
References: <BLU436-SMTP27D65F59A444FA678FFD8AA5DA0@phx.gbl>
	<0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>
	<xmqqr3h1l2x8.fsf@gitster.mtv.corp.google.com>
	<BLU436-SMTP10996033F3EBFE2E8639F96A5DB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, "'Thomas Gummerer'" <t.gummerer@gmail.com>,
	"'Stefan Beller'" <sbeller@google.com>
To: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
X-From: git-owner@vger.kernel.org Fri Jan 29 20:59:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPFC5-00075w-4l
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 20:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbcA2T6x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2016 14:58:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753640AbcA2T6v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2016 14:58:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D74F33EA84;
	Fri, 29 Jan 2016 14:58:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bZ+KDyHFQ1Vk
	tGGnVyunBeA1cPU=; b=Bs1cMp4UL4Iz12Z9iH+6cTM5DPrD02r2G+yQQE7LvcFa
	JTcPA7lnfVVo1p3h5UyCYQ9wTtoLTZBqirDayWXgtrZ3a0Ckl1T4HM7I6gA8M4ub
	JwQkOhvRQE7YgGiidiZLvjJclIrTcQY9i4TGNrfnpIKwMNe4OqP18sK79tMC9zM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GGsMdM
	sqqdU3zxBhHNf1YlrFHWZRnFERoRJeYlnKOanBJC6mic7tz29W9jnDMasoaWmhdh
	1kJ6EW4hbirPPho+444Ol3E+yT22uD+dXplHyvKKmwwOU61fMFC+OxqAU1R1MV2o
	ecRgf9da2caHINFWsnYl1trELk6a5t+LBPZys=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE7943EA83;
	Fri, 29 Jan 2016 14:58:50 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 53EBB3EA7E;
	Fri, 29 Jan 2016 14:58:50 -0500 (EST)
In-Reply-To: <BLU436-SMTP10996033F3EBFE2E8639F96A5DB0@phx.gbl> ("Matthias
	=?utf-8?Q?A=C3=9Fhauer=22's?= message of "Fri, 29 Jan 2016 20:32:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B72960DA-C6C2-11E5-A141-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285091>

Matthias A=C3=9Fhauer <mha1993@live.de> writes:

[administrivia: please wrap your lines to reasonable lengths]

>> Honestly, I had high hopes after seeing the "we are rewriting it
>> in C" but I am not enthused after seeing this.  I was hoping that
>> the rewritten version would do this all in-core, by calling these
>> functions that we already have:
>
> These functions might be obvious to you, but I'm new to git's
> source code, ...

Ahh, I didn't realize I was talking with somebody unfamiliar with
the codebase.  Apologies.

Nevertheless, the list of functions I gave are a good starting
point; they are widely used building blocks in the codebase.

> I'll be working on a v2 that incorporates the feedback from you,
> Thomas Gummerer and Stefan Beller then. Further feedback is of
> course welcome.

Thanks.
