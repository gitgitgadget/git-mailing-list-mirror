From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tag: support --sort=<spec>
Date: Mon, 24 Feb 2014 08:39:51 -0800
Message-ID: <xmqqy510bh2g.fsf@gitster.dls.corp.google.com>
References: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
	<1393039762-4843-1-git-send-email-pclouds@gmail.com>
	<20140222080404.GB1576@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:40:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyZX-0008Ry-PH
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbaBXQj6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Feb 2014 11:39:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256AbaBXQj5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Feb 2014 11:39:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AE456BBFA;
	Mon, 24 Feb 2014 11:39:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ibfvFVpYr7AF
	jQ+3Qd2x6u7ns/o=; b=tMszoWLXG6PK/pn/5aVtrtVJAzL71+EAIZV2pEazYD4P
	PHHUs6Yp/MPQ9Pm2bvkGrMmFAGi7S7Nh5qCztpIPDtiR5KnFqtaGhK57gDYp+HIw
	pMCtRq/my+wnu/u9g2WkYH2tQSr1uyYNwKPyBdBLCTFmcwVw/1XXVqmlvSOaQSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qclp76
	9KMgmjyGu7COBXqxoZKWle5xrLLh+rvh9Mss7ut5xT3wXaHFSTVPFqhB5Emabodr
	sCwDfbPjv0bD8Wv2Alcsbsiivbo/vw4uPImPwpHwSDdowyK6J0EsTA06eVTCXU/e
	IAYqKq7JUtjem0T0APzdD+7rjMWZLbsrs++w8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CA1E6BBF8;
	Mon, 24 Feb 2014 11:39:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85A226BBF6;
	Mon, 24 Feb 2014 11:39:55 -0500 (EST)
In-Reply-To: <20140222080404.GB1576@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 22 Feb 2014 03:04:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4AA75E1A-9D72-11E3-A15F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242610>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 22, 2014 at 10:29:22AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  The new prereq GNULINUX is an ugly workaround until people provide
>>  strverscmp compat implementation. I hope that will happen soon as
>>  strverscmp.c does not look very complex.
>
> Should GNULINUX be called HAVE_STRVERSCMP in the Makefile?
>
> Then this:
>
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -721,4 +721,11 @@ void warn_on_inaccessible(const char *path);
>>  /* Get the passwd entry for the UID of the current process. */
>>  struct passwd *xgetpwuid_self(void);
>> =20
>> +#ifndef __GNU_LIBRARY__
>> +static inline int strverscmp(const char *s1, const char *s2)
>> +{
>> +	die("strverscmp() not supported");
>> +}
>> +#endif
>
> becomes "#ifndef HAVE_STRVERSCMP", and this:
>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 1531c24..5e8c39a 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -771,6 +771,8 @@ case $(uname -s) in
>>  	;;
>>  esac
>> =20
>> +[ "$(uname -o)" =3D "GNU/Linux" ] && test_set_prereq GNULINUX
>> +
>
> can pick up the value from GIT-BUILD-OPTIONS as a prerequisite (see t=
he
> way we handle NO_PERL for an example). Though if we can just grab the
> glibc version as a fallback, we can do away with that completely.

;-)  I like that.
