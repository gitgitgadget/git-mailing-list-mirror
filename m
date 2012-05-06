From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Sun, 6 May 2012 22:53:24 +0200
Message-ID: <CAMP44s1bvez99p=hBreB4xDy9hRmwomYx8keae5Cj-mywdxjDQ@mail.gmail.com>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
	<20120506111425.GJ2164@goldbirke>
	<20120506121204.GA5799@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun May 06 22:53:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR8SQ-0003b7-E0
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 22:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab2EFUx0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 16:53:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59062 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab2EFUxZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 16:53:25 -0400
Received: by eaaq12 with SMTP id q12so1228455eaa.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oHUr0ZfjK/AKzbeKyz5xKp7CoL1AwTRzFjyQXmTAKUk=;
        b=qP3UweYPuLp5Y16Qwf1BqJuYV78RqoZrSOrLu0sA3xgqco6ZaykZFW4WTyQVyygRQM
         LNwFfOIkIdEJCf4N0uXlDRzgky6GGTw6wVdQxX5Az/cez22NI3xNJ0qOyVOb58MPiKnv
         nUL7ZhMGNQguTLHzPJBzAhxD/n616vj+S2+9LZa5XsDfqMMyyS23LJaec4i4iyaoclQj
         FZ8JJ9k03bDQAIb0Ah26u1EZ8dni6U1hgGR3p5q3INNNse49h0x+PEfra5UWuea3XFYd
         y2Tk2sSgqVMHaROvOsKOWbnmw7fXanG5aOP8VVvtHo6VyjlhuKhUPMR/mFfKw17AhhwV
         F5ew==
Received: by 10.213.14.143 with SMTP id g15mr812614eba.52.1336337604412; Sun,
 06 May 2012 13:53:24 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sun, 6 May 2012 13:53:24 -0700 (PDT)
In-Reply-To: <20120506121204.GA5799@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197212>

On Sun, May 6, 2012 at 2:12 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> w=
rote:
> Hi,
>
>
> On Sun, May 06, 2012 at 01:14:25PM +0200, SZEDER G=C3=A1bor wrote:
>> On Sat, May 05, 2012 at 05:23:20PM +0200, Felipe Contreras wrote:
>> > +__git_func_wrap ()
>> > +{
>> > + =C2=A0 if [[ -n ${ZSH_VERSION-} ]]; then
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 emulate -L bash
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setopt KSH_TYPESET
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # workaround zsh's bug that l=
eaves 'words' as a special
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # variable in versions < 4.3.=
12
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h words
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # workaround zsh's bug that q=
uotes spaces in the COMPREPLY
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # array if IFS doesn't contai=
n spaces.
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h IFS
>> > + =C2=A0 fi
>> > + =C2=A0 local cur words cword prev
>> > + =C2=A0 _get_comp_words_by_ref -n =3D: cur words cword prev
>> > + =C2=A0 __git_func "$@"
>> > +}
>> > +
>> > +_GIT_complete ()
>> > +{
>> > + =C2=A0 local name=3D"${2-$1}"
>> > + =C2=A0 eval "$(typeset -f __git_func_wrap | sed -e "s/__git_func=
/_$name/")"
>>
>> Still don't like the subshell and sed here ...
>>
>> > + =C2=A0 complete -o bashdefault -o default -o nospace -F _${name}=
_wrap $1 2>/dev/null \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || complete -o default -o nos=
pace -F _${name}_wrap $1
>> > +}
>> > +
>> > +_GIT_complete git
>> > +_GIT_complete gitk
>>
>> ... because it adds delay when the completion script is loaded. =C2=A0=
But I
>> still don't have ideas how to avoid them.
>
> Ok, I think I got it. =C2=A0How about this on top of Felipe's patch?
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index f300b87d..8c18db92 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2688,19 +2688,19 @@ __git_func_wrap ()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local cur words cword prev
> =C2=A0 =C2=A0 =C2=A0 =C2=A0_get_comp_words_by_ref -n =3D: cur words c=
word prev
> - =C2=A0 =C2=A0 =C2=A0 __git_func "$@"
> + =C2=A0 =C2=A0 =C2=A0 $1
> =C2=A0}
>
> =C2=A0_GIT_complete ()
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 local name=3D"${2-$1}"
> - =C2=A0 =C2=A0 =C2=A0 eval "$(typeset -f __git_func_wrap | sed -e "s=
/__git_func/_$name/")"
> - =C2=A0 =C2=A0 =C2=A0 complete -o bashdefault -o default -o nospace =
-F _${name}_wrap $1 2>/dev/null \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || complete -o def=
ault -o nospace -F _${name}_wrap $1
> + =C2=A0 =C2=A0 =C2=A0 local wrapper=3D"__git_wrap_$1"
> + =C2=A0 =C2=A0 =C2=A0 eval "$wrapper () { __git_func_wrap $2 ; }"
> + =C2=A0 =C2=A0 =C2=A0 complete -o bashdefault -o default -o nospace =
-F $wrapper $1 2>/dev/null \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || complete -o def=
ault -o nospace -F $wrapper $1
> =C2=A0}

This has unnecessary changes, and can be simplified this way:

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index f300b87..dd1ff33 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2688,13 +2688,13 @@ __git_func_wrap ()
        fi
        local cur words cword prev
        _get_comp_words_by_ref -n =3D: cur words cword prev
-       __git_func "$@"
+       _$1
 }

 _GIT_complete ()
 {
        local name=3D"${2-$1}"
-       eval "$(typeset -f __git_func_wrap | sed -e "s/__git_func/_$nam=
e/")"
+       eval "_${name}_wrap () { __git_func_wrap $name ; }"
        complete -o bashdefault -o default -o nospace -F _${name}_wrap
$1 2>/dev/null \
                || complete -o default -o nospace -F _${name}_wrap $1
 }

Of course, it might make sense to use the $wrapper variable, but that
increases the diff, so I avoided it for reviewing purposes. And I
still see no point forcing users to specify the full name of the
function; they should not be bothered with such details.

Cheers.

--=20
=46elipe Contreras
