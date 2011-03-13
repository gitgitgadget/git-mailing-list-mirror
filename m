From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Mon, 14 Mar 2011 00:42:12 +0100
Message-ID: <AANLkTi=8m+nypebRXOBHYthmRpidqPnAB3iWRKVPvcTN@mail.gmail.com>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vzkpxm45e.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102152040370.14950@debian>
 <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com>
 <alpine.DEB.2.00.1102161122350.14950@debian> <AANLkTik-JGZFCE+m7g__mwfQhRReOM=Qe_EO3otw50XC@mail.gmail.com>
 <alpine.DEB.2.00.1103120930250.15442@debian> <AANLkTikrYbY6r5hYnhWCB1GVKbPgounxdvAGeejsUKoC@mail.gmail.com>
 <alpine.DEB.2.00.1103122005490.15442@debian> <alpine.DEB.2.00.1103122159300.15442@debian>
 <7vd3luhbmt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 00:42:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pyuvm-0000ZK-RF
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 00:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605Ab1CMXme convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Mar 2011 19:42:34 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43482 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894Ab1CMXmd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Mar 2011 19:42:33 -0400
Received: by qyg14 with SMTP id 14so3908027qyg.19
        for <git@vger.kernel.org>; Sun, 13 Mar 2011 16:42:32 -0700 (PDT)
Received: by 10.229.76.202 with SMTP id d10mr9354210qck.169.1300059752118;
 Sun, 13 Mar 2011 16:42:32 -0700 (PDT)
Received: by 10.229.78.209 with HTTP; Sun, 13 Mar 2011 16:42:12 -0700 (PDT)
In-Reply-To: <7vd3luhbmt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168983>

On Sun, Mar 13, 2011 at 11:57 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>
>> So here are the updated figures for the force-updated history
>> (pu-like):
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u@{10} =A0 =A0 u@{100} =A0 =A0u@{=
1000}
>> manual =A0 =A0 =A0 =A0 0m0.535s =A0 =A00m1.164s =A0 =A00m1.415s
>> linear =A0 =A0 =A0 =A0 0m1.245s =A0 0m37.367s =A0 5m10.068s
>> merge-base =A0 =A00m14.490s =A0 0m15.409s =A0 0m15.508s
>> exp(1,2) =A0 =A0 =A0 0m1.056s =A0 =A00m6.175s =A0 0m27.221s
>> exp(10,10) =A0 =A0 0m1.950s =A0 0m20.031s =A0 0m18.215s
>> exp(7,7) =A0 =A0 =A0 0m1.310s =A0 =A00m6.851s =A0 0m16.757s
>>
>> and for the non-force-updated history (master-like):
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u@{10} =A0 =A0 u@{100} =A0 =A0u@{=
1000}
>> manual =A0 =A0 =A0 =A0 0m0.885s =A0 =A00m6.126s =A0 0m52.248s
>> linear =A0 =A0 =A0 =A0 0m1.349s =A0 0m39.688s =A0 5m28.753s
>> merge-base =A0 =A0 0m1.160s =A0 =A00m1.699s =A0 =A00m1.901s
>> exp(1,2) =A0 =A0 =A0 0m0.769s =A0 =A00m4.342s =A0 =A00m7.360s
>> exp(10,10) =A0 =A0 0m0.700s =A0 =A00m2.535s =A0 =A00m3.110s
>> exp(7,7) =A0 =A0 =A0 0m0.653s =A0 =A00m2.332s =A0 =A00m3.506s
>
> I have a suspicion that merge-base shouldn't be taken as "one of the
> candidates among others".
>
> It is merely a technique to check multiple heads simultaneously and
> cheaply, instead of checking things one by one, and should be applica=
ble
> regardless of these "multiple heads" come from. =A0It may come from a=
 linear
> walk of reflog, or it may come from a leaky exponential or fibonacci =
walk.

Here the merge-base strategy mean take all the reflog at once. And in t=
his
case the reflog is 1000 entries long, it is only relevant to the u@{100=
0}
case. For me it is more like: take the solution and check that indeed i=
t is
the solution. In this sense it is the "minimum" time required to find t=
he
solution.

>
> Instead of "linear" that checks "Is the tip good? =A0Is the tip@{1} g=
ood?
> Is the tip@{2} good? How about tip@{3}?" repeatedly, we can check "is=
 the
> tip through tip@{N} good?" with a single invocation using the merge-b=
ase
> technique.

exp(n,m) is similar to this. But, yes, we could have a merge-base(N)
strategy which checks using the merge-base technique the first N reflog
entries, then the next N entries, and so on. But I think it would scale=
 worst
then the exponential strategy.

>
> Similarly if your exp(i,j) checks "Is the tip good? tip@{1}? tip@{2}?
> tip@{4}? =A0tip@{8}? ..." =A0iteratively, you can grab these commit o=
bject
> names out of reflog and still use the merge-base optimization, effect=
ively
> making "one at a time" check into "N at a time" check (perhaps checki=
ng a
> dozen or two at a time).

Indeed it is "Is the tip good? tip@{1},tip@{2}? tip@{4},tip{5},...,tip@=
{8}?
=2E.. and the merge-base techinque is used to answer each question.

>
> If you generate list of reglog entries way beyond what matters to the=
 end
> result, and feed all of them to the machinery, it is not surprising t=
hat
> it would spend more time than linear that can stop early upon the fir=
st
> success.

But if the answer is the last entry in the reflog (as in the u@{1000} c=
ase) it
is a lower limit, see above.

>
> We should optimize for common case by picking the default that perfor=
ms
> well for history that is never rewound. =A0If the the default algorit=
hm on
> pathological histories performs badly, it is Ok to have an alternativ=
e
> heuristics that is only triggered on such a history, but if we are go=
ing
> to do so, we need to make sure that we can cheaply detect if we need =
to
> use the alternative heuristics in the first place.

Maybe I'm wrong, but from the number I see that the exp strategy this
"optimize for the common case and works reasonably work for pathologica=
l
histories".

>
> Is it easy to tell in an earlier phase if the history is "force-updat=
ed"
> or not?
>

I'm afraid this is a similar question.

HTH,
Santi
