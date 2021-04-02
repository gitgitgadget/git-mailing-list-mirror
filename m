Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717C1C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 12:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA3761055
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 12:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhDBMXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBMXi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 08:23:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E60C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 05:23:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d191so2433471wmd.2
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+30LM/YGpl2sKO9nFABz4+HyoZS9KWswgIh0l9TLRw=;
        b=au7KKfPyZNbiy3wP8LCsDKfHBlCFR8tbaU9nH+/pAV3B6D2+ZOWgMTiiKice+TdF/+
         J3bXshtAMc4RxsN7pxeOZVUJqWP2A9Ou1efd/tquuVDxRRY5hKG96Gn9cJVmtx/VS3q6
         HxMNRthAEAG9zCwfKiXsknNUUbFWAZGJ0AkuhUWSZmKLhnPiTHdI7q9/DFTHk14Cao0a
         cKrR4DIgqFI2l7KhtfraAec++S8gU+B/Fpy3g6tmcPlXlgfwIMIuMp0ALmu3UFPSBMvq
         8yhAbr+RrpvqWcQX2SiUdct+EiRTgsm0dhxTH33/smRVzWzqmvliYi1Cu9rloNXwDjEh
         el1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+30LM/YGpl2sKO9nFABz4+HyoZS9KWswgIh0l9TLRw=;
        b=eYdI0vvBlZ7IQP+ohu0FmtiFNsPWgQP9QvRIHcX9RsLQRJDvl7YPHx9Y0ftHl4dyKh
         5cPmaV94YhPpc68U/sj9fUXTogThsRY074WiSYCvAYM+OXTOnXa/MsdBIzsbM3I2cmVe
         1GuMDH9i+yGSv0KNqztLih3ZFblv7KRoOzFDpr8TxQ3CgVmSfnNQEJ5c2TvHW9Jo7EZK
         YsynexalLkXT41MV+uIus8HQVM3+78WMF6KOmHb/ddmRaruBEfq6z8bHf4KohA8kdDd4
         spj+qVnDYoT0WnsnBoVIHQt4l4mR8ebwhAlplGl/FCR6N3pFi+bEQKE7bXgkx7/3n6rA
         +Msw==
X-Gm-Message-State: AOAM531mav8ETaQnMOh5JnHByCfaACVBfz5zTEOQXfHPfVFWSoPwFyLL
        FDTaCEP1bFDahA9epfCln70s1mETkKt0FA==
X-Google-Smtp-Source: ABdhPJyIc5YizilBT7tFFH///1YegphvSjlLWMhkPMkcojg3PQX5Iiq6GODmOaB4HNMIAXH3ecF6tQ==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr12682080wmc.100.1617366215776;
        Fri, 02 Apr 2021 05:23:35 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42001050eea1631e4a9c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:1050:eea1:631e:4a9c])
        by smtp.gmail.com with ESMTPSA id h62sm14733598wmf.37.2021.04.02.05.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 05:23:35 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [PATCH][GSoC] user-manual.txt: fix empty heading of introduction
Date:   Fri,  2 Apr 2021 14:13:03 +0200
Message-Id: <20210402121303.344914-1-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two among the three warnings raised by "make git.info" are related to the fact
that the introductory heading being empty in user-manual.txt.

    user-manual.texi:15: warning: empty menu entry name in `* : idm4.'
    user-manual.texi:141: warning: @unnumbered missing argument

Recall that the dependencies chain is as follows:

    user-manual.txt => user-manual.xml => user-manual.texi => git.info

Asciidoc creates an empty title tag in user-manual.xml which turns to be an
empty node in user-manual.texi and git.info. This is not negligible in those
files as docbook2x-texi creates a node "idm4" in the menu and the navigation
bar, which can be confusing for the average user: in Emacs, the first entry of
the menu in the git info page is even displayed as empty.

Note that this fix will create an "Introduction" section in the files:
user-manual.{xml, texi, html, pdf} and git.info.

For future reference, here are the content of the relevant & auto-generated files
before this commit.

user-manual.xml:

    l07|<bookinfo>
    l08|<title>Git User Manual</title>
    l09|</bookinfo>
    l10|<preface>
    l11|<title></title>
    l12|<simpara>Git is a fast distributed revision control system.</simpara>

user-manual.texi:

    l10 |@node Top, idm4, , (dir)
    ... |
    l14 |@menu
    l15 |* : idm4.
    ... |
    l140|@node idm4, Repositories and Branches, Top, Top
    l141|@unnumbered
    ... | ...
    l181|@node Repositories and Branches, Exploring Git history, idm4, Top

git.info:

    l10  |File: git.info,  Node: Top,  Next: idm4,  Up: (dir)
    ...  | ...
    l15  |* Menu:
    l16  |
    l17  |* : idm4.
    ...  | ...
    l140 |File: git.info,  Node: idm4,  Next: Repositories and Branches,  Prev: Top,  Up: Top
    ...  | ...
    l177 |File: git.info,  Node: Repositories and Branches,  Next: Exploring Git history,  Prev: idm4,  Up: Top
    ...  | ...
    l5474|Node: idm43164

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/user-manual.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index fd480b8645..d708612da2 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1,5 +1,8 @@
 = Git User Manual
 
+[[introduction]]
+== Introduction
+
 Git is a fast distributed revision control system.
 
 This manual is designed to be readable by someone with basic UNIX
-- 
2.31.1.133.g84d06cdc06

