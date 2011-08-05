From: James Gregory <j.gregory@epigenesys.co.uk>
Subject: Re: git-fast-export is returning streams with source code inside
Date: Fri, 5 Aug 2011 10:54:29 +0100
Message-ID: <CAFC9htzzPQWFLGCpAP2WHhDQajfknwz1KUu6K0gvyhCVX5gyaQ@mail.gmail.com>
References: <CAFC9htxwRg=+RD68hnnRy0hfptq23x3bL+xxHieK1evfFCTPjw@mail.gmail.com>
	<20110804070528.GA11805@sigill.intra.peff.net>
	<CAFC9htxRD0z3O_k_OLp08KZFUOL_T3AryCXD+OqqXx9ZYeRutg@mail.gmail.com>
	<20110804183218.GA15943@sigill.intra.peff.net>
	<CAFC9htyFKm7NCNFvrUkxXpmj1jwatWkxrnRSEdztY4Syo+EQ-g@mail.gmail.com>
	<20110805093618.GA19062@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 05 11:54:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpH6y-0003OW-4h
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 11:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab1HEJyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Aug 2011 05:54:31 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:49210 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab1HEJya convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2011 05:54:30 -0400
Received: by yia27 with SMTP id 27so1576662yia.19
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 02:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=epigenesys.co.uk; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3h7nJFyhgFUNtFPOTkniEspzpuhhYPemTyYyX//ffos=;
        b=YWcnhNVDRawZ4HxCzjaMly7d00ect6WVfyInM3GJQcNEvMLoetRHUvfkK8V3RaXv3d
         9vkfKRzZYAExmHcTUONpSeI/kynFrweE9d0kDRZGgRy0jtzh4AmmglNobl/r1fjw6uda
         t4Bb1WwYQ2+P7D0MnVt77a2k+8SBUC+/aHp6o=
Received: by 10.143.20.5 with SMTP id x5mr1864250wfi.41.1312538069259; Fri, 05
 Aug 2011 02:54:29 -0700 (PDT)
Received: by 10.142.71.15 with HTTP; Fri, 5 Aug 2011 02:54:29 -0700 (PDT)
In-Reply-To: <20110805093618.GA19062@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178784>

Hi Peff,

Thanks for the feedback. I've just looked at the commit on gitweb, and
this could be the problem!

---
fixed dodgy filename
spec/blueprints/sjt_blueprint.rb	[moved from
spec/blueprints/sjt_blueprint.rb\n lead_in\n scenario\n answers {
Sham.answers_object }\n justification_selected\n
justification_unselected\n mark_scheme {
Sham.single_mark_scheme_object }\nend\nmcq_blueprint.rb with 100%
similarity]
---

I'm guessing that is where the problem lies... somehow the git
transaction has got corrupt(?)

James

On 5 August 2011 10:36, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 05, 2011 at 10:24:07AM +0100, James Gregory wrote:
>
>> I've attached the valgrind.out file. If I'm reading the output
>> properly, it does look like it is suffering from a memory leak.
>
> It looks pretty innocuous:
>
>> =3D=3D3267=3D=3D Conditional jump or move depends on uninitialised v=
alue(s)
>> =3D=3D3267=3D=3D =A0 =A0at 0x4E39510: inflateReset2 (in /lib/x86_64-=
linux-gnu/libz.so.1.2.3.4)
>> =3D=3D3267=3D=3D =A0 =A0by 0x4E39605: inflateInit2_ (in /lib/x86_64-=
linux-gnu/libz.so.1.2.3.4)
>> =3D=3D3267=3D=3D =A0 =A0by 0x4D5B02: ??? (in /usr/bin/git)
>> =3D=3D3267=3D=3D =A0 =A0by 0x4BB059: ??? (in /usr/bin/git)
>> =3D=3D3267=3D=3D =A0 =A0by 0x4BC464: ??? (in /usr/bin/git)
>> =3D=3D3267=3D=3D =A0 =A0by 0x4BCA29: ??? (in /usr/bin/git)
>> =3D=3D3267=3D=3D =A0 =A0by 0x4BCAFD: ??? (in /usr/bin/git)
>> =3D=3D3267=3D=3D =A0 =A0by 0x4BD161: ??? (in /usr/bin/git)
>> =3D=3D3267=3D=3D =A0 =A0by 0x49AEAC: ??? (in /usr/bin/git)
>> =3D=3D3267=3D=3D =A0 =A0by 0x4B38AA: ??? (in /usr/bin/git)
>> =3D=3D3267=3D=3D =A0 =A0by 0x4B422A: ??? (in /usr/bin/git)
>> =3D=3D3267=3D=3D =A0 =A0by 0x4A9CD2: ??? (in /usr/bin/git)
>
> This is a well-known false positive caused by zlib, and is nothing to
> worry about.
>
>> =3D=3D3267=3D=3D LEAK SUMMARY:
>> =3D=3D3267=3D=3D =A0 =A0definitely lost: 48,016 bytes in 3 blocks
>> =3D=3D3267=3D=3D =A0 =A0indirectly lost: 30,226 bytes in 1,889 block=
s
>
> These are actual leaks, but minor.
>
>> =3D=3D3267=3D=3D =A0 =A0 =A0possibly lost: 0 bytes in 0 blocks
>> =3D=3D3267=3D=3D =A0 =A0still reachable: 2,743,134 bytes in 4,334 bl=
ocks
>
> These are not really leaks, but rather things we don't bother cleanin=
g
> up since we're about to exit and let the OS reclaim memory (e.g., all=
 of
> the commit objects).
>
> So yes, there's leaking, but it's not much. And more importantly, I w=
as
> looking not for leaks, but for memory access errors (of which there a=
re
> none, except for the zlib false positive).
>
> So I'm not sure where to go from here. I can't reproduce the problem
> locally. Is there anything else you can tell us about the problem? Do=
es
> it always happen on the same commit? If you export just that commit,
> does the problem happen? Is there anything noteworthy in the contents=
 of
> that commit?
>
> -Peff
>



--=20

James Gregory
Senior Developer
epiGenesys - a University of Sheffield company
Enterprise Zone, Portobello, Sheffield, S1 4DP, UK
T: +44 (0)114 22 21884 ~ F: +44 (0)114 22 24042
www.epigenesys.co.uk ~ @epigenesys
--
This email and its attachments should be considered confidential and
are intended solely for the individual to whom the email is addressed.
If you are not the intended recipient you should take no action based
upon them, nor should you copy or show them to anyone. Any views or
opinions expressed are solely those of the author and might not
represent those of Epi Genesys Limited.
Epi Genesys Limited is registered in England and Wales with company
number 06388971 and has its registered office at 40 Leavygreave Road,
Sheffield, S3 7RD.
