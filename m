From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/8] Convert resolve_ref_unsafe+xstrdup to resolve_ref
Date: Thu, 17 Nov 2011 15:52:53 +0530
Message-ID: <CALkWK0=h2Q1VTt5AwbBMaZgCYNEkZG5vQGoG=SDBMqYexhJjGA@mail.gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com> <1321522335-24193-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 11:23:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQz7p-0004Q3-2y
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 11:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593Ab1KQKXQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 05:23:16 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46563 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756394Ab1KQKXP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 05:23:15 -0500
Received: by wwe5 with SMTP id 5so2621597wwe.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 02:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+uuBn0yXrjEbcpq6Uv9Y/lKw680LZ7qW1Ikpu6CgvGc=;
        b=HhmqgiYJGoXPryTQ8Rrwn9Xa34SOTqfVOqQs6CMXZrnbPdME9EV3jbdB7EoKAo9GaI
         p/r566PCOBQRnG8vQ2VCzUgZqTLDLgcGhF4M0UdDyP2Zi3qG6uSWOwvS8G0U1Hy6j82F
         +ambbk5m5tL5fcGKAfOnF1o1bQbbWod/MotNg=
Received: by 10.216.188.145 with SMTP id a17mr5831032wen.24.1321525394220;
 Thu, 17 Nov 2011 02:23:14 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Thu, 17 Nov 2011 02:22:53 -0800 (PST)
In-Reply-To: <1321522335-24193-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185590>

Hi Nguy=E1=BB=85n,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2b8e73b..6efb1cf 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -696,15 +696,14 @@ static int switch_branches(struct checkout_opts=
 *opts, struct branch_info *new)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct branch_info old;
> + =C2=A0 =C2=A0 =C2=A0 char *path;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char rev[20];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int flag;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&old, 0, sizeof(old));
> - =C2=A0 =C2=A0 =C2=A0 old.path =3D xstrdup(resolve_ref_unsafe("HEAD"=
, rev, 0, &flag));
> + =C2=A0 =C2=A0 =C2=A0 old.path =3D path =3D resolve_ref("HEAD", rev,=
 0, &flag);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0old.commit =3D lookup_commit_reference_gen=
tly(rev, 1);
> - =C2=A0 =C2=A0 =C2=A0 if (!(flag & REF_ISSYMREF)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free((char *)old.p=
ath);
> + =C2=A0 =C2=A0 =C2=A0 if (!(flag & REF_ISSYMREF))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0old.path =3D N=
ULL;
> - =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (old.path && !prefixcmp(old.path, "refs=
/heads/"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0old.name =3D o=
ld.path + strlen("refs/heads/");

This caught my eye immediately: you introduced a new "path" variable.
Let's scroll ahead and see why.

> @@ -718,8 +717,10 @@ static int switch_branches(struct checkout_opts =
*opts, struct branch_info *new)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D merge_working_tree(opts, &old, new=
);
> - =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(path);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> + =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!opts->quiet && !old.path && old.commi=
t && new->commit !=3D old.commit)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0orphaned_commi=
t_warning(old.commit);
> @@ -727,7 +728,7 @@ static int switch_branches(struct checkout_opts *=
opts, struct branch_info *new)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0update_refs_for_switch(opts, &old, new);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D post_checkout_hook(old.commit, new=
->commit, 1);
> - =C2=A0 =C2=A0 =C2=A0 free((char *)old.path);
> + =C2=A0 =C2=A0 =C2=A0 free(path);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret || opts->writeout_error;
> =C2=A0}

Before application of your patch, if !(flag & REF_ISSYMREF) then
old.path is set to NULL and this free() would've read free(NULL).  Was
this codepath ever reached, and did you fix a bug by introducing the
new "path" variable, or was it never reached but you introduced the
new variable for clarity anyway?  Either case is worth mentioning in
the commit message, I think.

> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index b954ca8..dc19f3c 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -628,11 +628,8 @@ static void populate_value(struct refinfo *ref)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (need_symref && (ref->flag & REF_ISSYMR=
EF) && !ref->symref) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char =
unused1[20];
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *symref=
;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 symref =3D resolve=
_ref_unsafe(ref->refname, unused1, 1, NULL);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (symref)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ref->symref =3D xstrdup(symref);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref->symref =3D re=
solve_ref(ref->refname, unused1, 1, NULL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ref->symref)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ref->symref =3D "";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> [...]

This bit along with the others follow a common pattern: one temporary
variable was used to capture the value of resolve_ref_unsafe(), before
using xstrdup() on it to perform the actual assignment.  You changed
the resolve_ref_unsafe() to resolve_ref() and got rid of that extra
variable.

Thanks.

-- Ram
