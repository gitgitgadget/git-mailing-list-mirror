Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2760DC433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 13:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiECN2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 09:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiECN17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 09:27:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B39D377D8
        for <git@vger.kernel.org>; Tue,  3 May 2022 06:24:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso2192336pjb.1
        for <git@vger.kernel.org>; Tue, 03 May 2022 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZhNDzkQk13+lF73w7hNw67wa9mlmkwYZeAMjQPLUm4c=;
        b=LyVPBmm9+rRH/AFlkvGvcLFEYyE7LyhgfPHmnKOiyzB4XKifQbAsQGM9ptwe5jR0HG
         hPODj6mEFs6Dy1+FOiurFcsa9TEmoM9lC8txJcJ6RFnlp/kO1TtNO8/9HqaSApKOmQo8
         SNQ6r6eNGdB5UByg6Z0QBk3XUrEG+DxjbDK9mqlXdS10jyXRr7AQRjI5ATw6Ov4Ltlqk
         pLh+m1/yZwCaxTYA65B+WLxjeXco8S/SAmf4+npk3EcInA9LVTXPwcAdYbyhCny9IdfI
         4IVzJhDyvFZRUsLfx5v5j3gpYOYAr1XiNpI7EOIpCl3O4eBcj+sfgQmD02/MY08+NJJH
         6LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZhNDzkQk13+lF73w7hNw67wa9mlmkwYZeAMjQPLUm4c=;
        b=c7x3jeaXbuNTXMC4+Z6bwnfaAa8KyniIkC3Le0g+LY96CNYlm8QbhlpX+xP+aAXXD7
         eOibbZL8FaCFWP4KvPA/bWmdhcFVyPbx8FV0HyJt6MvEyw9jhM/0gFzNT3LLyYCKf3cR
         6+eDKpm6zY7Lceohqn6p8eEzkf0f6SxiHi9SvI8Dd0MHE99HzaGftzQbrri/BujBMAc5
         jcTcGt8uIcu+MzEswWt+y+ihAW+UoOLxCCWVu2d97qG8rG2Et70d4DVNi0HggVl/kCBC
         LHWOCBFtESRpWB7Uh60APAm7tosFsIF+sYimrnsteUNueU4lMIamifRr15C8tB0xbjEC
         Zhcg==
X-Gm-Message-State: AOAM5329VEi5wqi9f5/snUyRC+rFBKVprGLRgRRzhtgecoo7rAKfIi0b
        fQFgAApdRcJgjgcrcDhWALc=
