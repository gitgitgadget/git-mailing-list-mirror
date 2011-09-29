From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 29 Sep 2011 12:10:06 -0700
Message-ID: <7vy5x7rwq9.fsf@alter.siamese.dyndns.org>
References: <4DF6A8B6.9030301@op5.se>
 <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
 <201109281338.04378.mfick@codeaurora.org>
 <201109281610.49322.mfick@codeaurora.org>
 <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk>
 <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com>
 <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
 <4E84B89F.4060304@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Sep 29 21:10:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9M05-0003Lv-TV
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 21:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470Ab1I2TKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 15:10:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757468Ab1I2TKJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 15:10:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EC665B9F;
	Thu, 29 Sep 2011 15:10:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BzF46A6idvSK
	ZdW6GYMBGqGHrrc=; b=RnNGZD61ixauQwLF/vh7AePnMVCF7AAI7Yf3nzm0BmXt
	Gn11lpjQRyRdTkBbIByPg74q9SDHcS+PkZa/60rEA3EIEeVrypMp2AW9/gjJVHGy
	EMWRjYO6LBe9Cbdt9txpbYd5Xv1fqxuWAZpe/fcvBFMNA1SBgHh8UG+92OPcjcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VGf2Ky
	RCevN4aOBm2Sbb2+ve7UwDyGwWoTiGXKlSnDUCMB61rfVtZhg8+rkFiauVf1aWE2
	JLS1Ymry+f1EsEx7JIwjOGVUFGkKQ/YPeyXHSVFIijVNlcAmbYrW9BFrHUroJPcN
	RgWtowio/pFjf6MIMqkL7IIFERkFkInO0PAcU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 544645B9E;
	Thu, 29 Sep 2011 15:10:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E9AB5B9C; Thu, 29 Sep 2011
 15:10:07 -0400 (EDT)
In-Reply-To: <4E84B89F.4060304@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Thu, 29 Sep 2011 20:27:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A520AA94-EACE-11E0-880E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182425>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Hmm.  Can we get rid of the multiple ref lookups fixed by the above
> *and* the overhead of dealing with a textual argument list at the sam=
e
> time by calling add_pending_object directly, like this?  (Factoring
> out add_pending_sha1 should be a separate patch..)

I haven't tested it or thought about it through, but it smells right ;-=
)

Also we would probably want to drop "next" field from "struct ref_list"
(i.e. making it not a linear list), introduce a new "struct ref_array"
that is a ALLOC_GROW() managed array of pointers to "struct ref_list",
make get_packed_refs() and get_loose_refs() return a pointer to "struct
ref_array" after sorting the array contents by "name". Then resolve_ref=
()
can do a bisection search in the packed refs array when it does not fin=
d a
loose ref.
