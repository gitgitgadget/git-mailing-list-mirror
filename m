From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCHv2] git bisect old/new
Date: Wed, 13 Jun 2012 12:05:11 +0200
Message-ID: <CAP8UFD1A+GggOOb4-GYn5O1vFWpCUZ8b98Z-WOZc4gorC4p=yg@mail.gmail.com>
References: <1339466625-17461-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
	<1339541765-2078-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 13 12:05:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SekS1-0006Z0-H8
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 12:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab2FMKFO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 06:05:14 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36543 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab2FMKFM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 06:05:12 -0400
Received: by pbbrp8 with SMTP id rp8so2075554pbb.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 03:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Za/Y1LbcpBEny4X+oHT054l9pnYoNsVEAO/1pU/Ke2Q=;
        b=IG5qHksrhy/ddSniLNLbh822PfwaW58Y01W6mJODk/IsI09UvJIfKOLiUlfeZ14Uo2
         +GeCwUS6bUPLu6UUL/LRXyiWyE+4hW/VAa1PXDdImA9vGhSHeb587Sd5M8W/VvNxkFS5
         fuTysVdyze3x96E5R79P3Kinly521aUX0YDC9+FwPzVlmZbHMx4qH2zbLGWey6zfMpNL
         C8zOB2Xrz9rBhJ56sthyoCHdxNlWsAX+cOLqKk/IEE89MumVnShfKD4nJ1M0zL7OZtq7
         mFxvsKwhbP/qw0+F44QYmyRu6zcKLYVnkM1tD4zlXGl7YfnTqKsRF4+Ym34uRCEkvtw0
         i59g==
Received: by 10.68.228.102 with SMTP id sh6mr48656962pbc.134.1339581911822;
 Wed, 13 Jun 2012 03:05:11 -0700 (PDT)
Received: by 10.142.234.9 with HTTP; Wed, 13 Jun 2012 03:05:11 -0700 (PDT)
In-Reply-To: <1339541765-2078-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199884>

On Wed, Jun 13, 2012 at 12:56 AM, Valentin Duperray
<Valentin.Duperray@ensimag.imag.fr> wrote:
>
> Related discussions:
>
> =A0 =A0 =A0 =A0- http://thread.gmane.org/gmane.comp.version-control.g=
it/86063
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0introduced bisect fix unfixed to find =
fix.
> =A0 =A0 =A0 =A0- http://thread.gmane.org/gmane.comp.version-control.g=
it/182398
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0discussion around bisect yes/no or old=
/new.

Thanks!

> =A0/*
> + * The terms used for this bisect session are stocked in
> + * BISECT_TERMS: it can be bad/good or new/old.
> + * We read them and stock them to adapt the messages
> + * accordingly. Default is bad/good.
> + */
> +void read_bisect_terms(void)
> +{
> + =A0 =A0 =A0 struct strbuf str =3D STRBUF_INIT;
> + =A0 =A0 =A0 const char *filename =3D git_path("BISECT_TERMS");
> + =A0 =A0 =A0 FILE *fp =3D fopen(filename, "r");
> +
> + =A0 =A0 =A0 if (!fp) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bisect_bad =3D "bad";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bisect_good =3D "good";

Ok, but...

> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 strbuf_getline(&str, fp, '\n');
> + =A0 =A0 =A0 bisect_bad =3D strbuf_detach(&str, NULL);
> + =A0 =A0 =A0 strbuf_getline(&str, fp, '\n');
> + =A0 =A0 =A0 bisect_good =3D strbuf_detach(&str, NULL);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 strbuf_release(&str);
> + =A0 =A0 =A0 fclose(fp);
> +}


> @@ -953,6 +991,8 @@ int bisect_next_all(const char *prefix, int no_ch=
eckout)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(roughly %d step%s)\n", nr, (nr =3D=3D 1=
 ? "" : "s"),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 steps, (steps =3D=3D 1 ? "" : "s"));
>
> + =A0 =A0 =A0 free((char*)bisect_bad);
> + =A0 =A0 =A0 free((char*)bisect_good);

=2E..it is not a good thing to free these variables if they were not al=
located.

> +
> =A0 =A0 =A0 =A0return bisect_checkout(bisect_rev_hex, no_checkout);
> =A0}
> =A0 =A0 =A0 =A0case "$missing_good,$missing_bad,$1" in
> =A0 =A0 =A0 =A0,,*)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 : have both good and bad - ok
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 : have both good and bad or old and new=
 - ok

Maybe ": have both $BISECT_GOOD and $BISECT_BAD - ok".

Thanks,
Christian.
