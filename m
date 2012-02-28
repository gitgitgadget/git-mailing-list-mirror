From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: don't assume the merge filter ref exists
Date: Tue, 28 Feb 2012 09:32:21 -0800
Message-ID: <7vehte27a2.fsf@alter.siamese.dyndns.org>
References: <20120227122609.GA26981@mx.loc>
 <1330355513-22351-1-git-send-email-cmn@elego.de>
 <20120227193044.GD1600@sigill.intra.peff.net>
 <7vk4386pgi.fsf@alter.siamese.dyndns.org>
 <20120227194305.GE1600@sigill.intra.peff.net>
 <1330442090.691.9.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>,
	git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Feb 28 18:32:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Qub-0004oF-CX
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 18:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965712Ab2B1RcZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 12:32:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964793Ab2B1RcY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 12:32:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08E566644;
	Tue, 28 Feb 2012 12:32:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8GxV1bB490MO
	KMscUv8y6D8fJBY=; b=MlR3BZ/smnz05ZAbl0eW3SzxQU+tg1DdkPaD7/JH/2Ps
	QRn+9ONySSJYhjoJwNVTlpA+9I24l3TcjL5ZRao2GwBLL9Yg+XkZR/74pQCvO1Ys
	HwNLKKPrvoquRCv8AMrb7erBgB4oJic0S9sTj0lhMTgK5ivXFa/ey586nGnyKm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Wn7GuX
	Z+KhEVKfQsWrmzD0CheGK8zErMIBfZlJyTr7gT+ZJ2K+QHlO69x4+BV+lDnoq/J+
	+AO7BPI2YlU4/Vs/Zndw/KTF02mCwOSRMOC1AKgUgkQYklM9nSs1SpNeyLGAW61Y
	8x60XsuPAxgK8W3QOE/F0tl3j8IsXYyli1kPc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1CC46643;
	Tue, 28 Feb 2012 12:32:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6509C6642; Tue, 28 Feb 2012
 12:32:23 -0500 (EST)
In-Reply-To: <1330442090.691.9.camel@centaur.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 28 Feb 2012 16:14:50
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C9DF1F4-6232-11E1-882C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191750>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Mon, 2012-02-27 at 14:43 -0500, Jeff King wrote:
>>=20
>> It looks like "bad object" generally comes from parse_object failing=
,
>> which makes sense. It either means object corruption or you fed a fu=
ll
>> 40-char sha1 that didn't exist (which, if you are being that specifi=
c,
>> probably is an indication of broken-ness in your repository).
>
> Right. Another version of the fix I was playing with used parse_objec=
t
> after get_sha1 in opt_parse_merge_filter to make sure there that the
> objects did exist, so I copied that error message for this patch.
>
> I see Junio's already squashed this in, and it's certainly a better
> message.

Ok, so what I have is good for everybody.  Will merge to "next" and soo=
n
to "master" and "maint".

Thanks, both.
