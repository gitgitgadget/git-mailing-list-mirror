From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 01/14] Fix non-constant array creation
Date: Fri, 21 Aug 2009 15:41:24 +0200
Message-ID: <40aa078e0908210641m660b003do6f637535293672ae@mail.gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
	 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 15:41:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUNO-0005ip-Jl
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbZHUNlY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2009 09:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbZHUNlY
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:41:24 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:33062 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208AbZHUNlX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 09:41:23 -0400
Received: by qw-out-2122.google.com with SMTP id 8so411885qwh.37
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v7z3gTZE7X2GScgAeBzWubiYd+k1RGoO2zT5uslJU84=;
        b=N0BsC3TaqGWp9ktJpd5/p9Dts0SnoRfAYfm8erDcicPqK1Bx/codb/rhLXiqJGVqcp
         Jn34XA7dquw0xtWVQd7Kgem8sQK+2SO3qp+pZRA5JYNPkUq1CkHW+2zih8948b38oh2G
         dwqBS221neB+CRAP44IbLJWUmDEpJ7IrPSzMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rqs8fZs221l13dv9wCFB93mmpa9JEyx3skY3Y9AkTDJHbKKI+RAXTozaibYnXJTCdi
         DGUHEC8TAe1qWnSsoZftx98IswVMKtPqOveCEYJaE47r2PmFfOiXaZY96UMyIFEqpPxb
         BmvIhNH8A2pkFkzjd3ne0QcCg0LXO/DsDz0F0=
Received: by 10.224.92.143 with SMTP id r15mr681070qam.105.1250862084403; Fri, 
	21 Aug 2009 06:41:24 -0700 (PDT)
In-Reply-To: <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126724>

On Fri, Aug 21, 2009 at 3:30 PM, Marius Storm-Olsen<mstormo@gmail.com> =
wrote:
> @@ -1875,7 +1875,7 @@ static int match_fragment(struct image *img,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t imgoff =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t preoff =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t postlen =3D postimage->len;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t imglen[preimage->nr];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t *imglen =3D xmalloc(sizeof(size_=
t) * preimage->nr);

How about using alloca instead? It allocates from the stack (just like
the C99-style variable-length array you're replacing), and you don't
need to free the memory afterwards.

=2E.. or is alloca frowned upon? I see it's already used both in
compat/regex/regex.c and in compat/nedmalloc/malloc.c, but not
apparently not in the git core.

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
