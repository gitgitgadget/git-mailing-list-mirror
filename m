From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] CYGWIN: Use a TCP socket for pipe()
Date: Sun, 30 Jun 2013 15:56:35 -0700
Message-ID: <7vwqpbi4ws.fsf@alter.siamese.dyndns.org>
References: <201306271831.13865.tboegi@web.de>
	<7vvc4zsbbs.fsf@alter.siamese.dyndns.org> <51CCF91F.7080501@gmail.com>
	<51D08B58.8000103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Levedahl <mlevedahl@gmail.com>, ramsay@ramsay1.demon.co.uk,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 01 00:56:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtQXy-0005U5-VJ
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 00:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab3F3W4j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jun 2013 18:56:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48284 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397Ab3F3W4i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jun 2013 18:56:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C5842CB24;
	Sun, 30 Jun 2013 22:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FPDPSNM8kEXV
	xFUk2FybeO8H1J8=; b=r94Wq/8Pd+BPvcIkh9DoxKCpxmhkeyIWiJk+mdfOSjdn
	3hrVvGJ3YNl8O8DD3RQpvFeEFVDyH90UHlYXYmU99ip/a/i+EOptF41pItoR3uyb
	SW6KS8twOOoLSqbloftWYEI97O0nxrw1I5XEdYGkpLH1fA/Y3kXgVgOLzWsFMUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=G143C7
	JrOKYHU3GjZgRyFfOnN9X69wJcBk6FdFVm0Jkim4qr+4sRE9aXS7rnHsEt3/sclD
	h0eqfWq5Ua66v+MMkQvaLKM6wZfMlTP8wJenLkkdcvoEmXvM+6m3kctd4WS5TL9N
	ZkDJQYx1bkNDltRZXJuEugr2upQSxx1/IGKuc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FB6B2CB23;
	Sun, 30 Jun 2013 22:56:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9ED92CB1C;
	Sun, 30 Jun 2013 22:56:36 +0000 (UTC)
In-Reply-To: <51D08B58.8000103@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sun, 30 Jun 2013 21:47:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5142A258-E1D8-11E2-B72A-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229289>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> I testet "rj/cygwin-remove-cheating-lstat" with the "socket pipe" on =
top:
> no hanging.
>
> Then I run "rj/cygwin-remove-cheating-lstat" without "socket pipe",
> (or in other words git.git/pu):
> No hanging.

So an immediate conclusion is that we can forget about this patch?

> So at the moment I don't have any problems to report for cygwin, whic=
h is good.
>
> And it looks as if "rj/cygwin-remove-cheating-lstat" prevents the "ha=
nging",
> so there is another +1 to keep it and move it into next.

Ramsay started a "mark places we call lstat() when we do not really
need fully correct lstat" topic, and I think it may be a sane
direction to go, as long as the helper function's semantic is
clearly defined.

It would be worth seeing where it leads us, before ripping that
"cheating and incomplete lstat out, I think.
