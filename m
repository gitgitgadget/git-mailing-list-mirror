From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] pretty: Add failing tests: user format ignores
 i18n.logOutputEncoding setting
Date: Thu, 24 Jan 2013 13:02:56 -0800
Message-ID: <7vip6m9tvj.fsf@alter.siamese.dyndns.org>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
 <6de583a2d281b1614c69d5e7b6f5c4495488f6a3.1359018188.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 22:03:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyTxC-0000Qg-CC
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 22:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab3AXVDB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 16:03:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755905Ab3AXVC7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 16:02:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D83EBCF53;
	Thu, 24 Jan 2013 16:02:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6QQsr4s/vcy4
	kVeRN8ZhhY88rAY=; b=bua8pNTNywPAkh8erpbQqUoVEmQtS5xUfir/ReUqXn1Z
	JoYRV86xdMWxEZI+oM6cEl/pWNFS5Pj0HYE2NLZCVFqL/qi+FbpJP6M+nfyHRC0w
	Ammq22TdLwxgyseEaUmB5Klw571jVqX7jgSpep8crCawLriiaj2m/5172jvNSPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mEW0h/
	kEoZ3x5JLo6LaAu1n2R5p1aN0fYOM8urFVT+Lq0uvgclQR/+VIS80QVNE2+0JcTJ
	x5nhZ3wLIQSuaZYXJ8ZPpwjae4nJdojV89gx30lqKsICHOtQAOVdshK6r9gXXMO5
	hZYlkezUoPvG0/EgQue6aVhfvvxpB68g+N97s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBEE2CF52;
	Thu, 24 Jan 2013 16:02:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21688CF4F; Thu, 24 Jan 2013
 16:02:58 -0500 (EST)
In-Reply-To: <6de583a2d281b1614c69d5e7b6f5c4495488f6a3.1359018188.git.Alex.Crezoff@gmail.com> (Alexey Shumkin's message of "Thu, 24 Jan 2013 13:10:27 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E3A475C-6669-11E2-904E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214456>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index c248509..4db43a4 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> ...
> @@ -112,12 +133,12 @@ commit $head2
>  commit $head1
>  EOF
> =20
> -test_format raw-body %B <<'EOF'
> -commit 131a310eb913d107dd3c09a65d1651175898735d
> -changed foo
> +test_format failure raw-body %B <<EOF
> +commit $head2
> +$changed
> =20
> -commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
> -added foo
> +commit $head1
> +$added
> =20
>  EOF

It may have been easier to follow if you did this "Don't hardcode"
as a separate preparatory patch, like your first two patches.

> @@ -135,16 +156,16 @@ commit $head1
>  foo
>  EOF
> =20
> -cat >commit-msg <<'EOF'
> +iconv -f utf-8 -t cp1251 > commit-msg <<EOF
>  Test printing of complex bodies
> =20
>  This commit message is much longer than the others,
> -and it will be encoded in iso8859-1. We should therefore
> -include an iso8859 character: =C2=A1bueno!
> +and it will be encoded in cp1251. We should therefore
> +include an cp1251 character: =D1=82=D0=B0=D0=BA =D0=B2=D0=BE=D1=82!
>  EOF
> =20
>  test_expect_success 'setup complex body' '
> -	git config i18n.commitencoding iso8859-1 &&
> +	git config i18n.commitencoding cp1251 &&

What is going on here?

Is this an example that shows that i18n.commitencoding works
correctly with iso8859-1 but not with cp1251? =20

> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index cf492f4..699c824 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> ...
> @@ -192,7 +214,7 @@ test_expect_success \
>  	'changing files and redo the last commit should succeed' '
>  	echo "3rd line 2nd file" >>secondfile &&
>  	git commit -a -C ORIG_HEAD &&
> -	check_changes 3d3b7be011a58ca0c179ae45d94e6c83c0b0cd0d &&
> +	check_changes f06f78b8dd468c722952b77569dd0db212442c25 &&
>  	test "$(git rev-parse ORIG_HEAD)" =3D \
>  			$head5
>  '

This and remaining hunks to this script shows that it would be
helped by the same love you gave to other scripts with your first
two patches before you add the "non-unicode" tests, no?
