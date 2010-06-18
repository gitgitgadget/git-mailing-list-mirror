From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Jun 2010, #02; Wed, 16)
Date: Fri, 18 Jun 2010 08:30:33 +0200
Message-ID: <vpq8w6cc0om.fsf@bauges.imag.fr>
References: <7viq5ict4p.fsf@alter.siamese.dyndns.org>
	<7vocf939vu.fsf@alter.siamese.dyndns.org>
	<0d059f457e2edc87093de2e0ea3c911a@ensimag.fr>
	<7vmxut1b8v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: clement.poulain@ensimag.imag.fr, <git@vger.kernel.org>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 18 08:31:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPV6Z-0002k9-Fd
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 08:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162Ab0FRGbA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jun 2010 02:31:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53426 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985Ab0FRGa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 02:30:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5I6MPMn022452
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Jun 2010 08:22:25 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OPV61-0004It-Qu; Fri, 18 Jun 2010 08:30:33 +0200
In-Reply-To: <7vmxut1b8v.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 17 Jun 2010 16\:37\:52 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 18 Jun 2010 08:22:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5I6MPMn022452
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277446948.32249@LEVvdB9GPJvNjEvEoVsmbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149336>

Junio C Hamano <gitster@pobox.com> writes:

> Cl=E9ment Poulain <clement.poulain@ensimag.imag.fr> writes:
>
>> A fix was proposed here:
>> http://mid.gmane.org/1276610328-28532-1-git-send-email-axel.bonnet@e=
nsimag.imag.fr
>
> This one changes textconv_object() to take a pointer to ulong*; a cal=
ler
> is changed to cast a long* down to that pointer (in
> fill_origin_blob);

Isn't sign-casting safe? If not, then the existing call to
read_sha1_file should be fixed too:

-file->ptr =3D read_sha1_file(o->blob_sha1, &type,
-   (unsigned long *)(&(file->size)));
[...]
+file->ptr =3D read_sha1_file(o->blob_sha1, &type,
+   (unsigned long *)(&(file->size)));

(it's been there for a while)

>     The only portable way in C to convert between types is by assignm=
ent. So
>     you have to do:
>
>       unsigned long foo;
>       textconv_object(read_from, null_sha1, &buf.buf, &foo);
>       buf.len =3D foo;

This is what the patch does a little later:

+unsigned long buf_len;
[...]
+if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
+    textconv_object(read_from, null_sha1, &buf.buf, &buf_len))
+buf.len =3D buf_len;

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
