Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30828C4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 11:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0473C20724
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 11:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmGSNShu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCULnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 07:43:03 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:36111 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgCULnD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 07:43:03 -0400
Received: by mail-ed1-f51.google.com with SMTP id b18so10382676edu.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 04:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aZeoJoIMrXm0FM170Om2fdyrUp328SGY1TyBLRO0HVM=;
        b=TmGSNShu4b6ugw63UvMmJQ4ARIyYPQvSJj5wiir+dSnZW4s1VrODJLwAAE9RMZBrf+
         i0AhROflLUBuyB0NWrJ0eEzDkQpSQsLkc7u/pAPSgv/wkRyA52YIqilfoa5Ry4nbPoeA
         qBI+9lYAnRPldaT+4848955rRkCpNF0rCjWeQzzsDh+SW0kz1okTVMRErpxne5qfe1j5
         BKvYujU0Wbm78s1o5rm6wBrL+rIFoIRnFS47Dqc0btjpf079rgUGYcI8yt14Tu4uF6Fp
         TGmi3w1WJfQsTAqBLUSFpvQ043qXYiV7vczbhk+XrVwSzw8l1Qc6xxXMLS4ySDBR8e6Y
         XANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aZeoJoIMrXm0FM170Om2fdyrUp328SGY1TyBLRO0HVM=;
        b=QIfU+Qfvoq/7wo+x6go6Fzxn0DKPSwx7jLQZB0RYC4cQUTmS37M4uOYAEvM9dVT7O3
         c3dCZK9t75cKerbGz33tzJMm8hLqsUAVub99Ik60t/pUpc4Y27Sn+pQUUOT2aMSQr367
         uCQxwK7cgteZwyfkFLBcg8uuUGxXMcINQzu+uVaAY/53s1HgETOD3CjZbsDyh+32p0iS
         DIDc2xwglviIPIDPuAbqqYA7w27XbNVWrPbN9ANm34dtMLkf5hfFkKwSVoY2C/p2oLea
         U18DGtpwiMBwYpP4FDAnQjItfhJ+U8uwk86ov5kDHxRQb+KNjaBs9yAREEOrajVJ/mcy
         arGQ==
X-Gm-Message-State: ANhLgQ1t/e34SboIiou4nAsMyZtTUwVL2uHXC6AMV5PYc+YAiwBoLBrv
        4tSwMTPX9GowVSQTSMRmvuQkB94LubvuTW8dQ17aHU+D9uc=
X-Google-Smtp-Source: ADFU+vuUl0DcoUhom+XdhlR4Xqh6W9W2qcrHYO9Iz0HyV/38f1ExTXeVKNRiH723IFtzEv95OPn2tueHy527aXBtvn4=
X-Received: by 2002:a17:906:614a:: with SMTP id p10mr3161927ejl.88.1584790981393;
 Sat, 21 Mar 2020 04:43:01 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Andr=C3=A1s_Kucsma?= <andras.kucsma@gmail.com>
Date:   Sat, 21 Mar 2020 12:42:50 +0100
Message-ID: <CANPdQv+tCnfy_csM8EwuqAYBtgkJ3RhRvo+ALbzO=BcZA7qJtg@mail.gmail.com>
Subject: GIT_ASKPASS absolute path detection bug on Windows
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I believe to have found an issue regarding properly executing the
GIT_ASKPASS binary. I'm using Windows Server 2019, with git 2.21.0
installed using cygwin.

## To reproduce:

Assume you have the askpass binary at C:\askpass.bat. In CMD the
following commands reproduce the issue:

C:\> set GIT_ASKPASS=C:\askpass.bat
C:\> git clone https://<private_repository>.git
Cloning into '<private_repository>'...
error: cannot run C:\askpass.bat: No such file or directory
[... proceeds to interactively ask for username and password ...]

On the other hand, if we change the GIT_ASKPASS environment variable
slightly, so that there is a forward slash (/) instead of a backslash
(\), things work as expected:

C:\> set GIT_ASKPASS=C:/askpass.bat
C:\> git clone https://<private_repository>.git
Cloning into '<private_repository>'...
[... success ...]

## Some context:

The source of the problem, is that if git doesn't find a forward slash
anywhere in the path, it assumes it is not a real path and has to look
for the binary using the PATH environment variable. See in
prepare_cmd():
https://github.com/git/git/blob/98cedd0233e/run-command.c#L429-L439

You can see that the "cannot run" error message is printed here, just
after prepare_cmd() returned -1:
https://github.com/git/git/blob/98cedd0233e/run-command.c#L749-L753

I believe this was introduced in late 2018 around git v2.19.2,
although I did not actually bisect the issue:
https://github.com/git/git/commit/321fd823897#diff-7577a5178f8cdc0f719e580577889f04R401-R415


I hope I'm sharing this bug at the right forum. Please direct me to
the proper place if not.

Thank you,
Andras
