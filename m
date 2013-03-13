From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 05/13] match_{base,path}name: replace strncmp_icase
 with memequal_icase
Date: Wed, 13 Mar 2013 08:14:14 +0700
Message-ID: <CACsJy8Du7XMPWa032kSp0-z6j2ggOYHAQ0xadt=-XCATM5rPRw@mail.gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com> <1363093500-16796-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 02:15:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFaHg-0004Vj-2e
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 02:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325Ab3CMBOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 21:14:46 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:38478 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab3CMBOp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Mar 2013 21:14:45 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so526869oag.23
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 18:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=L4SEoFowi8Akcc2Vb0hoxVc6qQEsbGGaMTSVp8dhnhA=;
        b=hDNcH5nBHdE60pwPf32/UDEr7I7Pm7sh7ABE4sZNf0B1viIzYl8AAztTUME/J0NkMK
         0WR2dEZcItM2sYbwWSMsq4dbRj/qQSIh9Gro/282LYfq8xNpj38FzLjO2SJkGVZXHECl
         GmDhmT/5DE1o/tgb9DH0l9/sFVkcfsKW4G605m39a4Jm5fBFl+Z3YlnmctRcPg7CiHsV
         LuFOI4m8yK/ao/pTPCOzGLbZJLQilKgeeBi6eNYuAtuomRAElcFczj059eDaAArwjAZB
         rxyrF8aLMDXcGTvd0usQrXVOVLExKTPwvR70u9kZARJYNg1+pD8hc0fmPcz+xIjAer8n
         zoTQ==
X-Received: by 10.60.30.231 with SMTP id v7mr14169857oeh.118.1363137285033;
 Tue, 12 Mar 2013 18:14:45 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Tue, 12 Mar 2013 18:14:14 -0700 (PDT)
In-Reply-To: <1363093500-16796-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218022>

On Tue, Mar 12, 2013 at 8:04 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> +static inline int memequal_icase(const char *a, const char *b, int n=
)
> +{
> +       if (!memcmp(a, b, n))
> +               return 1;
> +
> +       if (!ignore_case)
> +               return 0;
> +
> +       /*
> +        * This assumes that ASCII is used in most repositories. We
> +        * try the ascii-only version first (i.e. Git's
> +        * toupper). Failing that, fall back to normal strncasecmp.
> +        */
> +       while (n && toupper(*a) =3D=3D toupper(*b)) {
> +               a++;
> +               b++;
> +               n--;
> +       }
> +       if (!n)
> +               return 1;
> +       return !strncasecmp(a, b, n);
> +}

Note, the ignore_case =3D=3D 1 codepath was not tested and measured. I
suspect that strncasecmp may be more complex to support locales and
the "LANG=3DC" version should suffice in most case. But it's just
guesses at this moment.
--=20
Duy
