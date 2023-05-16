Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189D0C77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 10:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjEPKKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 06:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjEPKKS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 06:10:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA52A59F5
        for <git@vger.kernel.org>; Tue, 16 May 2023 03:09:55 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaf21bb42bso98609535ad.2
        for <git@vger.kernel.org>; Tue, 16 May 2023 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684231795; x=1686823795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FxG4CrC9AUgcIkXysGyBJ4wQ0MxeMoX5BkxDh/25wnw=;
        b=IIZZpnggEhuFmDKx7mF4WWJ7qh9II2NNlJwYFBlQjyFSpEAF2/T9y+Io/lP9kmo4Zv
         xP12/2BAd5fPsIpI0dUxR3jFruCDomXNpbBP36EVUhNQXiDX8zCt2MKO64F29lBps5jU
         hcTG+qDPyQeNgo8eJSiVhdNMUqwygKETt+Nklr4yaC7o6rD2IWREL/798hn9WqAgIqvV
         KjQPUWjIp0m8fewumJqjAUfg0Qj7MU5B/HFz3FC32oVKeMWJjE56apwPxmi/Mai6jvHO
         eldd3ZP8b0VkjUdT02gVbPRGFiuWUjtHbeOxd1kKYTPmv8bG0UOppGoaKAvXK3aebYCf
         lgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684231795; x=1686823795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxG4CrC9AUgcIkXysGyBJ4wQ0MxeMoX5BkxDh/25wnw=;
        b=HtOwre2EQl2z1RuKByLcSsa/Zxc/t7b7waJeZyCK2kxk1Nheh5MDONx1XWKOohGd+f
         jyZsZ8I6tz9oHj2cyrB0GYbHEDkZP7lTGfbGt5EPtKYzhY90rrRS41yGmQHCpcQNNIMc
         ASjvCc2lXGmPpAe/fME8KX7sGQaCMCoS5LJIAl2WA1VwP+Z0lyOp65EpXv3Os9XIKTev
         wbHB1Q/7TG2Gq/gmrRj76UirzUrll6SUslQzThfVkh4/iUB99xcGGJQKip7en6gwHiVB
         HLz0hngAtrKIKrdLRee0OAWwlHNPcNmElMYaqT/t1j5ocbAJAZSuRZXNFejMY3QW6c6a
         GsVw==
X-Gm-Message-State: AC+VfDzE7WgIN/hbBVVkVyTSakbFo4rh2uSijNYNTfBnYTqyl4MGwRg0
        RzNimdkfECxIf24vYe06KN26qsf7YB8=
X-Google-Smtp-Source: ACHHUZ5/ubLQ5wohR2o1CErj42xQEn5bMe6gJhxTRclok5//ILVIbp10Td/YG8FWJJkg5fUVI0sQ3Q==
X-Received: by 2002:a17:902:b08c:b0:1a1:ee8c:eef7 with SMTP id p12-20020a170902b08c00b001a1ee8ceef7mr39207156plr.48.1684231795119;
        Tue, 16 May 2023 03:09:55 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090341c400b001ab39cd875csm15042327ple.133.2023.05.16.03.09.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2023 03:09:54 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Arkadii Yakovets <ark@cho.red>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.41.0 round #1
Date:   Tue, 16 May 2023 18:09:49 +0800
Message-Id: <20230516100949.24007-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.41.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 39 updated messages need to be translated
since last release. Please send your pull request to the l10n coordinator's
repository below before this update window closes on Wed, 31 May 2023. 

    https://github.com/git-l10n/git-po/

As of git 2.37, we (git l10n contributors) have a new l10n workflow. The
following description of the new l10n workflow is from the "po/README.md"
file.


## The "po/git.pot" file is a generated file, no longer in the repository

The l10n coordinator does not need to generate the "po/git.pot" file every
time to start a new l10n workflow, and there is no "po/git.pot" file at all.

Everyone can generate the "po/git.pot" file with the command below:

    make po/git.pot

But we can also forget about it. By updating our corresponding "po/XX.po"
file, the "po/git.pot" file is automatically generated.


## Update the "po/XX.po" file, and start to translate

Before updating the "po/XX.po" file, l10n contributors should pull the latest
commits from the master branch of "git.git". E.g.:

    git pull --rebase git@github.com:git/git.git master

Then update the cooresponding "po/XX.po" file using the following command:

    make po-update PO_FILE=po/XX.po

Translate the uptodate "po/XX.po" file, and create a new commit.


## Refine your commits, send pull requests

In the "po/XX.po" file, there are location lines in comments like below:

    #: add-interactive.c:535 add-interactive.c:836 reset.c:136 sequencer.c:3505
    #: sequencer.c:3970 sequencer.c:4127 builtin/rebase.c:1261
    #: builtin/rebase.c:1671

These comments with file locations are useful for l10n contributors to locate
the context easily during translation. But these file locations introduce a
lot of noise and will consume a lot of repository storage. Therefore, we
should remove these file locations from the "po/XX.po" file.

To remove file locations in the "po/XX.po" file, you can use one of the
following two ways, but don't switch back and forth.

 * Keep the filenames, only remove locations (need gettext 0.19 and above):

        msgcat --add-location=file po/XX.po >po/XX.po.new
        mv po/XX.po.new po/XX.po

 * Remove both filenames and locations:

        msgcat --no-location po/XX.po >po/XX.po.new
        mv po/XX.po.new po/XX.po

After squashing trivial commits and removing file locations in the "po/XX.po"
file, send pull request to the l10n coordinator's repository below:

    https://github.com/git-l10n/git-po/


## Resolve errors found by the l10n CI pipeline for the pull request

A helper program hosted on "https://github.com/git-l10n/git-po-helper" can
help git l10n coordinator and git l10n contributors to check the conventions
of git l10n contributions, and it is also used in GitHub actions as l10n CI
pipeline to validate each pull request in the "git-l10n/git-po" repository.
Please fix the issues found by the helper program.


** Please note: The update window will close on Wed, 31 May 2023. **


--
Jiang Xin
