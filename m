From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Tue, 4 Jun 2013 22:51:01 +0200
Message-ID: <CALWbr2yv_vYpuFH4wTOaRwmAT-YZ-O=VMo-idWC_ALwgCkrqHQ@mail.gmail.com>
References: <1369591098-11267-1-git-send-email-apelisse@gmail.com>
	<7vzjv57mwx.fsf@alter.siamese.dyndns.org>
	<CALWbr2zJCxbW8Qug0i=oGvKZV5-vcAugextxMuQp9jaoaZYpyg@mail.gmail.com>
	<7v61xt7gej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 22:51:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjyCC-0001zF-GN
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 22:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403Ab3FDUvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 16:51:04 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:44071 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab3FDUvD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 16:51:03 -0400
Received: by mail-qa0-f45.google.com with SMTP id o13so2895341qaj.11
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oDbno7B1T2pz9PLVPUjgy+FhC0NCFx6zp4J+KpvxvLw=;
        b=SoMYJZmKAat6bnEValDMmvTvokuQ8NjWgPlbMSIcz38wxVdHpggnc7JBBTFKi0+xPr
         0RoCcbEcnvWEOM+QfWQE7pIzqmabJm82b/uzR5a9VGVIAEohss0b6HfxDwiL2xe1EJ05
         SdFnLSuBAxu3rNrdLXxEoaSVfb3+4+xoHmYVhMVN9v7pf8JaUE61J/QIRvDkZ2efXJQI
         M/jDUbZgdll2vauzxr51XKUxfS0unA3j22BaAnqY1YmOuklxSpiIEZCqLCLtERK6xPRJ
         hQ60lAglPxstjSHt72wr1COpSrGiAymqwxY9cohuKxgVuCxyLPjQolZi5/i/fGK+4QNF
         zeBQ==
X-Received: by 10.49.63.196 with SMTP id i4mr21071755qes.13.1370379061581;
 Tue, 04 Jun 2013 13:51:01 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Tue, 4 Jun 2013 13:51:01 -0700 (PDT)
In-Reply-To: <7v61xt7gej.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226401>

On Tue, Jun 4, 2013 at 10:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> OK.  Thanks.
>
> I think the logic would be more like:
>
>  1. Start from xscr, find the first xchp that is !xchp->ignore;
>     if there is none, we are done. There is no more to show.
>
>  2. Remember the xchp as the beginning.
>
>  3. Tangle ->next pointer to find the next xch that is !xch->ignore;
>     if there is none, we are also done.  xdchanges between the
>     beginning you remembered in the step 2. and your current xchp
>     are the only things we want to show.
>
>  4. Measure the distance between the end of xchp and the beginning
>     of xch.
>
>     - If it is larger than max_common, xdchanges between the
>       beginning you remembered in the step 2. and your current xchp
>       are the only things we want to show.  The next iteration will
>       start by skipping the blank-only changes between xchp and xch.
>
>     - If it is short enough, assign xchp = xch and go back to 3. to
>       find more interesting hunks (that is why we remembered the
>       real "beginning" in step 2.).

Yeah, I'm doing something pretty much like that right now (though I
will have to eventually sleep).
I decided that it would indeed be easier to split the logic rather
than do everything in one loop.

Thanks for the help !
