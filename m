Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEAFC54EE9
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 07:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiIPHZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 03:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiIPHYm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 03:24:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDBDA61C0
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 00:24:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso19539170pjd.4
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 00:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=GinfZmClDHk2jh5mr7Z9838OtEIGKtqyFhAHbpPfB2w=;
        b=hzZ2H4DuVP+e1PqSlZrIUImNBP/mNyP57V2hW4qouHWueSCUD7pwkUw//QGb7MjXCT
         +sb/CSs7I/WN0y9DigjD85hCuBjx9CTNztSWT8MitnUC4P4oWsR7wpgNhWjRc/jHLh+2
         OvXs+jA1iVHwPP/h+osmqOov063jkom0Z3l0jKn6XIm/WqcCk9PWhZaRHtD9QtK7R7rI
         LEV3C82ov/vD0o08mhdla/9bgais+SmnVloyWhhoXR+VaQtsyr/1nwJUv/L0TPNoVp0i
         O7ReRARvTGWupWPRk2DauOtXaIDuWRrp4Un0t1b3hHILFdbdv9/pzwilvL42x8iD4k1k
         VRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GinfZmClDHk2jh5mr7Z9838OtEIGKtqyFhAHbpPfB2w=;
        b=CQuTUNcI21hXqM9Hc/iJppvrAkru+R1xUYQEPYNSxOpnDSUCADI0hoN+T0mDvO1g0e
         bqBExM5/JBpNY/lmib5+jxo9Wb/HhAJbFR6wBSke56g2LXWqI2avdyGlCkqJ6X5R72if
         mKmwpmdbGuk2OBvlGDMxQhnxy6fzPwB5rBd3ugfhKzNLZAly5N9HKjMHfnxVtQ1N1pF2
         Dw/RIs/QFpsOig4XcFTTkj4aAlK3zXJyvgM1563G9S9qvyx5/YVyj/UALZAYwdjaWdxp
         iHXAOa/yAIIX/tlbkKTOAe6hWk+nZvbU60p40N1AYDyH/3QM/eiB59S3WOllLBjBGrhV
         ZPkA==
X-Gm-Message-State: ACrzQf1+MuwasjpvfQxc7JCx1yW3GJ5Svlpnkx5+P1W0/O4ClhTyBA5j
        y4yH14396lvwmKzSPTdWK/LKTS115bM=
X-Google-Smtp-Source: AMsMyM6GtnhvSrCDWKroqmjQUIcoqXr/UuHRpLU9FBOAE459WcshDEnR526IRl9fOjkcH69X9NQy7g==
X-Received: by 2002:a17:90b:1d05:b0:202:809c:2d52 with SMTP id on5-20020a17090b1d0500b00202809c2d52mr3961568pjb.215.1663313054187;
        Fri, 16 Sep 2022 00:24:14 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id w187-20020a6282c4000000b0053e156e9475sm13584156pfd.182.2022.09.16.00.24.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Sep 2022 00:24:13 -0700 (PDT)
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
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.38.0 round #1
Date:   Fri, 16 Sep 2022 15:23:59 +0800
Message-Id: <20220916072359.13044-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.38.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 154 updated messages need to be translated
since last release. Please send your pull request to the l10n coordinator's
repository below before this update window closes on Sun, Oct 02, 2022. 

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


** Please note: The update window will close on Sun, Oct 02, 2022. **


--
Jiang Xin
