From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v8 4/7] bisect: introduce --no-checkout,
 --update-ref=<ref> support into porcelain.
Date: Mon, 1 Aug 2011 05:48:40 +1000
Message-ID: <CAH3Anrp+Jynon0O8mQJnKvCNtp0v6oR9pLetmg0B6GnoP2QWMg@mail.gmail.com>
References: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
	<1312113321-28760-5-git-send-email-jon.seymour@gmail.com>
	<CAP8UFD2uWRS4KznUAQCCF8sShGy6+sGWgNsLj8mmO7Ur1CDrCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
	j6t@kdbg.org, jnareb@gmail.com
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 21:48:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnc0E-0002nk-Vx
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 21:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349Ab1GaTsn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 15:48:43 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52349 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab1GaTsl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 15:48:41 -0400
Received: by vws1 with SMTP id 1so4018650vws.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1rX0PjTo9xEnlWapSSUrKpeG04cnV4AlHxYCAHrn4i8=;
        b=Goh8FDaSwQSM8W4qmCcrPtH3jFwz2K09WzpmZIbi3ZdKf+PkOQL4NGihLA6M5Vc0JA
         kq2XTZOpvdxMREZOhvJEXmdr0NnpEfRLkonBUWlI2bOCDyzysQMifSe/7itTjAsstShJ
         /PNr3ICxHShbmliA48TnPRaVfq5TjLkOIIFa8=
Received: by 10.52.97.1 with SMTP id dw1mr2504431vdb.307.1312141721057; Sun,
 31 Jul 2011 12:48:41 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sun, 31 Jul 2011 12:48:40 -0700 (PDT)
In-Reply-To: <CAP8UFD2uWRS4KznUAQCCF8sShGy6+sGWgNsLj8mmO7Ur1CDrCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178271>

On Mon, Aug 1, 2011 at 4:35 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Jul 31, 2011 at 1:55 PM, Jon Seymour <jon.seymour@gmail.com> =
wrote:
>>
>> @@ -69,13 +71,18 @@ bisect_start() {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0orig_args=3D$(git rev-parse --sq-quote "$=
@")
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0bad_seen=3D0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0eval=3D''
>> + =C2=A0 =C2=A0 =C2=A0 BISECT_UPDATE_REF=3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0while [ $# -gt 0 ]; do
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg=3D"$1"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$arg" in
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shift
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shift; break ;;
>
> Please don't change this. We try to avoid having many instructions on
> the same line like this.

Sure.

=46WIW: there are two places in git-am.sh and git-repack.sh that put sh=
ift on
the same line as another statement,. Also this:

     case "$arg" in --) has_double_dash=3D1; break ;; esac

However, 'fixing' those can be another change, assessed on its own meri=
ts.

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --no-checkout)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BISECT_UPDATE_REF=
=3DHEAD; shift ;;
>
> Perhaps:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test -=
z "$BISECT_UPDATE_REF" && BISECT_UPDATE_REF=3DHEAD
>
> so that "--update-ref=3Dsomeref --no-checkout" works the same as
> "--no-checkout --update-ref=3Dsomeref".
>

Got the intent, thanks.

 How about BISECT_UPDATE_REF=3D${BISECT_UPDATE_REF:-HEAD}?

jon.
