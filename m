From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 6/8] Convert resolve_ref_unsafe+xstrdup to resolve_ref
Date: Fri, 18 Nov 2011 07:57:29 +0700
Message-ID: <CACsJy8ATKa+=8HT8qrxgvs1gwFvT=HNxbxwSWf26N3oss6Bhfw@mail.gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
 <1321522335-24193-7-git-send-email-pclouds@gmail.com> <CALkWK0=h2Q1VTt5AwbBMaZgCYNEkZG5vQGoG=SDBMqYexhJjGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 01:58:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRCmR-0000BR-4i
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 01:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464Ab1KRA6E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 19:58:04 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40552 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab1KRA6D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 19:58:03 -0500
Received: by bke11 with SMTP id 11so2780627bke.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 16:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IREuLV7qZcAGTM7YabcJ75KKvYqtBymrOktnLnDL294=;
        b=SrKNa27Fl13ZSNUeCVW7ap8nA383AnSG+juNX43LnPqY6eB0j7yqvdBy/AAK5On4Ar
         L+O0WPcUu5MboKG9mDGbyU36eCMUKVZNxTYMUrG8qbLKckBoGJXzlb8kcgzQJKWt6zsD
         m+ErDU6YccO8Zfpc5Z0gEpMaWsryQ3MG/XjPg=
Received: by 10.204.154.77 with SMTP id n13mr842493bkw.83.1321577880159; Thu,
 17 Nov 2011 16:58:00 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Thu, 17 Nov 2011 16:57:29 -0800 (PST)
In-Reply-To: <CALkWK0=h2Q1VTt5AwbBMaZgCYNEkZG5vQGoG=SDBMqYexhJjGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185615>

2011/11/17 Ramkumar Ramachandra <artagnon@gmail.com>:
> Hi Nguy=E1=BB=85n,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index 2b8e73b..6efb1cf 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -696,15 +696,14 @@ static int switch_branches(struct checkout_opt=
s *opts, struct branch_info *new)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct branch_info old;
>> + =C2=A0 =C2=A0 =C2=A0 char *path;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char rev[20];
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int flag;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&old, 0, sizeof(old));
>> - =C2=A0 =C2=A0 =C2=A0 old.path =3D xstrdup(resolve_ref_unsafe("HEAD=
", rev, 0, &flag));
>> + =C2=A0 =C2=A0 =C2=A0 old.path =3D path =3D resolve_ref("HEAD", rev=
, 0, &flag);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0old.commit =3D lookup_commit_reference_ge=
ntly(rev, 1);
>> - =C2=A0 =C2=A0 =C2=A0 if (!(flag & REF_ISSYMREF)) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free((char *)old.=
path);
>> + =C2=A0 =C2=A0 =C2=A0 if (!(flag & REF_ISSYMREF))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0old.path =3D =
NULL;
>> - =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (old.path && !prefixcmp(old.path, "ref=
s/heads/"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0old.name =3D =
old.path + strlen("refs/heads/");
>
> This caught my eye immediately: you introduced a new "path" variable.
> Let's scroll ahead and see why.
>
>> @@ -718,8 +717,10 @@ static int switch_branches(struct checkout_opts=
 *opts, struct branch_info *new)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D merge_working_tree(opts, &old, ne=
w);
>> - =C2=A0 =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(path);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>> + =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!opts->quiet && !old.path && old.comm=
it && new->commit !=3D old.commit)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0orphaned_comm=
it_warning(old.commit);
>> @@ -727,7 +728,7 @@ static int switch_branches(struct checkout_opts =
*opts, struct branch_info *new)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0update_refs_for_switch(opts, &old, new);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D post_checkout_hook(old.commit, ne=
w->commit, 1);
>> - =C2=A0 =C2=A0 =C2=A0 free((char *)old.path);
>> + =C2=A0 =C2=A0 =C2=A0 free(path);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret || opts->writeout_error;
>> =C2=A0}
>
> Before application of your patch, if !(flag & REF_ISSYMREF) then
> old.path is set to NULL and this free() would've read free(NULL). =C2=
=A0Was
> this codepath ever reached, and did you fix a bug by introducing the
> new "path" variable, or was it never reached but you introduced the
> new variable for clarity anyway? =C2=A0Either case is worth mentionin=
g in
> the commit message, I think.

free(NULL) is OK if I remember correctly, so it's not really a bug.
Although I do plug a memory leak when merge_working_tree() returns
non-zero.
--=20
Duy
