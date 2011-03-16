From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] valgrind: ignore SSE-based strlen invalid reads
Date: Wed, 16 Mar 2011 12:10:14 +0100
Message-ID: <1300273819.7214.12.camel@bee.lab.cmartin.tk>
References: <20110316095632.GA8277@elie>
	 <1300272453-25891-1-git-send-email-cmn@elego.de>
	 <20110316105214.GB8277@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:10:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzoce-0006XB-9r
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 12:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648Ab1CPLK3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 07:10:29 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:59168 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab1CPLK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 07:10:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id E394C1B4A6D;
	Wed, 16 Mar 2011 12:10:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nQtbXBGKfRSl; Wed, 16 Mar 2011 12:10:19 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 36EDC1B4B14;
	Wed, 16 Mar 2011 12:10:19 +0100 (CET)
In-Reply-To: <20110316105214.GB8277@elie>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169137>

On mi=C3=A9, 2011-03-16 at 05:52 -0500, Jonathan Nieder wrote:
> Carlos Mart=C3=ADn Nieto wrote:
>=20
> > The GNU C Library (glibc) uses SSE instructions to make strlen (amo=
ng
> > others) faster, loading 4 bytes at a time and reading past the end =
of
> > the allocated memory. This read is safe and when the strlen functio=
n
> > is inlined, it is (obviously) not replaced by valgrind, which repor=
ts
> > a false-possitive.
>=20
> This still makes no sense to me.  How is it possible to inline a
> function from glibc?  When I look in /usr/include/string.h, I see
>=20
> extern size_t strlen (__const char *__s)
>      __THROW __attribute_pure__ __nonnull ((1));

 Looking at that header, strlen is one of the few functions not being
replaced by its __builtin version, and I only see __builtin_strlen in
the C++ patches. I'll rephrase to something like "Some versions of
strlen use SSE which then get inlined" to avoid blaming anyone in
particular, though thinking about it, it does seem logical that it's
GCC's builtin strlen.

>=20
> > Tell valgrind to ignore this particular error, as the read is, in
> > fact, safe.
>=20
> I'm happy to see a workaround.  I would be even happier if it came
> with documentation about which versions of valgrind need it.

 I think 3.6.1 doesn't need it, as Debian's 1:3.5.0+3.6.0svn20100609-1
version is reportedly fixed. I'll see if I can find more information in
the valgrind bug tracker.

 Cheers,
   cmn
