From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 5/7] web--browse: better support for chromium
Date: Fri, 3 Dec 2010 23:25:09 +0100
Message-ID: <AANLkTinGzZQZo9yZtVtztu5CEXT8G10H6=EdbSM3PAwh@mail.gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-6-git-send-email-giuseppe.bilotta@gmail.com> <7vipzamsde.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 23:25:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POe4R-00046V-Qm
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 23:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab0LCWZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 17:25:31 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47088 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab0LCWZa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 17:25:30 -0500
Received: by iwn6 with SMTP id 6so385883iwn.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 14:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9nbkgTsXUJziqzS4ssJKBrv6NpQ7PGeuA7LGvTBPcCo=;
        b=Z/p6VujTegF90SHZArtpzzOco1+rvsz3cYVunPihmKA/jrP/DORDP1eUyTSiCibjkt
         xgPxKjC8b2k9VrFCWYAhzNTUjcd4wGO2MRKLYTOJc26QyBJzCiJp6IKiBt+vhsWJdAam
         zprkESe3B5uqGfL1dyXn2mDALPPkp6m/taXAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=X9yVWKeGu5toBXZ1BU9dNTqF5rPCflxulU75UXQgygMvpHQCQRb+rM3ZsmD9v7JUYT
         VS8JjhhS8TyWM2yHLWwJWftJxZfnkMKhNPOGZiwTgW2LpfAXR9aOenVCUybIBLo1OCiW
         xvVCundpCVvYwI/T6d1hBdmuuQQgu5TR08zX0=
Received: by 10.231.14.135 with SMTP id g7mr2391386iba.106.1291415130038; Fri,
 03 Dec 2010 14:25:30 -0800 (PST)
Received: by 10.231.39.3 with HTTP; Fri, 3 Dec 2010 14:25:09 -0800 (PST)
In-Reply-To: <7vipzamsde.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162870>

On Fri, Dec 3, 2010 at 10:57 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> =A0init_browser_path() {
>> =A0 =A0 =A0 browser_path=3D$(git config "browser.$1.path")
>> + =A0 =A0 if test -z "$browser_path" -a "$1" =3D chromium ; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 type chromium-browser > /dev/null 2>&1 && =
browser_path=3Dchromium-browser
>> + =A0 =A0 fi
>> =A0 =A0 =A0 test -z "$browser_path" && browser_path=3D"$1"
>
> We tolerate
>
> =A0 =A0 =A0 =A0test && test && effect
>
> and even encourage when the construct is short enough, over
>
> =A0 =A0 =A0 =A0if test && test
> =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0effect
> =A0 =A0 =A0 =A0fi
>
> But because you are writing an "if" block anyway, I think the above s=
hould
> be like this:
>
> =A0 =A0 =A0 =A0if test -z "$browser_path" &&
> =A0 =A0 =A0 =A0 =A0 test "$1" =3D chromium &&
> =A0 =A0 =A0 =A0 =A0 type chromium-browser >/dev/null 2>&1
> =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0browser_path=3Dchromium-browser
> =A0 =A0 =A0 =A0fi
> =A0 =A0 =A0 =A0browser_path=3D${browser_path:-"$1"}
>
> Yours is:
>
> =A0 =A0 =A0 =A0if test && test
> =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0test && effect
> =A0 =A0 =A0 =A0fi
>
> which is less than readable, no?

Absolutely. Actually, this final form is a side-effect on some
experimentations I was doing, thinking about doing something similar
with google-chrome vs chrome (in which case the body of the if would
get a case switch or something like that). I'll clean it up, unless
somebody can actually confirm that we do want these other special
cases.

--=20
Giuseppe "Oblomov" Bilotta
