From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] gpg: add support for gpgsm
Date: Thu, 31 Mar 2016 08:46:05 -0700
Message-ID: <xmqqa8ler6pu.fsf@gitster.mtv.corp.google.com>
References: <1459432304-35779-1-git-send-email-cmn@dwim.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
X-From: git-owner@vger.kernel.org Thu Mar 31 17:46:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alenX-0007Cr-D2
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 17:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbcCaPqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 11:46:11 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751243AbcCaPqL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 11:46:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 396604FE27;
	Thu, 31 Mar 2016 11:46:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=85NOKTBPwiHJ
	S+SbFQ2QwE/wHEU=; b=ogG2HQ97yYNaFsFhdWpDUt1yHXpOCaSdoxaS5nhTQOYz
	mPsLNBadqqq10fAOZPr/7y6WMxPgyKGHvdSmTlvkahP8ky8MZqjm0Nk7hL56ldn6
	wI73F5bNg88B9nQGWzmL+AYvFEh70CF9IGYipEeYd2iYiXkbSe1SA5W17HF3X84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=v6dUA3
	gpU6Y0lHTNaTi9luqYUMlYgL8YIbMoE8DAzHXgowmzKBWtmhNGYBU2VhanJIFI5U
	aJqupvdDd8VDn9uAtGC9rxDO6UZfFN9QmKmppM3ou96rZGO6wzeGHxjz0dZs+2+a
	JYymtZT/eXnUrAHDN/1k5XAfmMVBW1Yszzs2g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 30B1D4FE24;
	Thu, 31 Mar 2016 11:46:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8F79A4FE21;
	Thu, 31 Mar 2016 11:46:07 -0400 (EDT)
In-Reply-To: <1459432304-35779-1-git-send-email-cmn@dwim.me> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?=
	Nieto"'s message of "Thu, 31 Mar 2016 15:51:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AF10E54C-F757-11E5-8FA2-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290404>

Carlos Mart=C3=ADn Nieto <cmn@dwim.me> writes:

> Detect the gpgsm block header and run this command instead of gpg.
> On the signing side, ask gpgsm if it knows the signing key we're tryi=
ng
> to use and fall back to gpg if it does not.
>
> This lets the user more easily combine signing and verifying X509 and
> PGP signatures without having to choose a default for a particular
> repository that may need to be occasionally overridden.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
>
> ---
>
> Out there in the so-called "real world", companies like using X509 to
> sign things. Currently you can set 'gpg.program' to gpgsm to get
> gpg-compatible verification,...

I notice that you had to add GPGSM_MESSAGE string constant; does the
current code without any change really work correctly if you set
'gpg.program' to gpgsm and do nothing else?

> ... but if you're changing it to swap between
> PGP and X509, it's an extra variable to keep in mind when working wit=
h
> signed commits and tags.

> +gpgsm.program::
> +	Use this custom program instead of "gpgsm" found on $PATH when
> +	making or verifying a gpsm signature. The program must support the

gpsm signature, or gpgsm signature?
