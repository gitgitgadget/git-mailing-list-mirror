From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 19/20] refs: add LMDB refs backend
Date: Thu, 04 Feb 2016 14:33:05 -0500
Organization: Twitter
Message-ID: <1454614385.5545.5.camel@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
	 <1452788777-24954-20-git-send-email-dturner@twopensource.com>
	 <CACsJy8Ai93QWnoB8CMFchvO_fdJk+PXgDcBhuPbuQWGNaSdpyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 20:33:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRPeT-0004QC-Bd
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 20:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934017AbcBDTdJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 14:33:09 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34399 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932976AbcBDTdH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 14:33:07 -0500
Received: by mail-qg0-f47.google.com with SMTP id u30so50467640qge.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 11:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=zRmoRyTcpqUnpLJ5aOh5Hq+QuFa2kxWj1lBrx/Pxxw0=;
        b=b89fzooyGS/0j79/bvQ+9ZmIhfvA3a0xuCxiqmQSoQjZhE82y0o1NaS2te2IwohxN1
         Z51I62bMIpXxypnf7yF8FczJkzgZqJUUhSpeDe9rxv7TN17oqbzq9bSaZVf/eY8cS2OB
         L9pLcrht0F6Cw/FqJKXvSUtQ7Zy26ap1krwVnZ2TlfU2Le5CeRxFgK/efHYPaX30COAq
         jB0BHruToUgSx7c5NpnWO88QNkqxU1dOWLWMMJF2ntKAHZstVOZ4zGhwzV1OK+IN0Oo3
         HFZ7XSFnHgPIcVq2O0gEEmyOkBtAaGiCjyM4qu4+VBcUxUyictrYfHpXEInwwR9Zfo5c
         tySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=zRmoRyTcpqUnpLJ5aOh5Hq+QuFa2kxWj1lBrx/Pxxw0=;
        b=TJ5yGlYo1c8GSQZGgIPNVSKdgHXAJ7pwx6hh18Fod75Y0/KO4pPHw7DiCQTZjuExm+
         mqsCNUf5Dkjmyo8S/YdPk1C/xFpBe5Vzk9uMqC7dHcWbd1tGyP5qXD5Oq7JJIn0we1xr
         8R6wUN7hfv50f27ZKCIEcRGjJfFy7zoMm6/pDSfAN0ZwESsfrinxZvqTfUA5bJ52rbuO
         d/Onb4RjPfy48/u6tDuz7qBoONWn1lf9z/QBBvSfjhcUlFDy6O1M8V3NgyP8fGRXzSC+
         KJpVWFz1GR3SlmkRu3HCM6TYecFOWqp6EUYCMqQUm9/AuQZFTiVQKLW0DSBtN8lBNQj8
         3t3g==
X-Gm-Message-State: AG10YOQFL6sbvvnycOUkiz/Bov1wUv+KHU11jiHcXN8gPqiL6Kv9BdhTAhfdtyqlQoh6ow==
X-Received: by 10.140.217.67 with SMTP id n64mr12240309qhb.26.1454614387382;
        Thu, 04 Feb 2016 11:33:07 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id u16sm5935945qka.22.2016.02.04.11.33.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Feb 2016 11:33:06 -0800 (PST)
In-Reply-To: <CACsJy8Ai93QWnoB8CMFchvO_fdJk+PXgDcBhuPbuQWGNaSdpyw@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285481>

On Thu, 2016-02-04 at 16:58 +0700, Duy Nguyen wrote:
> On Thu, Jan 14, 2016 at 11:26 PM, David Turner <
> dturner@twopensource.com> wrote:
> > diff --git a/refs/lmdb-backend.c b/refs/lmdb-backend.c
> > new file mode 100644
> > index 0000000..470c79f
> > --- /dev/null
> > +++ b/refs/lmdb-backend.c
> > @@ -0,0 +1,2051 @@
> > +/*
> > + * This file implements a lmdb backend for refs.
> > + *
> > + * The design of this backend relies on lmdb's write lock -- that
> > is, any
> > + * write transaction blocks all other writers.  Thus, as soon as a
> > ref
> > + * transaction is opened, we know that any values we read won't
> > + * change out from under us, and we have a fully-consistent view
> > of the
> > + * database.
> > + *
> > + * We store the content of refs including the trailing \0 so that
> > + * standard C string functions can handle them.  Just like struct
> > + * strbuf.
> > + */
> > +#include "../cache.h"
> > +#include <lmdb.h>
> > +#include "../object.h"
> > +#include "../refs.h"
> > +#include "refs-internal.h"
> > +#include "../tag.h"
> > +#include "../lockfile.h"
> > +
> > +static struct trace_key db_trace =3D TRACE_KEY_INIT(LMDB);
>=20
> Super nit:
>=20
>     CC refs/lmdb-backend.o
> refs/lmdb-backend.c:22:25: c=E1=BA=A3nh b=C3=A1o: =E2=80=98db_trace=E2=
=80=99 defined but not used
> [-Wunused-variable]

=46ixed, thanks.
