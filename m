From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] t9001: avoid not portable '\n' with sed
Date: Tue, 10 Jun 2014 01:03:16 -0400
Message-ID: <CAPig+cTeqjj6pstzvRh2z6CW8ksW5tpz41+RzpO=Aj2gYr7DAg@mail.gmail.com>
References: <5396849F.7060206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 07:03:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuEDS-00087h-Eq
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 07:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbaFJFDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 01:03:18 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:46481 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaFJFDR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2014 01:03:17 -0400
Received: by mail-yk0-f179.google.com with SMTP id 20so970428yks.24
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 22:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=K2eVv27x6d1NF8g2MBfv+WNtYwyVSfvhg7Ah1g920QM=;
        b=UyFPkimaqNFzP2JQLgl0n0YUB+rkozbbwDUz+T4zNfWOn6Ww0XC4B8D+jdoxzjPgaM
         1zuIaI1uwsxy/L6iVB9CU1MaGud3itLyyq6D8okqXXyFue53E4sPjZBJwRIxfJUNiWog
         EFukfMtd5Lnq8wacQq5LGBnMM7LMVNryKvCa6qKt6+JmLt0evU69iArRnSBQRu+sSlF6
         cgxVGi8oNntJZfWoxjCX1UVJnE7Q4F4KUViy2GAPjo1uHrjotmGYfl0HetBKnGloxKiv
         SkgOmhiuApCobKwpnDwKmSd5RTG38VK0dpQhf0IuKOTx0oRmjJaPFi9g3mfoOgu8K3F5
         UxGA==
X-Received: by 10.236.133.178 with SMTP id q38mr310115yhi.110.1402376596961;
 Mon, 09 Jun 2014 22:03:16 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Mon, 9 Jun 2014 22:03:16 -0700 (PDT)
In-Reply-To: <5396849F.7060206@web.de>
X-Google-Sender-Auth: 5lXQDwRH3jzjK2Dx65h2ttJLNSk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251156>

On Tue, Jun 10, 2014 at 12:07 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> t9001 used a '\n' in a sed expression to split one line into two line=
s,
> but the usage of '\n' in the "replacement string" is not portable.
>
> The '\n' can be used to match a newline in the "pattern space",
> but otherwise the meaning of '\n' is unspecified in POSIX.
>
> - Gnu versions of sed will treat '\n' as a newline character.
> - Other versions of sed (like /usr/bin/sed under Mac OS X)
>   simply ignore the '\' before the 'n', treating '\n' as 'n'.
>
> For reference see:
> pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html
> http://www.gnu.org/software/sed/manual/sed.html
>
> As the test already requires perl as a prerequisite, use perl instead=
 of sed.

Ren=C3=A9 Scharfe pointed out this useful resource [1] for writing port=
able
'sed' when he fixed [2] a problem on NetBSD in a test I had written.

[1]: http://sed.sourceforge.net/sedfaq4.html
[2]: http://thread.gmane.org/gmane.comp.version-control.git/231654

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> Sending a V3 patch seems "spammish", but after re-reading all
> the comments I think that the commit msg should point out the differe=
nce
> between POSIX sed and gnu sed somewhat better.
>
>  t/t9001-send-email.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 64d9434..19a3ced 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1342,7 +1342,7 @@ test_cover_addresses () {
>         git format-patch --cover-letter -2 -o outdir &&
>         cover=3D`echo outdir/0000-*.patch` &&
>         mv $cover cover-to-edit.patch &&
> -       sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-ed=
it.patch >"$cover" &&
> +       perl -pe "s/^From:/$header: extra\@address.com\nFrom:/" cover=
-to-edit.patch >"$cover" &&
>         git send-email \
>           --force \
>           --from=3D"Example <nobody@example.com>" \
> --
> 2.0.0.553.ged01b91
