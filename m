From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] Add possibility to store configuration in
 ~/.config/git/config file
Date: Sat, 26 May 2012 17:15:13 +0700
Message-ID: <CACsJy8BD_=6PtQeuDGEt2mee9tMWZB1hL2obu2f2KUmAENTEzA@mail.gmail.com>
References: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
 <20120525203056.GC4364@sigill.intra.peff.net> <7vd35sq7fx.fsf@alter.siamese.dyndns.org>
 <20120525214406.GA10064@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 26 12:16:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYE2s-0006jq-Rn
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 12:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290Ab2EZKPq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 06:15:46 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33988 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab2EZKPp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 May 2012 06:15:45 -0400
Received: by wgbdr13 with SMTP id dr13so1567059wgb.1
        for <git@vger.kernel.org>; Sat, 26 May 2012 03:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=u0icZkzWGy2H95BbxBpNw6olrx0jBan6C4vxMRc/dIg=;
        b=rJCQIVm0Uldq0gYVg1j93GxGgCnSzp/tIoQ4HWRpWllHtc9+7NcoMP/PguRNXoaGnf
         gdK3x72WGUpA+d9yL297e6BSbyC2u1kQFGpHzEXpme8k6Bs8yLtq29POAiW2HgTsXHby
         t8GxhBgI2ZF8VPCRYTgtygI6qF8lY8IdhsNLl1HZWsBZfT4ZWgOCmubrADeJBd3h6DKg
         OlkGcVfGFEKYYs/GZXGfnRqR0iZ+yaiFRX4ZGahu1zaT7Q0pmBs1KWTdJUkvplhuSUVE
         hcP50m/jo+nAtjcsaePwZT+gKYwFi8nxPbv61H85+d4VsCPSX7D83t2fPF5YxfpqOoxL
         V6dQ==
Received: by 10.216.194.196 with SMTP id m46mr254303wen.197.1338027344164;
 Sat, 26 May 2012 03:15:44 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sat, 26 May 2012 03:15:13 -0700 (PDT)
In-Reply-To: <20120525214406.GA10064@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198549>

On Sat, May 26, 2012 at 4:44 AM, Jeff King <peff@peff.net> wrote:
>> I'd rather see it ignore the new location as long as ~/.gitconfig ex=
ists
>> (and if only the new location exists, read from and write to it), an=
d have
>> users make a conscious decision to transition. =C2=A0That is:
>>
>> =C2=A0- If ~/.gitconfig exists, do not do anything new. =C2=A0Just e=
xercise the
>> =C2=A0 =C2=A0original code. =C2=A0For these users, ~/.config/ does _=
not_ exist as far as
>> =C2=A0 =C2=A0Git is concerned.
>>
>> =C2=A0- (optional) If ~/.gitconfig exists, offer _moving_ it to the =
new
>> =C2=A0 =C2=A0location after telling the user to make sure that the u=
ser will never
>> =C2=A0 =C2=A0use older version of git again, and move it if the user=
 agrees.
>>
>> =C2=A0- Otherwise, read from and write to the new location.
>
> That doesn't solve all problems with multiple versions, though. For
> example, this sequence:
>
> =C2=A01. User consciously moves to new location, moving ~/.gitconfig =
to
> =C2=A0 =C2=A0 ~/.config/git/config (or perhaps they do not do so cons=
ciously, but
> =C2=A0 =C2=A0 do not have a ~/.gitconfig at all, and run "git config =
--global"
> =C2=A0 =C2=A0 with the new version.
>
> =C2=A02. User runs "git config --global" with an old version of git, =
which
> =C2=A0 =C2=A0 writes to ~/.gitconfig.
>
> After step 1, old versions of git will not respect the user's config =
at
> all. This is unavoidable; the old version does not know about the new
> location.
>
> But after step 2, _all_ versions of git have stopped respecting the n=
ew
> location (because ~/.gitconfig takes precedence). Whereas if we read
> from everywhere, then it is broken only in older versions (which are
> broken anyway).
>
> So I consider it the lesser of two evils. The rule is much simpler: "=
old
> versions of git do not know about this new location". Which is
> unavoidable, and easier to explain than "Old versions of git do not k=
now
> about this location. New versions do, but will sometimes ignore
> depending on whether this other file exists, which might have been
> created by an old version".

We could amend Junio's version a bit:

 - if both versions exist, warn loudly (optionally refuse to work) and
suggest to symlink .gitconfig to .config/git/config


> However, let's take a step back for a minute. I think the real issue =
is
> writing to the XDG location without the user knowing about it. So a
> better transition plan would be:
>
> =C2=A01. Start reading from the XDG location in addition to the old
> =C2=A0 =C2=A0 location. Always write to the old location.
>
> =C2=A02. Wait N time units until everybody reasonable has a version t=
hat
> =C2=A0 =C2=A0 does (1).
>
> =C2=A03. Start writing to the XDG location by default. Keep reading f=
rom the
> =C2=A0 =C2=A0 old version for compatibility.

Hang on.. this "by default" is only for Linux, or for every other OS to=
o?


> People who want to start using the new location after step 1 are free=
 to
> do so; they just shouldn't expect git to write to it, and they should
> accept the obvious caveat that older versions of git will not underst=
and
> it. An optional addendum is that we could start writing to the XDG
> location after step 1 only if it exists, which implies that the user =
has
> decided it's OK to do so (which is still a guess; they might have wan=
ted
> to split their config intentionally).
--=20
Duy
