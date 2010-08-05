From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 07/12] ll-merge: make flag easier to populate
Date: Thu, 5 Aug 2010 14:12:30 +0200
Message-ID: <AANLkTi=9GwZgiQHpBLN_L14==Pir0Gs=DosZHF4wg9zi@mail.gmail.com>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
	<20100804031935.GA19699@burratino>
	<20100804032338.GF19699@burratino>
	<7vocdifdrk.fsf@alter.siamese.dyndns.org>
	<20100805110822.GB13779@burratino>
	<20100805111738.GI13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 14:12:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgzJb-0002O9-T3
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 14:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933225Ab0HEMMd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 08:12:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35192 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221Ab0HEMMb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 08:12:31 -0400
Received: by gyg10 with SMTP id 10so2459178gyg.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GxTvg3N7d+ErGgxTtkVUiBM9+x2z5Em51ZgZi27/g58=;
        b=DCAmM6VJC2De1+fWyDVaLenpCP7uPBMUp30NPMgAC4lFmw9iyr6tfSQEn0ctL7fj/O
         H5l4iYPoEaGU+YewptYs4LBHdBKsqKSA5XbWSxYnbVhvpvHpsqPpQazdy5m7NQS61Xi/
         SaADrJpok+zz3yVXZWqwFtfDRKc1a9BH8P5Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iV+yfSMcDQXAcl28V2+RkDBSYFc4J3seHD+J/f53BlpLcOvQwdjzo+MI+/5+iMH4lw
         8MjhyeO15oQ1a5hMPQUHmwx7V2J6IlkF1awUMeXKk4uZ6Ec71w4S5gomkmFlgfJ6aIlm
         9/IY9QsgW6bhIbqZmsb+MYPG3/VxiR96NVaFY=
Received: by 10.151.4.8 with SMTP id g8mr12053531ybi.365.1281010350514; Thu, 
	05 Aug 2010 05:12:30 -0700 (PDT)
Received: by 10.231.146.131 with HTTP; Thu, 5 Aug 2010 05:12:30 -0700 (PDT)
In-Reply-To: <20100805111738.GI13779@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152649>

