From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] upload-pack: send shallow info over stdin to pack-objects
Date: Fri, 7 Mar 2014 08:24:38 +0700
Message-ID: <CACsJy8AYWBKwUCB=pC0istGvNCNor0i-Ntp1nY5NbJGW+c2fVw@mail.gmail.com>
References: <1393936205-15953-1-git-send-email-pclouds@gmail.com> <1394095783-24402-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Duy Nguyen <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 02:25:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLjXV-0005H8-Rv
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 02:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbaCGBZK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2014 20:25:10 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:44691 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbaCGBZI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2014 20:25:08 -0500
Received: by mail-qc0-f170.google.com with SMTP id e9so3983102qcy.15
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 17:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zpVNHVYN9oK39wLOzWKr3554DTbfRrdBXNYpgEofnu4=;
        b=dbYXbTfLz6RN/9icBgDMsn7mLnTK8bUg2n23MjEI0scWorAcLUdKBJ7tI6l2K3KLWK
         Su3wBY0CGGLEXPRCj9mHcP6GthsXOUiEywJ0GSz+XETzNooFYN2Ix3Yuj9fZ5q1KCdFk
         KZCiG+AGX7OwENN/OmIRmvnl6REYM02DfPkaVSmM+zX23L2RwQfnr/0UnK4w3OiJIzwA
         lmyDYDIuIentaQdFUmE4eUJ+azqY3RzHeYoxsY+q+JbQqpqbKeL0bvMS6a386POL0JdC
         CvYT+H1SeHR2mJtpoyyP2ENjR0Rzt/me2k+HWYDmGc3pQfKeUA4JMslMy2bwbAvJDB7r
         MVJg==
X-Received: by 10.140.101.74 with SMTP id t68mr2352628qge.106.1394155508229;
 Thu, 06 Mar 2014 17:25:08 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 6 Mar 2014 17:24:38 -0800 (PST)
In-Reply-To: <1394095783-24402-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243581>

On Thu, Mar 6, 2014 at 3:49 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index 3ae9092..a980574 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -173,4 +173,17 @@ EOF
>         )
>  '
>
> +test_expect_success POSIXPERM,SANITY 'shallow fetch from a read-only=
 repo' '
> +       cp -R .git read-only.git &&
> +       find read-only.git -print | xargs chmod -w &&
> +       test_when_finished "find read-only.git -type d -print | xargs=
 chmod +w" &&
> +       git clone --no-local --depth=3D2 read-only.git from-read-only=
 &&
> +       git --git-dir=3Dfrom-read-only/.git log --format=3D%s >actual=
 &&
> +       cat >expect <<EOF &&
> +add-1-back
> +4
> +EOF
> +       test_cmp expect actual
> +'
> +
>  test_done

It's a separate issue, but maybe we should add a similar test case for
non-shallow clone from a read-only repo too. Are there any other
operations that should work well on read-only repos?
--=20
Duy
