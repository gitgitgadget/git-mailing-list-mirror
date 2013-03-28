From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/5] commit.c/GPG signature verification: Also look at
 the first GPG status line
Date: Thu, 28 Mar 2013 15:33:01 -0700
Message-ID: <7v620brw82.fsf@alter.siamese.dyndns.org>
References: <7vli9bue40.fsf@alter.siamese.dyndns.org>
 <cover.1364295502.git.jaseg@physik-pool.tu-berlin.de>
 <51518106.6060804@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Thu Mar 28 23:33:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULLOH-00057M-12
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 23:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab3C1WdG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Mar 2013 18:33:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753381Ab3C1WdD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Mar 2013 18:33:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32AA4E3B5;
	Thu, 28 Mar 2013 22:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rU6CDLYSYAMC
	y6ofUPXb0JxkfA0=; b=bWdFqO7QAHqyhmALF4NkxsJ4yrxXXbbRGTt46Qff8Tsa
	/wK8u79gBQzHVymmjMcAkXxP8AUQnnxYVg2Ab9vvVj8g6k0y5PAxDOUHPciDWEPD
	K0Ijdj6DwvT/X5u71aw7ZO3TH3ARqA3wnzfrbRkVLmh/4GYMC0cQGAVt6qtxZ0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dgxrGT
	dSZP3QQtWV+wiRc/LbWh+VqsKxrjLN/5z4cXWyfCc8zBeCMLA3UYMVMe9NJqCXOA
	aQ5UjNIRuYVD8Feq22Go1HHWcMl/opwAnMHlmv2edLhCp4nQQj4Iwt0TXQHSB57x
	eUG4D7/GJHbo6qXN4TlVCNn0vmNZwzyb9ru/k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28299E3B4;
	Thu, 28 Mar 2013 22:33:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73B2FE3B2; Thu, 28 Mar 2013
 22:33:02 +0000 (UTC)
In-Reply-To: <51518106.6060804@physik.tu-berlin.de> ("Sebastian
 =?utf-8?Q?G=C3=B6tte=22's?= message of "Tue, 26 Mar 2013 12:05:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 737CE322-97F7-11E2-9273-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219473>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> Signed-off-by: Sebastian G=C3=B6tte <jaseg@physik-pool.tu-berlin.de>
> ---
>  commit.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 1aeb17a..533727c 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1027,8 +1027,8 @@ static struct {
>  	char result;
>  	const char *check;
>  } signature_check[] =3D {
> -	{ 'G', "\n[GNUPG:] GOODSIG " },
> -	{ 'B', "\n[GNUPG:] BADSIG " },
> +	{ 'G', "[GNUPG:] GOODSIG " },
> +	{ 'B', "[GNUPG:] BADSIG " },
>  };
> =20
>  static void parse_signature_lines(struct signature *sig)
> @@ -1041,6 +1041,9 @@ static void parse_signature_lines(struct signat=
ure *sig)
>  		const char *next;
>  		if (!found)
>  			continue;
> +		if (found !=3D buf)=20
> +			if (found[-1] !=3D '\n')
> +				continue;

It would be much easier to read if it were "unless we are not
looking at the very first byte, the previous byte must be LF", i.e.

	if (found !=3D buf && found[-1] !=3D '\n')

Is that continue correct?  Don't you want to retry from the end of
the line that contains the mistaken hit?

The "\n" at the beginning anchors the expected string for quicker
multi-line scan done with strstr().  If you really want to lose that
LF and still write this function correctly and clearly, I think you
would need to iterate over the buffer line by line.

What you want to do may be more like this, I think.

 commit.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/commit.c b/commit.c
index d093c9c..d6e0b00 100644
--- a/commit.c
+++ b/commit.c
@@ -1045,8 +1045,8 @@ static struct {
 	char result;
 	const char *check;
 } signature_check[] =3D {
-	{ 'G', "[GNUPG:] GOODSIG " },
-	{ 'B', "[GNUPG:] BADSIG " },
+	{ 'G', "\n[GNUPG:] GOODSIG " },
+	{ 'B', "\n[GNUPG:] BADSIG " },
 };
=20
 static void parse_signature_lines(struct signature *sig)
@@ -1055,15 +1055,18 @@ static void parse_signature_lines(struct signat=
ure *sig)
 	int i;
=20
 	for (i =3D 0; i < ARRAY_SIZE(signature_check); i++) {
-		const char *found =3D strstr(buf, signature_check[i].check);
-		const char *next;
-		if (!found)
-			continue;
-		if (found !=3D buf)
-			if (found[-1] !=3D '\n')
+		const char *found, *next;
+
+		if (!prefixcmp(buf, signature_check[i].check + 1)) {
+			/* At the very beginning of the buffer */
+			found =3D buf + strlen(signature_check[i].check + 1);
+		} else {
+			found =3D strstr(buf, signature_check[i].check);
+			if (!found)
 				continue;
+			found +=3D  strlen(signature_check[i].check);
+		}
 		sig->check_result =3D signature_check[i].result;
-		found +=3D strlen(signature_check[i].check);
 		sig->key =3D xmemdupz(found, 16);
 		found +=3D 17;
 		next =3D strchrnul(found, '\n');
