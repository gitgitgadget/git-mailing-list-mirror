From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/25] t5500, t5539: tests for shallow depth since a specific date
Date: Mon, 08 Feb 2016 13:24:20 -0800
Message-ID: <xmqqio1y7v5n.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-19-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 22:24:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aStIJ-0005DF-9b
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 22:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbcBHVYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 16:24:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754413AbcBHVYX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 16:24:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F290410FD;
	Mon,  8 Feb 2016 16:24:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IXSs9RvL/Nf5
	guc3Paj/2muZGmE=; b=uGePARDI3C3fXod8lRPypOY4vR7Xfq/UxmbOyv1qNoyU
	FeHH/GWECP2hqxGi5DAx2jQQyBGbKnZyTCCaEQzPt9VFYUG1wUfL7pNrlbDjpWYi
	wLXOr0y7SWpKuEaHaIXrTCGsMvD9Ae60++stvNC9nqET47uWmScMZhoANHczHpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aAdlxa
	rDkvvjllzQ+RaVR4AKPYTbeNpeNoJ5SyrL9CT4ovfmj5m7dKQhKlGnlYUzQvCgUZ
	0ExhyHR3rkAtM35xdMa407lYzDU6ErgUsAZvsHfNYYNo3RCV0WOau8rLInR4Ccx3
	B8q1uG0hvkB2oWMcNRDXnWzinKVaV4v5nlfuI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44ACB410FC;
	Mon,  8 Feb 2016 16:24:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BB9C7410F9;
	Mon,  8 Feb 2016 16:24:21 -0500 (EST)
In-Reply-To: <1454576641-29615-19-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 51DC7966-CEAA-11E5-92BD-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285809>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +	cd shallow-since &&
> +	GIT_COMMITTER_DATE=3D"100000000 +0700" git commit --allow-empty -m =
one &&
> +	GIT_COMMITTER_DATE=3D"200000000 +0700" git commit --allow-empty -m =
two &&
> +	GIT_COMMITTER_DATE=3D"300000000 +0700" git commit --allow-empty -m =
three &&

Didn't --date=3D"@10000000 +0700" work?

Not a complaint but genuinely curious.

> +	git clone --shallow-since "300000000 +0700" "file://$(pwd)/." ../sh=
allow11 &&

Are we required to add TZ to --shallow-since, or we merely tolerate
if there is one (I am hoping that it is the latter)?

> +	git -C ../shallow11 log --pretty=3Dtformat:%s HEAD >actual &&
> +	echo three >expected &&
> +	test_cmp expected actual
> +	)
> +'
> +
> +test_expect_success 'fetch shallow since ...' '
> +	git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
> +	git -C shallow11 log --pretty=3Dtformat:%s origin/master >actual &&
> +	echo three >expected &&
> +	echo two  >>expected &&

test_write_lines perhaps?

> +	test_cmp expected actual
> +'
