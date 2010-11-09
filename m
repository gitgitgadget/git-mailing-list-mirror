From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Tue, 9 Nov 2010 11:52:02 +0100
Message-ID: <AANLkTins_qq=unv101JuV_CVvkp3KbTq5qycva7bZ7sm@mail.gmail.com>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
	<1288524860-538-2-git-send-email-avarab@gmail.com>
	<4CCFCCC8.7080603@viscovery.net>
	<AANLkTimjRwSxkemMffASvHCxK009b1fnvNRs05_T_1DF@mail.gmail.com>
	<4CD8F965.6050402@viscovery.net>
	<AANLkTinKYJtaDjwEk0OqebBnL6+wvVO4wfWg7G-VYh7d@mail.gmail.com>
	<4CD918AB.6060206@viscovery.net>
	<AANLkTi=23MXbZeBF=eJLRnQycx4Bdg_an2aa_3oGWR66@mail.gmail.com>
	<4CD9241F.6070807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 09 11:52:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFloT-00056o-2f
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 11:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab0KIKwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 05:52:08 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40511 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262Ab0KIKwE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 05:52:04 -0500
Received: by fxm16 with SMTP id 16so4813505fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 02:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zqdrDW2BGxv52LxSG9D+MVNJ/v9dP970HNFFEvIGbnU=;
        b=u+pxC/BDySd5RWEd0OxuYthQyhPG46xuqCNZLOKXh6Ar98CvS8u+qPqKszjYI+V0S0
         6QReAhkUpnNZwZDoQFeqO2QGJjo/QuNFMETZmeBXiNV34DK9cyn8fn3CZ8neJg/y1tOg
         l6YvyKho5Gbwi1ySBc4rLukLtVQkQO/odM89k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fjuuaha5F2yDeVmZLEma1+X3EwHWy8a/DD/XvpkuhYRMXJUbH4Dy+eevfX3zYgHA4/
         bpZ0cCsi4FJpxN+JRtZ2GgsBvk5r7HpVFND4lNTF7beKZUG5EjcDE/r7Vkp2rgpIbUrs
         O2g3vgROATKZKaCY8ubqayYCgzzz2zmeNSU3Y=
Received: by 10.223.69.134 with SMTP id z6mr5060511fai.19.1289299922746; Tue,
 09 Nov 2010 02:52:02 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Tue, 9 Nov 2010 02:52:02 -0800 (PST)
In-Reply-To: <4CD9241F.6070807@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161033>

On Tue, Nov 9, 2010 at 11:36, Johannes Sixt <j.sixt@viscovery.net> wrot=
e:
> Am 11/9/2010 10:49, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> On Tue, Nov 9, 2010 at 10:47, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
>>> Am 11/9/2010 10:35, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>> Why is that a "*must*"?
>>> ...
>>>> But maybe you have reason to think otherwise? I haven't noticed an=
y
>>>> noticable slowdowns from doing it this way, but maybe I've been
>>>> looking at the wrong thing.
>>>
>>> You didn't do your timings in Windows, did you? Every fork() that y=
ou can
>>> avoid is a win.
>>
>> What's the result of timing it on Windows?
>
> I do not have gettext, hence, I test 'git version' as a reference:
>
> $ time (for i in {1..100}; do git version; done) > /dev/null
>
> real =C2=A0 =C2=A00m5.610s
> user =C2=A0 =C2=A00m1.707s
> sys =C2=A0 =C2=A0 0m0.712s
>
> Then I tested this function. It is not exactly the same that you test=
ed,
> but it has the same number of subshells and builtin and external comm=
and
> invocations:
>
> eval_gettext ()
> {
> =C2=A0 =C2=A0gettext "$1" |
> =C2=A0 =C2=A0( : `git-sh-i18n--envsubst <<< "$1"`
> =C2=A0 =C2=A0 =C2=A0git-sh-i18n--envsubst <<< "$1"
> =C2=A0 =C2=A0)
> }
>
> $ time (for i in {1..100}; do eval_gettext foobar; done) > /dev/null
>
> real =C2=A0 =C2=A00m20.578s
> user =C2=A0 =C2=A00m8.457s
> sys =C2=A0 =C2=A0 0m3.915s
>
> Note that there are only 100 iterations, so we are talking about 0.2
> seconds per eval_gettext call! That's an awful lot of time even for a
> single error message.

Thanks for elaborating. But just so I understand you correctly it's a
cost of invoking *any* program in shellscripts on Windows? So e.g. 10
sed calls would cost the same as 10 git-sh-i18n--envsubst calls (but
of course 5 eval_gettext() calls, since it calls git-sh-i18n--envsubst
twice).

So e.g. using eval_gettext once isn't a bigger problem than calling
some trivial sed substitution twice?
