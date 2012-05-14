From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5] completion: add new __git_complete helper
Date: Mon, 14 May 2012 20:30:45 +0200
Message-ID: <CAMP44s1h=MPT8vx6JrGjMZWJzRjndxYKoYgo+1Y_Mmv+gWXzaQ@mail.gmail.com>
References: <1337009718-1164-1-git-send-email-felipe.contreras@gmail.com>
	<7vvcjyhd5n.fsf@alter.siamese.dyndns.org>
	<CAMP44s1pb+J_SAzZ66QVcWq4V=LauUQ2VmzMD8KBtnhjubkkVg@mail.gmail.com>
	<7vmx5ahbrm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 20:30:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU02n-0007p7-Jg
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 20:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448Ab2ENSat convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 May 2012 14:30:49 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37053 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757199Ab2ENSar convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 14:30:47 -0400
Received: by lahd3 with SMTP id d3so3555115lah.19
        for <git@vger.kernel.org>; Mon, 14 May 2012 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=rt764RdrDGjclGGZ+kc4JpPFeG0b68a2TMbIUXzU3E8=;
        b=qX+YsTHiA+WqoaNdO9Bf2l6ZmBrfibCarNhF++EcCmQO3j0yQQgBZuzgwooACJ67am
         uz4jeWAa5sPy/YCZKATdeTer0//yv4L85gxu8r9kenRNHnUthop5lkU+a6LJGbYBkh5w
         E3poUNrkVUKJKrlbtCchI5Q6ACiMJjY+r8VsC/ZD+2Zb+t/0pvRcpf9VBR7XuZLZhcjF
         P1e8f+C56XhHGdOEOsQyVBQou1svtm6lPwUq4OAwpMtKSZPi3Q5SGNqdC5yRTp5XeUyg
         Bv8VQ8CThJFvCHDocAg6lX0vDF7Ooqrz6/3wDyRs35KLuoniNRdE7mdip9gMu+N74LSi
         Wciw==
Received: by 10.112.98.70 with SMTP id eg6mr4204464lbb.13.1337020245782; Mon,
 14 May 2012 11:30:45 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Mon, 14 May 2012 11:30:45 -0700 (PDT)
In-Reply-To: <7vmx5ahbrm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197797>

On Mon, May 14, 2012 at 8:13 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>> +__git_func_wrap ()
>>>> +{
>>>> + =C2=A0 =C2=A0 if [[ -n ${ZSH_VERSION-} ]]; then
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 emulate -L bash
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setopt KSH_TYPESET
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # workaround zsh's bug=
 that leaves 'words' as a special
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # variable in versions=
 < 4.3.12
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h words
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # workaround zsh's bug=
 that quotes spaces in the COMPREPLY
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # array if IFS doesn't=
 contain spaces.
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h IFS
>>>> + =C2=A0 =C2=A0 fi
>>>> + =C2=A0 =C2=A0 local cur words cword prev
>>>> + =C2=A0 =C2=A0 _get_comp_words_by_ref -n =3D: cur words cword pre=
v
>>>> + =C2=A0 =C2=A0 $1
>>>> +}
>>>> +
>>>> +# Setup completion for certain functions defined above by setting=
 common
>>>> +# variables and workarounds.
>>>> +# This is NOT a public function; use at your own risk.
>>>> +__git_complete ()
>>>> +{
>>>> + =C2=A0 =C2=A0 local wrapper=3D"__git_wrap${2}"
>>>> + =C2=A0 =C2=A0 eval "$wrapper () { __git_func_wrap $2 ; }"
>>>> + =C2=A0 =C2=A0 complete -o bashdefault -o default -o nospace -F $=
wrapper $1 2>/dev/null \
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || complete -o default=
 -o nospace -F $wrapper $1
>>>> +}
>>>> +
>>>> +__git_complete git _git
>>>> +__git_complete gitk _gitk
>>>
>>> It makes my stomach queasy whenever I see $var not in double quotes=
 that
>>> forces me to guess (and trace to verify if the codepath is what I r=
eally
>>> care about) if any value with $IFS in it could be used there, so ev=
en when
>>> they are known to be safe, I'd prefer to see either explicit quotes=
 or
>>> comment that says what are expected in $1 and $2.
>>
>> Which ones?
>
> All of them ;-)
>
> Here is my attempt to explain why none of them needs to be quoted:
>
> =C2=A0# Setup completion for certain functions defined above by setti=
ng common
> =C2=A0# variables and workarounds.
> =C2=A0# It takes two parameters:
> =C2=A0# =C2=A0- the first is the command name on the command line to =
complete its
> =C2=A0# =C2=A0 =C2=A0arguments for the user;
> =C2=A0# =C2=A0- the second is a name of the completion function
> =C2=A0# This is NOT a public function; use at your own risk.
> =C2=A0#
> =C2=A0# Note that none of the variable reference in the implementatio=
n of this
> =C2=A0# function needs dq around it.

I don't understand that.

> =C2=A0# wrapper: the name of an internal shell function that wraps th=
e
> =C2=A0# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0completion function $2, for=
med by prefixing "__git_wrap"
> =C2=A0# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in front of it. =C2=A0As it=
 has to be usable as a name of a
> =C2=A0# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shell function, by definiti=
on there won't be $IFS characters
> =C2=A0# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in it.
> =C2=A0# $1: =C2=A0 =C2=A0 =C2=A0the command name on the command line-=
--ditto.
> =C2=A0# $2: =C2=A0 =C2=A0 =C2=A0the shell function name that implemen=
ts the completion-ditto.

So in short; because the variables are used as function/command names.

Cheers.

--=20
=46elipe Contreras
