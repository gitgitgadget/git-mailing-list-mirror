From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Suppress "statement not reached" warnings under Sun
 Studio
Date: Wed, 21 Dec 2011 10:27:29 -0800
Message-ID: <7vvcp9hjam.fsf@alter.siamese.dyndns.org>
References: <1324430302-22441-1-git-send-email-avarab@gmail.com>
 <1324430302-22441-5-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jason Evans <jasone@canonware.com>,
	David Barr <david.barr@cordelta.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 19:27:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdQt9-00079e-2R
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 19:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab1LUS1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Dec 2011 13:27:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49219 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908Ab1LUS1d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2011 13:27:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1640C52E0;
	Wed, 21 Dec 2011 13:27:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iUfLJJN5tp4x
	YUfYc0z/t2rvUpI=; b=ixQ5GHBBbCHNRf3A8ESrhBATZzzPSBJErSroFW7vSaV8
	CtMgp9z/GNWUaQgmgtvL7IehYQ5q+jnuaKhXpSmharvXCrCDRMcy/mY3SttYP5Pz
	t6I9jaglnIV1EuHyk3PST2jZ8d0dFMZopy/puV6Ci4B+u9MJRpvYC+x3YuonWV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pYzuDS
	aVGSM0a4S4M+9lkD5xgdjVjiUnLiLThNnuVWEfLdQz50faLM3TTPsfvdp/tp1duY
	NKZgToi5mj+eqmepwaicTaT8VZsLmWelFYxhVOItDZyXBeke2DhfULj9pZtxGOKv
	G2seMq2qlZb/AIpNXb8dlg62e/uyq5XxI72qc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D50D52DF;
	Wed, 21 Dec 2011 13:27:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9516852DD; Wed, 21 Dec 2011
 13:27:31 -0500 (EST)
In-Reply-To: <1324430302-22441-5-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 21 Dec
 2011 01:18:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71F3E126-2C01-11E1-860E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187575>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/read-cache.c b/read-cache.c
> index a51bba1..0a4e895 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -758,7 +758,13 @@ int verify_path(const char *path)
>  		return 0;
> =20
>  	goto inside;
> +#ifdef __sun
> +#	pragma error_messages (off, E_STATEMENT_NOT_REACHED)
> +#endif
>  	for (;;) {
> +#ifdef __sun
> +#	pragma error_messages (on, E_STATEMENT_NOT_REACHED)
> +#endif
>  		if (!c)
>  			return 1;

Patches 1-3 makes sense, but this one is too ugly to live.

Wouldn't something like this be equivalent and have the same effect
without sacrificing the readablity?

diff --git a/read-cache.c b/read-cache.c
index a51bba1..73af797 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -757,12 +757,12 @@ int verify_path(const char *path)
 	if (has_dos_drive_prefix(path))
 		return 0;
=20
-	goto inside;
+	/* we are at the beginning of a path component */
+	c =3D '/';
 	for (;;) {
 		if (!c)
 			return 1;
 		if (is_dir_sep(c)) {
-inside:
 			c =3D *path++;
 			if ((c =3D=3D '.' && !verify_dotfile(path)) ||
 			    is_dir_sep(c) || c =3D=3D '\0')
