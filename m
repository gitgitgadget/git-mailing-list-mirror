From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] Use reflog in 'pull --rebase . foo'
Date: Sun, 14 Nov 2010 00:10:55 +0100
Message-ID: <AANLkTi=QQZUjYtvRRiunrsCXMOX9+85K_nZXwsrT30bM@mail.gmail.com>
References: <1289590708-11064-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <m2pqu98urp.fsf@whitebox.home> <AANLkTiniwpk7ao=M4=5vuahczk6FscQYJE1rZx=wuBk_@mail.gmail.com>
 <AANLkTikmJVj9BM=K2oSYJvPV27Uzn_9SQhsLc9EQm8zQ@mail.gmail.com> <AANLkTineaFVawXbJKHKv39bwPco7JHcmpUwXtZhscaFs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 00:11:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHPFl-00077n-9u
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 00:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827Ab0KMXLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Nov 2010 18:11:20 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48662 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab0KMXLT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Nov 2010 18:11:19 -0500
Received: by qyk12 with SMTP id 12so2417481qyk.19
        for <git@vger.kernel.org>; Sat, 13 Nov 2010 15:11:18 -0800 (PST)
Received: by 10.229.241.78 with SMTP id ld14mr3482002qcb.188.1289689876873;
 Sat, 13 Nov 2010 15:11:16 -0800 (PST)
Received: by 10.229.105.76 with HTTP; Sat, 13 Nov 2010 15:10:55 -0800 (PST)
In-Reply-To: <AANLkTineaFVawXbJKHKv39bwPco7JHcmpUwXtZhscaFs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161399>

On Sat, Nov 13, 2010 at 6:52 PM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> On Sat, Nov 13, 2010 at 12:20 PM, Santi B=E9jar <santi@agolina.net> w=
rote:
>> On Sat, Nov 13, 2010 at 1:09 PM, Martin von Zweigbergk
>> <martin.von.zweigbergk@gmail.com> wrote:
>>> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
>>> index 5f47b18..2e1661d 100644
>>> --- a/git-parse-remote.sh
>>> +++ b/git-parse-remote.sh
>>> @@ -63,11 +63,8 @@ get_default_remote () {
>>> =A0get_remote_merge_branch () {
>>> =A0 =A0 =A0 =A0case "$#" in
>>> =A0 =A0 =A0 =A00|1)
>>> - =A0 =A0 =A0 =A0 =A0 origin=3D"$1"
>>> - =A0 =A0 =A0 =A0 =A0 default=3D$(get_default_remote)
>>> - =A0 =A0 =A0 =A0 =A0 test -z "$origin" && origin=3D$default
>>> =A0 =A0 =A0 =A0 =A0 =A0curr_branch=3D$(git symbolic-ref -q HEAD)
>>> - =A0 =A0 =A0 =A0 =A0 [ "$origin" =3D "$default" ] &&
>>> + =A0 =A0 =A0 =A0 =A0 test -z "$1" || test "$1" =3D $(get_default_r=
emote) &&
>>> =A0 =A0 =A0 =A0 =A0 =A0echo $(git for-each-ref --format=3D'%(upstre=
am)' $curr_branch)
>>> =A0 =A0 =A0 =A0 =A0 =A0;;
>>> =A0 =A0 =A0 =A0*)
>>
>> They are not equivalent, the last line (echo $(git for-each-ref...))
>> is always executed, not only when ask for the default remote. When
>> $origin !=3D $default the last line does not return the correct answ=
er.
>> It should return nothing, it is not well defined. Or maybe it should
>> return the branch pointed by $origin/HEAD (I cannot test right now
>> what 'git pull $remote-not-the-default' merges).

After thinking (and testing) this again, I see now that I was wrong,
the behavior is identical. But I find it more difficult to follow, but
maybe it is because I wrote the original.

>>
>> And it has nothing to do with letting 'pull --rebase . for" work.
>
> You are right, of course. I think I was modifying the code to try to
> understand how it behaved and it should not have been part of the pat=
ch.
> Sorry about that.
>
> Junio, will you just exclude that hunk?

Better send it again, and add my

Ack-by: Santi B=E9jar <santi@agolina.net>

Santi
