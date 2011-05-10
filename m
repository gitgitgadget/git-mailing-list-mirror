From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] completion: suppress zsh's special 'words' variable
Date: Tue, 10 May 2011 14:29:29 +0300
Message-ID: <BANLkTinahOqULpaH8KHiRa3NdTM1s9EzkQ@mail.gmail.com>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
	<1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
	<20110510025529.GA26619@elie>
	<20110510025916.GB26619@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 13:29:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJl8C-0003CJ-Cc
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 13:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608Ab1EJL3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 07:29:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53482 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab1EJL3a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 07:29:30 -0400
Received: by fxm17 with SMTP id 17so4230054fxm.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 04:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jHyVH/JGlixlTXkg7DPXxerkY+uiTAhJhP9sKuzz6UE=;
        b=ZROrsadLAmOMYIM8HjoGWYxF7TRmdCzCJFTVJbrr2IXrh0iwKWjW6o701Yduo2Gizt
         f8WSWOzYJ5yv9WweF7nqBCl62L18otGJiRTc/eV6zRn7byH6N8Ns4t+1c4NBlFqiqy6n
         MdNGRyofVtoJtI4N1gUykrbKgMGXn9Ox7IECo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oKRs+3HMABrGfF0oxBkU5X2RjwGdlIUy68RvJlmBOfVyqkEVmMoBd1QIKOWCKoQ9qh
         2/FEAMn+X1AefUdiaBDNKRCsca5KPqIV9jljnF1HA6g8YSdEl4ak/KKR/Dk2iesQIhVk
         Y8ljr9+FsiUzMIV/saSCN9DJnb0m5EI9fT5NA=
Received: by 10.223.100.86 with SMTP id x22mr1311736fan.108.1305026969355;
 Tue, 10 May 2011 04:29:29 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Tue, 10 May 2011 04:29:29 -0700 (PDT)
In-Reply-To: <20110510025916.GB26619@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173326>

On Tue, May 10, 2011 at 5:59 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> From: Felipe Contreras <felipe.contreras@gmail.com>

The summary:
"completion: suppress zsh's special 'words' variable"

Does not explain what is the effect to the end-user. If some months
for now somebody starts looking for the fix to this issue, the summary
would not help, and the commit would be easily missed.

> After git's tab completion script gained zsh support in
> v1.7.4-rc0~169^2 (completion: make compatible with zsh, 2010-09-06)
> it was broken moments later.

You are missing a comma there. And to me "after foo, it got" sounds
more natural.

> More precisely, the completion does not
> notice when it has seen a subcommand name, so all words complete as
> options to the git wrapper or subcommand names. =C2=A0For example, ty=
ping
> "git log origi<TAB>" gives no completions because there are no "git
> origi..." commands.
>
> The cause: it turns out 'words' is one of the special parameters used
> by the zsh completion system, used to hold the words from the command
> it is completing. =C2=A0As a result (in the words of zshcompwid(1)):
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[...] the parameters are reset on each fun=
ction exit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(including nested function calls from with=
in the completion
> =C2=A0 =C2=A0 =C2=A0 =C2=A0widget) to the values they had when the fu=
nction was entered.

Interesting. I hadn't seen this behavior documented before.

> Each function in git's completion script using the 'words' array
>
> =C2=A0- declares "local words", causing the array to be cleared (but =
not
> =C2=A0 resetting the special attribute);
>
> =C2=A0- calls "_get_comp_words_by_ref -n :=3D words" to fill it with =
a
> =C2=A0 modified version of COMP_WORDS with ':' and '=3D' no longer tr=
eated
> =C2=A0 as word separators (see v1.7.4-rc0~11^2~2, 2010-12-02). =C2=A0=
Within
> =C2=A0 _get_comp_words_by_ref all is well, and when the function retu=
rns,
> =C2=A0 words is reset to its former value;
>
> =C2=A0- examines $words and finds it empty.

I don't see the point of explaining these 3 points. This is explaining
how the fix was found, which is rarely useful. If you really want to
explain each step from the fix to it's effect, I say that should be at
the end of the commit message.

> Fix it by suppressing the special 'words' variable with typeset -h
> so it can be used as an ordinary array.

The 'word' variable is not "suppressed"; it's replaced locally with an
ordinary variable.

> The only risk is that the
> completion script might call a function that wants to inspect the
> 'words' variable,

There are no such functions. AFAIK the only function used by bash
completion is 'compgen' and in no part of it does the zsh emulation
make use of the 'words' special variable.

> expecting the zsh-specific meaning;

> luckily the next
> version of zsh's bashcompinit (e880604f, 29140: hide the "words"
> special variable so that it may be used as an ordinary variable by
> bash completions, 2011-05-04) will also use 'typeset -h words' when
> calling completion functions so

This looks like it should be a separate paragraph, specially since you
are referring to this text next:

> =C2=A0- soon this fix will be redundant :)

This is important, and can be explained with one word in the summary:
workaround.

> =C2=A0- anyone else using the bashcompinit library is risking the sam=
e
> =C2=A0 problem, so presumably other functions from that library are
> =C2=A0 carefully written to only look at $COMP_WORDS and not $words.

There is no problem, you have always assumed so, you are the only one.

Write a test that shows the problem.

> This fixes a regression introduced by v1.7.4-rc0~11^2~2 (2010-12-02).

This is the important part, you should start with that.

> Reported-by: Stefan Haller <lists@haller-berlin.de>
> Improved-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

I have not s-o-b'ed this.

Also, mention that you wrote the changelog:

[rewrote changelog]
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

--=20
=46elipe Contreras
