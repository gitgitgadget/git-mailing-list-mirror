From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 1/4] Add base64 encoder and decoder
Date: Tue, 9 Feb 2010 15:45:23 +0100
Message-ID: <40aa078e1002090645s63449057hf88c89a232933680@mail.gmail.com>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
	 <1265717345-2118-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Tue Feb 09 15:45:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NerLI-0004Fd-7T
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 15:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab0BIOp1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 09:45:27 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:35887 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab0BIOp0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 09:45:26 -0500
Received: by wwi18 with SMTP id 18so2187955wwi.19
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 06:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6R/P51dTWWK1iSP3eVx6J9ScsuJZTgEZ34UHNqsGdLw=;
        b=hjrRHOfhbHoG1UUT8M6RcDkeqWK0fndQsfkML35IC5570fe9Shc4daLWGNYs75y846
         5YjtszeBXnvlzLd0DfWir1DnCEfMrownWM9V3wLJWv9ss/cWAH4CA3w5w4ToCaVmfiNE
         Nu1ICd605KW/jmqxq9flWSsHLMXZ66SibYHLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Oh1JKEnSYyxX0ZiNd+Ombfi6sqLuBcznap1Y+mKmcyRjBn/dbQViYU1Vb1o2WGYaoS
         vh6I398tGlYAm7ImYIHd34zjwbSWO1q9wuH3H7MbGZedGG6Gk6gykBc0b6cv3Gd7Hy4c
         JNI8wd3KuK6nJkS/7isdoO0L4dBdQDZd1hkEo=
Received: by 10.216.178.70 with SMTP id e48mr3463251wem.0.1265726724004; Tue, 
	09 Feb 2010 06:45:24 -0800 (PST)
In-Reply-To: <1265717345-2118-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139407>

On Tue, Feb 9, 2010 at 1:09 PM, Hitoshi Mitake
<mitake@dcl.info.waseda.ac.jp> wrote:
> +void base64_encode(char *out, const char *in, int inlen)
> +{
> + =A0 =A0 =A0 const char *inp =3D in;
> + =A0 =A0 =A0 char *outp =3D out;

=2E..Why? It's copying the pointers to pointers of identical type with
different names, and never using the originals again... Looks like a
sloppy extraction from another code-base to me.

> +
> + =A0 =A0 =A0 while (inlen >=3D 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *outp++ =3D base64char[(inp[0] >> 2) & =
0x3f];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *outp++ =3D base64char[((inp[0] & 0x03)=
 << 4) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0((inp[1] >> 4) & 0x0f)];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *outp++ =3D base64char[((inp[1] & 0x0f)=
 << 2) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0((inp[2] >> 6) & 0x03)];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *outp++ =3D base64char[inp[2] & 0x3f];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 inp +=3D 3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 inlen -=3D 3;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (inlen > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *outp++ =3D base64char[(inp[0] >> 2) & =
0x3f];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (inlen =3D=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *outp++ =3D base64char[=
(inp[0] & 0x03) << 4];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *outp++ =3D '=3D';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *outp++ =3D base64char[=
((inp[0] & 0x03) << 4) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0((inp[1] >> 4) & 0x0f)];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *outp++ =3D base64char[=
((inp[1] & 0x0f) << 2)];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *outp++ =3D '=3D';
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 *outp =3D '\0';
> +}

If inlen is 0, a single '=3D' should be emitted (plus the obvious zero
termination). It could be that the code deals with that by making sure
that inlen never is zero, though.

--=20
Erik "kusma" Faye-Lund
