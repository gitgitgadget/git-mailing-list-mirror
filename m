Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820F9C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6869160F9D
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhKDA67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 20:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhKDA66 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 20:58:58 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D1EC061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 17:56:21 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s136so3909486pgs.4
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 17:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WGJ1yDdrdG5FfeVYWjSK4WKLmEvtzGLwOYHdFOwnA0I=;
        b=ZZVC4SeBKbjxAqio606RkmdhmA6xY/EhwqkvwuZ/FNmxeMZkU/x5GyTIkEUNr/A9iU
         V2hdBI+xIdoBva+g6fbBg2krkoSUUZRPpClB/tJ8+PYCFFbbFlrI6RS9aO54LAerC+AS
         DFjNcNhg1p4r7GvGy4aDYYMefn8Z/FciT/MqEvYM0D4/vRahMdXDjiE6HOTGi5CcvIdI
         fvDhxeS2GHMrNsaiS4B6WBzUoMBwZD6s1qzS6FUa+E6EkqePR53i3uitdu7DYpcjt0ec
         hAZxFL8+e0FOzGC0XvzEsbYrjQFqLCIiABJ3LjTdZm/jw2bDPAvupeiMuhDbVrmpz82p
         sRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WGJ1yDdrdG5FfeVYWjSK4WKLmEvtzGLwOYHdFOwnA0I=;
        b=JQU5LB0HSEPVNNhEJ5WO+dJyYhh4VtdHOiZNtc5pTUbzgw2XMcekAXubPb10Tisrk5
         aZggYOPmCbL9o4UWb0PbxsgPqiYABVcFFGjqUOdYX6yhV+i7+ULg+9XorBptWkCsWbWV
         lLtiCbKY4wpqoibBlf8Y3o5D6sc1ixLpLtjky6Ivbe8Djk8j6HVPswOdO96MenK2Rx3w
         fiFgYnx/hxI04cdwRzH1gR3Aj/XrVjBjQPNG5prrH+jmzvs9urjhhhebA97es3YQxBZ/
         NbxLTqwF6aAL+XbfcJoQdJXniLNPzuMHCDzkmXzFbqOYDBjOoHFhNSmDgPX1X83/+zPY
         uC6w==
X-Gm-Message-State: AOAM533RsL7ZZqvQChRzt/R2QtorWfs4JkshmihY49iPX6hpff0xvRa8
        n2oLPi+YrwvUQMmWXpGMo40DxcaJjuvTqw==
X-Google-Smtp-Source: ABdhPJwdZLyKs+QD+qj2/Jp+y8WcvwbN/N74N2rnT1YQO6PwXziqQ3jS/soiLoovBpTnVd6k5k4MgQ==
X-Received: by 2002:a05:6a00:148d:b0:492:66d3:e37e with SMTP id v13-20020a056a00148d00b0049266d3e37emr7888387pfu.41.1635987380952;
        Wed, 03 Nov 2021 17:56:20 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id h6sm3443835pfi.174.2021.11.03.17.56.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Nov 2021 17:56:20 -0700 (PDT)
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
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.34.0 round #2
Date:   Thu,  4 Nov 2021 08:56:13 +0800
Message-Id: <20211104005613.25005-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.34.0-rc1 has been released, and fixed three typos of i18n messages.
Let's start a new round of git l10n based on this commit:

    l10n: git.pot: v2.34.0 round 2 (3 new, 3 removed)
    
    Generate po/git.pot from v2.34.0-rc1 for git v2.34.0 l10n round 2.
    
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
