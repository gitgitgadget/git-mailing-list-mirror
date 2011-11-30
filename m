From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/13] strbuf: add strbuf_add*_urlencode
Date: Tue, 29 Nov 2011 21:40:25 -0800
Message-ID: <7v4nxmrwvq.fsf@alter.siamese.dyndns.org>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111124110728.GI8417@sigill.intra.peff.net>
 <7vzkfessff.fsf@alter.siamese.dyndns.org>
 <20111129211950.GD1793@sigill.intra.peff.net>
 <4ED56A1C.9050800@lsrfire.ath.cx>
 <20111130032028.GA24704@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 30 06:40:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVcuW-0005Bk-Jk
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 06:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147Ab1K3Fka convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Nov 2011 00:40:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895Ab1K3Fk3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2011 00:40:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B62D811B8;
	Wed, 30 Nov 2011 00:40:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wrvWH35e3NQq
	TmYwmioX/B+jEtk=; b=oHBZ1f4uwbbpimbzM7FFHeNzhckRIwJ5EuiCaEtrCGmO
	9p+SPjHrtfPlsNhXSr9tpfUFQRuOa3eECK0qvjXk3I4lrkuEmgc8ZMiBAkrhRVW1
	dPCK5xFyaXy0avT1uiO8rzrIAFpPa9hY9GoI3r8Ol3TMQ2r74bItTJp/lqaWqTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Wo+CF4
	jfTMhvfnzyIE6IP58pJMB04LgIx0YAhZIcXkHJjbOZgQvajIRLe5Pg87V8+IAcjR
	dGrqmy+XWtb5RS54NVV0wQt3CkI83219jFTy/Qhtz9L8Ec0S7F7q586cs222U195
	0W4zSwhZdiqS8bRwdikBKX3osiWiCXZPX8Eog=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD08011B7;
	Wed, 30 Nov 2011 00:40:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B6BE11B6; Wed, 30 Nov 2011
 00:40:27 -0500 (EST)
In-Reply-To: <20111130032028.GA24704@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 29 Nov 2011 22:20:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEB1DAAA-1B15-11E1-AA18-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186100>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 30, 2011 at 12:26:20AM +0100, Ren=C3=A9 Scharfe wrote:
>
>> >>> +static int is_rfc3986_reserved(char ch)
>> >>> +{
>> >>> +	switch (ch) {
>> >>> +	case '!': case '*': case '\'': case '(': case ')': case ';':
>> >>> +	case ':': case '@': case '&': case '=3D': case '+': case '$':
>> >>> +	case ',': case '/': case '?': case '#': case '[': case ']':
>> >>> +		return 1;
>> >>> +	}
>> [...]
>> Sorry for my bikeshedding, but I'd paint it like this:
>>=20
>> 	return !!strchr("!*'();:@&=3D+$,/?#[]", ch);
>
> I was always under the impression that computed jumps via "switch" wo=
uld
> out-perform even an optimized strchr. Of course, I never tested. And =
I
> doubt performance is even relevant here, and I admit I don't care ove=
rly
> much. I find them both equally readable.
>
> I'm going to leave it as-is unless somebody else wants to say "I
> strongly prefer version X".

I find the switch/case one much easier to read and count, especially si=
nce
all the choices are essentially line-noise characters.

Just make sure you indent it correctly ;-)
