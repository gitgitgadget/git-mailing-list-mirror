From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 08/10] revert: Introduce HEAD, TODO files to persist
 state, plan
Date: Thu, 26 May 2011 21:56:19 +0530
Message-ID: <BANLkTi=FkK=k6OavQtqMRvPCZ7nc+iKtwQ@mail.gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com> <1306425233-504-9-git-send-email-artagnon@gmail.com>
 <20110526161102.GC24931@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 18:26:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPdOa-0000CI-Ge
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 18:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867Ab1EZQ0l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 12:26:41 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48188 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932916Ab1EZQ0k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2011 12:26:40 -0400
Received: by wya21 with SMTP id 21so641021wya.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Oh8f0sJ77JsqmnpN4I1HCvb47R5vbEJaeNCibk+fSZg=;
        b=Im0CqK8MS53wTh5Q78Y931nAdaViNpuxU8xEW8ZJ2er4AiE+3GfMMnE4ooa5NVp4IP
         CNCbiSt03fJxNxLnKPijFGF930bRjlm0DGlTHjU/8py1b2H9Ycx7AlKCuFML5wcEg4Pu
         i8QWM3ZDFCwdmBIzHeN8m64nIYV+aWvvEuTw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=A1MRVPks1mKOnUpUldoMhFc9qrSuxIN2eqsSDaH7iKHvukg4tMWz8xy3zjEdM6rKzH
         rlB1LvA1l9m9knfaFD7YedinsZJmNy0HaOBw/i174UOU2xdAulC5ibUuGRM208eD3XBi
         4TBIVUxVVfruPp6FCFXjuPSXn3pLlL4epwEhw=
Received: by 10.216.255.201 with SMTP id j51mr975093wes.94.1306427199092; Thu,
 26 May 2011 09:26:39 -0700 (PDT)
Received: by 10.216.158.70 with HTTP; Thu, 26 May 2011 09:26:19 -0700 (PDT)
In-Reply-To: <20110526161102.GC24931@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174541>

Hi Jonathan,

Jonathan Nieder writes:
> Almost there. =C2=A0To comfort overly-worried people like me that thi=
nk we
> have not finished converted all die() calls yet, wouldn't this need t=
o
> look like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0persist_head(head);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((commit =3D ...)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int status_or_=
error;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Checkpoint.=
 =C2=A0If do_pick_commit exits, make sure the user
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * can still u=
se "git cherry-pick --continue" to recover.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0persist_todo(r=
evs.commits, opts);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status_or_erro=
r =3D do_pick_commit(...);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status_or_=
error)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return status_or_error;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Success! */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0remove_todo(opts);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0remove_head();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;

You told me about this on IRC last night, but I forgot to squash the
relevant patch into this series. Thanks :)

> And with that, this would no longer depend on the (valuable enough on
> their own terms) patches 1 and 2 so they could be treated as a
> separate series, no?

Yes, but I'd like to keep 1 and 2 in this series, if that's alright.
Another series will have to take care of error handling more
extensively.
With a few tests, would it be useful to get this series merged in? It
implements '--abort', which is already useful.

-- Ram
