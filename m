From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 (for maint)] git-completion: fix zsh support
Date: Tue, 10 May 2011 01:08:17 +0300
Message-ID: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
References: <1304973913-5376-1-git-send-email-felipe.contreras@gmail.com>
	<20110509211316.GB22908@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 00:08:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYcx-0007OS-1v
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166Ab1EIWIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 18:08:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60117 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165Ab1EIWIT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 18:08:19 -0400
Received: by fxm17 with SMTP id 17so3917548fxm.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dfS2X191YG8MEunONbOtb5FaxxJ0RF5tJk8yYklpjbA=;
        b=j8GehP8rRiaQyX9mF+wyW+LfdLuVW57N1jKbR60r8FXJZhuh7s+X6668f+sI46aKO1
         V0OqZ+B6vW6okqzLg9/idKAO5rjJYEItbhkWqF+MjPsgxns32jcw/ktclmwmBx7uHjN9
         /9nJ2ykVSNqZyxSIR6qYkVEvw4CZckmxLx/ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DUzh1WZCUCC5Set+SsovAV8WYCZ2PfXp0T6LoqI0Ame1f6/shrtLBXUex/36rXdGX/
         GUUKg6K+pkdDx/aT+hBsiGobHf2M5Lhcgar4wmZvpDcDf0t54g8lGLArS8AiBpmghbo5
         ZzsxZXo1uEN3COqx9/2TH6KEK9Qt5AkVMiGLs=
Received: by 10.223.83.3 with SMTP id d3mr2059287fal.89.1304978898050; Mon, 09
 May 2011 15:08:18 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Mon, 9 May 2011 15:08:17 -0700 (PDT)
In-Reply-To: <20110509211316.GB22908@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173273>

On Tue, May 10, 2011 at 12:13 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Felipe Contreras wrote:
>
>> It turns out 'words' is a special variable used by zsh completion, s=
ort
>> of like 'COMP_WORDS' in bash.
>
> I was not aware that COMP_WORDS was special (rather than just
> prepopulated). =C2=A0Is it?

I didn't mean to suggest it was special, only what 'words' was used
for. I'll remove that section as it doesn't really matter.

>> This was not isolated correctly in zsh's
>> bash completion, so by trying to set it as 'local' in git's completi=
on,
>> unexpected results occur; assignations are not propagated to upper
>> levels in the call stack.
>
> Does the call stack grow up or down? =C2=A0I suspect this means:

I'll change that to "outer levels".

> =C2=A0 =C2=A0 =C2=A0 =C2=A0zsh's bash completion emulation layer does=
 not sufficiently
> =C2=A0 =C2=A0 =C2=A0 =C2=A0insulate us from that reality. =C2=A0In pa=
rticular, the variable
> =C2=A0 =C2=A0 =C2=A0 =C2=A0keeps the "special" attribute (even after =
a declaration "local
> =C2=A0 =C2=A0 =C2=A0 =C2=A0words"), so assignments within a function =
are undone whenever
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the function returns.

That explains less.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0In particular, until 3bee6a473 (completion=
: don't declare
> =C2=A0 =C2=A0 =C2=A0 =C2=A0'local words' to make zsh happy, 2011-04-2=
8), the "words" array
> =C2=A0 =C2=A0 =C2=A0 =C2=A0would be cleared in _git by declaring "loc=
al words" and its new
> =C2=A0 =C2=A0 =C2=A0 =C2=A0value would never be propagated from _get_=
comp_words_by_ref so
> =C2=A0 =C2=A0 =C2=A0 =C2=A0it remained empty and the completion scrip=
t could not tell that
> =C2=A0 =C2=A0 =C2=A0 =C2=A0there were existing subcommand names on th=
e command line (so
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"git log m<TAB>" would complete subcommand=
 names).

I don't see the point in explaining in excruciating detail all the
series of steps in which an unset variable causes problems; the
variable doesn't get set, thus one can assume there are problems. And
the problem is already explained to be that completion is completely
broken.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0And even after 3bee6a473 we do not have th=
e ability to modify
> =C2=A0 =C2=A0 =C2=A0 =C2=A0words. =C2=A0(... explanation of impact of=
 the change goes here ...)
>
> I am not a great writer so that is probably more verbose than needed.
> So it might be better for me to describe the goals of a commit messag=
e:
>
> =C2=A01) the text should be specific about what the commit fixes, so
> =C2=A0 =C2=A0someone reading it later (e.g., after bisecting) does no=
t come
> =C2=A0 =C2=A0around and accidentally break it

See the title: fix zsh support

> =C2=A02) in particular, the text should be specific about the observa=
ble
> =C2=A0 =C2=A0symptoms, so it can be easier to check if a later change=
 has
> =C2=A0 =C2=A0broken it.

=46rom the title: zsh completion doesn't work at all. Which is repeated=
 again:
---
Right now zsh is completely broken...
---

If zsh completion is completely broken, chance are it has to do with
this. And I did explain the most obvious test; check if the value of
'words' doesn't get propagated to the upper layers in the call stack.

>> This is now fixed in the latest master branch of zsh[1] by simply
>> defining 'words' as hidden (typeset -h), which removes the special
>> meaning inside the emulated bash function. It probably won't be rele=
ased
>> until version 4.3.12.
>>
>> In the meantime, we can workaround the issue by doing the same; defi=
ning
>> words as hidden (typeset -h) as soon as possible.
>
> It might make sense to reverse the order of these: first explain the
> fix in the context of the problem being solved, and then add a note
> mentioning that the fix will not be needed for long and that the
> method is the same as what zsh is planning to use.

That's what I did initially, but everyone doubted my solution. Now I
want to start making sure people see it's a good solution.

> Meanwhile this doesn't address the risk that functions called by the
> completion script will use $words.

It does.

> Outside the context of the commit
> message I think you've said something about that (e.g., that the zsh
> developers prefer this fix --- a reference would be nice so we could
> steal their rationale).

I did. If you don't like their commit message, talk to them.

> Maybe the best thing to say would be "that is
> a risk, but let's wait and see", to give future readers more
> confidence that that was considered but it is ok to fix it if it come=
s
> up?

I don't see any risk.

>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2710,6 +2710,10 @@ _git ()
>> =C2=A0 =C2=A0 =C2=A0 if [[ -n ${ZSH_VERSION-} ]]; then
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 emulate -L bash
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setopt KSH_TYPESET
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # workaround zsh's bashi=
nit's bug that leaves 'words' as a
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # special variable in ve=
rsions < 4.3.12
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typeset -h words
>
> I don't think the comment clarifies much. =C2=A0What is the intended
> message to the reader? =C2=A0For example if it is "don't remove this =
line
> unless you use zsh 4.3.12 or greater", I'd say something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# bashcompinit=
 versions after 4.3.12 already hide the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# special "wor=
ds" variable already. =C2=A0We do it
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# again oursel=
ves to support older zsh versions.

I think it's perfectly clear. Specially if you compare it against the
two lines above that have no explanation at all. Double standards
much?

--=20
=46elipe Contreras