On Thu, Aug 5, 2010 at 13:17, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> ll_merge() takes its options in a flag word, which has a few
> advantages:
>
> =C2=A0- options flags can be cheaply passed around in registers, whil=
e
> =C2=A0 an option struct passed by pointer cannot;
>
> =C2=A0- callers can easily pass 0 without trouble for no options,
> =C2=A0 while an option struct passed by value would not allow that.
>
> The downside is that code to populate and access the flag word can be
> somewhat opaque. =C2=A0Mitigate that with a few macros.
>
> Cc: Avery Pennarun <apenwarr@gmail.com>
> Cc: Bert Wesarg <bert.wesarg@googlemail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =C2=A0Documentation/technical/api-merge.txt | =C2=A0 11 +++++++----
> =C2=A0ll-merge.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A09 +++++----
> =C2=A0ll-merge.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 14 ++++++++++++++
> =C2=A0merge-recursive.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 ++-
> =C2=A04 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/technical/api-merge.txt b/Documentation/te=
chnical/api-merge.txt
> index 01a89d6..a7e050b 100644
> --- a/Documentation/technical/api-merge.txt
> +++ b/Documentation/technical/api-merge.txt
> @@ -49,12 +49,15 @@ supports this.
>
> =C2=A0The `flag` parameter is a bitfield:
>
> - - The least significant bit indicates whether this is an internal
> - =C2=A0 merge to consolidate ancestors for a recursive merge.
> + - The `LL_OPT_VIRTUAL_ANCESTOR` bit indicates whether this is an
> + =C2=A0 internal merge to consolidate ancestors for a recursive merg=
e.
>
> - - The next two bits allow local conflicts to be automatically
> + - The `LL_OPT_FAVOR_MASK` bits allow local conflicts to be automati=
cally
> =C2=A0 =C2=A0resolved in favor of one side or the other (as in 'git m=
erge-file'
> - =C2=A0 `--ours`/`--theirs`/`--union` for 01, 10, and 11, respective=
ly).
> + =C2=A0 `--ours`/`--theirs`/`--union`).
> + =C2=A0 They can be populated by `create_ll_flag`, whose argument ca=
n be
> + =C2=A0 `XDL_MERGE_FAVOR_OURS`, `XDL_MERGE_FAVOR_THEIRS`, or
> + =C2=A0 `XDL_MERGE_FAVOR_UNION`.
>
> =C2=A0Everything else
> =C2=A0---------------
> diff --git a/ll-merge.c b/ll-merge.c
> index 5068fe0..290f764 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -46,7 +46,7 @@ static int ll_binary_merge(const struct ll_merge_dr=
iver *drv_unused,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * or common ancestor for an internal merg=
e. =C2=A0Still return
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * "conflicted merge" status.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 mmfile_t *stolen =3D (flag & 01) ? orig : src1=
;
> + =C2=A0 =C2=A0 =C2=A0 mmfile_t *stolen =3D (flag & LL_OPT_VIRTUAL_AN=
CESTOR) ? orig : src1;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0result->ptr =3D stolen->ptr;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0result->size =3D stolen->size;
> @@ -79,7 +79,7 @@ static int ll_xdl_merge(const struct ll_merge_drive=
r *drv_unused,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&xmp, 0, sizeof(xmp));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0xmp.level =3D XDL_MERGE_ZEALOUS;
> - =C2=A0 =C2=A0 =C2=A0 xmp.favor=3D (flag >> 1) & 03;
> + =C2=A0 =C2=A0 =C2=A0 xmp.favor =3D ll_opt_favor(flag);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (git_xmerge_style >=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xmp.style =3D =
git_xmerge_style;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (marker_size > 0)
> @@ -99,7 +99,8 @@ static int ll_union_merge(const struct ll_merge_dri=
ver *drv_unused,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0int flag, int marker_size)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Use union favor */
> - =C2=A0 =C2=A0 =C2=A0 flag =3D (flag & 1) | (XDL_MERGE_FAVOR_UNION <=
< 1);
> + =C2=A0 =C2=A0 =C2=A0 flag =3D (flag & LL_OPT_VIRTUAL_ANCESTOR) |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create_ll_flag(XDL_=
MERGE_FAVOR_UNION);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ll_xdl_merge(drv_unused, result, pa=
th_unused,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0orig, NULL, src1, NULL, src2, NULL,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0flag, marker_size);
> @@ -342,7 +343,7 @@ int ll_merge(mmbuffer_t *result_buf,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *ll_driver_name =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int marker_size =3D DEFAULT_CONFLICT_MARKE=
R_SIZE;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct ll_merge_driver *driver;
> - =C2=A0 =C2=A0 =C2=A0 int virtual_ancestor =3D flag & 01;
> + =C2=A0 =C2=A0 =C2=A0 int virtual_ancestor =3D flag & LL_OPT_VIRTUAL=
_ANCESTOR;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (merge_renormalize) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0normalize_file=
(ancestor, path);
> diff --git a/ll-merge.h b/ll-merge.h
> index 57754cc..5990271 100644
> --- a/ll-merge.h
> +++ b/ll-merge.h
> @@ -5,6 +5,20 @@
> =C2=A0#ifndef LL_MERGE_H
> =C2=A0#define LL_MERGE_H
>
> +#define LL_OPT_VIRTUAL_ANCESTOR =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 << 0)
> +#define LL_OPT_FAVOR_MASK =C2=A0 =C2=A0 =C2=A0((1 << 1) | (1 << 2))
> +#define LL_OPT_FAVOR_SHIFT 1
> +
> +static inline int ll_opt_favor(int flag)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return (flag & LL_OPT_FAVOR_MASK) >> LL_OPT_FA=
VOR_SHIFT;
> +}
> +
> +static inline int create_ll_flag(int favor)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return ((favor << LL_OPT_FAVOR_SHIFT) & LL_OPT=
_FAVOR_MASK);
> +}
> +

These two function names do not suggests that these are symmetric. How
about get_ll_flavor() and create_ll_flavor()? Or flavor_to_ll_flag()
and ll_flag_to_flavor().

Regards,
Bert

> =C2=A0int ll_merge(mmbuffer_t *result_buf,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *path,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmfile_t *ancestor, const c=
har *ancestor_label,
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 8a49844..c0c9f0c 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -647,7 +647,8 @@ static int merge_3way(struct merge_options *o,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0merge_status =3D ll_merge(result_buf, a->p=
ath, &orig, base_name,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&src1, name1, &src2, name2,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (!!o->call_depth) | (favor << 1));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((o->call_depth ? LL_OPT_VIRTUAL_AN=
CESTOR : 0) |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create_ll_flag(favor)));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0free(name1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0free(name2);
> --
> 1.7.2.1.544.ga752d.dirty
>
>
