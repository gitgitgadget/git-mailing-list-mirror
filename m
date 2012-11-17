From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 4/5] completion: get rid of compgen
Date: Sat, 17 Nov 2012 20:33:22 +0100
Message-ID: <CAMP44s0YnoGwJEgUbXZ831_OrgO=dDf5_QHxT5JYnGUHYPuiTw@mail.gmail.com>
References: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
	<1353116298-11798-5-git-send-email-felipe.contreras@gmail.com>
	<20121117110031.GE12052@goldbirke>
	<CAMP44s21CUb3_KhHBfJXW+Eqd45kz1hcbx3GCbs+f0HNRDEAzw@mail.gmail.com>
	<20121117141215.GG12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 17 20:33:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZo94-0003T1-0d
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 20:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab2KQTdX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 14:33:23 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44601 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab2KQTdW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 14:33:22 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so3793928obb.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 11:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+1WfrFV+dRDWrTha5Ar6dmkBcj9jjlwYRpdSFo3+hLw=;
        b=rYvGOgIcaiOyecCA6hbZqYBQ9zvz9/l+tHQ49pnvRqbNbJo+aCSulUGRIEkkT0AKQa
         /tTmmz/C0j2MMcHxPW4WrPXw2WKbImcYWQcVtRxSnxAG3L1VHInsOFZAb6BvuMneMY0L
         vKXJpqqU6e4gAWCsI3aQ6mqhXcWJwpMl1auMJQzduMn2NCENgPMyThXx6XZwk8Y8Ao3I
         A/aDQMAz6NYHcUk0kNaQN1G6S7UgR8cvr3d58f+ngv+zWslZi98pEZ6fPmI+MQKNEE9H
         jRgictLGkBZHOpySc9KgYDhJoytN0EhqwRJkq1NIdIbsHtOpEtbOJajpy6Vzr8kHLi2/
         F9SA==
Received: by 10.60.32.19 with SMTP id e19mr7171116oei.9.1353180802329; Sat, 17
 Nov 2012 11:33:22 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 17 Nov 2012 11:33:22 -0800 (PST)
In-Reply-To: <20121117141215.GG12052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209971>

On Sat, Nov 17, 2012 at 3:12 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> On Sat, Nov 17, 2012 at 12:42:38PM +0100, Felipe Contreras wrote:
>> On Sat, Nov 17, 2012 at 12:00 PM, SZEDER G=C3=A1bor <szeder@ira.uka.=
de> wrote:
>> > On Sat, Nov 17, 2012 at 02:38:17AM +0100, Felipe Contreras wrote:
>> >> The functionality we use is very simple, plus, this fixes a known
>> >> breakage 'complete tree filename with metacharacters'.
>> >>
>> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> >> ---
>> >>  contrib/completion/git-completion.bash | 6 +++++-
>> >>  1 file changed, 5 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/contrib/completion/git-completion.bash b/contrib/com=
pletion/git-completion.bash
>> >> index 975ae13..ad3e1fe 100644
>> >> --- a/contrib/completion/git-completion.bash
>> >> +++ b/contrib/completion/git-completion.bash
>> >> @@ -227,7 +227,11 @@ fi
>> >>
>> >>  __gitcompadd ()
>> >>  {
>> >> -     COMPREPLY=3D($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))
>> >> +     for x in $1; do
>> >> +             if [[ "$x" =3D "$3"* ]]; then
>> >> +                     COMPREPLY+=3D("$2$x$4")
>> >> +             fi
>> >> +     done
>> >
>> > The whole point of creating __gitcomp_nl() back then was to fill
>> > COMPREPLY without iterating through all words in the wordlist, mak=
ing
>> > completion faster for large number of words, e.g. a lot of refs, o=
r
>> > later a lot of symbols for 'git grep' in a larger project.
>> >
>> > The loop here kills that optimization.
>>
>> So your solution is to move the loop to awk? I fail to see how that
>> could bring more optimization, specially since it includes an extra
>> fork now.
>
> This patch didn't aim for more optimization, but it was definitely a
> goal not to waste what we gained by creating __gitcomp_nl() in
> a31e6262 (completion: optimize refs completion, 2011-10-15).  However=
,
> as it turns out the new version with awk is actually faster than
> current master with compgen:
>
>   Before:
>
>     $ refs=3D"$(for i in {0..9999} ; do echo branch$i ; done)"
>     $ time __gitcomp_nl "$refs"
>
>     real    0m0.242s
>     user    0m0.220s
>     sys     0m0.028s
>
>   After:
>
>     $ time __gitcomp_nl "$refs"
>
>     real    0m0.109s
>     user    0m0.096s
>     sys     0m0.012s

This one is even faster:

while read -r x; do
	if [[ "$x" =3D=3D "$3"* ]]; then
		COMPREPLY+=3D("$2$x$4")
	fi
done <<< $1

=3D=3D 10000 =3D=3D
one:
real	0m0.148s
user	0m0.134s
sys	0m0.025s
two:
real	0m0.055s
user	0m0.054s
sys	0m0.000s

--=20
=46elipe Contreras
