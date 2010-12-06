From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send: link against libcrypto for HMAC and others
Date: Sun, 05 Dec 2010 22:11:26 -0800
Message-ID: <7v39qbtoq9.fsf@alter.siamese.dyndns.org>
References: <7vwro2sd83.fsf@alter.siamese.dyndns.org>
 <1290629033-20566-1-git-send-email-flameeyes@gmail.com>
 <1291613304.3339.12.camel@fixed-disk>
 <1291613978.4756.157.camel@yamato.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
To: Diego Elio =?utf-8?Q?Petten=C3=B2?= <flameeyes@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 07:11:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPUIZ-00087a-0h
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 07:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135Ab0LFGLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 01:11:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab0LFGLh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 01:11:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9374335B;
	Mon,  6 Dec 2010 01:11:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RwnibuVELlD6
	nYfxzrXAwRvczwk=; b=SZ2cvaKaAo7XpJ0L5lyblewyiZyjPj/7VQn33ISR0bhM
	RLOC0urzxR821kHL6d9AFbyOO36Ya4sfSaWu9fbwyslm1POxnfrgrdrjz828efcM
	a37WO7+ZUU9NmIBUJI7+FeEUbFBH57Ua44nXUzf2YGlGYIEUbgdvPK9kOS6yN5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=v1+zSp
	0YGI05ZxdO4Iq8MaInVKbGKZw2AjIJRe+UVKBT6l09GM/xxsSCnLWLO5+Hv9LuXn
	WO3apCD73gmZywilhePoSHUUQ6KclSZgYkTx8GhOsDau4NG76dm+8djqaFhRnHBe
	CKu+Wia/P0tgD0HLPHyhEejSjcUDTSlG4prTM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A4E233358;
	Mon,  6 Dec 2010 01:11:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C1773357; Mon,  6 Dec 2010
 01:11:50 -0500 (EST)
In-Reply-To: <1291613978.4756.157.camel@yamato.local> ("Diego Elio
 =?utf-8?Q?Petten=C3=B2=22's?= message of "Mon\, 06 Dec 2010 06\:39\:38
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B9479884-00FF-11E0-B3C8-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162976>

Diego Elio Petten=C3=B2 <flameeyes@gmail.com> writes:

> Il giorno lun, 06/12/2010 alle 00.28 -0500, Anders Kaseorg ha scritto=
:
>> This broke the build with NO_OPENSSL=3D1, so Debian will need to rev=
ert
>> it:
>
> I'll try a NO_OPENSSL build later on today and see to get it fixed.
>
>> Also, the Makefile already has a NEEDS_CRYPTO_WITH_SSL flag that=E2=80=
=99s
>> automatically set on Darwin, Windows, and MinGW.  We shouldn=E2=80=99=
t have two
>> mechanisms for addressing the same problem; maybe we just need to en=
able
>> the existing flag on more (or all) platforms?
>
> No, these should be different issues; you may have a libssl (which us=
es
> libcrypto) requiring libcrypto to be linked in, even if you only use
> interfaces from libssl (and that's what NEEDS_CRYPTO_WITH_SSL seem to=
 be
> designed to deal with), but in this case what you have is rather
> imap-send using the libcrypto interfaces _as well as_ the libssl
> interfaces.

You are both correct; the point of NO_OPENSSL is not to link with anyth=
ing
from openssl suite, so we need a separate mechanism to address this.

Anders, wouldn't this be a better fix for NO_OPENSSL build, than revert=
ing
a fix for an incorrect ld invocation?

 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 7a5fb69..b20ae1a 100644
--- a/Makefile
+++ b/Makefile
@@ -1296,11 +1296,15 @@ else
 	BLK_SHA1 =3D 1
 	OPENSSL_LIBSSL =3D
 endif
+ifdef NO_OPENSSL
+	LIB_4_CRYPTO =3D
+else
 ifdef NEEDS_SSL_WITH_CRYPTO
 	LIB_4_CRYPTO =3D $(OPENSSL_LINK) -lcrypto -lssl
 else
 	LIB_4_CRYPTO =3D $(OPENSSL_LINK) -lcrypto
 endif
+endif
 ifdef NEEDS_LIBICONV
 	ifdef ICONVDIR
 		BASIC_CFLAGS +=3D -I$(ICONVDIR)/include
