From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/1] t6038; use crlf on all platforms
Date: Tue, 17 May 2016 11:39:35 -0700
Message-ID: <xmqqa8jowmu0.fsf@gitster.mtv.corp.google.com>
References: <573A993F.8020205@web.de>
	<1463501398-8608-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Tue May 17 20:39:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2juQ-0006ew-NH
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 20:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbcEQSjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2016 14:39:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751989AbcEQSjo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2016 14:39:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D08D41CF7F;
	Tue, 17 May 2016 14:39:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JW7GKpLX1/p7
	oS4TOkFp/6zl5uc=; b=H2ns7Xr0scBNXSgui8dCicjFiwTrwQ45MrHitTE/Bbox
	GArf3xATQWWZ+2G+vavV8upZS5/aq8mSOLlYwSUyuUyY+pWofxN/I8OLhJA0j0WO
	ISBluoivFzQ9BXxFnAYgCIvgvV97ze5wwkwHN8Ex+7Ov4S4XRZP3pOuWih6nRoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ulsEko
	WiJX3hiEznkdeaFPudFrP4KrC81LmkT3FkbV2IcqPe16a8ZyqgrUUH6hLP+XoGXb
	bzo4yJ1n8H1pIMdGWP3u3Rsaa9xkE0uAkIjHhgE6abhMZYKCNhbV4qelXhCBp0gR
	w/ew7XG0XAHOSsRr1xRwXiUeimGLhUIyrhOvw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C6E431CF7E;
	Tue, 17 May 2016 14:39:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B2341CF7B;
	Tue, 17 May 2016 14:39:37 -0400 (EDT)
In-Reply-To: <1463501398-8608-1-git-send-email-tboegi@web.de> (tboegi@web.de's
	message of "Tue, 17 May 2016 18:09:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B51E4A34-1C5E-11E6-B6EC-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294894>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> t6038 uses different code, depending if NATIVE_CRLF is set ot not.
> When the native line endings are LF, merge.renormalize is not tested =
very well.
> Change the test to always use CRLF by setting core.eol=3Dcrlf.
> ---
> Broke the 10/10 series into smaller pieces, this is the update of t60=
38

Thanks.

 - Missing sign-off.

 - "... is not tested very well", which implies "with this change,
   it will be tested", is a secondary benefit.  The reader need to
   agree that, whether the platform native line ending is CRLF or
   LF, 'git merge' should behave identically on any platform, as
   long as the line ending convention used in the repository is
   explicitly set in the same way, before agreeing that this is a
   good thing to do in general.  And that is a bigger benefit, no?

 - But doesn't the same principle apply in the other direction?
   When forced to do core.eol=3Dlf, a platform with NATIVE_CRLF should
   behave identically to how a platform without NATIVE_CRLF would?

   With this patch, we lose test coverage for core.eol=3Dlf case,
   which used to be tested on non-NATIVE_CRLF platforms.  Isn't that
   a concern to us?

>  t/t6038-merge-text-auto.sh | 37 +++++++++++-------------------------=
-
>  1 file changed, 11 insertions(+), 26 deletions(-)
>
> diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
> index 85c10b0..4dc8c1a 100755
> --- a/t/t6038-merge-text-auto.sh
> +++ b/t/t6038-merge-text-auto.sh
> @@ -18,6 +18,7 @@ test_have_prereq SED_STRIPS_CR && SED_OPTIONS=3D-b
> =20
>  test_expect_success setup '
>  	git config core.autocrlf false &&
> +	git config core.eol crlf &&
> =20
>  	echo first line | append_cr >file &&
>  	echo first line >control_file &&
> @@ -72,10 +73,8 @@ test_expect_success 'Merge after setting text=3Dau=
to' '
>  	same line
>  	EOF
> =20
> -	if test_have_prereq NATIVE_CRLF; then
> -		append_cr <expected >expected.temp &&
> -		mv expected.temp expected
> -	fi &&
> +	append_cr <expected >expected.temp &&
> +	mv expected.temp expected &&
>  	git config merge.renormalize true &&
>  	git rm -fr . &&
>  	rm -f .gitattributes &&
> @@ -90,10 +89,8 @@ test_expect_success 'Merge addition of text=3Dauto=
' '
>  	same line
>  	EOF
> =20
> -	if test_have_prereq NATIVE_CRLF; then
> -		append_cr <expected >expected.temp &&
> -		mv expected.temp expected
> -	fi &&
> +	append_cr <expected >expected.temp &&
> +	mv expected.temp expected &&
>  	git config merge.renormalize true &&
>  	git rm -fr . &&
>  	rm -f .gitattributes &&
> @@ -104,15 +101,9 @@ test_expect_success 'Merge addition of text=3Dau=
to' '
> =20
>  test_expect_success 'Detect CRLF/LF conflict after setting text=3Dau=
to' '
>  	echo "<<<<<<<" >expected &&
> -	if test_have_prereq NATIVE_CRLF; then
> -		echo first line | append_cr >>expected &&
> -		echo same line | append_cr >>expected &&
> -		echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected
> -	else
> -		echo first line >>expected &&
> -		echo same line >>expected &&
> -		echo =3D=3D=3D=3D=3D=3D=3D >>expected
> -	fi &&
> +	echo first line | append_cr >>expected &&
> +	echo same line | append_cr >>expected &&
> +	echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
>  	echo first line | append_cr >>expected &&
>  	echo same line | append_cr >>expected &&
>  	echo ">>>>>>>" >>expected &&
> @@ -128,15 +119,9 @@ test_expect_success 'Detect LF/CRLF conflict fro=
m addition of text=3Dauto' '
>  	echo "<<<<<<<" >expected &&
>  	echo first line | append_cr >>expected &&
>  	echo same line | append_cr >>expected &&
> -	if test_have_prereq NATIVE_CRLF; then
> -		echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
> -		echo first line | append_cr >>expected &&
> -		echo same line | append_cr >>expected
> -	else
> -		echo =3D=3D=3D=3D=3D=3D=3D >>expected &&
> -		echo first line >>expected &&
> -		echo same line >>expected
> -	fi &&
> +	echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
> +	echo first line | append_cr >>expected &&
> +	echo same line | append_cr >>expected &&
>  	echo ">>>>>>>" >>expected &&
>  	git config merge.renormalize false &&
>  	rm -f .gitattributes &&
