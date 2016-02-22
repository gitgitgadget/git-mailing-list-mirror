From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] t3034: add rename threshold tests
Date: Mon, 22 Feb 2016 11:03:50 -0800
Message-ID: <xmqqh9h07ejt.fsf@gitster.mtv.corp.google.com>
References: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
	<1456095545-20201-3-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	sunshine@sunshineco.com,
	Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis 
	<felipegassis@gmail.com>
To: =?utf-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 20:04:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXvmI-0001W4-2F
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 20:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbcBVTEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 14:04:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751907AbcBVTDw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 14:03:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A160472DB;
	Mon, 22 Feb 2016 14:03:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QwfuT2qQAnH3
	q6ZndYvt8LHy9NU=; b=M+X9LWQeoyDkF0BV6jvbAMGhq3qb6mpJ4WnGqhUlQJiY
	ZvW1DHYdlUk0GXND6utQspo2lwAfJ0us5l9SZW7i/HeSgNN3HPID7ohHzN0pFOGB
	PlfLOku8jxUZsanTsO0VKXE8mbNUHgHGvkLOQIHlwQ4R1y09sBVpNFbPNPvlCcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iYyyms
	jjFUO/UI7Ro5XBV04tfhUKop7wQMjP2UwT7RU8IRwXwhNDKY0de2WBpP/d2zDyo5
	ghCgyMPL03CGEaDzuh4cgw3RrgvzbIKuBm59lvyfCtcJ9Qf8hVZXA3QcWRVUzx+K
	ddGO4wU+x7HurM2voRz2zopJLURj5qVpX1ouM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21024472DA;
	Mon, 22 Feb 2016 14:03:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 90BDE472D8;
	Mon, 22 Feb 2016 14:03:51 -0500 (EST)
In-Reply-To: <1456095545-20201-3-git-send-email-felipegassis@gmail.com>
	("Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis"'s message of "Sun, 21 Feb 2016
 19:59:02
	-0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 02DE76D2-D997-11E5-86E5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286943>

"Felipe Gon=C3=A7alves Assis"  <felipeg.assis@gmail.com> writes:

> 10ae752 (merge-recursive: option to specify rename threshold,
> 2010-09-27) introduced this feature but did not include any tests.
>
> The tests use the new option --find-renames, which replaces the then
> introduced and now deprecated option --rename-threshold.
> ...
> diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merg=
e-recursive-rename-options.sh
> new file mode 100755
> index 0000000..7ae7f83
> --- /dev/null
> +++ b/t/t3034-merge-recursive-rename-options.sh
> @@ -0,0 +1,159 @@
> +#!/bin/sh
> +
> +test_description=3D'merge-recursive rename options
> +
> +Test rename detection by examining rename/delete conflicts.
> +
> +Similarity index:
> +R100 a-old a-new
> +R075 b-old b-new
> +R050 c-old c-new
> +R025 d-old d-new
> +'
> ...
> +test_expect_success setup '
> +	cat <<-\EOF >a-old &&
> +	aa1
> +	aa2
> +	aa3
> +	aa4
> +	EOF
> +	sed s/aa/bb/ <a-old >b-old &&
> +	sed s/aa/cc/ <a-old >c-old &&
> +	sed s/aa/dd/ <a-old >d-old &&
> +	git add [a-d]-old &&
> +	git commit -m base &&
> +	git rm [a-d]-old &&
> +	git commit -m delete &&
> +	git checkout -b rename HEAD^ &&
> +	cp a-old a-new &&
> +	sed 1,1s/./x/ <b-old >b-new &&
> +	sed 1,2s/./x/ <c-old >c-new &&
> +	sed 1,3s/./x/ <d-old >d-new &&
> +	git add [a-d]-new &&
> +	git rm [a-d]-old &&
> +	git commit -m rename &&
> +	get_expected_stages a &&
> +	get_expected_stages b &&
> +	get_expected_stages c &&
> +	get_expected_stages d
> +'

I somehow doubt that it is wise to make the similarity index
computed by the current heuristics as a hard promise like this test
does.

This test specifies that turning the original bb1/bb2/bb3/bb4 into
updated xb1/bb2/bb3/bb4 _MUST_ get 75% similarity, but that is not
something we want to guarantee, ever.  We may later update the
algorithm and tweak such a change to register 70% or 78%, but such a
change would break the expectation by this test.  This test script
however should not be interested in the exact similarity index
assignment for a given filepair--it only wants to make sure that the
option chooses the filepair with similarity index above the given
value.

The test for --find-renames=3D<num> should instead only validate that
the code works on the value given from the command line relative to
the similarity index the code computed.  I.e. first measure what the
similarity index going from b-old to b-new is (e.g. it may say 76%,
or 74%, depending on the version of Git being tested), then choose a
value that is higher (or lower) than that similarity to give to
the --find-renames=3D<num> option and ensure that merge-recursive does
what is expected.

I am not very happy with this one.
