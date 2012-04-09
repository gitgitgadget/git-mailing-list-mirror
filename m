From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] add mergesort() for linked lists
Date: Mon, 09 Apr 2012 11:26:34 -0700
Message-ID: <7vk41owylh.fsf@alter.siamese.dyndns.org>
References: <201203291818.49933.mfick@codeaurora.org>
 <7v7gy2q1kq.fsf@alter.siamese.dyndns.org>
 <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com>
 <20120330093207.GA12298@sigill.intra.peff.net>
 <20120330094052.GB12298@sigill.intra.peff.net>
 <4F7780C3.2050408@lsrfire.ath.cx> <7vpqbm56pf.fsf@alter.siamese.dyndns.org>
 <4F81F5E6.2070609@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Apr 09 20:26:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHJIi-0003V5-Ak
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 20:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676Ab2DIS0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Apr 2012 14:26:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757666Ab2DIS0g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2012 14:26:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D0C4736E;
	Mon,  9 Apr 2012 14:26:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YVmGMQVYfiTl
	TDp0Nb1AaGgQmFk=; b=DeGOn1OBgPJ3T/BFZsJ+KwwsWj1B8mPKp5rG0wfaL+Pr
	59zAAv4B/H8xMT/IuJpQxPVcb7BgcumoMDJpKMbQv95Pwp3wS3MQdWnIcgmTMyzn
	TDuL6C47vRpK+U13zXA7STjNX1oNJysFi8I4jMmhdIvbb2wWzdHTK1MJK5j1vn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EbxwY/
	dBqke570ou6IN/ZvUbjvtZW/kRE0cA9fol/3+YVYMQgcfPNEgOK6xTM1hxp3xZ/O
	ttsmhgjVRuxU65rpsYkfoc0gIEdvTnnPGqWfPUOa9hMtMrM7nsFLAQWmlWXgf2AT
	28pS/dNrX/fNDbLjTOY5qNKNXDU8MFdhPZPM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63388736D;
	Mon,  9 Apr 2012 14:26:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC1C1736B; Mon,  9 Apr 2012
 14:26:35 -0400 (EDT)
In-Reply-To: <4F81F5E6.2070609@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sun, 08 Apr 2012 22:32:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A39C4AA-8271-11E1-9F42-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195023>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 05.04.2012 21:17, schrieb Junio C Hamano:
>> After seeing "I wrote it myself due to NIH", it strikes me a bit odd=
 that
>> you still used "start from bunch of singleton sublist, elongating tw=
ice
>> per round as we go" structure from the original.
>
> It's just becasue the dumb bottom-up approach is the most simple way =
to
> implement merge sort.
> ...
> This optimization speeds up the pre-sorted case but slows down the ca=
se of
> a reversed pre-sorted list because we have to determine the length of=
 the
> sublists each time,...

Ah, I somehow missed that point.  Thanks.
