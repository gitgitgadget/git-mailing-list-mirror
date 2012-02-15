From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3 v4] diff --stat: use the full terminal width
Date: Tue, 14 Feb 2012 17:18:01 -0800
Message-ID: <7vwr7o3nee.fsf@alter.siamese.dyndns.org>
References: <7vsjie9q77.fsf@alter.siamese.dyndns.org>
 <1329263146-19215-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Feb 15 02:18:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxTVc-0001ih-KP
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 02:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761443Ab2BOBSI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 20:18:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49372 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761418Ab2BOBSG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 20:18:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A43C67EF;
	Tue, 14 Feb 2012 20:18:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=H4B35ZwT0W+mqTF3h/lU0Bi23
	2U=; b=uNrOHPRzduHTHowABa06TkGiBkCMQErS8SIwX1zjOdOvk9lNbpCXow6v6
	w3+97KZATbFzCsuTnLT7+kCgpcXLl8lhZ8olbEwrBxQKeNJnAXoiiDqIJfnwK3KH
	YsUgGODDFsYjxYSgwjqTIi81CTMYfeLotYuMWiJb3WyqWtwrNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=NQiIal9sIP6mxoE9nX/
	ZR/uImbcnXxtbAkKj/UKJGZUcBmVR7j348Eq+MOm3UCIT/nYmpQKl4UMqM0PDnvs
	YlIN1NTbToVNVxL26AJvSeG6M0TtTCixG/imvw78as/u9DegHomDmiI8OW6mEarX
	SbbVAcku0eUTJXfgDOSvNMfw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10FE967EE;
	Tue, 14 Feb 2012 20:18:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65AB267ED; Tue, 14 Feb 2012
 20:18:03 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E87C398C-5772-11E1-923D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190805>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> - comments are updated and the word "histogram" is banished

Heh, I still see at least three instances of them in this patch.

> - use decimal_width(max_change) to calculate number of columns

Please see comments for 3/3 I'll send separately.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 6797512..a65ade4 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -894,4 +894,100 @@ test_expect_success 'format patch ignores color=
=2Eui' '
>  	test_cmp expect actual
>  '
> =20
> +name=3Daaaaaaaaaa
> +name=3D$name$name$name$name$name$name$name$name$name$name$name$name

How long is this name?  120 columns?  I think that should be fine for a=
ny
filesystem we care about.

> +test_expect_success 'preparation' "
> +	> ${name} &&
> +	git add ${name} &&
> +	git commit -m message &&
> +	echo a > ${name} &&
> +	git commit -m message ${name}
> +"

Please write these (exactly -- paying close attention to SP) like this:

	>"$name" &&
	git add "$name" &&
        git commit -m message &&
        echo a >"$name" &&
        git commit -m message "$name"

Points to note:

 - Even though you (and the reader) may know that "$name" does not cont=
ain
   word-breaking spaces, writing double-quotes around it reduces the
   mental burden from the readers;

 - Strictly speaking, the target of I/O redirection (e.g. >"$name") doe=
s
   not have to have quotes around it, but some versions of bash are kno=
wn
   to give misguided warnings against it;

 - We do not write SP between the redirection and filename, but we do h=
ave
   one SP before the redirection; and

 - Unless you want to express concatenation with string that can appear
   later in words (e.g. "${name}1"), avoid ${name} to lessen the mental
   burden to readers, as "${" often signals there is some magic coming
   (e.g. "${name#strip}").

> +cat >expect <<'EOF'
> + ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaa | 1 +
> +EOF
> +test_expect_success 'format patch graph width is 80 columns' '

Please make sure this test (and all the other new tests) pass with or
without your the patch that updates diff.c, as we need to ensure that
COLUMNS=3D80 or vanilla format-patch produces result that is identical =
to
the old output without regression (again, see comments to [PATCH 3/3]).

> +	git format-patch --stat --stdout -1 |
> +		grep -m 1 aaaaa > actual &&

Do not use "grep -m $count"; it is not portable.

Literal translation of the above would be:

	sed -n -e "/aaaaa/{
        	p
                q
	}"

but you can perhaps rely on the fact that there is only one path and '|=
'
does not ppear in the payload or log message, and use this instead:

	grep "|" >actual

Also to catch errors in format-patch that unexpectedly dies (after all,
you are touching diff machinery with your patch), avoid using pipes, an=
d
write it perhaps like this:

	git format-patch --stat --stdout -1 >output &&
        grep "|" >actual &&
