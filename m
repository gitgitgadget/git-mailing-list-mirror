From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] commit: check return value of lookup_commit()
Date: Wed, 17 Aug 2011 08:32:13 +0700
Message-ID: <CACsJy8An1HwDkH86DoL2Kd9jfaD1cTkBN8sn=vfeHYVLbr0jAA@mail.gmail.com>
References: <1313422716-26432-1-git-send-email-pclouds@gmail.com>
 <7vei0mlg8d.fsf@alter.siamese.dyndns.org> <CACsJy8AusStKNWuw3j740r4Nc0FhzR+jJZJNaesxn68pr7dTqA@mail.gmail.com>
 <7vy5ytgrps.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 03:33:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtV0R-0004Hd-8Y
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 03:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862Ab1HQBcp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 21:32:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35496 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab1HQBco convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2011 21:32:44 -0400
Received: by bke11 with SMTP id 11so352325bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 18:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6k56zS1oprP9QvoVlb3yPonqKYyCbfmA1Nv3tQg8fk4=;
        b=WdjBUkAc4TBMNf7nS6nbNqawbbWscXMkKI+nmWNjcAG25X4/DJNwHLHeRkuEstjc5T
         8ATpvvI1tx/rKMKkbtaybgwTVFqjyw8POjo0PcwjHetrcbh4E9WYpyRsfV7qy7BoR9OQ
         1nm0pjVrCl+ZwIQfc+9SLGzDk9KzhnAFtwPYw=
Received: by 10.204.200.194 with SMTP id ex2mr153372bkb.19.1313544763213; Tue,
 16 Aug 2011 18:32:43 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Tue, 16 Aug 2011 18:32:13 -0700 (PDT)
In-Reply-To: <7vy5ytgrps.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179492>

On Wed, Aug 17, 2011 at 1:02 AM, Junio C Hamano >> But then I would
need to avoid die()ing in "initial_commit" case.
>
> That's exactly what I said.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!initial)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* we need to =
know the head_commit */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0head_commit =3D=
 lookup_and_check(HEAD);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* depending on what kind of commit, we ne=
ed different stuff */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (initial)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... going to c=
reate a parentless commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (amending)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... use the he=
ad_commit to learn parent, reuse the message
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... from there
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if ...
>
> These two are independent if/else cascades in the sense that the firs=
t is
> about learning the details of head_commit, and the latter is about
> learning how the commit is done, and in a subset of the latter head_c=
ommit
> is used.

And some months from now, someone may add more code in between the two
"if" blocks. Some more months past, someone tweaks the "if (initial)"
block but forgets to also update the "if (!initial)" above. This is
what I want to avoid.
--=20
Duy
