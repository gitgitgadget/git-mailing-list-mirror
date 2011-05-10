From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 (for maint)] git-completion: fix zsh support
Date: Tue, 10 May 2011 13:44:50 +0300
Message-ID: <BANLkTikRM==ttn2qmd-PY9tdfUhe5Xtqzg@mail.gmail.com>
References: <1304973913-5376-1-git-send-email-felipe.contreras@gmail.com>
	<20110509211316.GB22908@elie>
	<BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
	<20110510020421.GA25814@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 12:44:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJkQz-0000JU-J7
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 12:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812Ab1EJKox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 06:44:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60087 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916Ab1EJKow convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 06:44:52 -0400
Received: by fxm17 with SMTP id 17so4207181fxm.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 03:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=USNNdg8UKXE0Tfe2HoOLt1aM3PxZuZhjX1BoeGEAK/0=;
        b=wCR9Z9tpuvIfk9RxhQOD72khF/L+qeiPFGDVDT2eXg69OFtgwtA/vqaTBZ+nH2UyBv
         v/9mdOApk7U/7dv3qF/VOSMw03fWbAOhygrZrd0kpx80cvNF2ds6oBhsDYkqHcpyiTyt
         riBaOYd7CFg2c7821Vdx7/l9JyggT6BEyIns8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kNA2z1v2uAN2KCCWJU+qwzFakoRg/RAe+ZJWmAjTod0/TsKnTuBBLZ1/VcPpOO34Ju
         P6fWHVjqCZWYGzLuliDlJi9+EiLHhsMIjb9MHBmov4TEUye5KIDlTIwyPmiCEhC6G8LL
         0VFLUhqivvDkx7Bws/+9FWQXKq0H569rfzcU4=
Received: by 10.223.87.215 with SMTP id x23mr1163484fal.32.1305024290865; Tue,
 10 May 2011 03:44:50 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Tue, 10 May 2011 03:44:50 -0700 (PDT)
In-Reply-To: <20110510020421.GA25814@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173324>

On Tue, May 10, 2011 at 5:04 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>> On Tue, May 10, 2011 at 12:13 AM, Jonathan Nieder <jrnieder@gmail.co=
m> wrote:
>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0zsh's bash completion emulation layer do=
es not sufficiently
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0insulate us from that reality. =C2=A0In =
particular, the variable
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0keeps the "special" attribute (even afte=
r a declaration "local
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0words"), so assignments within a functio=
n are undone whenever
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the function returns.
>>
>> That explains less.
>
> I believe you. =C2=A0Could you give a hint of what it misses, so that=
 it
> can be fixed?

This is what I explained:
---
so by trying to set it as 'local' in git's completion, unexpected
results occur; assignations are not propagated to outer levels in the
call stack.
---

My text explains why Gabor's patch works: it doesn't set 'words' as
local. Your text doesn't explain that; it generalizes that 'words'
always behave that way, which is not the case. Your text also suggests
that the assignments are always undone, which is not the case, as I
explained; it only happens to the outer levels in the call stack.

>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0In particular, until 3bee6a473 (completi=
on: don't declare
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0'local words' to make zsh happy, 2011-04=
-28), the "words" array
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0would be cleared in _git by declaring "l=
ocal words" and its new
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0value would never be propagated from _ge=
t_comp_words_by_ref so
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0it remained empty and the completion scr=
ipt could not tell that
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0there were existing subcommand names on =
the command line (so
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"git log m<TAB>" would complete subcomma=
nd names).
>>
>> I don't see the point in explaining in excruciating detail all the
>> series of steps in which an unset variable causes problems; the
>> variable doesn't get set, thus one can assume there are problems.
>
> Am I daft? =C2=A0I guess so. =C2=A0I really do have sympathy for the =
person who
> runs into this code, and wanting to check while making some change
> with unrelated purpose that it is still fixed, fires up zsh and runs
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git a<TAB>
>
> . =C2=A0Does it complete? =C2=A0Yep, check, moving on. =C2=A0Oops.

I didn't notice that. That can be easily explained with one line:

---
the completion script could not tell that there were existing
subcommand names on the command line (so "git log m<TAB>" would
complete subcommand names).
---

--=20
=46elipe Contreras
