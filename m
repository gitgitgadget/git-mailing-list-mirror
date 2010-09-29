From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 02/15] t4017 (diff-retval): replace manual exit code
 check with test_expect_code
Date: Wed, 29 Sep 2010 11:07:54 -0700
Message-ID: <7vd3rwo22t.fsf@alter.siamese.dyndns.org>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 20:08:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P114c-0004id-2M
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 20:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897Ab0I2SIE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 14:08:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab0I2SIC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 14:08:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 193D0DA93F;
	Wed, 29 Sep 2010 14:08:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zcpvSEYwdEXL
	lEQ02ZOK5qY0Im8=; b=eCYCNY1ATRFDnaJzMfu86/4mVM0OSe85+q/hKjFziI3G
	cNXu4IBecGEusNeXvwhgjLwQs18MioA9Nri9783NNh1Vn5FZhGjNBobe7E7NEzAP
	NfLMaiJeq1jgUgBU6MDpkVg+mZodkqQkjbGFRuTXhD42d57/2zCzXWzAnYcKXs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wsauQg
	GXLfs50naQOIZA9QDAtX4N8oS0UaRarAB/S6StQuwDSeKiHdULV9jciWINTP7mbU
	N3r8zOfsfCafQOucPck/n1at+2F0gjYQaUOed2jla0YLNLrN5xwdipjA/5x0ojmV
	goruneg626y/ppuJONemvbwePv82FXPDDmGC0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 81F40DA93E;
	Wed, 29 Sep 2010 14:07:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEDFCDA93C; Wed, 29 Sep
 2010 14:07:55 -0400 (EDT)
In-Reply-To: <1285542879-16381-3-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Sun\, 26 Sep 2010 17\:14\:26 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7DA85902-CBF4-11DF-B3C7-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157586>

Elijah Newren <newren@gmail.com> writes:

> Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t4017-diff-retval.sh |   30 ++++++++++--------------------
>  1 files changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
> index 6158985..6605e12 100755
> --- a/t/t4017-diff-retval.sh
> +++ b/t/t4017-diff-retval.sh
> @@ -28,37 +28,29 @@ test_expect_success 'git diff --quiet -w  HEAD^ H=
EAD' '
>  	test_must_fail git diff --quiet -w HEAD^ HEAD
>  '
> =20
> -test_expect_success 'git diff-tree HEAD^ HEAD' '
> +test_expect_code 1 'git diff-tree HEAD^ HEAD' '
>  	git diff-tree --exit-code HEAD^ HEAD
> -	test $? =3D 1
>  '
> -test_expect_success 'git diff-tree HEAD^ HEAD -- a' '
> +test_expect_code 0 'git diff-tree HEAD^ HEAD -- a' '
>  	git diff-tree --exit-code HEAD^ HEAD -- a
> -	test $? =3D 0
>  '

It probably is better to simply drop "test $? =3D 0" and keep the
expect-success, no?
