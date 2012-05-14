From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5] completion: add new __git_complete helper
Date: Mon, 14 May 2012 19:55:09 +0200
Message-ID: <CAMP44s1pb+J_SAzZ66QVcWq4V=LauUQ2VmzMD8KBtnhjubkkVg@mail.gmail.com>
References: <1337009718-1164-1-git-send-email-felipe.contreras@gmail.com>
	<7vvcjyhd5n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 19:55:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STzUN-0008Jt-4m
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 19:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062Ab2ENRzM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 May 2012 13:55:12 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33971 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751239Ab2ENRzL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 13:55:11 -0400
Received: by lahd3 with SMTP id d3so3526314lah.19
        for <git@vger.kernel.org>; Mon, 14 May 2012 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=60CMSbOxh6SxDHFUBjd1rxWwjhZKO4bEPhAnyq9ylqE=;
        b=Z6E1RnA54vB+aFXdxYWlHAydQB+p90wy59pPF99TCwmL63E42HqS79qwvTML+NN+Dm
         PkYdBcNFm4idvsGldJ4dZdY1YR4PjcidiIJwL2aT8zwj8DsOrBqQzA6t9BGFAi+fs0Uk
         VxtR2BsqqolCclkTFndxQSc1OkJ2tCKa6FY1lx2v/6fu9BEY3coD3Cxr6i6+VrqvB0u9
         GvqLQtvaPeTmZl1txi89oyXR+74bs+nmwzGeoln4yEWqOvCwCqXpiEteN0yAJ1vTWaTZ
         LfIBDYuHDAVJkYVwa/aIUJSfH6L2Xv/zKpMnocAAJLmcGxWeroayDtYchYEDdYhdjhXJ
         oUsg==
Received: by 10.112.28.10 with SMTP id x10mr4099616lbg.41.1337018109433; Mon,
 14 May 2012 10:55:09 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Mon, 14 May 2012 10:55:09 -0700 (PDT)
In-Reply-To: <7vvcjyhd5n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197793>

On Mon, May 14, 2012 at 7:43 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> This simplifies the completions, and would make it easier to define
>> aliases in the future.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> =C2=A0contrib/completion/git-completion.bash | =C2=A0 70 +++++++++++=
++++-----------------
>> =C2=A0t/t9902-completion.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
>> =C2=A02 files changed, 34 insertions(+), 38 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index 9f56ec7..d60bb8a 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2603,21 +2603,6 @@ _git ()
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 local i c=3D1 command __git_dir
>>
>> - =C2=A0 =C2=A0 if [[ -n ${ZSH_VERSION-} ]]; then
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 emulate -L bash
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setopt KSH_TYPESET
>> -
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # workaround zsh's bug t=
hat leaves 'words' as a special
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # variable in versions <=
 4.3.12
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h words
>> -
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # workaround zsh's bug t=
hat quotes spaces in the COMPREPLY
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # array if IFS doesn't c=
ontain spaces.
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h IFS
>> - =C2=A0 =C2=A0 fi
>> -
>> - =C2=A0 =C2=A0 local cur words cword prev
>> - =C2=A0 =C2=A0 _get_comp_words_by_ref -n =3D: cur words cword prev
>> =C2=A0 =C2=A0 =C2=A0 while [ $c -lt $cword ]; do
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i=3D"${words[c]}"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case "$i" in
>> @@ -2667,22 +2652,6 @@ _git ()
>>
>> =C2=A0_gitk ()
>> =C2=A0{
>> - =C2=A0 =C2=A0 if [[ -n ${ZSH_VERSION-} ]]; then
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 emulate -L bash
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setopt KSH_TYPESET
>> -
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # workaround zsh's bug t=
hat leaves 'words' as a special
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # variable in versions <=
 4.3.12
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h words
>> -
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # workaround zsh's bug t=
hat quotes spaces in the COMPREPLY
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # array if IFS doesn't c=
ontain spaces.
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h IFS
>> - =C2=A0 =C2=A0 fi
>> -
>> - =C2=A0 =C2=A0 local cur words cword prev
>> - =C2=A0 =C2=A0 _get_comp_words_by_ref -n =3D: cur words cword prev
>> -
>> @@ -2703,16 +2672,43 @@ _gitk ()
>> =C2=A0 =C2=A0 =C2=A0 __git_complete_revlist
>> =C2=A0}
>>
>> -complete -o bashdefault -o default -o nospace -F _git git 2>/dev/nu=
ll \
>> - =C2=A0 =C2=A0 || complete -o default -o nospace -F _git git
>> -complete -o bashdefault -o default -o nospace -F _gitk gitk 2>/dev/=
null \
>> - =C2=A0 =C2=A0 || complete -o default -o nospace -F _gitk gitk
>
> Nice code reduction by moving the duplicated code into the new helper=
s ;-)
>
>> +__git_func_wrap ()
>> +{
>> + =C2=A0 =C2=A0 if [[ -n ${ZSH_VERSION-} ]]; then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 emulate -L bash
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setopt KSH_TYPESET
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # workaround zsh's bug t=
hat leaves 'words' as a special
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # variable in versions <=
 4.3.12
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h words
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # workaround zsh's bug t=
hat quotes spaces in the COMPREPLY
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # array if IFS doesn't c=
ontain spaces.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h IFS
>> + =C2=A0 =C2=A0 fi
>> + =C2=A0 =C2=A0 local cur words cword prev
>> + =C2=A0 =C2=A0 _get_comp_words_by_ref -n =3D: cur words cword prev
>> + =C2=A0 =C2=A0 $1
>> +}
>> +
>> +# Setup completion for certain functions defined above by setting c=
ommon
>> +# variables and workarounds.
>> +# This is NOT a public function; use at your own risk.
>> +__git_complete ()
>> +{
>> + =C2=A0 =C2=A0 local wrapper=3D"__git_wrap${2}"
>> + =C2=A0 =C2=A0 eval "$wrapper () { __git_func_wrap $2 ; }"
>> + =C2=A0 =C2=A0 complete -o bashdefault -o default -o nospace -F $wr=
apper $1 2>/dev/null \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || complete -o default -=
o nospace -F $wrapper $1
>> +}
>> +
>> +__git_complete git _git
>> +__git_complete gitk _gitk
>
> It makes my stomach queasy whenever I see $var not in double quotes t=
hat
> forces me to guess (and trace to verify if the codepath is what I rea=
lly
> care about) if any value with $IFS in it could be used there, so even=
 when
> they are known to be safe, I'd prefer to see either explicit quotes o=
r
> comment that says what are expected in $1 and $2.

Which ones? These?

>> + =C2=A0 =C2=A0 $1
>> + =C2=A0 =C2=A0 complete -o bashdefault -o default -o nospace -F $wr=
apper $1 2>/dev/null \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || complete -o default -=
o nospace -F $wrapper $1

So you want:

  "$1"

  complete -o bashdefault -o default -o nospace -F "$wrapper" "$1" 2>/d=
ev/null \
    || complete -o default -o nospace -F "$wrapper" "$1"

I wouldn't object to the arguments of complete, but the function call
seems totally unintuitive to me like that.

--=20
=46elipe Contreras
