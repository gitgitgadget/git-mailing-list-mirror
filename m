From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] imap-send.c: fix pointer to be const
Date: Wed, 28 Oct 2009 14:33:35 +0100
Message-ID: <4AE8482F.7020807@drmicha.warpmail.net>
References: <1256706591-2763-1-git-send-email-vietor@vxwo.org>	 <7vk4ygxce6.fsf@alter.siamese.dyndns.org> <1256713526.3333.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Vietor Liu <vietor@vxwo.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 14:42:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N38ep-0005v5-GW
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 14:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbZJ1Ndh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 09:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbZJ1Ndg
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 09:33:36 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:37768 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751247AbZJ1Ndg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 09:33:36 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DE25BBDB27;
	Wed, 28 Oct 2009 09:33:39 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 28 Oct 2009 09:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=kOxzaFuQmEn0G0YA1+/W7DSP9Es=; b=s7pqAOF9CXe0FiA/XnAvCCB9CDC0cm+3D4UzLMveEMrDEBoeNHOWjGV7UHjYGMPtGya7RdU76E1PtgiSxfl8HF4Li6Zudd7ohA6FE7BbHkZXUKNL+9yGeu+yd+gE1hdCuPR9BTdC66nWuaKm43Usfo+ZLIQ7YnxKl07cN/ZsJNg=
X-Sasl-enc: 9z/gHNtHV6pQ7Ts+OCVIM0daX67KOEZWvoOTjbf3DBJF 1256736819
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 041A8489200;
	Wed, 28 Oct 2009 09:33:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091028 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <1256713526.3333.0.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131463>

Vietor Liu venit, vidit, dixit 28.10.2009 08:05:
> On Tue, 2009-10-27 at 23:26 -0700, Junio C Hamano wrote:
>> Vietor Liu <vietor@vxwo.org> writes:
>>
>>> Fixes some compiler warnings:
>>> imap-send.c: In function =E2=80=98ssl_socket_connect=E2=80=99:
>>> warning: assignment discards qualifiers from pointer target type
>>>
>>> Signed-off-by: Vietor Liu <vietor@vxwo.org>
>>
>> I do not quite understand.  This variable gets assigned the return v=
alues
>> from TLSv1_method() or SSLv23_method(), but the copy of ssl.h I have
>> declares them as:
>>
>>     SSL_METHOD *SSLv23_method(void);	/* SSLv3 but can rollback to v2=
 */
>>     SSL_METHOD *TLSv1_method(void);		/* TLSv1.0 */
>=20
> 1. openssl-devel-1.0.0-0.10
>=20
> const SSL_METHOD *SSLv23_method(void);	/* SSLv3 but can rollback to v=
2
> */
> const SSL_METHOD *TLSv1_method(void);		/* TLSv1.0 */
>=20
>=20
> 2. http://www.openssl.org/docs/ssl/ssl.html
>=20
> const SSL_METHOD *SSLv2_method(void);
>        =20
>         Constructor for the SSLv2 SSL_METHOD structure for combined
>         client and server.
> const SSL_METHOD *TLSv1_method(void);
>        =20
>         Constructor for the TLSv1 SSL_METHOD structure for combined
>         client and server.
>=20
> 3. it maybe fixes warnings for other version.

No const here with openssl 0.9.8k. I think major distros will switch to
1.0.0 with their next major release (e.g. Fedora 12 will have it by the
end of this year).

Since this is only about warnings, maybe git 1.7.0 is the right time
frame to adjust this to the upcoming standard?

Michael
