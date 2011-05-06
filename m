From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH for maint] git-completion: fix zsh support
Date: Fri, 6 May 2011 12:27:45 +0300
Message-ID: <BANLkTikk1wfaC4Aic4iyJZXbZ5kkuEDxaA@mail.gmail.com>
References: <20110505185907.GD1377@goldbirke>
	<1304625144-5206-1-git-send-email-felipe.contreras@gmail.com>
	<20110505232503.GA7507@elie>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174733ae39fa8a04a2981aeb
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 11:27:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIHKF-0001SH-M5
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 11:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892Ab1EFJ1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 05:27:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53427 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab1EFJ1r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 05:27:47 -0400
Received: by fxm17 with SMTP id 17so2116581fxm.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=eP7/xzDVGO+isA8GKwj5zilI41i7sQXk7+G6tusPfhc=;
        b=YMABFXX8edXj1M08m98cwMUgfoXpG7UIz7eFQxpMEdzl7UUTX7mCvbAIofuxwNzJBs
         +oukGOY61fvECQPlBoTNOMx8Z2Ec1l1q7Wt+++gDPVNLH5hy5iwC48CLsc5v7Wzf2YLm
         U3N3/dbUzHmOi1NrZ6QI38gZDOYGJKG8GPSCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=A//xEtCbnEbCyoO2+nvWz7aEqEIMepMVcnUyOxAyMfvqWKmDI8eQ4+eZrrszR5tV+U
         HgJGohd2RkbXGXgE44ySSy+XZTJl09TFoEdsH+TTfTXU0ouuGMHiiNW/32e/pCtP5DSu
         tvvVhTLEUhg1Xf859CetRJMcWiBpla+ZOtR9U=
Received: by 10.223.100.86 with SMTP id x22mr1845600fan.108.1304674065578;
 Fri, 06 May 2011 02:27:45 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Fri, 6 May 2011 02:27:45 -0700 (PDT)
In-Reply-To: <20110505232503.GA7507@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172963>

--0015174733ae39fa8a04a2981aeb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 6, 2011 at 2:25 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>> It turns out 'words' is a special variable used by zsh completion.
>>
>> There's probably a bug in zsh's bashcompinit:
>> http://article.gmane.org/gmane.comp.shells.zsh.devel/22546
>>
>> But in the meantime we can workaround it by using 'typedef -h', which
>> gets rid of any special meaning.
>
> As I mentioned before (sorry to come in late; I assume you forgot to
> cc the previous participants in the discussion?), I do not think this
> is a good fix.
>
> The point here is that 'words' is a special variable used by zsh
> completion, and we are using facilities from zsh completion. =C2=A0So
> if you set 'typeset -h', then the zsh completion functions will
> use _our_ copy of "words".

No, the scope remains local.

