From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff returns fatal error with core.safecrlf is set to true.
Date: Wed, 26 Jun 2013 08:48:53 -0700
Message-ID: <7vsj04yisa.fsf@alter.siamese.dyndns.org>
References: <6a3d8a2b19a859d8c969ee434e1d6a89@meuh.org>
	<7vobazo4ds.fsf@alter.siamese.dyndns.org>
	<7vip17ktyz.fsf@alter.siamese.dyndns.org>
	<b8e932cba326588db09ebd0986913ac2@meuh.org>
	<7vbo6v9xrr.fsf@alter.siamese.dyndns.org>
	<7vli5z6uyq.fsf@alter.siamese.dyndns.org> <51C9FDC0.5020709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Droneaud <ydroneaud@opteya.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 26 17:49:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urrxv-0000ws-4y
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 17:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475Ab3FZPs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jun 2013 11:48:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab3FZPs6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jun 2013 11:48:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E366B2B728;
	Wed, 26 Jun 2013 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=mej8UXunpIXyS2Z9tuM5kLfGd
	AE=; b=H/nkYia78Vuw6B2fdTIq16FxA74rEqYY+E6lPQVo+ifV2MtMve1Iv/28l
	tVnIJoE7imDapeJrjaVNJSary8R9xIeFXvn0u1ClzylEecm3eVoywXH8zkZ7exhG
	rRAGzqWzZNGFa2I0/i354wHoRJoyyCFgCDqn/ln/bmUc1qxXYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=r8CA0b//66HFfQ1LdsL
	MaBJr7IuNN9lHsb8B9/bDnJgVJE/6OHfo9DZ8pYTEfLYA6v8fqbtn2tfhMbMpGQM
	HBx8EngHZzcRQ4183nybQ5TVTqHWnIMTCg4PmNb2glA6d6Fo2wDHhdSv+GdW2TwE
	EaCX/SKje+Sip1LpfhedaYy0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD2A62B727;
	Wed, 26 Jun 2013 15:48:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13C3F2B726;
	Wed, 26 Jun 2013 15:48:55 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8B0AA36-DE77-11E2-97CC-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229043>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> +++ b/diff.c
>> @@ -2647,6 +2647,10 @@ static int diff_populate_gitlink(struct diff_=
filespec *s, int size_only)
>>  int diff_populate_filespec(struct diff_filespec *s, int size_only)
>>  {
>>  	int err =3D 0;
>> +	enum safe_crlf crlf_warn =3D (safe_crlf !=3D SAFE_CRLF_FAIL
>> +				    ? safe_crlf
>> +				    : SAFE_CRLF_WARN);
>
> Thanks,=20
> Does it makes sense to write it the other way around?
>
> enum safe_crlf crlf_warn =3D (safe_crlf =3D=3D SAFE_CRLF_FAIL=20
>                            ? SAFE_CRLF_WARN=20
>                            : safe_crlf);

I didn't see much difference either way, but between "FAIL needs to
be demoted to WARN, everything else goes as-is" and the original "We
do not care about anything other than FAIL, so use it as-is, but
demote FAIL to WARN", yours look shorter.  Will replace.
