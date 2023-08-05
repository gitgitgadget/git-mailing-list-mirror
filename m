Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1227C0015E
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 15:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjHEPas (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 11:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHEPaq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 11:30:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513CE139
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 08:30:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbc64f9a91so27035585ad.0
        for <git@vger.kernel.org>; Sat, 05 Aug 2023 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691249442; x=1691854242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cnj6yPo0Ii5xJGnH/MMYZkiDzwvis9mfBJ5AisA/Dng=;
        b=qIt8a6M2W9+d9VK9nazQyz2M6kOCBFwvsYY6D8aPD9x920G9gaZSDmP4ZmMkBXaomT
         2ikjIApOW8yyrKTr6qUYTo7KioddXYsqtXaC2658PVlVNZPNrcALqJswE7feBt27ukoU
         ic4Xa1jOSF8lBXmaJ3VgFpUBF6899/mONVC9a0A2UMPHTZNv/EyxvKsw1D5MRKD7KOda
         TdlNvC8LO2BB3AEHXQM1QbyMMeJmUSZalbYsmZRzD/tN82nuMFwOquPTgI0+fqaa3loo
         JvcJ4lBO9uxayrqcWQYvaSBWhM9wAAmr3LArPyOdXaNHZR/mARLUNINwrAGXiSUG1AkJ
         z3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691249442; x=1691854242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cnj6yPo0Ii5xJGnH/MMYZkiDzwvis9mfBJ5AisA/Dng=;
        b=MpsORlAyn7BNExbZMjimRnnXxqBk/IhxqqV4YOZSbviXRVUgK7GLjg2+9gZmjAeayt
         EFhV/siocKqrNWqpKzhmWd+0yzNs2dVaiVmAT8w100f37Js2cNuLrD9xElKJ6GxmtM08
         ANIfUAxOyglU/VULEgSINZ3NIxmRvx2NRA7FrgHyvq+tVxVr3DaJWKh0zxfcGG6qj/Hd
         86C1kAbPO8l70SFh/MXJAy5ZpljGw7Sqy5sZNx/6wJ2MZxOg38Ux//OTJH97sjDfCQWx
         YOlrDv/1YBqd6W84mVnaTTWub94yOaKaYSX+mqLvzgJKLmHJYTNhpqkVpxKjsXsb9FgE
         ImIw==
X-Gm-Message-State: AOJu0YylDzTnKW44BmGB4pV1ObjpZvuznjXdad0SyB8/MbGdURew4+mw
        8oyXyVF3pr1honh/EJCRNDB1XdTg+mRhLg==
X-Google-Smtp-Source: AGHT+IFwY5KarJ1uxqKIZBm1MQmD3Ut9Uh0QFeaP6iBZAuUaAWwfLGYs4Fwz7qo8oW+3u53tMYCOtw==
X-Received: by 2002:a17:903:248:b0:1b9:cf52:2bcf with SMTP id j8-20020a170903024800b001b9cf522bcfmr5852149plh.0.1691249442475;
        Sat, 05 Aug 2023 08:30:42 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001bbaf09ce15sm3637024plb.152.2023.08.05.08.30.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Aug 2023 08:30:41 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
        Git l10n discussion group <git-l10n@googlegroups.com>,
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
        Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.42.0 round #1
Date:   Sat,  5 Aug 2023 23:30:38 +0800
Message-Id: <20230805153038.7225-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.42.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 50 updated messages need to be translated
since last release. Please send your pull request to the l10n coordinator's
repository below before this update window closes on Sun, 20 Aug 2023. 

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


** Please note: The update window will close on Sun, 20 Aug 2023. **


--
Jiang Xin
