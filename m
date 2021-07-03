Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F33BC07E98
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 07:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FEA061421
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 07:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhGCIAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 04:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhGCIA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 04:00:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DBAC061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 00:57:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u14so12286844pga.11
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 00:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eiQ+J++MPEOXmS3ucZeZeURtjkCKfxOIfE08FA9bbqs=;
        b=dflWbXNqjAfrK6vHI8pu3T1kD43vyB/ptwtpgF9XvF5zPQym80JoIww0Fr1JcV01XB
         ce8BDM/5odtPnsBeHsFZG4ULbFZ2LSD4dYD5QnLyHRPw7MHIDBo0JVulr9emerESXoTP
         6F9OB1l47JYIkxJPpFVe5/xgwxPSGmdE7EzyKu3rzer9b/w7ACr7h07q1DY8vts8IH7M
         7KCwma4ikoJC/2/tAJGgiIIklTCF/cY/5erHu0m/k5vteoTzugnlY8VPGR/ekcpVN8CV
         XcWcF9usws+1XVBvFRJA1zRQhCphjAwQ439tii039sL65JmvK1AIAA8PKe0sHqs/Cdj1
         x5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eiQ+J++MPEOXmS3ucZeZeURtjkCKfxOIfE08FA9bbqs=;
        b=WBxdqw4Hi2rjuRym2izKDZs6SLe3ckWsmhaSgfzUcywANioJQuyYkOQ6vAQVcnPhc4
         snwwxlqemGG3AGozICLIFpmMK15PUEuakEoCq7QQeSO/MVccmHJaoXM3rLJL2cWixNyv
         CLf7vRjm85oc62+IUavhsCq3D9Vxs/h69ZFDZOkR1DrwPyYvmatF0wA0+9McHUlbt3/W
         TWnds3dleqtt3jXbFSAD1Xq0QjTvUF0VeIYL21vWDWzR3hqsRwYm+rYduRuSWqfDuRYN
         GAiDySar6AaQTaVsjuyzzGKiT+dTQhi4dCXogyfx89zPDTVuQ7Bn8FNylT/z5aKwrUpk
         l9AA==
X-Gm-Message-State: AOAM532x43UVitBz9zX4ASclGSLXRwJkjw8N9CSNEAcCNzA+kDAlFcLg
        +oKNvnxzVZAYoGqWlesBODE=
X-Google-Smtp-Source: ABdhPJz1ZzmftVwY96Q6RDF6lrkftCVR5gXf2tW6QJJJp7xzEF9X0e3rZsPtGl/+rAtsae1RUS0s7g==
X-Received: by 2002:a63:f20:: with SMTP id e32mr4162735pgl.235.1625299075492;
        Sat, 03 Jul 2021 00:57:55 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.73])
        by smtp.gmail.com with ESMTPSA id k20sm14907924pji.3.2021.07.03.00.57.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jul 2021 00:57:55 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: Logical bug during MERGE or REBASE
From:   Atharva Raykar <raykar.ath@gmail.com>
X-Priority: 3 (Normal)
In-Reply-To: <1932019063.20210702192555@wp.pl>
Date:   Sat, 3 Jul 2021 13:27:51 +0530
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3CD890FA-7A99-4DDC-9691-80D1ED6BD51B@gmail.com>
References: <1932019063.20210702192555@wp.pl>
To:     skottkuk@wp.pl
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02-Jul-2021, at 21:55, skottkuk@wp.pl wrote:
>=20
> Hello.
>=20
> I got a strange result in the process of "merge" and/or "rebase".
>=20
> I'm not a git professional, so maybe this is not a bug, but a feature.
> But as for me, it would be logical to consider the construction inside =
{}
> as something whole, and not just put all the changes into one heap =
with
> notification what all OK, no conflicts.
>=20
> All the details are inside the git-bugreport-2021-07-02-1737.txt.
> I hope this log will be useful. Feel free to write me for extra =
details. =20
>=20
> Best regards,
> Skott<git-bugreport-2021-07-02-1737.txt>

Let's look at the diffs (I have annotated this with arrows):

$ # common ancestor, ie, the first commit
$ initial=3D$(git merge-base master dev)

$ git diff $initial master

diff --git a/program.cs b/program.cs
index 8bc1a4d..93f872f 100644
--- a/program.cs
+++ b/program.cs
@@ -1,4 +1,6 @@
 {
  Console.Writeline("1");
+ Console.Writeline("2");
+ Console.Readline();
  Console.Readline();     <--- X
 }

$ git diff $initial dev

diff --git a/program.cs b/program.cs
index 8bc1a4d..eb91c97 100644
--- a/program.cs
+++ b/program.cs
@@ -1,4 +1,6 @@
 {
  Console.Writeline("1");
  Console.Readline();     <--- X
+ Console.Readline();
+ Console.Readline();
 }

As you can tell, on the master branch, Git sees the changes as
"lines were added above the line labeled X",
and on the dev branch, Git sees the changes as
"lines were added below the line labeled X".

Thus when a 3-way merge is performed, it sees no conflicting changes.
Adding lines above X does not conflict with adding lines below X.

I do agree the result does look surprising at first. If in the dev
branch, git had assumed the "Readline()s" to be added in between,
rather than at the bottom, you would have ended up with a conflict,
but that did not happen.

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

