From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] sha1_file: replace PATH_MAX buffer wirh strbuf in prepare_packed_git_one()
Date: Sun, 29 Jun 2014 08:21:22 +0700
Message-ID: <CACsJy8B_DAjLRcMe4ys2LGkLOcKuW-PL_WNHyFB8Ry3Uv38LCw@mail.gmail.com>
References: <53AED59B.1020209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Jun 29 03:22:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X13ot-0005On-9E
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 03:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbaF2BVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jun 2014 21:21:53 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:53787 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbaF2BVw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jun 2014 21:21:52 -0400
Received: by mail-qg0-f48.google.com with SMTP id q108so819586qgd.35
        for <git@vger.kernel.org>; Sat, 28 Jun 2014 18:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6DBVy/GVvKnyMguV6ioZgBhLzuzH/FiGU+e9M9uv3Tc=;
        b=hX3EUcMPNRS8R0lbiB8T3NZaWaXwHoduMc6QGDCHW1sJPHs/Vgn6bbU7iz67+VO03F
         WD1mBAA1Va+Sesycbzj4GN6QIHLVd+NG023h7/4sIWmXWLUeKen3lh5A6sCXGcC+zgmb
         TTd/T0RL5ME6Xxkq8yGSNSo/w1teaXo5Jdw1nEgSK2VTYBYM/cvxcfvyJjd50jhCrwt/
         y7WhOAxH9rVsZ6WmDRwHzh+y+gGZiFCg9JhQIQG/EIrQPSg5yv14w17hCJHzTAR0Vmua
         /IHTa3X/QZg4ITXFchYshLG24h0MTLVDfWjEO7gAEAPp4waRLMSqb7d3SNZPkcwFK1mG
         0gUA==
X-Received: by 10.224.2.74 with SMTP id 10mr47509743qai.89.1404004912050; Sat,
 28 Jun 2014 18:21:52 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 28 Jun 2014 18:21:22 -0700 (PDT)
In-Reply-To: <53AED59B.1020209@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252626>

On Sat, Jun 28, 2014 at 9:47 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> -       sprintf(path, "%s/pack", objdir);
> -       len =3D strlen(path);
> -       dir =3D opendir(path);
> +       strbuf_addstr(&path, objdir);
> +       strbuf_addstr(&path, "/pack");
> +       dir =3D opendir(path.buf);
>         if (!dir) {
>                 if (errno !=3D ENOENT)
>                         error("unable to open object pack directory: =
%s: %s",
> -                             path, strerror(errno));
> +                             path.buf, strerror(errno));
>                 return;

Memory leak. The rest looks good.
--=20
Duy
