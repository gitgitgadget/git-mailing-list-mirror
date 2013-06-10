From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 05/45] Add parse_pathspec() that converts cmdline args to
 struct pathspec
Date: Sun, 9 Jun 2013 21:24:01 -0400
Message-ID: <CAPig+cQ=cmCgXhgumrN75b42GZiborTyyhTnGuR-7MnPo8cR2Q@mail.gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
	<1370759178-1709-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 03:24:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlqqP-0000nY-IE
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 03:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908Ab3FJBYE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 21:24:04 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36259 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab3FJBYD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 21:24:03 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so3694302lbi.5
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 18:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dbo0Pfm0FUlvWU5xdcjVxHurwbV1I7dSsimpx/490s8=;
        b=s/MayhAB3J8A9E+dK+KJWO5EocJ/4uL5fM//QKHs66Z3FMbV+hlyZ7wehMmThmmL8I
         2kTUyeHJWv0sBSBlkWau2b8VBbRykuN4jnZIqc9KN7+T1/7w0clkH9i9k1Tdk+MCXYnh
         aUkl8tn3Jr9GHlOgnkWIaG/JipYGywfgk8nDKI4tPoNE2q36hXLgDJYuMGkfAtt+UW5z
         FA0VhgyLq0MA6b6PNkwaoC8UbmZ7qdt/KzxAKrm9i2KTS7xFZMkQUqiAm83Pq9ao53G+
         s6IFZ7BUN7mwE584D+g/8Y2qFVbn6Nl5DeMRuf+UCCbkA9jXoGMrW69KNs0G7G0SQ/cV
         ZVqw==
X-Received: by 10.112.159.202 with SMTP id xe10mr5379478lbb.52.1370827441256;
 Sun, 09 Jun 2013 18:24:01 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 18:24:01 -0700 (PDT)
In-Reply-To: <1370759178-1709-6-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: F0jKGYTH76Zo04942_tMS1B08Y0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227222>

On Sun, Jun 9, 2013 at 2:25 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> diff --git a/pathspec.c b/pathspec.c
> index 8fe56cd..b49bd51 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -195,15 +195,128 @@ static const char *prefix_pathspec(const char =
*prefix, int prefixlen, const char
> +/*
> + * Given command line arguments and a prefix, convert the input to
> + * pathspec. die() any magic in magic_mask is used.

Did you mean s/any/if any/ ?

> + */
> +void parse_pathspec(struct pathspec *pathspec,
> +                   unsigned magic_mask, unsigned flags,
> +                   const char *prefix, const char **argv)
