From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 0/5] Add internationalization support to Git
Date: Mon, 31 May 2010 12:17:11 +0000
Message-ID: <AANLkTinDqGaqlTJs91vB8giQGo6GfEmCdX3wpNX7lMCR@mail.gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
	<20100530014607.GA27387@progeny.tock>
	<AANLkTimI5xGiq_GNF_H2bOLECw0NxOiCPsnRqOS39H32@mail.gmail.com>
	<20100530222347.GB477@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 14:17:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ3vh-0000Il-Cf
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 14:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab0EaMRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 May 2010 08:17:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61313 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652Ab0EaMRM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 May 2010 08:17:12 -0400
Received: by iwn6 with SMTP id 6so476984iwn.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZsQAp8xFLsnQ85QR3u96uhrLn6tC8xq67HThO/unr6M=;
        b=cziHIHszyvMrJXsWFH+l4rRZqS40lcz/1V2jqUGGHZI9ysP21x8dylHQdnm82kCle2
         f8iPXLxJuxeb087nWLNQnA2eAys2KlQmrH+ppSeDVQhlLpNQBD8hSh4/f7WNJ5V1kaJM
         LXrQW0ankjntSpHAlgKsckyI18CcoWaXCGQ80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IxoiHjpa7+k0pSFhsVVk4J32afnrtfSc89XCKRPBX7+CG+IcojPykJB4qmxFXYdMIS
         IcxEqNKbL3v+/qqWuYSoZ6qhdAVgM4+oUzgnvAUXn/3RMwsWpM4OjPckoyX1CzSAPctE
         9fRIFSGtMx6cWcj35zsequCdNs9KmvexUA0yA=
Received: by 10.231.185.86 with SMTP id cn22mr5718626ibb.69.1275308231354; 
	Mon, 31 May 2010 05:17:11 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 31 May 2010 05:17:11 -0700 (PDT)
In-Reply-To: <20100530222347.GB477@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148040>

On Sun, May 30, 2010 at 22:23, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> [...]
> It would seem that __attribute__((__pure__)) should let the compiler =
give
> us the best of both worlds, but no luck. =C2=A0Even __attribute__((__=
const__))
> is ignored; the compiler inlines the body of _() before it has a chan=
ce
> to notice.
>
> We can fool the compiler into paying attention by making it not
> inlinable: if gettext.h contains
>
> | extern char *_(const char *s) __attribute__((__format_arg__(1), __c=
onst__));
>
> and a separate gettext.c contains
>
> | #include <libintl.h>
> | #include "gettext.h"
> | char *_(const char *s) { return gettext(s); }
>
> we get the performance of B again:
>
> =C2=A01.36user 0.01system 0:01.38elapsed 98%CPU (0avgtext+0avgdata 23=
04maxresident)k
> =C2=A00inputs+0outputs (0major+180minor)pagefaults 0swaps
>
> This amounts to lying to the compiler, since it is possible for the s=
tring
> pointed to by a single address s to differ between calls to _. =C2=A0=
The __pure__
> attribute would be more honest, but for reasons I don=E2=80=99t under=
stand it
> suppresses the optimization.
>
> Moral of the story: at least in simple cases, we can keep the perform=
ance
> and the typechecking. =C2=A0Phew.

Awesome, how portable is this? If it's just GCC I guess it can just be
wrapped in #ifdef __GNUC__.

Thanks for investingating this.
