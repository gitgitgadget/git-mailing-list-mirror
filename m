Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D475CC352A2
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 17:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CB3214AF
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 17:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCrQXPoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgBFRw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:52:29 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:55834 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgBFRw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 12:52:29 -0500
Received: by mail-wm1-f44.google.com with SMTP id q9so936793wmj.5
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 09:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MPAYwrvIbSLJIGjtU40/LWRHA4NPADpwzjH5de9OboI=;
        b=TCrQXPoZbniSpnlWT7v7c+vzcobddZeCUTW677uxEj5dtIJawCqgY2T10U70iD/rvx
         3VCEwUxaSdhK6EjHOxtPJ4TazkbE+461e0yMZzw0VBfHqL8o+MOxVQLJ35raFCuN5D6F
         NyNAvLiMfKfuQZZpBTNLbJ4ffPFQS63o53khIjm5+fE4R7LJCQrgm7XfzxFtRnPtthe9
         RL5d51kLROLS6vToJ4/6L3CB//B/VpSj50NI+oK0qn9CkzssxUk6o5okOeHeOlxNWn94
         S88wmVPalTxTcRIZY3SGRD4SGapEw78XJu5vJxr/vLOtNGf/f30RZjERwfahxjaAGzvR
         Jucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MPAYwrvIbSLJIGjtU40/LWRHA4NPADpwzjH5de9OboI=;
        b=rqFPzWQBPKnqDoOUsiSswzNg65ehxYeA26qm+iMKM+NEapqIjhd0J/WzQJgzluA1bx
         z2H/RnTIgD+1aZr7mLUKG0+19+zRQS8iAkF18tHnBWghPA8pzzt7mWJoRY/bZjzl/xHu
         wzrUPciedHTGvWJen6ij5uuvgPhYcedLixO6/wdgUOHuNXkIXdfwjdFuasspIb+EAaqU
         1e0rH0jsvbdIrwAYIQmk/8CuScRxNamUwP9AcP9V7HneGxBc/jz35GK9mho061UCCK5U
         Uhm3hkhhuhMJXt5TAGL+mMh6NqnC7G4IwrBhElkYruksmAFoTK975Fc/AWIzeDo21G91
         XXmQ==
X-Gm-Message-State: APjAAAWwn1d2rhyZxySR262UUbLKQ+HfHYkg26uuvSfltSWpKRDB6M2R
        vNNKtHVNAtyYSFznY5NrgL09LJBJpeRIUB2LqQ6UR1ZDn2M=
X-Google-Smtp-Source: APXvYqz1XW7dyiH377+HRhgklZbDLoTnpVQwKF3Amn+cgK2MkJGZGHvqol//BEKS3dggYAJr6xaDuJRuBEYZS5zdijU=
X-Received: by 2002:a1c:660a:: with SMTP id a10mr5770308wmc.122.1581011546591;
 Thu, 06 Feb 2020 09:52:26 -0800 (PST)
MIME-Version: 1.0
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 6 Feb 2020 18:52:14 +0100
Message-ID: <CAFQ2z_Pac6yb9Vi782VMtPkssNmdc08WntS7xRt8KCFfM6KVsw@mail.gmail.com>
Subject: Printing a uint64_t portably in Git?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The reftable patch is starting to shape up, but I still see failures on OSX=
,

See https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D29465&v=
iew=3Dlogs&j=3Dcfa20e98-6997-523c-4233-f0a7302c929f&t=3D3de1ae02-4adb-5138-=
54da-65cec5dd3141&l=3D518

What is the right incantation to do printf of a uint64_t on OSX ?

Apparently PRIuMAX is to be used for "uintmax_t", and not for "long
long unsigned int".

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
