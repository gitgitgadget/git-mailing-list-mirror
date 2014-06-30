From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t0027: combinations of core.autocrlf, core.eol and text
Date: Mon, 30 Jun 2014 11:27:42 -0700
Message-ID: <xmqq61jiz201.fsf@gitster.dls.corp.google.com>
References: <53AFB38E.8000401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 20:28:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1gJC-0003k8-5V
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 20:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620AbaF3S1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 14:27:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57332 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756501AbaF3S1u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2014 14:27:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3EF623BDA;
	Mon, 30 Jun 2014 14:27:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IU44xZIPg1to
	JU/Jwme8iUZGdjQ=; b=kyYj8qiJCu6UbujA8fsz+IIEK+S78Dj8fJvVNzSAXniG
	lMQT2gkJB8OOvS5PHmxM/QGPn2IMW3eUjV5CRVD5gzP0GZ7dn6cZKnaUZAKQx4+g
	trFvknjeuCCTGoIEy6FbxUSgDHiznesjboCd4AimHipBSlo1XQZ9KROKA/tO3yE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pnQzji
	lYWFxC8PbYwFYSoXq72dpifYQ+0mS1X4+9wmQDWDmH797lQhRpWLCn5uTnnfVlon
	kQAIOR8bYgSGhgWCPbl5x6Vrh7BYyXHS3x1u+8nj9O7pHJ/jUGjJnuAIvFan+4UP
	UMP4LGpqeMEdAe61LjLHy32BpYUE9Ae0Nvpxk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C98E123BD9;
	Mon, 30 Jun 2014 14:27:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B264C23BCA;
	Mon, 30 Jun 2014 14:27:35 -0400 (EDT)
In-Reply-To: <53AFB38E.8000401@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sun, 29 Jun 2014 08:34:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3545B5B0-0084-11E4-8639-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252699>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Historically there are 3 different parameters controlling how line en=
dings
> are handled by Git:
> - core.autocrlf
> - core.eol
> - the "text" attribute in .gitattributes
>
> There are different types of content:
> - (1) Files with only LF
> - (2) Files with only CRLF
> - (3) Files with mixed LF and CRLF
> - (4) Files with LF and/or CRLF with CR not followed by LF
> - (5) Files which are binary (e.g. have NUL bytes)
>
> Recently the question came up, how files with mixed EOLs are handled =
by Git
> (and libgit2) when they are checked out and core.autocrlf=3Dtrue.

I have a slight suspicion that it may be better to leave behaviour
on some nonsensical combinations (e.g. 3 and 4) as "unspecified",
which would mean we shouldn't be able to pick between
test_expect_success and test_expect_failure for some of them.

> +test_description=3D'CRLF conversion all combinations'
> +
> +check_files_in_ws()
> +{

(minor) Please have SP between "ws" and "()".


> +(
> +	type od >/dev/null &&
> +	printf "line1Q\r\nline2\r\nline3" | q_to_nul >CRLF_nul &&
> +	cat >expect <<-EOF &&
> +	0000000 l i n e 1 \0 \r \n l i n e 2 \r \n l
> +	0000020 i n e 3
> +	0000024
> +EOF
> +	od -c CRLF_nul | sed -e "s/[ 	][	 ]*/ /g" -e "s/ *$//" >actual
> +	test_cmp expect actual &&
> +	rm expect actual
> +) || {
> +		skip_all=3D"od not found or od -c not usable"
> +		exit 0
> +		test_done
> +}

I am not sure how cast-in-stone portable "od -c" output is across
platforms in practice.  You can use tr to convert NUL, CR and LF to
some distinctive and otherwise unused character, just like you use
q_to_nul to map NUL to "Q" already.  And that would allow you to
forget about such portability issues.


> +test_expect_success 'setup master' '
> +	echo >.gitattributes &&
> +	git checkout -b master &&
> +	git add .gitattributes &&
> +	git commit -m "add .gitattributes" "" &&
> +	printf "line1\nline2\nline3"     >LF &&
> +	printf "line1\r\nline2\r\nline3" >CRLF &&
> +	printf "line1\r\nline2\nline3"   >CRLF_mix_LF &&
> +	printf "line1\nline2\rline3"     >LF_mix_CR &&
> +	printf "line1\r\nline2\rline3"   >CRLF_mix_CR &&
> +	printf "line1Q\nline2\nline3" | q_to_nul >LF_nul

I do not see why you would want files that end with incomplete lines
for these.  Please have the line-end for the last line in them.
