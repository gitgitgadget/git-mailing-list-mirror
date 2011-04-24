From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 2/4] diff.c: return filepair from diff_unmerge()
Date: Sun, 24 Apr 2011 19:18:35 -0300
Message-ID: <BANLkTi=fnzRVc8Lx_Wba4yqa7u8t3xGAtQ@mail.gmail.com>
References: <1303678289-27627-1-git-send-email-gitster@pobox.com>
	<1303678289-27627-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 00:18:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE7dZ-0003Nj-B2
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 00:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757918Ab1DXWSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2011 18:18:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49240 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757675Ab1DXWSg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2011 18:18:36 -0400
Received: by iyb14 with SMTP id 14so1483348iyb.19
        for <git@vger.kernel.org>; Sun, 24 Apr 2011 15:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LkpQ/ywfx6rKOHAHIne8ni/9q3zwMKCQP4rhuuHGIUE=;
        b=tYYU1+8ZultHBLdyp5fwW5yqKKbWAYhh/YKRnxYiH1hUqgzt9k6YmxKwF56w7rsJVW
         2W7d+OWx8KIXhEcCF6wWapNpAXdlX9s2n77T2PciiCGJPm/pIcjt3sVhOUMNva2xWkE6
         DKDvBzGFzWPJKXIP7FhFumOsH9qbixGcOWd24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q7GMJN/hjEJCkeN2RQxwCBN9vMgWKBUkPls3Vxi6aJU0HK4NACU9Cb+//KVgqE6/LV
         oWRWXt+Y6l1DujZOpYXy8tZ/jdekmyZPhjJXO5saOBqrmA7sY+mrK324EnAvqg+Jl4WJ
         lxuMyiTSmp9G+nOM4rM5zCRPcIeYkF9YYEFkw=
Received: by 10.42.240.136 with SMTP id la8mr3994763icb.274.1303683515542;
 Sun, 24 Apr 2011 15:18:35 -0700 (PDT)
Received: by 10.42.219.8 with HTTP; Sun, 24 Apr 2011 15:18:35 -0700 (PDT)
In-Reply-To: <1303678289-27627-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172006>

Some unrelated style comments below.

On Sun, Apr 24, 2011 at 5:51 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> The underlying diff_queue() returns diff_filepair so that the caller =
can
> further add information to it, and the helper function diff_unmerge()
> utilizes the feature itself, but does not expose it to its callers, w=
hich
> was kind of selfish.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =C2=A0diff.c | =C2=A0 13 ++++++++-----
> =C2=A0diff.h | =C2=A0 =C2=A02 +-
> =C2=A02 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 9a5c77c..4c34c64 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4308,20 +4308,23 @@ void diff_change(struct diff_options *options=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DIFF_OPT_SET(o=
ptions, HAS_CHANGES);
> =C2=A0}
>
> -void diff_unmerge(struct diff_options *options,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char =
*path,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned mo=
de, const unsigned char *sha1)
> +struct diff_filepair *diff_unmerge(struct diff_options *options,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *path,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned mode, const u=
nsigned char *sha1)
> =C2=A0{

While you are here, why not write one arg per line?

> + =C2=A0 =C2=A0 =C2=A0 struct diff_filepair *pair;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct diff_filespec *one, *two;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (options->prefix &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncmp(path, options->prefi=
x, options->prefix_length))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0one =3D alloc_filespec(path);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0two =3D alloc_filespec(path);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fill_filespec(one, sha1, mode);
> - =C2=A0 =C2=A0 =C2=A0 diff_queue(&diff_queued_diff, one, two)->is_un=
merged =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 pair =3D diff_queue(&diff_queued_diff, one, tw=
o);
> + =C2=A0 =C2=A0 =C2=A0 pair->is_unmerged =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 return pair;
> =C2=A0}
>
> =C2=A0static char *run_textconv(const char *pgm, struct diff_filespec=
 *spec,
> diff --git a/diff.h b/diff.h
> index bf2f44d..f51a8ee 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -209,7 +209,7 @@ extern void diff_change(struct diff_options *,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0const char *fullpath,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0unsigned dirty_submodule1, unsigned dirty_submodule2);
>
> -extern void diff_unmerge(struct diff_options *,
> +extern struct diff_filepair *diff_unmerge(struct diff_options *,

While you are here, why not add the argument name |options| here too?

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 const char *path,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 unsigned mode,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 const unsigned char *sha1);
