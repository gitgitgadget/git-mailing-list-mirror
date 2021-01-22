Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BA3C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 17:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE48823AC8
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 17:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbhAVRvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 12:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbhAVR2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 12:28:49 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E387BC06174A
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 09:28:08 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id y4so6189811ybn.3
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 09:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cjhdYJzfG+LHN40aXel7zB+0h56kIkwSC2q4TzergIs=;
        b=S/30rZSgJLcaVa4hWidRRpD/pPtdyZbizulJktrCo+TOf9WAgDqvX5ynxAhx6F1Erz
         Vhb+8TkoKW4yY+J+0j/tGoNYeDAxJPacdhkukqc5boB20qgJW8xXIF0vj6RP7JjY1nOF
         M5AS62pFDHnII+bOfFM4AwfU7REtb+O/BBcELzKLYYkbtYs5r9Wqi+b91v4HfHpZozGq
         Xxy6q+BGfbEn4/wGHPSnlHRpB0YXPH+J96fkLl6hn2j8kOzJNwFgM8ssK8YtxsZ9mKd0
         DWvrGoJPsRehWnqU9D2/5Ba7qztJpp3vSGDdrab6DkhogAPn29Vzj85te/h4aPPt+iqR
         el8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=cjhdYJzfG+LHN40aXel7zB+0h56kIkwSC2q4TzergIs=;
        b=DAQVoOtIBMu8NnOeFILWCx4KpqMOOUiCNLzDHxkSREa1soxbW9AsFeoaTdWRlNB+eP
         aExQnI65+g0480yNSgtPxtEH90qZbNRtisjcI16/k/6CpvoPnLnMaT7ZN9KwXux2rXaC
         r/sm0DxyPPPtJ5/IbcNuRYf2aJnDxfDy21YlMMVU1h7DVessx/pbjvkmmkbqkP0tgPeR
         c0kQ+rI0V2HIwIIGLWLz0zJNOLmSCUpiBoFZb+vDpYPOdMb/ELvbkjb7VLtL2eBhs9At
         LUNTGSqxrLFvT0AW5rR9HN/O1sJDLDaLEkBdzWSuhF/0UdaG214GvA7jzQyPvij9aXBW
         cGUg==
X-Gm-Message-State: AOAM532bloEpCR9cc+inAYYvcHwRLCPKEWrnjnxKH+b5DeZF6CKwpTTr
        hzoyJwS9t35D54ReXDTosCSCLUxeuUQZjKsZaUyA0D9imFU=
X-Google-Smtp-Source: ABdhPJyP63loN/bMFQzsgghpIOS2KFjXUEear/3Nm4jJjxzZU9IHwTMQ2LoirYAfC1fs6adOoDMTtXnnZZeSmC7al+k=
X-Received: by 2002:a25:9882:: with SMTP id l2mr7315338ybo.425.1611336487760;
 Fri, 22 Jan 2021 09:28:07 -0800 (PST)
MIME-Version: 1.0
References: <000001d6f0cd$40f07270$c2d15750$@gmail.com> <001e01d6f0cd$f5aaed30$e100c790$@gmail.com>
In-Reply-To: <001e01d6f0cd$f5aaed30$e100c790$@gmail.com>
From:   Jacek Lipiec <jacek.lipiec.bc@gmail.com>
Date:   Fri, 22 Jan 2021 18:27:56 +0100
Message-ID: <CAPGWkwdGvG5mAg85Ys_0NcwhsRoQ7_ago3nTPVo0oDBBZsf80Q@mail.gmail.com>
Subject: Feature Request: View transformation operator for git commit object's read
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

Recently I was thinking about various methods to bring order to a
chaos of commit messages that are used throughout the dev space =E2=80=93
namely conventional commits and, as alternative, emoji-log. First
method focuses on context, while the second one focuses on
presentation. Both are trying to bend current GIT capabilities to
convey context.

Feature request:
Option to add a transforming script to the output of all read
operations on commit object.

Example:
   $ GIT SHOW FDCCAE00C2D112717306F91A21BFA2BBDDB7DCF6
   COMMIT FDCCAE00C2D112717306F91A21BFA2BBDDB7DCF6
   MERGE: 6A235DB 0FCD13B
   AUTHOR: JACEK LIPIEC <jacek.lipiec.bc@gmail.com>
   DATE:   THU NOV 7 21:11:45 2020 +0100

       FEAT(LANG): SOME LANG FEATURE

with view transformation script of, either:
   /^FEAT\((?<SCOPE>.+?)\)/ =3D> =F0=9F=91=8C
   /^FEAT\((?<SCOPE>.+?)\)/ =3D> <SPAN TITLE=3D=E2=80=9DSCOPE: $SCOPE=E2=80=
=9D>=F0=9F=91=8C</SPAN>

it could work like this:
   $ GIT CONFIG VIEW.TRANSFORMATION.EMOJI=3D/^FEAT\((?<SCOPE>.+?)\):/ =3D> =
=F0=9F=91=8C
   $ GIT CONFIG VIEW.TRANSFORMATION.FULLTEXT=3D/^FEAT\((?<SCOPE>.+?)\):/
=3D> FEATURE $REST WITH SCOPE $SCOPE
   $ GIT CONFIG
VIEW.TRANSFORMATION.SHELLSCRIPT=3D/HOME/JACEK/PARSE-COMMIT-MESSAGE.SH
   $ GIT SHOW =E2=80=93TRANSFORM=3DEMOJI FDCCAE00C2D112717306F91A21BFA2BBDD=
B7DCF6
   COMMIT FDCCAE00C2D112717306F91A21BFA2BBDDB7DCF6
   MERGE: 6A235DB 0FCD13B
   AUTHOR: JACEK LIPIEC <JACEK.LIPIEC.BC@GMAIL.COM>
   DATE:   THU NOV 7 21:11:45 2020 +0100

      =F0=9F=91=8C: SOME LANG FEATURE

   $ GIT SHOW =E2=80=93TRANSFORM=3D FULLTEXT FDCCAE00C2D112717306F91A21BFA2=
BBDDB7DCF6
   COMMIT FDCCAE00C2D112717306F91A21BFA2BBDDB7DCF6
   MERGE: 6A235DB 0FCD13B
   AUTHOR: JACEK LIPIEC <JACEK.LIPIEC.BC@GMAIL.COM>
   DATE:   THU NOV 7 21:11:45 2020 +0100

    FEATURE SOME LANG FEATURE WITH SCOPE LANG

Would allow both backwards compatibility and an option to return a
result in a way that can be easily read by humans, or alternatively,
easily parsable by machine.

Z powa=C5=BCaniem/Regards,
Jacek Lipiec
