Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886FFC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 00:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550FC60F13
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 00:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhHNAOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 20:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbhHNAOe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 20:14:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43420C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 17:14:07 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d1so14121448pll.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 17:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RbM/JNHV+Egf2VaVtLoXY8IyjEKLRhxIeVoICn1L5jU=;
        b=b5eXIYjXkCYgW3y5NGeb0B0q6ApyO/v153ASkZjwgSI+onGjzIcr1J0cnXNHxvt6Np
         hd/zKtiTRiz6Vjhzie1Uyc8uMgxmBO32tOmod4VisgXYalosnGHHJXd6kBz8mg2ReCsB
         D41kcFthAm4u8V8Lks7BHqvkuuNt9K8Jj5AGXwFjSSkUSnKl0+g85jJ2JEVD9qO4l7Oy
         la9YqPaTwC74y1MR/5DMuwFjM7jptRbLre5khJR9cD8nDW9aSbiZE1owpjoygfIoKWP8
         uxgm/jgrexDn6dkv4Ud4F6f/1UXCRKcKM+e3m3KiPhzvmRN4jR5771jIWLjgb7q0oAqt
         W/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RbM/JNHV+Egf2VaVtLoXY8IyjEKLRhxIeVoICn1L5jU=;
        b=PX3kFY3yLtVKIfIl4iQvZP4w08vMsOF3gCJV09a+NGJ4b/w8O4KSWgWnid/6GQfAaJ
         aDCoIgHGscqHvyRZBgQpRTjyUpgOgrAN6ZYEtq4jBZdfKdQTC4CNlr5GKrfx1Ddb9KwJ
         YVWpwwPWkEETNBhwMU7k6LyD4y9Yqj/jyRdLgBvOqmUXlGudcoH9lQRp1/TD821QHS2I
         FwVzThvJO+0ekSBleadG+2JgtWeb4WU2bxIZDW9TpP8M1cQMXFc4X/woIME5oA/zA0tv
         +olaH7jcKgsfe4mnqyyo2y9KQbElEACmtN1yeLOE+cYx4Vw6W7p/+bkw+m5wnwz1jExH
         TRsQ==
X-Gm-Message-State: AOAM532nYeGM1zvEuyLCBCL5ItwCzxmCrftAB8eAwaBy6iA3MHRdPesT
        xEHEX1lJV5Iuuca01mfwFXY+tsCVOG5Ttg==
X-Google-Smtp-Source: ABdhPJztLrGx4TcRbXzDJcHDDJjty6GuSUTtpv9dTpqiflM4O3V45QsbW3j9s9Zxo6pRNB5+Y4xBAw==
X-Received: by 2002:a17:90a:af88:: with SMTP id w8mr5061519pjq.104.1628900046480;
        Fri, 13 Aug 2021 17:14:06 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id k197sm3533760pfd.190.2021.08.13.17.14.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 17:14:05 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
        Git l10n discussion group <git-l10n@googlegroups.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [L10N] Kickoff for Git 2.33.0 round #2
Date:   Sat, 14 Aug 2021 08:14:01 +0800
Message-Id: <20210814001401.8459-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for sending this email a bit late, for the Git l10n window will be
closed at the end of this Sunday.  There are 11 new messages need to be
translated from git v2.33.0-rc2.  Let's start a new round of git l10n
based on this commit:

    l10n: git.pot: v2.33.0 round 2 (11 new, 8 removed)
    
    Generate po/git.pot from v2.33.0-rc2 for git v2.33.0 l10n round 2.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

There is a helper program hosted on https://github.com/git-l10n/git-po-helper
for git l10n coordinators and git l10n contributors to check the conventions
of git l10n contributions.


--
Jiang Xin
