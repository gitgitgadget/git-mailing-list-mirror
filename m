From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Build in gettext poison feature unconditionally
Date: Tue, 21 Aug 2012 09:37:11 -0700
Message-ID: <7va9xofbgo.fsf@alter.siamese.dyndns.org>
References: <1345523970-14914-1-git-send-email-pclouds@gmail.com>
 <20120821052404.GB55686@mannheim-rule.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <pclouds@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
	<avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 18:37:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3rSE-0001Wi-G2
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 18:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758097Ab2HUQhQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Aug 2012 12:37:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756147Ab2HUQhO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2012 12:37:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7993665B2;
	Tue, 21 Aug 2012 12:37:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+U/4GWktHbq3
	7JvTDyABRH/AsSs=; b=sXrBj0G+seYLGTiCoRB4AnWz3KdhYaw0MBDPG3E1Nr49
	2OGc7YW4v6CdaF8apGl9Xz+jeeU44FRGxHQZ4EmvrDZ0l0SkZuwBML27l1syirUo
	YecEtF59Dn9P2wMPM79mSA3Amwqf5hjOpXNN8iNOd5HH1DmRN06+MC9EY1ulHh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FSy1gv
	zjjX8GdHD7jjWfrbxmyh4njtXb5M+3h014mG/QXC8p0vHsvSbXsCEABRaik1Kqu/
	er5njUpT5Bg3w70E8TFfj6DAZK16ziOAFhBKuDmpslndfH0cVksa8eIc5ZiCUEG9
	GDNKaHvMqRJ1Tt08kMAsY00Kj43iJ53gX/E8U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6605D65B1;
	Tue, 21 Aug 2012 12:37:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDFE265B0; Tue, 21 Aug 2012
 12:37:12 -0400 (EDT)
In-Reply-To: <20120821052404.GB55686@mannheim-rule.local> (Jonathan Nieder's
 message of "Mon, 20 Aug 2012 22:24:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75A6AB38-EBAE-11E1-842E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203969>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> The runtime cost should be small. "gcc -O2" inlines _() and
>> use_gettext_poison(). But even if it does not, performance should no=
t
>> be impacted as _() calls are usually not on critical path. If some o=
f
>> them are, we better fix there as gettext() may or may not be cheap
>> anyway.
>
> That seems reasonable to me.  The increase in code size of a commonly
> inlined function and the extra "if" in a common if not
> performance-critical codepath is annoying (and I'd prefer to keep
> use_gettext_poison() un-inlined), but in any event the cost would go
> away once the translation-based implementation of poison lands.

I would say it is not worse than just "annoying"; if the cost will
go away, I'd rather see this conversion postponed and is done as
part of (and preferrably at the end of) the "poison with a
poison-locale" series.

> Yes, that would be nice (or perhaps a mode to run most tests in
> the current locale and rerun test assertions that use a test_i18n*
> helper or C_LOCALE_OUTPUT prerequisite in the C locale).

Yeah, I think that is the right direction to go; I suspect that
"poison with a poison-locale" would have to be ready to allow us to
go there, though.
