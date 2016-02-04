From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 19/20] refs: add LMDB refs backend
Date: Thu, 4 Feb 2016 16:58:31 +0700
Message-ID: <CACsJy8Ai93QWnoB8CMFchvO_fdJk+PXgDcBhuPbuQWGNaSdpyw@mail.gmail.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com> <1452788777-24954-20-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 10:59:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRGgy-0002WW-3e
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbcBDJ7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:59:06 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35013 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328AbcBDJ7D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 04:59:03 -0500
Received: by mail-lf0-f47.google.com with SMTP id l143so32487463lfe.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FqY86nsvKy6LBaRoyMgpSF72d1e774/z1XRhKqCm9Eg=;
        b=GXcerq4bQ9otzRrbxy+9/Wb5stQR2MueEqPqrC7AoG8vJ8+uFpm0Smrul/LufJohKb
         Xy0E3chmJv+H8uhNYbH0Wk4VneFjm6nf+2r1nP+u4HqsM92gHTS7frAKsDN0+eKodZHs
         UL+mmI5HC9JoKzFw5Fd6Qym5IktfTdxryQvaFDizURbO4MoBybQPGdLdVpxrKV66KCKC
         8JMprfq5c1+sZupsp0rXdlMLmTcxz1WT1Z84ZUFj/cQR+sxmyZ90ksS4NFDzuxeYGh1L
         SjpeSkkbo0z50/gN8btM7vI+8OJ+szV4fjeD0JyG5eOSbGoxVU0UETCKxhKS17Hkt5QW
         6IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=FqY86nsvKy6LBaRoyMgpSF72d1e774/z1XRhKqCm9Eg=;
        b=SIqjoq5XOvZ3aY+PEGl7oVEvz+ReuY58ie0LDBTgk16aF0mFBP/TpqCz5Jgur4qpzW
         1VBbamjNq7K8UzhmP2gMK8srW7UV1Wczft5n3tob2NMkk8rxDCqWk59CP2viTULvRsPb
         u8y8W33rlZZ6cor94oDdXI2SE/z5g4Osnbyb+WGIiQxCFoyBUNnez7L2OmpLQWaex7FD
         eYgrcFYovH8ma393uagR+85QyRRPVZO3NIt/YDjZdQv1V69Jdess3B3sJCuCrrj03YMP
         NMmkPuaS5tombtolpTZEL8WXt27lkXdMtR0+0Nc6ur0vMZNDDG4ZEmrIdhOHzaMzMS+8
         v1hw==
X-Gm-Message-State: AG10YOTwbFD1aNiNI34z8QXEtvW6eojGc+CykoMuVi0+W6K6ews2lp688RU7ydBbfuTCFtwc7p83XEj/WmQgew==
X-Received: by 10.25.161.144 with SMTP id k138mr3055470lfe.83.1454579941098;
 Thu, 04 Feb 2016 01:59:01 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 4 Feb 2016 01:58:31 -0800 (PST)
In-Reply-To: <1452788777-24954-20-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285446>

On Thu, Jan 14, 2016 at 11:26 PM, David Turner <dturner@twopensource.co=
m> wrote:
> diff --git a/refs/lmdb-backend.c b/refs/lmdb-backend.c
> new file mode 100644
> index 0000000..470c79f
> --- /dev/null
> +++ b/refs/lmdb-backend.c
> @@ -0,0 +1,2051 @@
> +/*
> + * This file implements a lmdb backend for refs.
> + *
> + * The design of this backend relies on lmdb's write lock -- that is=
, any
> + * write transaction blocks all other writers.  Thus, as soon as a r=
ef
> + * transaction is opened, we know that any values we read won't
> + * change out from under us, and we have a fully-consistent view of =
the
> + * database.
> + *
> + * We store the content of refs including the trailing \0 so that
> + * standard C string functions can handle them.  Just like struct
> + * strbuf.
> + */
> +#include "../cache.h"
> +#include <lmdb.h>
> +#include "../object.h"
> +#include "../refs.h"
> +#include "refs-internal.h"
> +#include "../tag.h"
> +#include "../lockfile.h"
> +
> +static struct trace_key db_trace =3D TRACE_KEY_INIT(LMDB);

Super nit:

    CC refs/lmdb-backend.o
refs/lmdb-backend.c:22:25: c=E1=BA=A3nh b=C3=A1o: =E2=80=98db_trace=E2=80=
=99 defined but not used
[-Wunused-variable]
--=20
Duy
