From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Sun, 13 Mar 2011 00:51:30 +0100
Message-ID: <AANLkTikrYbY6r5hYnhWCB1GVKbPgounxdvAGeejsUKoC@mail.gmail.com>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vzkpxm45e.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102152040370.14950@debian>
 <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com>
 <alpine.DEB.2.00.1102161122350.14950@debian> <AANLkTik-JGZFCE+m7g__mwfQhRReOM=Qe_EO3otw50XC@mail.gmail.com>
 <alpine.DEB.2.00.1103120930250.15442@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 00:51:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyYbG-0005UM-KI
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 00:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756260Ab1CLXvx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Mar 2011 18:51:53 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54865 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250Ab1CLXvv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Mar 2011 18:51:51 -0500
Received: by qyk7 with SMTP id 7so535737qyk.19
        for <git@vger.kernel.org>; Sat, 12 Mar 2011 15:51:50 -0800 (PST)
Received: by 10.224.201.198 with SMTP id fb6mr2926158qab.92.1299973910339;
 Sat, 12 Mar 2011 15:51:50 -0800 (PST)
Received: by 10.229.78.209 with HTTP; Sat, 12 Mar 2011 15:51:30 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1103120930250.15442@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168952>

Thanks for pushing this further.

I'll read it all carefully later, but let me just comment one thing.

On Sat, Mar 12, 2011 at 10:15 PM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> On Thu, 17 Feb 2011, Santi B?jar wrote:
>
>> On Wed, Feb 16, 2011 at 5:45 PM, Martin von Zweigbergk
>> <martin.von.zweigbergk@gmail.com> wrote:
>> > On Wed, 16 Feb 2011, Santi B?jar wrote:
>> >
>> >> On Wed, Feb 16, 2011 at 3:03 AM, Martin von Zweigbergk
>> >> <martin.von.zweigbergk@gmail.com> wrote:
>> >> >
>> >> > =A0 =A0 =A0 =A0.-u@{0}
>> >> > =A0 =A0 =A0 /
>> >> > =A0 =A0 =A0.---u@{1}
>> >> > =A0 =A0 /
>> >> > x---y-----u@{2}
>> >> > =A0 =A0 \
>> >> > =A0 =A0 =A0.---u@{3}---b
>> >> > =A0 =A0 =A0 \
>> >> > =A0 =A0 =A0 =A0.-u@{4}
>> >> >
>> >> >
>> >> > I have an idea inspired by bisection, Thomas's exponential stri=
de, and
>> >> > what someone (you?) mentioned the other day about virtual merge
>> >> > commits. I haven't tried it out, but let me know what you think=
=2E I'll
>> >> > try to explain it using an example only:
>> >> >
>> >> > Exponential stride phase:
>> >> > 1. candidates=3D{ u@{0} }
>> >> > =A0 merge-base b $candidates -> y, _not_ in $candidates
>> >> > 2. candidates=3D{ u@{1} u@{2} }
>> >> > =A0 merge-base b $candidates -> y, _not_ in $candidates
>> >> > 3. candidates=3D{ u@{3} u@{4} u@{5} u@{6} }
>> >> > =A0 merge-base b $candidates -> u@{3}, in $candidates
>> >>
>> >> Doesn't it indicate that u@{3} is the commit we are looking for? =
I
>> >> haven't found a counterexample...
>> >
>> > Yes, of course. Stupid me ;-). Forget about the other half. (I thi=
nk
>> > that's what I did manually to match the sha1 back to the ref name,=
 but
>> > that is of course complete non-sense to do in the script.)
>> >
>> >> If this is true the following patch can implement it for git-pull=
=2Esh and
>> >> git-rebase.sh (sorry if it is space damaged):
>> >
>> > Thanks! Will have a closer look at it later today. If I understand
>> > correctly, you simply call merge-base with the _entire_ reflog. I
>>
>> Yes, that is the idea (plus the old remote hash in case of git-pull)
>>
>> > would have thought that would be slow, but it's great if that is f=
ast
>> > enough.
>>
>> Yes, I think it is fast enough in the normal case. Even feeding the
>> entire git.git's master, ~25000 revisions, it takes around 2-4 secon=
ds
>> only:
>>
>> $ git rev-list origin/master | wc -l
>> 24380
>> $ time git merge-base $(git rev-list origin/master)
>> 9971d6d52c5afeb8ba60ae6ddcffb34af23eeadd
>>
>> real =A00m4.014s
>> user =A00m1.520s
>> sys =A0 0m2.284s
>>
>> (2.5GHz CPU)
>
>
> I finally got around to doing some tests on this myself. I used
> git.git as of mid Feb, which at that time had 10010 commits in master=
,
> following only the first parent. I took the first 563 commits from th=
e
> todo branch and transplanted onto master~10000 (there were some
> conflicts after about 563 commits and I figured that would be enough
> anyway). I then rebased the resulting branch (let's call it 'u')
> against master~9990, then against master~9980 and so on to get a
> reflog with 1001 entries for u. I then created another branch 'b'
> based on u@{10}, u@{100} and @{1000}, for different runs of the
> tests. I created one additional commit on b in each case. I then
> rebased b with master, using the following algorithms to find the bas=
e
> to rebase from:
>
> =A0manual: simply calling 'git rebase --onto u b~1'
>
> =A0linear: same algorithm as in 'git pull', which linearly walks the
> =A0reflog until a commit that b contains is found
>
> =A0merge-base: the base will be calculated as 'git merge-base b $(git
> =A0ref-list -g u)'
>
> =A0exponential: like merge-base, but start with only u@{0}, then
> =A0{u@{1},u@{2}} and so on until a commit that b contains is found
>

=46irst, care to share the scripts/patches for the timings? Thanks.

Could you test also variants of the exponential strategy?

exponential(n,m): like merge-base, but start with n candidates {u@{0},
=2E.., u@{n-1}}, then n*m candidates and so on until a commit that b
contains is found.

Your exponential would be exponential(1,2).

Timings for something like exponential(10,2) or exponential(10,10),
maybe others.

Thanks,
Santi
