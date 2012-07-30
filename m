From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: improve RFC2047 quote parsing
Date: Mon, 30 Jul 2012 14:05:09 -0700
Message-ID: <7vzk6hot8a.fsf@alter.siamese.dyndns.org>
References: <cb7aa2a8fc08df4f1d12add603ffcbc104f67823.1343676034.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	Christoph Miebach <christoph.miebach@web.de>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?SsO8cmdlbiBSw7xobGU=?= <j-r@online.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 30 23:05:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svx9T-00064q-NK
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 23:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675Ab2G3VFN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 17:05:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754599Ab2G3VFM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 17:05:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7B158FC2;
	Mon, 30 Jul 2012 17:05:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xp1n7yrEAc9a
	E18izvD+In21sno=; b=JU+eophk0byLfzGsMbTgW6DALer1GZE5n4EJkANcMwMJ
	+uLyhmIx3GrsKG23arrOkIpC2RaGEiBDr8OXCFeLgpuOgH8o1hf37j+2xRCSI75V
	GbwvNB7xNPzD+qsJ/fWe5uby7OX7TPerIHcmBiC47nBLAA9X+lY9RGPgreR0GR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=keDKjg
	7djGGDI+Fq/mAhtWONPxbPnOBamoUqAZlC6JIlGdp/GCO/iJCpDvsjd6y61HrCGu
	pKwUgVoc0TSQQy7JQ5VXIhBQk/vqAR93fmfG87o2NKyAhp84Bj/jOHKHErxQSP5N
	xMzL0bjHq1yN1Sqr0a8DesQXlLG5UP74pAbjU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1F8A8FC1;
	Mon, 30 Jul 2012 17:05:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB2F78FC0; Mon, 30 Jul 2012
 17:05:10 -0400 (EDT)
In-Reply-To: <cb7aa2a8fc08df4f1d12add603ffcbc104f67823.1343676034.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon, 30 Jul 2012 21:25:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FDE8BB8-DA8A-11E1-88B1-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202615>

Thomas Rast <trast@student.ethz.ch> writes:

> The RFC2047 unquoting, used to parse email addresses in From and Cc
> headers, is broken in several ways:
>
> * It erroneously substitutes ' ' for '_' in *the whole* header, even
>   outside the quoted field. [Noticed by Christoph.]
>
> * It is too liberal in its matching, and happily matches the start of
>   one quoted chunk against the end of another, or even just something
>   that looks like such an end. [Noticed by Junio.]
>
> * It fundamentally cannot cope with encodings that are not a superset
>   of ASCII, nor several (incompatible) encodings in the same header.
>
> This patch fixes the first two by doing a more careful decoding of th=
e
> =3DAB outer quoting.  Fixing the fundamental issues is left for a
> future, more intrusive, patch.

What is this =3DAB thing?

>
> Noticed-by: Christoph Miebach <christoph.miebach@web.de>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> This is the easy part, fixed as per Junio's comment that it needs to
> use a .*? match for the contents, and with a test.

What's the hard part?  Do you mean the "fundamentally cannot" part?

Thanks.

>  git-send-email.perl   | 10 ++++++----
>  t/t9001-send-email.sh | 13 +++++++++++++
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index ef30c55..6647137 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -862,11 +862,13 @@ sub make_message_id {
>  sub unquote_rfc2047 {
>  	local ($_) =3D @_;
>  	my $encoding;
> -	if (s/=3D\?([^?]+)\?q\?(.*)\?=3D/$2/g) {
> +	s{=3D\?([^?]+)\?q\?(.*?)\?=3D}{
>  		$encoding =3D $1;
> -		s/_/ /g;
> -		s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
> -	}
> +		my $e =3D $2;
> +		$e =3D~ s/_/ /g;
> +		$e =3D~ s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
> +		$e;
> +	}eg;
>  	return wantarray ? ($_, $encoding) : $_;
>  }
> =20
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 8c12c65..0351228 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -841,6 +841,19 @@ test_expect_success $PREREQ '--compose adds MIME=
 for utf8 subject' '
>  	grep "^Subject: =3D?UTF-8?q?utf8-s=3DC3=3DBCbj=3DC3=3DABct?=3D" msg=
txt1
>  '
> =20
> +test_expect_success $PREREQ 'utf8 author is correctly passed on' '
> +	clean_fake_sendmail &&
> +	test_commit weird_author &&
> +	test_when_finished "git reset --hard HEAD^" &&
> +	git commit --amend --author "F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <o=
dd_?=3Dmail@example.com>" &&
> +	git format-patch --stdout -1 >funny_name.patch &&
> +	git send-email --from=3D"Example <nobody@example.com>" \
> +	  --to=3Dnobody@example.com \
> +	  --smtp-server=3D"$(pwd)/fake.sendmail" \
> +	  funny_name.patch &&
> +	grep "^From: F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd_?=3Dmail@exam=
ple.com>" msgtxt1
> +'
> +
>  test_expect_success $PREREQ 'detects ambiguous reference/file confli=
ct' '
>  	echo master > master &&
>  	git add master &&
