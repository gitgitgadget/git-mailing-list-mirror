Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6E51F597
	for <e@80x24.org>; Thu,  2 Aug 2018 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeHBTvG (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 15:51:06 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:38632 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbeHBTvG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 15:51:06 -0400
Received: by mail-it0-f43.google.com with SMTP id v71-v6so4669326itb.3
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=xFRBR9UeX039I1auDvQz7nB6H3PjdzYiaDHIbozSBcE=;
        b=U5cxE3tE7R3U78p1Re66I0074BbA/A/+M9hPVVMnzGIexitpVNRl6tDjoySw+H+wGJ
         H0v2YL5hVtRb4T6AiK7fs70qMzOeyxhhANiaxRb6sjyba0Yn20XeSdXGVg2WM3qMOFw+
         MF/I8tOd0FAt1cpOuYB+F2Mrk39sc3fEhOpPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xFRBR9UeX039I1auDvQz7nB6H3PjdzYiaDHIbozSBcE=;
        b=YFssVs4F2jjbrsLYfDECwmBDpe7GJFpOgkDjBPxOXhmj+G5d70318E/8uBLdLKu1rW
         pPtDAFP9hDU58e5a2Hfv8khNrMhy7zm8P54xERX0W5JZkIA3kDvt4RbF/8XToZf8KkQY
         6RxNgbNn6x41ZXSg2l1r6AUeNTAgnKWghohFVRFALHZQQ5DjORSV3ulUElOe0AbKn+RI
         lplHyoNvTZ6/48MJDmu0TqSR49QWUR2LNcIjlsSO6v05AAOI3jE8BjAB/69IQd18xagi
         JpcQP4m+ViTkhDbVK3tkSOCsTWswgRWghuFayegDXwBp3/F4+l0ei71UXIgwoRN/Sp3T
         +eZw==
X-Gm-Message-State: AOUpUlFltrh4aBsclFD9ltCR4wJgUO7C8cLchCKnH1KT4PEVtcWmj5Pq
        ZLT33pUv3R9uKURMTj3rzEelX9OzdsvDFrGX4yGgSEgZGiM=
X-Google-Smtp-Source: AAOMgpcyoLqnIYIUbasyHuX446kdR4nL9jiXCev4X1Cxs2iH1SHbYzAEnYRj4c/enucvBWT81JCI6Cj7txHlEqOOU/8=
X-Received: by 2002:a24:d681:: with SMTP id o123-v6mr3576960itg.115.1533232733761;
 Thu, 02 Aug 2018 10:58:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:7b8f:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 10:58:52 -0700 (PDT)
From:   Liam Decker <ldecker@indeed.com>
Date:   Thu, 2 Aug 2018 12:58:52 -0500
Message-ID: <CALcD6sYfcaftciYU+2AHpzabyOS9ohRcZoE6LDuMyht+dxktHw@mail.gmail.com>
Subject: Question regarding quarantine environments
To:     git@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000744e950572779094"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000744e950572779094
Content-Type: text/plain; charset="UTF-8"

Hi all,

I've been working on a git hook in golang recently. However, the library I
was using did not support a possible quarantine directory, which I would
use for my hook.

I have been trying to find out how git finds this incoming directory in the
objects folder, as their code simply assumed it resided in
.git/objects/<1st byte>/<last 19 bytes>
I read the documentation describing the git repository layout here [1] as
well as the objects documentation here [2] and the git hooks documentation
here [3] directed me to the receive-pack documentation here [4]
I have also tried googling, but this is a pretty specific question

The solution that I implemented was to check the objects directory for the
object, and if it was not there, to look for a quarantine directory and try
there. However, that feels fairly inefficient.
For the curious, the library and solution I attempted are both here [5]

If anyone could help direct me to find specifically how git looks for
objects in the repository, I would be very grateful

[1] https://git-scm.com/docs/gitrepository-layout
[2] https://git-scm.com/book/en/v2/Git-Internals-Git-Objects
[3] https://git-scm.com/docs/githooks
[4] https://git-scm.com/docs/git-receive-pack
[5] https://github.com/src-d/go-git/pull/887

--000000000000744e950572779094
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I&#39;ve been working on a git =
hook in golang recently. However, the library I was using did not support a=
 possible quarantine directory, which I would use for my hook.</div><div><b=
r></div><div>I have been trying to find out how git finds this incoming dir=
ectory in the objects folder, as their code simply assumed it resided in .g=
it/objects/&lt;1st byte&gt;/&lt;last 19 bytes&gt;=C2=A0</div><div>I read th=
e documentation describing the git repository layout here [1] as well as th=
e objects documentation here [2] and the git hooks documentation here [3] d=
irected me to the receive-pack documentation here [4]</div><div>I have also=
 tried googling, but this is a pretty specific question</div><div><br></div=
><div>The solution that I implemented was to check the objects directory fo=
r the object, and if it was not there, to look for a quarantine directory a=
nd try there. However, that feels fairly inefficient.</div><div>For the cur=
ious, the library and solution I attempted are both here [5]</div><div><br>=
</div><div>If anyone could help direct me to find specifically how git look=
s for objects in the repository, I would be very grateful</div><div><br></d=
iv><div>[1]=C2=A0<a href=3D"https://git-scm.com/docs/gitrepository-layout">=
https://git-scm.com/docs/gitrepository-layout</a></div><div>[2]=C2=A0<a hre=
f=3D"https://git-scm.com/book/en/v2/Git-Internals-Git-Objects">https://git-=
scm.com/book/en/v2/Git-Internals-Git-Objects</a></div><div>[3]=C2=A0<a href=
=3D"https://git-scm.com/docs/githooks">https://git-scm.com/docs/githooks</a=
></div><div>[4]=C2=A0<a href=3D"https://git-scm.com/docs/git-receive-pack">=
https://git-scm.com/docs/git-receive-pack</a></div><div>[5]=C2=A0<a href=3D=
"https://github.com/src-d/go-git/pull/887">https://github.com/src-d/go-git/=
pull/887</a></div></div>

--000000000000744e950572779094--
