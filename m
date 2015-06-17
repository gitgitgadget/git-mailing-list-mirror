From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] strbuf: stop out-of-boundary warnings from Coverity
Date: Wed, 17 Jun 2015 10:28:15 -0700
Message-ID: <CAGZ79kYRfjeXGkYAv-Kn2Bk-pp2ZSzpKGHDhqMpw03scdRZAmQ@mail.gmail.com>
References: <1434536209-31350-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 19:28:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5H8h-0005Wu-RS
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 19:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758028AbbFQR2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 13:28:20 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33944 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770AbbFQR2Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 13:28:16 -0400
Received: by ykfl8 with SMTP id l8so45796524ykf.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1SbQVRVNa07xbmIkw82S6BGTP0KbCqEQLg4QeFxur1w=;
        b=FB6Mu0kFWQLcFQFQYIgJkSqC2blAcFHH/6ZVxxsNin6HpDx3QNbGsPGR4td6OY1hyZ
         nw3+0aRHdyTaNUmgZAQJy3aLLYs0T/nZl+AwpAKLc8SSU5ghb+kjRepMjB/5x2zYdBE9
         Dt+kfza69b8ua46dv+lTYp/rcL9AtdxGeQT9z+2GZmwxVwu9YK6WtuPgcvD2a9oUYnqT
         TKh63l/HMxxIqLwxlSio3+MOiBbUHDt8qMjdWL15Yb6sHwlpDz0DHTewLrSMSC5jBu6+
         7sIp0pE/SiBMQtlJeokU+NVV0kHxuC6/3/CY5N0spvaokHYOunLyNfGMp5cdDNIvpwRN
         xfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1SbQVRVNa07xbmIkw82S6BGTP0KbCqEQLg4QeFxur1w=;
        b=S/KmVRE5+XYBE+3xILUgnROBHPazZL0Kogvmu62mNMc/0XWuLCw43Fj8hjgtH9BxRV
         7kMppiHgPMC2oXGuXg60UAPLOBOQpruduf22mUEC3v5EYFyG3gcCCY6o0hnv8mmdOUTG
         JoVUMZ7A3xNweSfHNHPCAGnYHY8eEmWaZ7IWa8wYXkGQf0TmLvcr8cd32MtA6yzqBsnA
         KEkQHqMueAH3tRlbERedFdQcO14kvZke2DiELke8l0u0H8cL+MA/jb3+6vCD679+xGA/
         NVRcFNv2btT8kh9kNJPjqllisF0ortdBGHhX298IQ6l1jj4W9vdKkmIEkcTRlVK5ISxg
         Kqrw==
X-Gm-Message-State: ALoCoQlS8+qwGX6LmqViCUrHf1Vm+N0teKwI25mtZAzq7yO0D+1J0vxFiOw51255FMbNKOmCxlDx
X-Received: by 10.129.111.65 with SMTP id k62mr8627683ywc.88.1434562095348;
 Wed, 17 Jun 2015 10:28:15 -0700 (PDT)
Received: by 10.37.26.213 with HTTP; Wed, 17 Jun 2015 10:28:15 -0700 (PDT)
In-Reply-To: <1434536209-31350-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271875>

On Wed, Jun 17, 2015 at 3:16 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> It usually goes like this
>
>     strbuf sb =3D STRBUF_INIT;
>     if (!strncmp(sb.buf, "foo", 3))
>        printf("%s", sb.buf + 3);
>
> Coverity thinks that printf() can be executed, and because initial
> sb.buf only has one character (from strbuf_slopbuf), sb.buf + 3 is ou=
t
> of bound. What it does not recognize is strbuf_slopbuf[0] is always (=
*)
> zero. We always do some string comparison before jumping ahead to
> "sb.buf + 3" and those operations will stop out of bound accesses.
>
> Just make strbuf_slopbuf[] large enough to keep Coverity happy. If it=
's
> happy, we'll have cleaner defect list and better chances of spotting
> true defects.
>
> (*) It's not entirely wrong though. Somebody may do sb.buf[0] =3D 'f'
>     right after variable declaration and ruin all unused strbuf.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  There are lots of false warnings like this from Coverity. I just
>  wanted to kill them off so we can spot more serious problems easier.
>  I can't really verify that this patch shuts off those warnings
>  because scan.coverity.com policy does not allow forks.

Thanks a lot for looking into this!
I'll just took this patch and have run a custom build now.
(Depending on the outcome of the discussion, I may just carry
this patch around on top of the origin/pu for each scan.)

This patch is however a work around and not fixing the root problem.
(The root problem being, coverity is not good enough to understand the
implications of strncmp, skip_prefix, starts_with or such).

The trade off is we're not able to detect problems with strbuf if any a=
rise.


>
>  I had another patch that avoids corrupting strbuf_slopbuf, by puttin=
g
>  it to .rodata section. The patch is more invasive though, because
>  this statement buf.buf[buf.len] =3D '\0' now has to make sure buf.bu=
f
>  is not strbuf_slopbuf. It feels safer, but probably not enough to
>  justify the change.
>
>  strbuf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/strbuf.c b/strbuf.c
> index 0d4f4e5..0d7c3cf 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -16,7 +16,12 @@ int starts_with(const char *str, const char *prefi=
x)
>   * buf is non NULL and ->buf is NUL terminated even for a freshly
>   * initialized strbuf.
>   */
> +#ifndef __COVERITY__
>  char strbuf_slopbuf[1];
> +#else
> +/* Stop so many incorrect out-of-boundary warnings from Coverity */
> +char strbuf_slopbuf[64];
> +#endif
>
>  void strbuf_init(struct strbuf *sb, size_t hint)
>  {
> --
> 2.3.0.rc1.137.g477eb31
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
