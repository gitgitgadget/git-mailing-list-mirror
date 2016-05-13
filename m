From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v10 11/20] index-helper: use watchman to avoid
 refreshing index with lstat()
Date: Fri, 13 May 2016 13:47:25 -0400
Organization: Twitter
Message-ID: <1463161645.24478.59.camel@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
	 <1463084415-19826-12-git-send-email-dturner@twopensource.com>
	 <57350D7F.5030006@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri May 13 19:47:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1HBW-0008SM-JI
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 19:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbcEMRra convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 13:47:30 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33044 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbcEMRr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 13:47:29 -0400
Received: by mail-qk0-f169.google.com with SMTP id n63so64705671qkf.0
        for <git@vger.kernel.org>; Fri, 13 May 2016 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :mime-version:content-transfer-encoding;
        bh=1x7LZvYmPR9ya7gUrX+womvcCGlOgjS21+y8olnXYDE=;
        b=KpvaqJnmp4nDq4J/t0UCfl/vX3hX2jdXpZahd6DWU0UXGoYniaoDEzQDoyvayGrfJN
         jgLS3pbWLqxErUs80qh554ExTAixtV7yksl+scCLGpguClS7PkRryX5tRtAq84RgDesw
         Um6zeCDgFW8YNtOZqT8fC79T5ihdBawoOxIh98mY7OCDaWranEgO7aPktwosN5iAkDyb
         kGwZq9SQQxh02yBYMeWspJE8x4lIXwBkO3Vq0qT4HrHik+cFR8adi7PXCwUNjaxL+WUD
         ADREZHfceExRFCCkZv1obbrpDylktPhU6QXssyuX0Ws7GyUeYn2h0De5gH22RR2qcdee
         tfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=1x7LZvYmPR9ya7gUrX+womvcCGlOgjS21+y8olnXYDE=;
        b=Ye6SDuVutYbhNy6Dfj0ebjo4+fSQdZgEchaDHL+R54JewjhCJBZWtsHFI8lGj1s3cT
         nxRP9Fey7lRQtdH6iyWqijyeGnC2M4GzcO4mWbh1XQYr2AqgDLfHU7KLZ4C+YdndMQUn
         1GGGtbBM9szrdkF2xRontKOpg7sy4BpV537frW2MMyhN+jTgUC1hB1krxNdubGnDoQv7
         W8iTjCsf5IH0Bn6oRI3zWOhTePN0fgXbsGnA0vzDrZ3E1ylDRkZUkFZQuM2WNtStNLcC
         Bz7VTE9bpVVAi8L40YCaHtvkrnoI3vc/zFpmNf1DqGEKRe83nrMPVmzU+hCp47GIvWrK
         XUnw==
X-Gm-Message-State: AOPr4FVGQ/v8FHIzsi/Ovz8oAkJigNlaV60BV4NME/J9RDMYVDYxmXdRVSdr7NbWb6EUWQ==
X-Received: by 10.55.27.98 with SMTP id b95mr10897068qkb.18.1463161648753;
        Fri, 13 May 2016 10:47:28 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id b139sm8766201qhb.3.2016.05.13.10.47.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2016 10:47:27 -0700 (PDT)
In-Reply-To: <57350D7F.5030006@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294549>

On Fri, 2016-05-13 at 00:10 +0100, Ramsay Jones wrote:
>=20
> On 12/05/16 21:20, David Turner wrote:
> > From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> [snip]
>=20
> > =20
> > +/* in ms */
> > +#define WATCHMAN_TIMEOUT 1000
> > +
> > +static int poke_and_wait_for_reply(int fd)
> > +{
> > +	struct strbuf buf =3D STRBUF_INIT;
> > +	int ret =3D -1;
> > +	struct pollfd pollfd;
> > +	int bytes_read;
> > +	char reply_buf[4096];
> > +	const char *requested_capabilities =3D "";
> > +
> > +#ifdef USE_WATCHMAN
> > +	requested_capabilities =3D "watchman";
> > +#endif
> > +
> > +	if (fd < 0)
> > +		return -1;
> > +
> > +	strbuf_addf(&buf, "poke %d %s", getpid(),
> > requested_capabilities);
> > +	if (packet_write_gently(fd, buf.buf, buf.len))
>=20
> This is not causing a problem or bug, but is none the less not
> correct - as you know, packet_write_gently() takes a 'printf' like
> variable argument list. (So, buf.buf is the format specifier and
> buf.len is an unused arg).
>=20
> I think I would write this as:
>=20
> 	strbuf_addf(&buf, "poke %d", getpid());
> 	if (requested_capabilities && *requested_capabilities)
> 		strbuf_addf(&buf, " %s", requested_capabilities);
> 	if (packet_write_gently(fd, "%s", buf.buf))
>=20
> ... or something similar. [Note, just typing into my email client, so
> it's not been close to a compiler.]

Thanks for the report. I'll fix it.

I'm going to just send the requested_capabilities regardless of whether
they are empty -- it won't hurt. =20

> > +		return -1;
> > +	if (packet_flush_gently(fd))
> > +		return -1;
>=20
> Why are you sending a flush packet - doesn't the index-helper
> simply ignore it?

It's not the packet that I'm excited about -- it's that later,
packet_write might be buffered (according to a docstring).  So I want
to ensure that the writes actually go out *now*.

> I haven't tried this yet BTW, just reading patches as they float
> on past... ;-)
>=20
> ATB,
> Ramsay Jones
>=20
