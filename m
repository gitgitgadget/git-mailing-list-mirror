From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2 1/3] add strnncmp() function
Date: Tue, 17 Jun 2014 08:48:41 -0700
Message-ID: <20140617154841.GA5162@hudson.localdomain>
References: <cover.1402990051.git.jmmahler@gmail.com>
 <50de63f47ded2337adcd8bce151190fb99b38d64.1402990051.git.jmmahler@gmail.com>
 <539FFAF2.3070002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 17 17:48:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvcv-0004k8-Ur
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756327AbaFQPsq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2014 11:48:46 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:63961 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756320AbaFQPsp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:48:45 -0400
Received: by mail-pd0-f181.google.com with SMTP id v10so4831171pde.40
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SR4VhrT8howf6iHCCr6qt96F3bgpyA6IwhZ3aOkQhVw=;
        b=RhH+/eLEnHqxN9xvCob7hmlc/9nzdpaDDGdE1Y9/3H9LZus0+gqiNQSea/7ImLkcX8
         hnmNWV96BL279pkzS8Uu7hRYyAp1vE3qBvUNPltRGMHJ5KhMbFsRVJ/FzMGi9Rp7Qsp0
         f5nfmQjT5nteUdUaoO8u+QWWgGuFlPJ1gd6Z5VC/gmZTChTZEtOk2fuNgUZ5WvLXffcR
         jFgLO80C0slqoqRHbUAJP5JTAoeQn4qboynrPPtHSIspkFXMN4HB0OA++5/NZUeoo8MH
         zd/YKVJ/iqE7WsJM5r4e3noOQeFjArEdYvIZ1cBe3pmTn+GWp1luFpt28zh2GCee6TeA
         Y2Lg==
X-Received: by 10.66.163.164 with SMTP id yj4mr33453347pab.91.1403020125128;
        Tue, 17 Jun 2014 08:48:45 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id is5sm24659401pbb.8.2014.06.17.08.48.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jun 2014 08:48:43 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <539FFAF2.3070002@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251867>

Torsten,

On Tue, Jun 17, 2014 at 10:23:14AM +0200, Torsten B=C3=B6gershausen wro=
te:
> On 2014-06-17 09.34, Jeremiah Mahler wrote:
> > Add a strnncmp() function which behaves like strncmp() except it ta=
kes
> > the length of both strings instead of just one.  It behaves the sam=
e as
> > strncmp() up to the minimum common length between the strings.  Whe=
n the
> minimum common length? Isn'n t that 0?
> Using the word "common", I think we could call it "common length".
> (And more places below)
>=20
Yes, "minimum" doesn't make sense.  "common length" sounds better.

> > strings are identical up to this minimum common length, the length
> > difference is returned.
> >=20
> > Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> > ---
> >  strbuf.c | 9 +++++++++
> >  strbuf.h | 2 ++
> >  2 files changed, 11 insertions(+)
> >=20
> > diff --git a/strbuf.c b/strbuf.c
> > index ac62982..4eb7954 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -600,3 +600,12 @@ char *xstrdup_tolower(const char *string)
> >  	result[i] =3D '\0';
> >  	return result;
> >  }
> > +
> strncmp uses size_t, not int:
> int strncmp(const char *s1, const char *s2, size_t n);
>=20
> Is there a special reason to allow negative string length?
> Some call sites use int when calling strncmp() or others,
> that is one thing.
> But when writing a generic strnncmp() function, I think
> it should use size_t, unless negative values have a meaning and
> are handled in the code.
>=20
Don't need negatives, size_t is more appropriate.  Fixed.

>=20
> > +int strnncmp(const char *a, int len_a, const char *b, int len_b)
> > +{
> > +	int min_len =3D (len_a < len_b) ? len_a : len_b;
> > +	int cmp =3D strncmp(a, b, min_len);
>=20
> > +	if (cmp)
> > +		return cmp;
> > +	return (len_a - len_b);
> > +}

Thanks,
--=20
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
