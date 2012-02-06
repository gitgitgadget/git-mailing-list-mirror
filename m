From: Johan Herland <johan@herland.net>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Mon, 6 Feb 2012 07:53:57 +0100
Message-ID: <CALKQrgfOE7Ekmuvut9Lff37v7BPJu5ohYjwq_Nk2sCkrUOF15w@mail.gmail.com>
References: <201202042045.54114.jnareb@gmail.com>
	<EAF9D593-4E0C-4C95-A048-3F6AC8ADD866@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 07:54:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuISn-00014G-Cs
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 07:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388Ab2BFGyE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 01:54:04 -0500
Received: from locusts.copyleft.no ([178.255.144.241]:58820 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab2BFGyD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 01:54:03 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1RuISe-000BKY-IM
	for git@vger.kernel.org; Mon, 06 Feb 2012 07:54:00 +0100
Received: by iacb35 with SMTP id b35so8074130iac.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 22:53:57 -0800 (PST)
Received: by 10.50.222.132 with SMTP id qm4mr8885666igc.21.1328511237280; Sun,
 05 Feb 2012 22:53:57 -0800 (PST)
Received: by 10.42.226.9 with HTTP; Sun, 5 Feb 2012 22:53:57 -0800 (PST)
In-Reply-To: <EAF9D593-4E0C-4C95-A048-3F6AC8ADD866@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190032>

On Mon, Feb 6, 2012 at 01:57, Steven Michalske <smichalske@gmail.com> w=
rote:
> On Feb 4, 2012, at 11:45 AM, Jakub Narebski wrote:
>> In Mercurial 2.1 there are three available phases: 'public' for
>> published commits, 'draft' for local un-published commits and
>> 'secret' for local un-published commits which are not meant to
>> be published.
>>
>> The phase of a changeset is always equal to or higher than the phase
>> of it's descendants, according to the following order:
>>
>> =C2=A0 =C2=A0 =C2=A0public < draft < secret
>
> Let's not limit ourselves to just three levels. =C2=A0They are a grea=
t start but I propose the following.
>
> published - The commits that are on a public repository that if are r=
ewritten will invoke uprisings.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0general rule here would be to revert or pa=
tch, no rewrites.
> based - The commits that the core developers have work based upon. (n=
ot just the commits in their repo.)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0general rule is notify your fellow develop=
ers before a rewrite.
> shared - The commits that are known to your fellow core developers.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0These commits are known, but have not had =
work based off of them. =C2=A0Minimal risk to rewrite.
> local - The commits that are local only, no one else has a copy.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Commits your willing to share, but have no=
t been yet shared, either from actions of you, or a fetch from others.
> restricted or private - The commits that you do not want shared.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Manually added, think of a branch tip mark=
ed as restricted automatically promotes commits to the branch as restri=
cted.
>
> Maybe make these like nice levels, but as two components, publicity 0=
-100 and rewritability 0-100
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Published is publicity 100 and rewritabili=
ty 0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Restricted is publicity 0 and rewritabilit=
y 100
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Based publicity 75 and rewritability 25
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Shared publicity 50 and rewritability 50
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Local publicity 25 and rewritability 75
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Restricted publicity 0 and rewritability 1=
00
>
> [...]

With all due respect, I believe this is crazy. You're adding an entire
layer of complexity on top of commits that every user has to know
about, and has little or no value to most of them. IMHO, most users
only want Git to help them avoid doing something stupid (rewriting
'public' commits or publishing 'secret' commits), and to do so with
the minimal amount of manual user interaction. The above idea is more
suitable for armchair dictators that want to micromanage their commits
along two arbitrary axes of evil^H^H^H^Hpointlessness. On both axes,
you'll need threshold values where Git starts refusing to
publish/rewrite your commit. Hence, the only thing that matters is
whether the 'publicity'/'rewritability' value is above/below that
threshold, at which point you could save yourself a lot of trouble by
making them simple boolean flags instead.

Having said that, you can use 'git notes' along with existing and
proposed hooks (as described elsewhere in this thread) to implement
whatever crazy commit publishing/rewriting scheme you desire. To
misquote someone famous: I disapprove of what you want to do with Git,
but I will defend to the death your right to make Git do what you want
(in the privacy of your own repos). ;)


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
