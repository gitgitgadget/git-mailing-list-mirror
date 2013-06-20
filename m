From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7400: test of UTF-8 submodule names pass under Mac OS
Date: Thu, 20 Jun 2013 12:01:05 -0700
Message-ID: <7vwqpotxn2.fsf@alter.siamese.dyndns.org>
References: <201306201658.50174.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, iveqy@iveqy.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 20 21:01:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upk6k-0007uR-3M
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 21:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669Ab3FTTBS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Jun 2013 15:01:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60870 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161288Ab3FTTBR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 15:01:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E46F629F14;
	Thu, 20 Jun 2013 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7GXANKEfvAAT
	0l0jU/+r6fld+ZY=; b=PuPQAuNrsTN1sqX06B3Jvrp8JrzmK/wt81lEhVBKhzAD
	UKHzKardxI9HZ9g4huifbeGHcC5sP6D7kmivf5rIMoym48h71lAEnF2WxvdcFus9
	FvycrCZhPvI2zPjn1IkY0vVz48akH8Y4iwSR59r9uFOiqgolrh/Z/qelNcfQG+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vx93+s
	KAFDRUmxEbcjz1L6lXgcU4UksJic6kv2ssnzchQlCg9Dy8uYkWTT5hrPVbqVotpK
	TvdKg4RRK8Pxo8T/o/8aV1aQjZvLx2XJ5O0q2W+YpkiYSjB+ZJVJ24VE7fljsp9T
	GVQ8hUX6TH/6wabNtnFPDwfYpw/T46m/KjIII=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBCA129F13;
	Thu, 20 Jun 2013 19:01:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29B2029F0D;
	Thu, 20 Jun 2013 19:01:16 +0000 (UTC)
In-Reply-To: <201306201658.50174.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 20 Jun 2013 16:58:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8A4290C-D9DB-11E2-AD7C-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228522>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> submodules with names using UTF-8 need core.precomposeunicode true
> under Mac OS X, set it in the TC.

I take that TC stands for test case?

> +test_expect_success 'submodule with UTF-8 name' '
> +	mkdir "$svname" &&
>  	(
> -		cd "=C3=A5 =C3=A4=C3=B6" &&
> +		cd "$svname" &&
>  		git init &&
>  		touch sub
>  		git add sub
>  		git commit -m "init sub"
>  	)

While we are at it, let's fix this broken && chain.

> -	git submodule add "/=C3=A5 =C3=A4=C3=B6" &&
> -	test -n "$(git submodule | grep "=C3=A5 =C3=A4=C3=B6")"
> +	git config core.precomposeunicode true &&

and use test_config here.

> +	git submodule add /"$svname" &&
> +	git submodule >&2 &&
> +	test -n "$(git submodule | grep "$svname")"
>  '
>  test_done

Will queue with an obvious fix-up.  Thanks for catching.

-- >8 --
=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

submodules with names using UTF-8 need core.precomposeunicode true
under Mac OS X, set it in the test case.

Improve the portability:

  - Not all shells on all OS may understand literal UTF-8 strings.
  - Use a help variable filled by printf, as we do it in e.g. t0050.

"strange names" can be called UTF-8, rephrase the heading.

While at it, unbreak &&-chain in the test, and use test_config.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7400-submodule-basic.sh | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d5743ee..7e23421 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -868,16 +868,19 @@ test_expect_success 'submodule deinit fails when =
submodule has a .git directory
 	test -n "$(git config --get-regexp "submodule\.example\.")"
 '
=20
-test_expect_success 'submodule with strange name works "=C3=A5 =C3=A4=C3=
=B6"' '
-	mkdir "=C3=A5 =C3=A4=C3=B6" &&
+test_expect_success 'submodule with UTF-8 name' '
+	svname=3D$(printf "\303\245 \303\244\303\266") &&
+	mkdir "$svname" &&
 	(
-		cd "=C3=A5 =C3=A4=C3=B6" &&
+		cd "$svname" &&
 		git init &&
-		touch sub
-		git add sub
+		>sub &&
+		git add sub &&
 		git commit -m "init sub"
-	)
-	git submodule add "/=C3=A5 =C3=A4=C3=B6" &&
-	test -n "$(git submodule | grep "=C3=A5 =C3=A4=C3=B6")"
+	) &&
+	test_config core.precomposeunicode true &&
+	git submodule add ./"$svname" &&
+	git submodule >&2 &&
+	test -n "$(git submodule | grep "$svname")"
 '
 test_done
--=20
1.8.3.1-674-g24fae08