>From the manual:
---
Hide: only useful for special parameters (those marked `<S>' in the
table in zshparam(1)), and for local parameters with the same name as
a special parameter, though harmless for others. A special parameter
with this attribute will not retain its special effect when made
local. Thus after `typeset -h PATH', a function containing `typeset
PATH' will create an ordinary local parameter without the usual
behaviour of PATH. Alterna=E2=80=90 tively, the local parameter may itself =
be
given this attribute; hence inside a function `typeset -h PATH'
creates an ordinary local parameter and the special PATH parameter is
not altered in any way. It is also possible to create a local
parameter using `typeset +h special', where the local copy of special
will retain its special properties regardless of having the -h
attribute. Global special parameters loaded from shell modules (cur=E2=80=
=90
rently those in zsh/mapfile and zsh/parameter) are automatically given
the -h attribute to avoid name clashes.
---

> Now in practice our copy of words matches zsh's anyway, so nothing
> goes wrong. =C2=A0But that could easily change in the future.

It doesn't matter if we change the value of 'words'. See the attached
test. The result is:

 complete: words=3Dfoo  (before)
 foo: cur=3Dfoo words=3Dblah cwords=3D1
 foo bar: cur=3Dfoo words=3Dblah cwords=3D1
 complete: words=3Dfoo  (after)

See? No change.

In fact, if you follow the link I posted, that's precisely the fix the
zsh guys were pushing for. And the it is already merged:
http://zsh.git.sourceforge.net/git/gitweb.cgi?p=3Dzsh/zsh;a=3Dcommitdiff;h=
=3De880604f029088f32fb1ecc39213d720ae526aaa

I also discussed the workaround with zsh guys:
http://article.gmane.org/gmane.comp.shells.zsh.devel/22557

>> Currently zsh is completely broken after commit da48616 (bash: get
>> --pretty=3Dm<tab> completion to work with bash v4), which introduced
>> _get_comp_words_by_ref() that comes from debian's bash_completion
>> scripts
>
> The bash_completion project does not originate in Debian fwiw; it
> was originally from Ian Macdonald iirc and available from
>
> =C2=A0http://www.caliban.org/bash/index.shtml
>
> and then it was abandoned. =C2=A0The bash-completion project on alioth is
> not Debian-specific, either.

Well, it's hosted on debian.org, and I haven't seen it used anywhere
else. I just don't know how else to identify that project.

> Maybe simplest would be to use Szeder's fix + make the zsh version of
> _get_comp_words_by_ref not overwrite "words" at all?

I think the simplest fix is the one I'm proposing, which zsh guys agree wit=
h.

Cheers.

--=20
Felipe Contreras

--0015174733ae39fa8a04a2981aeb
Content-Type: application/octet-stream; name=zsh_words_2
Content-Disposition: attachment; filename=zsh_words_2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gncx6pke0

IyF6c2gKCnNldF92YXJzICgpCnsKCWN1cj0ke0NPTVBfV09SRFNbQ09NUF9DV09SRF19CgkjIHdv
cmRzPSgiJHtDT01QX1dPUkRTW0BdfSIpCgl3b3Jkcz0iYmxhaCIKCWN3b3Jkcz0kQ09NUF9DV09S
RAp9CgpfZm9vX2JhciAoKQp7Cglsb2NhbCBjdXIgd29yZHMgY3dvcmRzCglzZXRfdmFycwoKCWVj
aG8gImZvbyBiYXI6IGN1cj0ke2N1cn0gd29yZHM9JHt3b3Jkc30gY3dvcmRzPSR7Y3dvcmRzfSIg
Pj4gL3RtcC9jb21wX3Rlc3QudHh0Cn0KCl9mb28gKCkKewoJdHlwZXNldCAtaCB3b3JkcwoKCWxv
Y2FsIGN1ciB3b3JkcyBjd29yZHMKCXNldF92YXJzCgoJZWNobyAiZm9vOiBjdXI9JHtjdXJ9IHdv
cmRzPSR7d29yZHN9IGN3b3Jkcz0ke2N3b3Jkc30iID4+IC90bXAvY29tcF90ZXN0LnR4dAoKCV9m
b29fYmFyCn0KCmJhc2hfY29tcGxldGUgKCkKewoJKCggQ09NUF9DV09SRCA9IENVUlJFTlQgLSAx
KSkKCUNPTVBfV09SRFM9KCAkd29yZHMgKQoJQ09NUFJFUExZPSgpCgoJZWNobyAiY29tcGxldGU6
IHdvcmRzPSR7d29yZHN9IChiZWZvcmUpIiA+PiAvdG1wL2NvbXBfdGVzdC50eHQKCV9mb28gIiR7
d29yZHNbMF19IiAiJHt3b3Jkc1tDVVJSRU5ULTFdfSIgIiR7d29yZHNbQ1VSUkVOVC0yXX0iCgll
Y2hvICJjb21wbGV0ZTogd29yZHM9JHt3b3Jkc30gKGFmdGVyKSIgPj4gL3RtcC9jb21wX3Rlc3Qu
dHh0Cn0KCmNvbXBkZWYgYmFzaF9jb21wbGV0ZSBmb28K
--0015174733ae39fa8a04a2981aeb--
