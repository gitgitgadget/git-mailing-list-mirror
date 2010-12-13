From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 01/19] Add struct pathspec
Date: Mon, 13 Dec 2010 15:31:28 -0200
Message-ID: <AANLkTim+6d+XZ7j4pxE+WwBCsAvcZfN2qYu4=1rs6AAn@mail.gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
	<1292233616-27692-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 18:31:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSCFL-0003ki-SX
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 18:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640Ab0LMRba convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 12:31:30 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:55895 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090Ab0LMRb3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 12:31:29 -0500
Received: by bwz16 with SMTP id 16so6879709bwz.4
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 09:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VyiT4jlsMu7pfeFSIJ5rdzd3LOJFc1W/EETQI0CkMQs=;
        b=iLbEn/oqu1Ob9oZOXTzgBX8IBnOvdxdSbdI+3P8lnXOO4IYPyAYS75rz1iBQjwxIgA
         coxFnaMCMBzrIxc4BQlMQAtjAU8NJGNJm/thHW5LLK9qmLCkeuDpnU76KlNmXujZycUl
         80jgLKTbgB2ydIXqr1loPEePu+q3LhJpFZkSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VAwaoXrE++bpNuPGp37uBn7w85s73wLMUF/6u6nfb2MRpN9fOxzaopZJNUvUAD9pz5
         C5E9Lbhw1Skx2/QYd6N88dVRdegekSOW2bB3KTJLBWREOu8kfW9dCTUibyEoZW1K45gr
         zD3hWZ/xDTPOVSWhiMxWrwxj1756Bju3/ZVrY=
Received: by 10.204.156.8 with SMTP id u8mr4010008bkw.70.1292261488303; Mon,
 13 Dec 2010 09:31:28 -0800 (PST)
Received: by 10.204.141.82 with HTTP; Mon, 13 Dec 2010 09:31:28 -0800 (PST)
In-Reply-To: <1292233616-27692-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163569>

2010/12/13 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
> This struct for now is just a wrapper for the current pathspec form:
> const char **. It is intended to be extended with more useful
> pathspec-related information over time.
>
> The data structure for passing pathspec around remains const char **,
> struct pathspec will be initialized locally to be used and destroyed.
> Hopefully all pathspec related code will be gradually migrated to pas=
s
> this struct instead.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0cache.h | =C2=A0 =C2=A07 +++++++
> =C2=A0dir.c =C2=A0 | =C2=A0 18 ++++++++++++++++++
> =C2=A02 files changed, 25 insertions(+), 0 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 2ef2fa3..3330769 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -493,6 +493,13 @@ extern int index_name_is_other(const struct inde=
x_state *, const char *, int);
> =C2=A0extern int ie_match_stat(const struct index_state *, struct cac=
he_entry *, struct stat *, unsigned int);
> =C2=A0extern int ie_modified(const struct index_state *, struct cache=
_entry *, struct stat *, unsigned int);
>
> +struct pathspec {
> + =C2=A0 =C2=A0 =C2=A0 const char **raw; /* get_pathspec() result, no=
t freed by free_pathspec() */
> + =C2=A0 =C2=A0 =C2=A0 int nr;
> +};
> +
> +extern int init_pathspec(struct pathspec *, const char **);
> +extern void free_pathspec(struct pathspec *);
> =C2=A0extern int ce_path_match(const struct cache_entry *ce, const ch=
ar **pathspec);
> =C2=A0extern int index_fd(unsigned char *sha1, int fd, struct stat *s=
t, int write_object, enum object_type type, const char *path);
> =C2=A0extern int index_path(unsigned char *sha1, const char *path, st=
ruct stat *st, int write_object);
> diff --git a/dir.c b/dir.c
> index 133f472..205adc4 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1071,3 +1071,21 @@ int remove_path(const char *name)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> +int init_pathspec(struct pathspec *pathspec, const char **paths)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const char **p =3D paths;
> +
> + =C2=A0 =C2=A0 =C2=A0 memset(pathspec, 0, sizeof(*pathspec));
> + =C2=A0 =C2=A0 =C2=A0 if (!p)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 while (*p)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p++;
> + =C2=A0 =C2=A0 =C2=A0 pathspec->raw =3D paths;
> + =C2=A0 =C2=A0 =C2=A0 pathspec->nr =3D p - paths;
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +void free_pathspec(struct pathspec *pathspec)
> +{
> + =C2=A0 =C2=A0 =C2=A0 ; /* do nothing */

Of curse this ; here is not necessary :)