X-Google-Smtp-Source: ABdhPJxDchR3FdA/3BZ4qx5YhFhUO0YQUqkbC52xecTrrbF/7YGFZ6ez6HYhmiZc+uJ2BugPTnUEsQ==
X-Received: by 2002:a17:902:8644:b0:153:9f01:2090 with SMTP id y4-20020a170902864400b001539f012090mr16011876plt.101.1651584266399;
        Tue, 03 May 2022 06:24:26 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78008000000b0050dc76281b3sm6484950pfi.141.2022.05.03.06.24.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2022 06:24:25 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
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
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 9/9] l10n: Document the new l10n workflow
Date:   Tue,  3 May 2022 21:23:54 +0800
Message-Id: <20220503132354.9567-10-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220503132354.9567-1-worldhello.net@gmail.com>
References: <20220503132354.9567-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Change the "flow" of how translators interact with the l10n repository
at [1] to adjust it for a new workflow of not having a po/git.pot file
in-tree at all, and to not commit line numbers to the po/*.po files
that we do track in tree.

The current workflow was added in a combination of dce37b66fb0 (l10n:
initial git.pot for 1.7.10 upcoming release, 2012-02-13) and
271ce198cd0 (Update l10n guide, 2012-02-29).

As noted in preceding commits I think that it came about due to
technical debt I'd left behind in how the "po/git.pot" file was
created, and a mis-impression that the file:line comments were needed
as anything more than a transitory translation aid.

As the updated po/README.md shows the new workflow is substantially
the same, the difference is that translators no longer need to
initially pull from the l10n coordinator for a new po/git.pot, they
can simply use git.git's canonical source repository.

The l10n coordinator is still expected to announce a release to
translate, which presumably would always be Junio's latest release
tag. I'm not certain if this part of the process is actually
important. I.e. the delta translation-wise between that tag and
"master" is usually pretty small, so perhaps translators can just work
on "master" instead.

1. https://github.com/git-l10n/git-po/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 po/README.md | 191 ++++++++++++++++++++++++---------------------------
 1 file changed, 88 insertions(+), 103 deletions(-)

diff --git a/po/README.md b/po/README.md
index 19fabb4acf..00c090e7c0 100644
--- a/po/README.md
+++ b/po/README.md
@@ -46,65 +46,67 @@ for a new language translation. Because there are more than 5000 messages
 in the template message file "po/git.pot" that need to be translated,
 this is not a piece of cake for the contributor for a new language.
 
-The core template message file which contains a small set of messages
-will be generated in "po-core/core.pot" automatically by running a helper
-program named "git-po-helper" (described later).
+The "core" set of messages can be generated at "po/git-core.pot" by
+running:
 
 ```shell
-git-po-helper init --core XX.po
+make core-pot
 ```
 
-After translating the generated "po-core/XX.po", you can merge it to
-"po/XX.po" using the following commands:
-
-```shell
-msgcat po-core/XX.po po/XX.po -s -o /tmp/XX.po
-mv /tmp/XX.po po/XX.po
-git-po-helper update XX.po
-```
-
-Edit "po/XX.po" by hand to fix "fuzzy" messages, which may have misplaced
-translated messages and duplicate messages.
+And then proceeding with the rest of these instructions on the new
+generated "po/git-core.pot" file.
 
 
 ## Translation Process Flow
 
 The overall data-flow looks like this:
 
-    +-------------------+            +------------------+
-    | Git source code   | ---(1)---> | L10n coordinator |
-    | repository        | <---(4)--- | repository       |
-    +-------------------+            +------------------+
-                                          |      ^
-                                         (2)    (3)
-                                          V      |
-                                     +------------------+
-                                     | Language Team XX |
-                                     +------------------+
+    +-------------------+             +------------------+
+    | Git source code   | ----(2)---> | L10n coordinator |
+    | repository        | <---(5)---- | repository       |
+    +-------------------+             +------------------+
+                    |                     |    ^
+                   (1)                   (3)  (4)
+                    V                     v    |
+               +----------------------------------+
+               |        Language Team XX          |
+               +----------------------------------+
 
 - Translatable strings are marked in the source file.
-- L10n coordinator pulls from the source (1)
-- L10n coordinator updates the message template "po/git.pot"
-- Language team pulls from L10n coordinator (2)
-- Language team updates the message file "po/XX.po"
-- L10n coordinator pulls from Language team (3)
-- L10n coordinator asks the result to be pulled (4).
+- Language teams can start translation iterations at any time, even
+  before the l10n window opens:
+
+  + Pull from the source (1)
+  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
+  + Translate the message file "po/XX.po"
 
+- The L10n coordinator pulls from source and announces the l10n window
+  open (2)
+- Language team pulls from the l10n coordinator, starts another
+  translation iteration against the l10n coordinator's tree (3)
 
-## Maintaining the "po/git.pot" file
+  + Run "git pull --rebase" from the l10n coordinator
+  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
+  + Translate the message file "po/XX.po"
+  + Squash trivial l10n git commits using "git rebase -i"
 
-(This is done by the l10n coordinator).
+- Language team sends pull request to the l10n coordinator (4)
+- L10n coordinator checks and merges
+- L10n coordinator asks the result to be pulled (5).
 
-The "po/git.pot" file contains a message catalog extracted from Git's
-sources. The l10n coordinator maintains it by adding new translations with
-msginit(1), or update existing ones with msgmerge(1).  In order to update
-the Git sources to extract the messages from, the l10n coordinator is
-expected to pull from the main git repository at strategic point in
-history (e.g. when a major release and release candidates are tagged),
-and then run "make pot" at the top-level directory.
 
-Language contributors use this file to prepare translations for their
-language, but they are not expected to modify it.
+## Creating the "po/git.pot" file
+
+The "po/git.pot" file, once generated by the the l10n coordinator had
+been removed from the tree. L10n contributors can generated it at
+runtime using command:
+
+```shell
+make pot
+```
+
+Then language contributors use this file to prepare translations for
+their language, but they are not expected to modify it.
 
 
 ## Initializing a "XX.po" file
@@ -115,32 +117,14 @@ If your language XX does not have translated message file "po/XX.po" yet,
 you add a translation for the first time by running:
 
 ```shell
-msginit --locale=XX
-```
-
-in the "po/" directory, where XX is the locale, e.g. "de", "is", "pt\_BR",
-"zh\_CN", etc.
-
-Then edit the automatically generated copyright info in your new "XX.po"
-to be correct, e.g. for Icelandic:
-
-```diff
-@@ -1,6 +1,6 @@
--# Icelandic translations for PACKAGE package.
--# Copyright (C) 2010 THE PACKAGE'S COPYRIGHT HOLDER
--# This file is distributed under the same license as the PACKAGE package.
-+# Icelandic translations for Git.
-+# Copyright (C) 2010 Ævar Arnfjörð Bjarmason <avarab@gmail.com>
-+# This file is distributed under the same license as the Git package.
- # Ævar Arnfjörð Bjarmason <avarab@gmail.com>, 2010.
+make po-init PO_FILE=po/XX.po
 ```
 
-And change references to PACKAGE VERSION in the PO Header Entry to
-just "Git":
+Where XX is the locale, e.g. "de", "is", "pt\_BR", "zh\_CN", etc.
 
-```shell
-perl -pi -e 's/(?<="Project-Id-Version: )PACKAGE VERSION/Git/' XX.po
-```
+The newly generated message file "po/XX.po" is based on the core pot
+file "po/git-core.pot", so it contains only a minimal set of messages
+and it's a good start for a new language contribution.
 
 Once you are done testing the translation (see below), commit the result
 and ask the l10n coordinator to pull from you.
@@ -153,19 +137,40 @@ and ask the l10n coordinator to pull from you.
 If you are replacing translation strings in an existing "XX.po" file to
 improve the translation, just edit the file.
 
-If there's an existing "XX.po" file for your language, but the repository
-of the l10n coordinator has newer "po/git.pot" file, you would need to first
-pull from the l10n coordinator (see the beginning of this document for its
-URL), and then update the existing translation by running:
+If you want to find new translatable strings in source files of upstream
+repository and propagate them to your "po/XX.po", run command:
 
 ```shell
-msgmerge --add-location --backup=off -U XX.po git.pot
+make po-update PO_FILE=po/XX.po
 ```
 
-in the "po/" directory, where "XX.po" is the file you want to update.
+It will:
 
-Once you are done testing the translation (see below), commit the result
-and ask the l10n coordinator to pull from you.
+- Call "make pot" at runtime to generate new "po/git.pot" file
+- Call "msgmerge --add-location --backup=off -U po/XX.po po/git.pot"
+  to update your "po/XX.po"
+- The "--add-location" option for msgmerge will add location lines,
+  and these location lines will help translation tools to location
+  translation context easily.
+
+Once you are done testing the translation (see below), it's better
+to commit a location-less "po/XX.po" file to save repository space
+and make a user-friendly patch for review.
+
+To save a location-less "po/XX.po" automatically in repository, you
+can:
+
+- Define new attribute for "po/XX.po" by adding new line in
+  ".git/info/attributes":
+
+        /po/XX.po filter=gettext-no-location
+
+- Define driver for "gettext-no-location" filter:
+
+        $ git config --global filter.gettext-no-location.clean \
+              "msgcat --no-location -"
+
+You're now ready to ask the l10n coordinator to pull from you.
 
 
 ## Fuzzy translation
@@ -196,6 +201,14 @@ common errors, e.g. missing printf format strings, or translated
 messages that deviate from the originals in whether they begin/end
 with a newline or not.
 
+L10n coordinator will check your contributions using a helper program
+(see "PO helper" section below):
+
+```shell
+git-po-helper check-po po/XX.po
+git-po-helper check-commits <rev-list-opts>
+```
+
 
 ## Marking strings for translation
 
@@ -370,29 +383,6 @@ l10n workflow.
 To build and install the helper program from source, see
 [git-po-helper/README][].
 
-Usage for git-po-helper:
-
-- To start a new language translation:
-
-  ```shell
-  git-po-helper init XX.po
-  ```
-
-- To update your "XX.po" file:
-
-  ```shell
-  git-po-helper update XX.po
-  ```
-
-- To check commit log and syntax of "XX.po":
-
-  ```shell
-  git-po-helper check-po XX.po
-  git-po-helper check-commits
-  ```
-
-Run "git-po-helper" without arguments to show usage.
-
 
 ## Conventions
 
@@ -436,13 +426,8 @@ additional conventions:
 - Initialize proper filename of the "XX.po" file conforming to
   iso-639 and iso-3166.
 
-- Must complete a minimal translation based on the "po-core/core.pot"
-  template. Using the following command to initialize the minimal
-  "po-core/XX.po" file:
-
-  ```shell
-  git-po-helper init --core <your-language>
-  ```
+- Must complete a minimal translation based on the "Core
+  translation". See that section above.
 
 - Add a new entry in the "po/TEAMS" file with proper format, and check
   the syntax of "po/TEAMS" by running the following command:
-- 
2.35.1.577.g74cc1aa55f

