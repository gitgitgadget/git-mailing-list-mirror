From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] builtins: check for startup_info->help, print and
 exit early
Date: Wed, 20 Oct 2010 08:18:22 +0700
Message-ID: <AANLkTik7=q3UyxxY+PGhokzCSDJyb9ZRjgjM9SoZ37vd@mail.gmail.com>
References: <1287495320-27278-1-git-send-email-pclouds@gmail.com>
 <1287495320-27278-3-git-send-email-pclouds@gmail.com> <7vvd4y16t8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 03:19:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8NLD-0003KE-5C
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 03:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003Ab0JTBSp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 21:18:45 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55942 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab0JTBSn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Oct 2010 21:18:43 -0400
Received: by wyb28 with SMTP id 28so3156046wyb.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 18:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=37hVTl/MBMK3NV5Shg37tkLOggD6Ayy8kBOGrS9Bwr8=;
        b=gxKIAEznabpVX+FS4vWz/Nu5t2ZLEiqXFOwADXGW7TefXXVG+hCOY/dSo2rp7rtJvl
         aeyLnz/rF/X0S3Klabeat7JAOaWYfPSs960WZegOshew3dKeOaYv/adcTsE9AfF8McwX
         NraWKSPM+Qh/RQOQlceFdA8GwzCbAxdMFgSSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GlFZORHh9QrrklGunUJyjAFNSQZChiEE4LVpdpPVoVzLGJa6znP+bnJnBFYIcPRFmf
         CZcshBpPzSBmcA8pM9CUavYAZufETxSsNGrAnmh8nEWk1rqRzYMIPfjkR8UeVFza5PHI
         3y5cjDssbJvaDuKjZnZ/Z1la3zrNpfi8TeMcE=
Received: by 10.216.1.18 with SMTP id 18mr7464311wec.24.1287537522274; Tue, 19
 Oct 2010 18:18:42 -0700 (PDT)
Received: by 10.216.171.207 with HTTP; Tue, 19 Oct 2010 18:18:22 -0700 (PDT)
In-Reply-To: <7vvd4y16t8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159383>

2010/10/19 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> These commands need more than just git_config() before parsing
>> commmand line arguments. Some of these activities will unconditional=
ly
>> look into a repository. When startup_info->help is TRUE, no reposito=
ry
>> is set up and the caller expects callees to print help usage and exi=
t,
>> no more.
>>
>> Do as expected.
>> ---
>
> No sign-off given to any of the three patches...

Oops, I removed old signoffs and accidentally mine too.

>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 87976f0..9f152ed 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -667,6 +667,9 @@ int cmd_branch(int argc, const char **argv, cons=
t char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_END(),
>> =C2=A0 =C2=A0 =C2=A0 };
>>
>> + =C2=A0 =C2=A0 if (startup_info->help)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usage_with_options(built=
in_branch_usage, options);
>> +
>> =C2=A0 =C2=A0 =C2=A0 git_config(git_branch_config, NULL);
>
> I can just say:
>
> =C2=A0 =C2=A0$ cd / && git branch -h
> =C2=A0 =C2=A0usage: git branch [options] ...
>
> without your patch just fine (and no I am not insane to make / contro=
lled
> by git).
>
> The same for checkout-index, commit, ls-files, etc.
>
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index c304638..f040171 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -191,6 +191,9 @@ int cmd_gc(int argc, const char **argv, const ch=
ar *prefix)
>>
>> =C2=A0 =C2=A0 =C2=A0 git_config(gc_config, NULL);
>>
>> + =C2=A0 =C2=A0 if (startup_info->help)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usage_with_options(built=
in_gc_usage, builtin_gc_options);
>> +
>> =C2=A0 =C2=A0 =C2=A0 if (pack_refs < 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pack_refs =3D !is_b=
are_repository();
>
> This one is curious. =C2=A0Why do you need a call to git_config() in =
"gc" only?
> You don't do that for e.g. "branch".

Hmm.. I don't think that git_config() is needed. It does no harm, but
no gain either.

> While I do not see anything glaringly wrong with this change, I am no=
t
> sure I am getting the point of these patches.

As Jonathan pointed out, the series makes "git foo -h" works even in
special cases where setup code may terminate program early. Apparently
my test in hurry does not work great.
--=20
Duy
