From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache.c: fix index memory allocation
Date: Tue, 25 Oct 2011 09:24:52 -0700
Message-ID: <7vmxcp3up7.fsf@alter.siamese.dyndns.org>
References: <4EA20C5B.3090808@gmail.com> <vpqfwiknmh3.fsf@bauges.imag.fr>
 <4EA3D1BB.2010802@gmail.com> <4EA415BD.1040109@lsrfire.ath.cx>
 <20111023162944.GB28156@sigill.intra.peff.net>
 <4EA453D3.7080002@lsrfire.ath.cx> <4EA4B8E7.5070106@lsrfire.ath.cx>
 <7vipne50lz.fsf@alter.siamese.dyndns.org> <4EA5DFB2.3050406@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, John Hsing <tsyj2007@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Oct 25 18:25:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIjoL-0008HK-T3
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 18:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862Ab1JYQY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 12:24:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40191 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab1JYQY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 12:24:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0BB34FD2;
	Tue, 25 Oct 2011 12:24:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=E4aXkH7zZfJz
	4mLZWJl8Hp9/06c=; b=hFxWIeDbOOx5AJD377Vasq6OQIcfKtRNjNU3SM2Ii36u
	Az1nf0eMIklhl6CudS/1wwGe62wvG+h9el253leXOja3SrQYEClj/Jdep3tm2slg
	GrRfEczKQAc5xjPQsjNujKozgrDZ9VfCdFCWmV8Ma97fcM3PAetIf40HYPrWF28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RUB81/
	Z96s6UXsiji+QsdFNYu8NKP/vs9g1Ob1F9XtF258VIGyVA1Pkz4nDh294BSeF7r/
	djdOWaIyLaJGaMneuPRYP1VOohD6jZc/ZOVkeZtyX9zPibh47Znlo53FNkRHVhXg
	sb6tmn+JLOfM5TQsJcxFSioUu69pgb/CYYqhU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DEBE4FD1;
	Tue, 25 Oct 2011 12:24:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1509F4FCF; Tue, 25 Oct 2011
 12:24:53 -0400 (EDT)
In-Reply-To: <4EA5DFB2.3050406@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon, 24 Oct 2011 23:59:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEFB2D00-FF25-11E0-9B56-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184217>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Something like this (applies to master)?  Very basic testing didn't s=
how
> any slowdown of git status in the Linux repo.
>
> -- >8 --
> Subject: read-cache.c: allocate index entries individually

Yeah, and code reduction looks nice.
