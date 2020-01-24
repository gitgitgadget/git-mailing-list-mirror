Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16A2C2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 22:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6472072C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 22:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROwpXvHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgAXWdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:33:47 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:41736 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbgAXWdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 17:33:46 -0500
Received: by mail-wr1-f49.google.com with SMTP id c9so3878948wrw.8
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 14:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S9khvTp6z6N31WcH3B5Y/KdiRTBTYVYeL/Th0XrFd+Q=;
        b=ROwpXvHIrJr4dWNa7W8Y7y2XWTjJik+wUOkA86vunQq+VVa5aUoLTzUMSzH67syvXg
         D7eQ6ypVritjX/LokXdLRUhKtYiTjqH0gfxhfvlZPopYdNdvBU1Y5xG20YGVMxB0i+4v
         V/lehqTJ+rBB497Z3FNNLIumd09avmqvHQ9V4n9gzvFcc89KT2unkScL4/6Dt0/3f880
         480p9FWN3s73fMxKd4hOeD3kqvcnCHXGqWbf3odi6lR24qStwTvR1iLLkB72673wnFo+
         sX2NqwvNp2dank3DVrigyuS6z36Xa+NMoD+fkJTcSA7Jwg2xs59XDIN3YuZvil8Orkg4
         9nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S9khvTp6z6N31WcH3B5Y/KdiRTBTYVYeL/Th0XrFd+Q=;
        b=V/Gc6EsdpqTMgfVyi/IQLJf8Zvg2Gy5VOJIsAop+TCHvfWTAHax2rUOhYMiAYqnBd/
         wpMriCZDuOHu+k6XA5MFbm0niW4LjJh86R7Z6shj86NliY05i+lNrDjda+uw9yi1Hjrb
         9mOsMzgN+owcisLKxN7tbMkhukWnZA5CMNiKw82sLe6hYWf7TnbYLTbo6tXDoubo4YlD
         2kZeuzZKM2KTt5c9btlZvk7okdL6vKlMwK9N07tSoHS9H1wa2Vs5dJBAbPzVN10kRrMp
         zbm+cAXFCfIaSqZz2WxIwAnVkXsmIKM0DZ5h6PJQ1/jgeS7Wtvltj5F0omE9ihxl00pj
         fTGg==
X-Gm-Message-State: APjAAAVAyWHmGq+4iOfhesv9gpTp8mAOY5EVV3fLRIWqbt6vDX4Ugb1v
        b2mSmAvqCYVHhTEiQ9vunE7yOFi4
X-Google-Smtp-Source: APXvYqzc1fW4UwQHaA8D+V8YQ85D/E3Kc5bwpWIStsnYlNeTaJ4HRadx5DsIMGlzIOVThTCiDZlWmQ==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr6523806wrp.171.1579905221353;
        Fri, 24 Jan 2020 14:33:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c195sm9388087wmd.45.2020.01.24.14.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 14:33:41 -0800 (PST)
Message-Id: <85842282221465469872ed1d5be63dfb2399fb43.1579905218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.525.git.1579905218.gitgitgadget@gmail.com>
References: <pull.525.git.1579905218.gitgitgadget@gmail.com>
From:   "Christian Stimming via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 22:33:37 +0000
Subject: [PATCH 2/3] git-gui: update german translation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Stimming <christian@cstimming.de>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Christian Stimming <christian@cstimming.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Stimming <christian@cstimming.de>

Switch several terms from uncommon translations back to english
vocabulary, most prominently commit (noun, verb) and repository. Adapt
glossary and translation accordingly.

Signed-off-by: Christian Stimming <christian@cstimming.de>
---
 po/de.po          | 425 ++++++++++++++++++++--------------------------
 po/glossary/de.po |  20 +--
 2 files changed, 191 insertions(+), 254 deletions(-)

diff --git a/po/de.po b/po/de.po
index 162dc8aebe..ae7b0d8fd9 100644
--- a/po/de.po
+++ b/po/de.po
@@ -8,10 +8,10 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2020-01-13 21:51+0100\n"
-"PO-Revision-Date: 2010-01-26 22:25+0100\n"
+"PO-Revision-Date: 2020-01-13 22:37+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
-"Language: \n"
+"Language: de_DE\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
@@ -73,7 +73,7 @@ msgstr ""
 
 #: git-gui.sh:1309
 msgid "Cannot use bare repository:"
-msgstr "Bloßes Projektarchiv kann nicht benutzt werden:"
+msgstr "Bloßes Repository kann nicht benutzt werden:"
 
 #: git-gui.sh:1317
 msgid "No working directory"
@@ -89,14 +89,11 @@ msgstr "Nach geänderten Dateien suchen..."
 
 #: git-gui.sh:1629
 msgid "Calling prepare-commit-msg hook..."
-msgstr ""
-"Aufrufen der Eintragen-Vorbereiten-Kontrolle (»prepare-commit hook«)..."
+msgstr "Aufrufen des »prepare-commit hook«..."
 
 #: git-gui.sh:1646
 msgid "Commit declined by prepare-commit-msg hook."
-msgstr ""
-"Eintragen abgelehnt durch Eintragen-Vorbereiten-Kontrolle (»prepare-commit "
-"hook«)."
+msgstr "Commit abgelehnt durch »prepare-commit hook«."
 
 #: git-gui.sh:1804 lib/browser.tcl:252
 msgid "Ready."
@@ -118,38 +115,35 @@ msgstr "Verändert, nicht bereitgestellt"
 
 #: git-gui.sh:2094 git-gui.sh:2106
 msgid "Staged for commit"
-msgstr "Bereitgestellt zum Eintragen"
+msgstr "Bereitgestellt zum Committen"
 
 #: git-gui.sh:2095 git-gui.sh:2107
 msgid "Portions staged for commit"
-msgstr "Teilweise bereitgestellt zum Eintragen"
+msgstr "Teilweise bereitgestellt zum Committen"
 
 #: git-gui.sh:2096 git-gui.sh:2108
 msgid "Staged for commit, missing"
-msgstr "Bereitgestellt zum Eintragen, fehlend"
+msgstr "Bereitgestellt zum Committen, fehlend"
 
 #: git-gui.sh:2098
 msgid "File type changed, not staged"
 msgstr "Dateityp geändert, nicht bereitgestellt"
 
 #: git-gui.sh:2099 git-gui.sh:2100
-#, fuzzy
 msgid "File type changed, old type staged for commit"
-msgstr "Dateityp geändert, nicht bereitgestellt"
+msgstr "Dateityp geändert, alter Dateityp bereitgestellt"
 
 #: git-gui.sh:2101
 msgid "File type changed, staged"
 msgstr "Dateityp geändert, bereitgestellt"
 
 #: git-gui.sh:2102
-#, fuzzy
 msgid "File type change staged, modification not staged"
-msgstr "Dateityp geändert, nicht bereitgestellt"
+msgstr "Dateityp-Änderung bereitgestellt, Inhaltsänderung nicht bereitgestellt"
 
 #: git-gui.sh:2103
-#, fuzzy
 msgid "File type change staged, file missing"
-msgstr "Dateityp geändert, bereitgestellt"
+msgstr "Dateityp-Änderung bereitgestellt, Datei gelöscht"
 
 #: git-gui.sh:2105
 msgid "Untracked, not staged"
@@ -177,9 +171,9 @@ msgid "Couldn't find gitk in PATH"
 msgstr "Gitk kann im PATH nicht gefunden werden."
 
 #: git-gui.sh:2210 git-gui.sh:2245
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Starting %s... please wait..."
-msgstr "Gitk wird gestartet... bitte warten."
+msgstr "%s wird gestartet... bitte warten."
 
 #: git-gui.sh:2224
 msgid "Couldn't find git gui in PATH"
@@ -187,7 +181,7 @@ msgstr "»Git gui« kann im PATH nicht gefunden werden."
 
 #: git-gui.sh:2726 lib/choose_repository.tcl:53
 msgid "Repository"
-msgstr "Projektarchiv"
+msgstr "Repository"
 
 #: git-gui.sh:2727
 msgid "Edit"
@@ -199,7 +193,7 @@ msgstr "Zweig"
 
 #: git-gui.sh:2732 lib/choose_rev.tcl:554
 msgid "Commit@@noun"
-msgstr "Version"
+msgstr "Commit"
 
 #: git-gui.sh:2735 lib/merge.tcl:127 lib/merge.tcl:174
 msgid "Merge"
@@ -207,7 +201,7 @@ msgstr "Zusammenführen"
 
 #: git-gui.sh:2736 lib/choose_rev.tcl:563
 msgid "Remote"
-msgstr "Externe Archive"
+msgstr "Extern"
 
 #: git-gui.sh:2739
 msgid "Tools"
@@ -219,7 +213,7 @@ msgstr "Arbeitskopie im Dateimanager"
 
 #: git-gui.sh:2763
 msgid "Git Bash"
-msgstr ""
+msgstr "Git Bash"
 
 #: git-gui.sh:2772
 msgid "Browse Current Branch's Files"
@@ -323,11 +317,11 @@ msgstr "Fertig"
 
 #: git-gui.sh:2899
 msgid "Commit@@verb"
-msgstr "Eintragen"
+msgstr "Committen"
 
 #: git-gui.sh:2908 git-gui.sh:3400
 msgid "Amend Last Commit"
-msgstr "Letzte nachbessern"
+msgstr "Letzten Commit nachbessern"
 
 #: git-gui.sh:2918 git-gui.sh:3361 lib/remote_branch_delete.tcl:101
 msgid "Rescan"
@@ -335,15 +329,15 @@ msgstr "Neu laden"
 
 #: git-gui.sh:2924
 msgid "Stage To Commit"
-msgstr "Zum Eintragen bereitstellen"
+msgstr "Zum Committen bereitstellen"
 
 #: git-gui.sh:2930
 msgid "Stage Changed Files To Commit"
-msgstr "Geänderte Dateien bereitstellen"
+msgstr "Geänderte Dateien für Commit bereitstellen"
 
 #: git-gui.sh:2936
 msgid "Unstage From Commit"
-msgstr "Aus der Bereitstellung herausnehmen"
+msgstr "Aus der Commit-Bereitstellung herausnehmen"
 
 #: git-gui.sh:2942 lib/index.tcl:521
 msgid "Revert Changes"
@@ -409,14 +403,13 @@ msgstr "SSH-Schlüssel anzeigen"
 
 #: git-gui.sh:3097 git-gui.sh:3229
 msgid "usage:"
-msgstr ""
+msgstr "Verwendung:"
 
 #: git-gui.sh:3101 git-gui.sh:3233
 msgid "Usage"
-msgstr ""
+msgstr "Verwendung"
 
 #: git-gui.sh:3182 lib/blame.tcl:575
-#, fuzzy
 msgid "Error"
 msgstr "Fehler"
 
@@ -437,7 +430,7 @@ msgstr "Nicht bereitgestellte Änderungen"
 
 #: git-gui.sh:3293
 msgid "Staged Changes (Will Commit)"
-msgstr "Bereitstellung (zum Eintragen)"
+msgstr "Bereitstellung (zum Committen)"
 
 #: git-gui.sh:3367
 msgid "Stage Changed"
@@ -449,7 +442,7 @@ msgstr "Versenden"
 
 #: git-gui.sh:3413
 msgid "Initial Commit Message:"
-msgstr "Erste Versionsbeschreibung:"
+msgstr "Erste Commit-Beschreibung:"
 
 #: git-gui.sh:3414
 msgid "Amended Commit Message:"
@@ -469,7 +462,7 @@ msgstr "Zusammenführungs-Beschreibung:"
 
 #: git-gui.sh:3418
 msgid "Commit Message:"
-msgstr "Versionsbeschreibung:"
+msgstr "Commit-Beschreibung:"
 
 #: git-gui.sh:3477 git-gui.sh:3641 lib/console.tcl:73
 msgid "Copy All"
@@ -508,18 +501,16 @@ msgid "Apply/Reverse Line"
 msgstr "Zeile anwenden/umkehren"
 
 #: git-gui.sh:3684 git-gui.sh:3794 git-gui.sh:3805
-#, fuzzy
 msgid "Revert Hunk"
-msgstr "Kontext anwenden/umkehren"
+msgstr "Kontextänderung umkehren"
 
 #: git-gui.sh:3689 git-gui.sh:3801 git-gui.sh:3812
-#, fuzzy
 msgid "Revert Line"
-msgstr "Änderungen verwerfen"
+msgstr "Zeilenänderungen umkehren"
 
 #: git-gui.sh:3694 git-gui.sh:3791
 msgid "Undo Last Revert"
-msgstr ""
+msgstr "Letzte Umkehrung rückgängig"
 
 #: git-gui.sh:3713
 msgid "Run Merge Tool"
@@ -535,7 +526,7 @@ msgstr "Lokale Version benutzen"
 
 #: git-gui.sh:3726
 msgid "Revert To Base"
-msgstr "Ursprüngliche Version benutzen"
+msgstr "Zurücksetzen auf ursprünglichen Commit"
 
 #: git-gui.sh:3744
 msgid "Visualize These Changes In The Submodule"
@@ -562,9 +553,8 @@ msgid "Unstage Lines From Commit"
 msgstr "Zeilen aus der Bereitstellung herausnehmen"
 
 #: git-gui.sh:3798 git-gui.sh:3809
-#, fuzzy
 msgid "Revert Lines"
-msgstr "Änderungen verwerfen"
+msgstr "Zeilenänderung umkehren"
 
 #: git-gui.sh:3800
 msgid "Unstage Line From Commit"
@@ -678,7 +668,7 @@ msgstr "Neue Änderungen von »%s« holen"
 #: lib/transport.tcl:18
 #, tcl-format
 msgid "remote prune %s"
-msgstr "Aufräumen von »%s«"
+msgstr "Extern aufräumen von »%s«"
 
 #: lib/transport.tcl:19
 #, tcl-format
@@ -687,22 +677,19 @@ msgstr "Übernahmezweige aufräumen und entfernen, die in »%s« gelöscht wurde
 
 #: lib/transport.tcl:25
 msgid "fetch all remotes"
-msgstr ""
+msgstr "Abrufen aller externen"
 
 #: lib/transport.tcl:26
-#, fuzzy
 msgid "Fetching new changes from all remotes"
-msgstr "Neue Änderungen von »%s« holen"
+msgstr "Neue Änderungen von allen externen anfordern"
 
 #: lib/transport.tcl:40
-#, fuzzy
 msgid "remote prune all remotes"
-msgstr "Aufräumen von »%s«"
+msgstr "Extern aufräumen aller externen Repositories"
 
 #: lib/transport.tcl:41
-#, fuzzy
 msgid "Pruning tracking branches deleted from all remotes"
-msgstr "Übernahmezweige aufräumen und entfernen, die in »%s« gelöscht wurden"
+msgstr "Übernahmezweige aufräumen und entfernen, die in allen externen Repositories gelöscht wurden"
 
 #: lib/transport.tcl:54 lib/transport.tcl:92 lib/transport.tcl:110
 #: lib/remote_add.tcl:162
@@ -743,15 +730,15 @@ msgstr "Lokale Zweige"
 
 #: lib/transport.tcl:162
 msgid "Destination Repository"
-msgstr "Ziel-Projektarchiv"
+msgstr "Ziel-Repository"
 
 #: lib/transport.tcl:165 lib/remote_branch_delete.tcl:51
 msgid "Remote:"
-msgstr "Externes Archiv:"
+msgstr "Externes Repository:"
 
 #: lib/transport.tcl:187 lib/remote_branch_delete.tcl:72
 msgid "Arbitrary Location:"
-msgstr "Adresse:"
+msgstr "Beliebige Adresse:"
 
 #: lib/transport.tcl:205
 msgid "Transfer Options"
@@ -773,7 +760,7 @@ msgstr "Mit Markierungen übertragen"
 #: lib/transport.tcl:229
 #, tcl-format
 msgid "%s (%s): Push"
-msgstr ""
+msgstr "%s (%s): Übertragen"
 
 #: lib/checkout_op.tcl:85
 #, tcl-format
@@ -841,10 +828,9 @@ msgid ""
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
-"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
+"Der letzte geladene Status stimmt nicht mehr mit dem Repository überein.\n"
 "\n"
-"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
-"geändert.  Vor dem Wechseln des lokalen Zweigs muss neu geladen werden.\n"
+"Ein anderes Git-Programm hat das Repository seit dem letzten Laden geändert.  Vor dem Wechseln des lokalen Zweigs muss neu geladen werden.\n"
 "\n"
 "Es wird gleich neu geladen.\n"
 
@@ -893,13 +879,11 @@ msgstr "Umgestellt auf »%s«."
 #: lib/checkout_op.tcl:536
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
-msgstr "Zurücksetzen von »%s« nach »%s« wird folgende Versionen verwerfen:"
+msgstr "Zurücksetzen von »%s« nach »%s« wird folgenden Commit verwerfen:"
 
 #: lib/checkout_op.tcl:558
 msgid "Recovering lost commits may not be easy."
-msgstr ""
-"Verworfene Versionen können nur mit größerem Aufwand wiederhergestellt "
-"werden."
+msgstr "Verworfene Commits können nur mit größerem Aufwand wiederhergestellt werden."
 
 #: lib/checkout_op.tcl:563
 #, tcl-format
@@ -933,13 +917,13 @@ msgstr ""
 "Dies ist ein interner Programmfehler von %s. Programm wird jetzt abgebrochen."
 
 #: lib/remote_add.tcl:20
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Add Remote"
-msgstr "Externes Archiv hinzufügen"
+msgstr "%s (%s): Externes Repository hinzufügen"
 
 #: lib/remote_add.tcl:25
 msgid "Add New Remote"
-msgstr "Neues externes Archiv hinzufügen"
+msgstr "Neues externes Repository hinzufügen"
 
 #: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
 msgid "Add"
@@ -947,7 +931,7 @@ msgstr "Hinzufügen"
 
 #: lib/remote_add.tcl:39
 msgid "Remote Details"
-msgstr "Einzelheiten des externen Archivs"
+msgstr "Einzelheiten des externen Repository"
 
 #: lib/remote_add.tcl:41 lib/tools_dlg.tcl:51 lib/branch_create.tcl:44
 msgid "Name:"
@@ -967,7 +951,7 @@ msgstr "Gleich anfordern"
 
 #: lib/remote_add.tcl:69
 msgid "Initialize Remote Repository and Push"
-msgstr "Externes Archiv initialisieren und dahin versenden"
+msgstr "Externes Repository initialisieren und dahin versenden"
 
 #: lib/remote_add.tcl:75
 msgid "Do Nothing Else Now"
@@ -975,18 +959,17 @@ msgstr "Nichts tun"
 
 #: lib/remote_add.tcl:100
 msgid "Please supply a remote name."
-msgstr "Bitte geben Sie einen Namen des externen Archivs an."
+msgstr "Bitte geben Sie einen Namen des externen Repository an."
 
 #: lib/remote_add.tcl:113
 #, tcl-format
 msgid "'%s' is not an acceptable remote name."
-msgstr "»%s« ist kein zulässiger Name eines externen Archivs."
+msgstr "»%s« ist kein zulässiger Name eines externen Repository."
 
 #: lib/remote_add.tcl:124
 #, tcl-format
 msgid "Failed to add remote '%s' of location '%s'."
-msgstr ""
-"Fehler beim Hinzufügen des externen Archivs »%s« aus Herkunftsort »%s«."
+msgstr "Fehler beim Hinzufügen des externen Repository »%s« aus Adresse »%s«."
 
 #: lib/remote_add.tcl:133
 #, tcl-format
@@ -996,8 +979,7 @@ msgstr "»%s« anfordern"
 #: lib/remote_add.tcl:156
 #, tcl-format
 msgid "Do not know how to initialize repository at location '%s'."
-msgstr ""
-"Initialisieren eines externen Archivs an Adresse »%s« ist nicht möglich."
+msgstr "Initialisieren eines externen Repositories an Adresse »%s« ist nicht möglich."
 
 #: lib/remote_add.tcl:163
 #, tcl-format
@@ -1009,9 +991,9 @@ msgid "Starting..."
 msgstr "Starten..."
 
 #: lib/browser.tcl:27
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): File Browser"
-msgstr "Datei-Browser"
+msgstr "%s (%s): Datei-Browser"
 
 #: lib/browser.tcl:132 lib/browser.tcl:149
 #, tcl-format
@@ -1023,9 +1005,9 @@ msgid "[Up To Parent]"
 msgstr "[Nach oben]"
 
 #: lib/browser.tcl:275
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Browse Branch Files"
-msgstr "Dateien des Zweigs durchblättern"
+msgstr "%s (%s): Dateien des Zweigs durchblättern"
 
 #: lib/browser.tcl:282
 msgid "Browse Branch Files"
@@ -1072,9 +1054,8 @@ msgid "files"
 msgstr "Dateien"
 
 #: lib/index.tcl:326
-#, fuzzy
 msgid "Unstaging selected files from commit"
-msgstr "Datei »%s« aus der Bereitstellung herausnehmen"
+msgstr ""
 
 #: lib/index.tcl:330
 #, tcl-format
@@ -1083,17 +1064,16 @@ msgstr "Datei »%s« aus der Bereitstellung herausnehmen"
 
 #: lib/index.tcl:369
 msgid "Ready to commit."
-msgstr "Bereit zum Eintragen."
+msgstr "Bereit zum Committen."
 
 #: lib/index.tcl:378
-#, fuzzy
 msgid "Adding selected files"
-msgstr "Änderungen in gewählten Dateien verwerfen"
+msgstr "Gewählte Dateien hinzufügen"
 
 #: lib/index.tcl:382
 #, tcl-format
 msgid "Adding %s"
-msgstr "»%s« hinzufügen..."
+msgstr "»%s« hinzufügen"
 
 #: lib/index.tcl:412
 #, tcl-format
@@ -1112,7 +1092,7 @@ msgstr "Änderungen in Datei »%s« verwerfen?"
 #: lib/index.tcl:508
 #, tcl-format
 msgid "Revert changes in these %i files?"
-msgstr "Änderungen in den gewählten %i Dateien verwerfen?"
+msgstr "Änderungen in diesen %i Dateien verwerfen?"
 
 #: lib/index.tcl:517
 msgid "Any unstaged changes will be permanently lost by the revert."
@@ -1135,31 +1115,29 @@ msgstr "Änderungen in den gewählten %i Dateien verwerfen?"
 
 #: lib/index.tcl:560
 msgid "Files will be permanently deleted."
-msgstr ""
+msgstr "Dateien werden endgültig gelöscht."
 
 #: lib/index.tcl:564
-#, fuzzy
 msgid "Delete Files"
-msgstr "Löschen"
+msgstr "Dateien löschen"
 
 #: lib/index.tcl:586
-#, fuzzy
 msgid "Deleting"
 msgstr "Löschen"
 
 #: lib/index.tcl:665
 msgid "Encountered errors deleting files:\n"
-msgstr ""
+msgstr "Fehler beim Löschen der Dateien:\n"
 
 #: lib/index.tcl:674
 #, tcl-format
 msgid "None of the %d selected files could be deleted."
-msgstr ""
+msgstr "Keine der %d gewählten Dateien konnten gelöscht werden."
 
 #: lib/index.tcl:679
 #, tcl-format
 msgid "%d of the %d selected files could not be deleted."
-msgstr ""
+msgstr "%d der %d gewählten Dateien konnten nicht gelöscht werden."
 
 #: lib/index.tcl:726
 msgid "Reverting selected files"
@@ -1171,9 +1149,9 @@ msgid "Reverting %s"
 msgstr "Änderungen in %s verwerfen"
 
 #: lib/branch_checkout.tcl:16
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Checkout Branch"
-msgstr "Auf Zweig umstellen"
+msgstr "%s (%s): Auf Zweig umstellen"
 
 #: lib/branch_checkout.tcl:21
 msgid "Checkout Branch"
@@ -1206,7 +1184,7 @@ msgstr "Versenden nach"
 
 #: lib/remote.tcl:218
 msgid "Remove Remote"
-msgstr "Externes Archiv entfernen"
+msgstr "Externes Repository entfernen"
 
 #: lib/remote.tcl:223
 msgid "Prune from"
@@ -1218,12 +1196,12 @@ msgstr "Anfordern von"
 
 #: lib/remote.tcl:249 lib/remote.tcl:253 lib/remote.tcl:258 lib/remote.tcl:264
 msgid "All"
-msgstr ""
+msgstr "Alle"
 
 #: lib/branch_rename.tcl:15
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Rename Branch"
-msgstr "Zweig umbenennen"
+msgstr "%s (%s): Zweig umbenennen"
 
 #: lib/branch_rename.tcl:23
 msgid "Rename Branch"
@@ -1291,7 +1269,7 @@ msgstr "Ungültige globale Zeichenkodierung »%s«"
 #: lib/option.tcl:19
 #, tcl-format
 msgid "Invalid repo encoding '%s'"
-msgstr "Ungültige Archiv-Zeichenkodierung »%s«"
+msgstr "Ungültige Repository-Zeichenkodierung »%s«"
 
 #: lib/option.tcl:119
 msgid "Restore Defaults"
@@ -1304,11 +1282,11 @@ msgstr "Speichern"
 #: lib/option.tcl:133
 #, tcl-format
 msgid "%s Repository"
-msgstr "Projektarchiv %s"
+msgstr "%s Repository"
 
 #: lib/option.tcl:134
 msgid "Global (All Repositories)"
-msgstr "Global (Alle Projektarchive)"
+msgstr "Global (Alle Repositories)"
 
 #: lib/option.tcl:140
 msgid "User Name"
@@ -1320,7 +1298,7 @@ msgstr "E-Mail-Adresse"
 
 #: lib/option.tcl:143
 msgid "Summarize Merge Commits"
-msgstr "Zusammenführungs-Versionen zusammenfassen"
+msgstr "Zusammenführungs-Commits zusammenfassen"
 
 #: lib/option.tcl:144
 msgid "Merge Verbosity"
@@ -1355,9 +1333,8 @@ msgid "Blame Copy Only On Changed Files"
 msgstr "Kopie-Annotieren nur bei geänderten Dateien"
 
 #: lib/option.tcl:153
-#, fuzzy
 msgid "Maximum Length of Recent Repositories List"
-msgstr "Zuletzt benutzte Projektarchive"
+msgstr "Anzahl Einträge in »Letzte Repositories«"
 
 #: lib/option.tcl:154
 msgid "Minimum Letters To Blame Copy On"
@@ -1377,7 +1354,7 @@ msgstr ""
 
 #: lib/option.tcl:158
 msgid "Commit Message Text Width"
-msgstr "Textbreite der Versionsbeschreibung"
+msgstr "Textbreite der Commit-Beschreibung"
 
 #: lib/option.tcl:159
 msgid "New Branch Name Template"
@@ -1407,7 +1384,7 @@ msgstr ""
 #: lib/database.tcl:57
 #, tcl-format
 msgid "%s:"
-msgstr ""
+msgstr "%s:"
 
 #: lib/option.tcl:210
 msgid "Change"
@@ -1577,9 +1554,9 @@ msgid "Merge tool failed."
 msgstr "Zusammenführungswerkzeug fehlgeschlagen."
 
 #: lib/tools_dlg.tcl:22
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Add Tool"
-msgstr "Werkzeug hinzufügen"
+msgstr "%s (%s): Werkzeug hinzufügen"
 
 #: lib/tools_dlg.tcl:28
 msgid "Add New Tool Command"
@@ -1641,9 +1618,9 @@ msgstr ""
 "%s"
 
 #: lib/tools_dlg.tcl:187
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Remove Tool"
-msgstr "Werkzeug entfernen"
+msgstr "%s (%s): Werkzeug entfernen"
 
 #: lib/tools_dlg.tcl:193
 msgid "Remove Tool Commands"
@@ -1655,12 +1632,12 @@ msgstr "Entfernen"
 
 #: lib/tools_dlg.tcl:231
 msgid "(Blue denotes repository-local tools)"
-msgstr "(Werkzeuge für lokales Archiv werden in Blau angezeigt)"
+msgstr "(Werkzeuge für lokales Repository werden in Blau angezeigt)"
 
 #: lib/tools_dlg.tcl:283
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s):"
-msgstr "Systemweit (%s)"
+msgstr "%s (%s):"
 
 #: lib/tools_dlg.tcl:292
 #, tcl-format
@@ -1689,16 +1666,16 @@ msgstr "Voriger"
 
 #: lib/search.tcl:52
 msgid "RegExp"
-msgstr ""
+msgstr "RegAusdruck"
 
 #: lib/search.tcl:54
 msgid "Case"
-msgstr ""
+msgstr "Groß/klein"
 
 #: lib/shortcut.tcl:8 lib/shortcut.tcl:43 lib/shortcut.tcl:75
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Create Desktop Icon"
-msgstr "Desktop-Icon erstellen"
+msgstr "%s (%s): Desktop-Icon erstellen"
 
 #: lib/shortcut.tcl:24 lib/shortcut.tcl:65
 msgid "Cannot write shortcut:"
@@ -1709,17 +1686,17 @@ msgid "Cannot write icon:"
 msgstr "Fehler beim Erstellen des Icons:"
 
 #: lib/remote_branch_delete.tcl:29
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Delete Branch Remotely"
-msgstr "Zweig in externem Archiv löschen"
+msgstr "%s (%s): Zweig in externem Repository löschen"
 
 #: lib/remote_branch_delete.tcl:34
 msgid "Delete Branch Remotely"
-msgstr "Zweig in externem Archiv löschen"
+msgstr "Zweig in externem Repository löschen"
 
 #: lib/remote_branch_delete.tcl:48
 msgid "From Repository"
-msgstr "In Projektarchiv"
+msgstr "In Repository"
 
 #: lib/remote_branch_delete.tcl:88
 msgid "Branches"
@@ -1757,10 +1734,7 @@ msgstr ""
 msgid ""
 "One or more of the merge tests failed because you have not fetched the "
 "necessary commits.  Try fetching from %s first."
-msgstr ""
-"Ein oder mehrere Zusammenführungen sind fehlgeschlagen, da Sie nicht die "
-"notwendigen Versionen vorher angefordert haben.  Sie sollten versuchen, "
-"zuerst von »%s« anzufordern."
+msgstr "Ein oder mehrere Zusammenführungen sind fehlgeschlagen, da Sie nicht die notwendigen Commits vorher angefordert haben.  Sie sollten versuchen, zuerst von »%s« anzufordern."
 
 #: lib/remote_branch_delete.tcl:208
 msgid "Please select one or more branches to delete."
@@ -1784,7 +1758,7 @@ msgstr "Zweige auf »%s« werden gelöscht"
 
 #: lib/remote_branch_delete.tcl:300
 msgid "No repository selected."
-msgstr "Kein Projektarchiv ausgewählt."
+msgstr "Kein Repository ausgewählt."
 
 #: lib/remote_branch_delete.tcl:305
 #, tcl-format
@@ -1797,7 +1771,7 @@ msgstr "Git Gui"
 
 #: lib/choose_repository.tcl:104 lib/choose_repository.tcl:427
 msgid "Create New Repository"
-msgstr "Neues Projektarchiv"
+msgstr "Repository neu erstellen"
 
 #: lib/choose_repository.tcl:110
 msgid "New..."
@@ -1805,7 +1779,7 @@ msgstr "Neu..."
 
 #: lib/choose_repository.tcl:117 lib/choose_repository.tcl:511
 msgid "Clone Existing Repository"
-msgstr "Projektarchiv klonen"
+msgstr "Repository klonen"
 
 #: lib/choose_repository.tcl:128
 msgid "Clone..."
@@ -1813,7 +1787,7 @@ msgstr "Klonen..."
 
 #: lib/choose_repository.tcl:135 lib/choose_repository.tcl:1105
 msgid "Open Existing Repository"
-msgstr "Projektarchiv öffnen"
+msgstr "Repository öffnen"
 
 #: lib/choose_repository.tcl:141
 msgid "Open..."
@@ -1821,17 +1795,17 @@ msgstr "Öffnen..."
 
 #: lib/choose_repository.tcl:154
 msgid "Recent Repositories"
-msgstr "Zuletzt benutzte Projektarchive"
+msgstr "Letzte Repositories"
 
 #: lib/choose_repository.tcl:164
 msgid "Open Recent Repository:"
-msgstr "Zuletzt benutztes Projektarchiv öffnen:"
+msgstr "Zuletzt benutztes Repository öffnen:"
 
 #: lib/choose_repository.tcl:331 lib/choose_repository.tcl:338
 #: lib/choose_repository.tcl:345
 #, tcl-format
 msgid "Failed to create repository %s:"
-msgstr "Projektarchiv »%s« konnte nicht erstellt werden:"
+msgstr "Repository »%s« konnte nicht erstellt werden:"
 
 #: lib/choose_repository.tcl:422 lib/branch_create.tcl:33
 msgid "Create"
@@ -1844,7 +1818,7 @@ msgstr "Verzeichnis:"
 #: lib/choose_repository.tcl:462 lib/choose_repository.tcl:588
 #: lib/choose_repository.tcl:1139
 msgid "Git Repository"
-msgstr "Git Projektarchiv"
+msgstr "Git Repository"
 
 #: lib/choose_repository.tcl:487
 #, tcl-format
@@ -1862,7 +1836,7 @@ msgstr "Klonen"
 
 #: lib/choose_repository.tcl:519
 msgid "Source Location:"
-msgstr "Herkunft:"
+msgstr "Herkunfts-Adresse:"
 
 #: lib/choose_repository.tcl:528
 msgid "Target Directory:"
@@ -1893,20 +1867,20 @@ msgstr ""
 #: lib/choose_repository.tcl:1145 lib/choose_repository.tcl:1153
 #, tcl-format
 msgid "Not a Git repository: %s"
-msgstr "Kein Git-Projektarchiv in »%s« gefunden."
+msgstr "Kein Git-Repository: %s"
 
 #: lib/choose_repository.tcl:630
 msgid "Standard only available for local repository."
-msgstr "Standard ist nur für lokale Projektarchive verfügbar."
+msgstr "Standard ist nur für lokale Repositories verfügbar."
 
 #: lib/choose_repository.tcl:634
 msgid "Shared only available for local repository."
-msgstr "Verknüpft ist nur für lokale Projektarchive verfügbar."
+msgstr "Verknüpft ist nur für lokale Repositories verfügbar."
 
 #: lib/choose_repository.tcl:655
 #, tcl-format
 msgid "Location %s already exists."
-msgstr "Projektarchiv »%s« existiert bereits."
+msgstr "Adresse »%s« existiert bereits."
 
 #: lib/choose_repository.tcl:666
 msgid "Failed to configure origin"
@@ -2004,7 +1978,7 @@ msgstr "Kein voreingestellter Zweig gefunden."
 #: lib/choose_repository.tcl:971
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
-msgstr "»%s« wurde nicht als Version gefunden."
+msgstr "»%s« wurde nicht als Commit gefunden."
 
 #: lib/choose_repository.tcl:998
 msgid "Creating working directory"
@@ -2025,38 +1999,37 @@ msgstr ""
 
 #: lib/choose_repository.tcl:1110
 msgid "Repository:"
-msgstr "Projektarchiv:"
+msgstr "Repository:"
 
 #: lib/choose_repository.tcl:1159
 #, tcl-format
 msgid "Failed to open repository %s:"
-msgstr "Projektarchiv »%s« konnte nicht geöffnet werden."
+msgstr "Repository »%s« konnte nicht geöffnet werden."
 
 #: lib/about.tcl:26
 msgid "git-gui - a graphical user interface for Git."
 msgstr "git-gui - eine grafische Oberfläche für Git."
 
 #: lib/blame.tcl:74
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): File Viewer"
-msgstr "Datei-Browser"
+msgstr "%s (%s): Datei-Browser"
 
 #: lib/blame.tcl:80
 msgid "Commit:"
-msgstr "Version:"
+msgstr "Commit:"
 
 #: lib/blame.tcl:282
 msgid "Copy Commit"
-msgstr "Version kopieren"
+msgstr "Commit kopieren"
 
 #: lib/blame.tcl:286
 msgid "Find Text..."
 msgstr "Text suchen..."
 
 #: lib/blame.tcl:290
-#, fuzzy
 msgid "Goto Line..."
-msgstr "Klonen..."
+msgstr "Gehe zu Zeile..."
 
 #: lib/blame.tcl:299
 msgid "Do Full Copy Detection"
@@ -2068,7 +2041,7 @@ msgstr "Historien-Kontext anzeigen"
 
 #: lib/blame.tcl:306
 msgid "Blame Parent Commit"
-msgstr "Elternversion annotieren"
+msgstr "Elterncommit annotieren"
 
 #: lib/blame.tcl:468
 #, tcl-format
@@ -2113,7 +2086,7 @@ msgstr "Autor:"
 
 #: lib/blame.tcl:1014
 msgid "Committer:"
-msgstr "Eintragender:"
+msgstr "Committer:"
 
 #: lib/blame.tcl:1019
 msgid "Original File:"
@@ -2121,15 +2094,15 @@ msgstr "Ursprüngliche Datei:"
 
 #: lib/blame.tcl:1067
 msgid "Cannot find HEAD commit:"
-msgstr "Zweigspitze (»HEAD«) kann nicht gefunden werden:"
+msgstr "Zweigspitze (»HEAD commit«) kann nicht gefunden werden:"
 
 #: lib/blame.tcl:1122
 msgid "Cannot find parent commit:"
-msgstr "Elternversion kann nicht gefunden werden:"
+msgstr "Elterncommit kann nicht gefunden werden:"
 
 #: lib/blame.tcl:1137
 msgid "Unable to display parent"
-msgstr "Elternversion kann nicht angezeigt werden"
+msgstr "Elterncommit kann nicht angezeigt werden"
 
 #: lib/blame.tcl:1138 lib/diff.tcl:345
 msgid "Error loading diff:"
@@ -2180,14 +2153,14 @@ msgid ""
 "REMOTE:\n"
 msgstr ""
 "LOKAL: gelöscht\n"
-"ANDERES:\n"
+"EXTERN:\n"
 
 #: lib/diff.tcl:148
 msgid ""
 "REMOTE: deleted\n"
 "LOCAL:\n"
 msgstr ""
-"ANDERES: gelöscht\n"
+"EXTERN: gelöscht\n"
 "LOKAL:\n"
 
 #: lib/diff.tcl:155
@@ -2196,7 +2169,7 @@ msgstr "LOKAL:\n"
 
 #: lib/diff.tcl:158
 msgid "REMOTE:\n"
-msgstr "ANDERES:\n"
+msgstr "EXTERN:\n"
 
 #: lib/diff.tcl:220 lib/diff.tcl:344
 #, tcl-format
@@ -2209,7 +2182,7 @@ msgstr "Fehler beim Laden der Datei:"
 
 #: lib/diff.tcl:227
 msgid "Git Repository (subproject)"
-msgstr "Git-Projektarchiv (Unterprojekt)"
+msgstr "Git-Repository (Subprojekt)"
 
 #: lib/diff.tcl:239
 msgid "* Binary file (not showing content)."
@@ -2241,9 +2214,8 @@ msgstr ""
 "Fehler beim Herausnehmen des gewählten Kontexts aus der Bereitstellung."
 
 #: lib/diff.tcl:591
-#, fuzzy
 msgid "Failed to revert selected hunk."
-msgstr "Fehler beim Bereitstellen des gewählten Kontexts."
+msgstr "Fehler beim Umkehren des gewählten Kontexts."
 
 #: lib/diff.tcl:594
 msgid "Failed to stage selected hunk."
@@ -2254,18 +2226,16 @@ msgid "Failed to unstage selected line."
 msgstr "Fehler beim Herausnehmen der gewählten Zeile aus der Bereitstellung."
 
 #: lib/diff.tcl:696
-#, fuzzy
 msgid "Failed to revert selected line."
-msgstr "Fehler beim Bereitstellen der gewählten Zeile."
+msgstr "Fehler beim Umkehren der gewählten Zeile."
 
 #: lib/diff.tcl:700
 msgid "Failed to stage selected line."
 msgstr "Fehler beim Bereitstellen der gewählten Zeile."
 
 #: lib/diff.tcl:889
-#, fuzzy
 msgid "Failed to undo last revert."
-msgstr "Aktualisieren von »%s« fehlgeschlagen."
+msgstr "Fehler beim Rückgängigmachen des letzten Umkehren-Commits"
 
 #: lib/sshkey.tcl:34
 msgid "No keys found."
@@ -2317,9 +2287,9 @@ msgid "Your key is in: %s"
 msgstr "Ihr Schlüssel ist abgelegt in: %s"
 
 #: lib/branch_create.tcl:23
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Create Branch"
-msgstr "Zweig erstellen"
+msgstr "%s (%s): Zweig erstellen"
 
 #: lib/branch_create.tcl:28
 msgid "Create New Branch"
@@ -2360,7 +2330,7 @@ msgstr "Bitte wählen Sie einen Übernahmezweig."
 #: lib/branch_create.tcl:141
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "Übernahmezweig »%s« ist kein Zweig im externen Projektarchiv."
+msgstr "Übernahmezweig »%s« ist kein Zweig im externen Repository"
 
 #: lib/console.tcl:59
 msgid "Working... please wait..."
@@ -2376,11 +2346,11 @@ msgstr "Fehler: Kommando fehlgeschlagen"
 
 #: lib/line.tcl:17
 msgid "Goto Line:"
-msgstr ""
+msgstr "Gehe zu Zeile:"
 
 #: lib/line.tcl:23
 msgid "Go"
-msgstr ""
+msgstr "Gehe"
 
 #: lib/choose_rev.tcl:52
 msgid "This Detached Checkout"
@@ -2430,10 +2400,9 @@ msgid ""
 "You are about to create the initial commit.  There is no commit before this "
 "to amend.\n"
 msgstr ""
-"Keine Version zur Nachbesserung vorhanden.\n"
+"Kein Commit zur Nachbesserung vorhanden.\n"
 "\n"
-"Sie sind dabei, die erste Version zu übertragen. Es gibt keine existierende "
-"Version, die Sie nachbessern könnten.\n"
+"Sie sind dabei, den ersten Commit zu erstellen. Es gibt keinen existierenden Commit, den Sie nachbessern könnten.\n"
 
 #: lib/commit.tcl:18
 msgid ""
@@ -2443,16 +2412,13 @@ msgid ""
 "completed.  You cannot amend the prior commit unless you first abort the "
 "current merge activity.\n"
 msgstr ""
-"Nachbesserung währen Zusammenführung nicht möglich.\n"
+"Nachbesserung bei Zusammenführung nicht möglich.\n"
 "\n"
-"Sie haben das Zusammenführen von Versionen angefangen, aber noch nicht "
-"beendet. Sie können keine vorige Übertragung nachbessern, solange eine "
-"unfertige Zusammenführung existiert. Dazu müssen Sie die Zusammenführung "
-"beenden oder abbrechen.\n"
+"Sie haben das Zusammenführen von Commits angefangen, aber noch nicht beendet. Sie können keinen vorigen Commit nachbessern, solange eine unfertige Zusammenführung existiert. Dazu müssen Sie die Zusammenführung beenden oder abbrechen.\n"
 
 #: lib/commit.tcl:56
 msgid "Error loading commit data for amend:"
-msgstr "Fehler beim Laden der Versionsdaten für Nachbessern:"
+msgstr "Fehler beim Laden der Commitdaten für Nachbessern:"
 
 #: lib/commit.tcl:83
 msgid "Unable to obtain your identity:"
@@ -2476,10 +2442,9 @@ msgid ""
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
-"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
+"Der letzte geladene Status stimmt nicht mehr mit dem Repository überein.\n"
 "\n"
-"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
-"geändert.  Vor dem Eintragen einer neuen Version muss neu geladen werden.\n"
+"Ein anderes Git-Programm hat das Repository seit dem letzten Laden geändert.  Vor dem nächsten Commit muss neu geladen werden.\n"
 "\n"
 "Es wird gleich neu geladen.\n"
 
@@ -2491,10 +2456,9 @@ msgid ""
 "File %s has merge conflicts.  You must resolve them and stage the file "
 "before committing.\n"
 msgstr ""
-"Nicht zusammengeführte Dateien können nicht eingetragen werden.\n"
+"Nicht zusammengeführte Dateien können nicht committet werden.\n"
 "\n"
-"Die Datei »%s« hat noch nicht aufgelöste Zusammenführungs-Konflikte. Sie "
-"müssen diese Konflikte auflösen, bevor Sie eintragen können.\n"
+"Die Datei »%s« hat noch nicht aufgelöste Zusammenführungs-Konflikte. Sie müssen diese Konflikte auflösen und die Dateien in die Bereitstellung hinzufügen, bevor Sie committen können.\n"
 
 #: lib/commit.tcl:190
 #, tcl-format
@@ -2505,7 +2469,7 @@ msgid ""
 msgstr ""
 "Unbekannter Dateizustand »%s«.\n"
 "\n"
-"Datei »%s« kann nicht eingetragen werden.\n"
+"Datei »%s« kann nicht committet werden.\n"
 
 #: lib/commit.tcl:198
 msgid ""
@@ -2513,9 +2477,9 @@ msgid ""
 "\n"
 "You must stage at least 1 file before you can commit.\n"
 msgstr ""
-"Keine Änderungen vorhanden, die eingetragen werden könnten.\n"
+"Keine Änderungen vorhanden, die committet werden könnten.\n"
 "\n"
-"Sie müssen mindestens eine Datei bereitstellen, bevor Sie eintragen können.\n"
+"Sie müssen mindestens eine Datei bereitstellen, bevor Sie committen können.\n"
 
 #: lib/commit.tcl:213
 msgid ""
@@ -2539,11 +2503,11 @@ msgstr ""
 
 #: lib/commit.tcl:244
 msgid "Calling pre-commit hook..."
-msgstr "Aufrufen der Vor-Eintragen-Kontrolle (»pre-commit hook«)..."
+msgstr "Aufrufen des »pre-commit hook«..."
 
 #: lib/commit.tcl:259
 msgid "Commit declined by pre-commit hook."
-msgstr "Eintragen abgelehnt durch Vor-Eintragen-Kontrolle (»pre-commit hook«)."
+msgstr "Committen abgelehnt durch »pre-commit hook«."
 
 #: lib/commit.tcl:278
 msgid ""
@@ -2557,18 +2521,15 @@ msgstr ""
 
 #: lib/commit.tcl:299
 msgid "Calling commit-msg hook..."
-msgstr ""
-"Aufrufen der Versionsbeschreibungs-Kontrolle (»commit-message hook«)..."
+msgstr "Aufrufen des »commit-message hook«..."
 
 #: lib/commit.tcl:314
 msgid "Commit declined by commit-msg hook."
-msgstr ""
-"Eintragen abgelehnt durch Versionsbeschreibungs-Kontrolle (»commit-message "
-"hook«)."
+msgstr "Committen abgelehnt durch »commit-message hook«."
 
 #: lib/commit.tcl:327
 msgid "Committing changes..."
-msgstr "Änderungen eintragen..."
+msgstr "Änderungen committen..."
 
 #: lib/commit.tcl:344
 msgid "write-tree failed:"
@@ -2576,7 +2537,7 @@ msgstr "write-tree fehlgeschlagen:"
 
 #: lib/commit.tcl:345 lib/commit.tcl:395 lib/commit.tcl:422
 msgid "Commit failed."
-msgstr "Eintragen fehlgeschlagen."
+msgstr "Committen fehlgeschlagen."
 
 #: lib/commit.tcl:362
 #, tcl-format
@@ -2591,16 +2552,15 @@ msgid ""
 "\n"
 "A rescan will be automatically started now.\n"
 msgstr ""
-"Keine Änderungen einzutragen.\n"
+"Keine Änderungen zum committen.\n"
 "\n"
-"Es gibt keine geänderte Datei bei dieser Version und es wurde auch nichts "
-"zusammengeführt.\n"
+"Es gibt keine geänderte Datei in diesem Commit und es wurde auch nichts zusammengeführt.\n"
 "\n"
 "Das Arbeitsverzeichnis wird daher jetzt neu geladen.\n"
 
 #: lib/commit.tcl:374
 msgid "No changes to commit."
-msgstr "Keine Änderungen, die eingetragen werden können."
+msgstr "Keine Änderungen, die committet werden können."
 
 #: lib/commit.tcl:394
 msgid "commit-tree failed:"
@@ -2616,9 +2576,9 @@ msgid "Created commit %s: %s"
 msgstr "Version %s übertragen: %s"
 
 #: lib/branch_delete.tcl:16
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Delete Branch"
-msgstr "Zweig löschen"
+msgstr "%s (%s): Zweig löschen"
 
 #: lib/branch_delete.tcl:21
 msgid "Delete Local Branch"
@@ -2640,7 +2600,7 @@ msgstr "Folgende Zweige sind noch nicht mit »%s« zusammengeführt:"
 #: lib/branch_delete.tcl:131
 #, tcl-format
 msgid " - %s:"
-msgstr ""
+msgstr " - %s:"
 
 #: lib/branch_delete.tcl:141
 #, tcl-format
@@ -2685,9 +2645,9 @@ msgid "Garbage files"
 msgstr "Dateien im Mülleimer"
 
 #: lib/database.tcl:66
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Database Statistics"
-msgstr "Datenbankstatistik"
+msgstr "%s (%s): Datenbankstatistik"
 
 #: lib/database.tcl:72
 msgid "Compressing the object database"
@@ -2707,37 +2667,35 @@ msgid ""
 "\n"
 "Compress the database now?"
 msgstr ""
-"Dieses Projektarchiv enthält ungefähr %i nicht verknüpfte Objekte.\n"
+"Dieses Repository enthält ungefähr %i nicht verknüpfte Objekte.\n"
 "\n"
-"Für eine optimale Performance wird empfohlen, die Datenbank des "
-"Projektarchivs zu komprimieren.\n"
+"Für eine optimale Performance wird empfohlen, die Datenbank des Repository zu komprimieren.\n"
 "\n"
 "Soll die Datenbank jetzt komprimiert werden?"
 
 #: lib/error.tcl:20
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s: error"
-msgstr "Fehler"
+msgstr "%s: Fehler"
 
 #: lib/error.tcl:36
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s: warning"
-msgstr "Warnung"
+msgstr "%s: Warnung"
 
 #: lib/error.tcl:80
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s hook failed:"
-msgstr "Werkzeug fehlgeschlagen: %s"
+msgstr "%s hook fehlgeschlagen:"
 
 #: lib/error.tcl:96
 msgid "You must correct the above errors before committing."
-msgstr ""
-"Sie müssen die obigen Fehler zuerst beheben, bevor Sie eintragen können."
+msgstr "Sie müssen die obigen Fehler zuerst beheben, bevor Sie committen können."
 
 #: lib/error.tcl:116
 #, tcl-format
 msgid "%s (%s): error"
-msgstr ""
+msgstr "%s (%s): Fehler"
 
 #: lib/merge.tcl:13
 msgid ""
@@ -2747,8 +2705,7 @@ msgid ""
 msgstr ""
 "Zusammenführen kann nicht gleichzeitig mit Nachbessern durchgeführt werden.\n"
 "\n"
-"Sie müssen zuerst die Nachbesserungs-Version abschließen, bevor Sie "
-"zusammenführen können.\n"
+"Sie müssen zuerst den Nachbesserungs-Commit abschließen, bevor Sie zusammenführen können.\n"
 
 #: lib/merge.tcl:27
 msgid ""
@@ -2759,10 +2716,9 @@ msgid ""
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
-"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
+"Der letzte geladene Status stimmt nicht mehr mit dem Repository überein.\n"
 "\n"
-"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
-"geändert.  Vor einem Zusammenführen muss neu geladen werden.\n"
+"Ein anderes Git-Programm hat das Repository seit dem letzten Laden geändert.  Vor einem Zusammenführen muss neu geladen werden.\n"
 "\n"
 "Es wird gleich neu geladen.\n"
 
@@ -2778,10 +2734,9 @@ msgid ""
 msgstr ""
 "Zusammenführung mit Konflikten.\n"
 "\n"
-"Die Datei »%s« enthält Konflikte beim Zusammenführen. Sie müssen diese "
-"Konflikte per Hand auflösen. Anschließend müssen Sie die Datei wieder "
-"bereitstellen und eintragen, um die Zusammenführung abzuschließen. Erst "
-"danach kann eine neue Zusammenführung begonnen werden.\n"
+"Die Datei »%s« enthält Konflikte beim Zusammenführen.\n"
+"\n"
+"Sie müssen diese Konflikte per Hand auflösen. Anschließend müssen Sie die Datei wieder bereitstellen und committen, um die Zusammenführung abzuschließen. Erst danach kann eine neue Zusammenführung begonnen werden.\n"
 
 #: lib/merge.tcl:55
 #, tcl-format
@@ -2795,10 +2750,9 @@ msgid ""
 msgstr ""
 "Es liegen Änderungen vor.\n"
 "\n"
-"Die Datei »%s« wurde geändert.  Sie sollten zuerst die bereitgestellte "
-"Version abschließen, bevor Sie eine Zusammenführung beginnen.  Mit dieser "
-"Reihenfolge können Sie mögliche Konflikte beim Zusammenführen wesentlich "
-"einfacher beheben oder abbrechen.\n"
+"Die Datei »%s« wurde geändert.\n"
+"\n"
+"Sie sollten zuerst den bereitgestellten Commit abschließen, bevor Sie eine Zusammenführung beginnen.  Mit dieser Reihenfolge können Sie mögliche Konflikte beim Zusammenführen wesentlich einfacher beheben oder abbrechen.\n"
 
 #: lib/merge.tcl:108
 #, tcl-format
@@ -2821,7 +2775,7 @@ msgstr "Zusammenführen fehlgeschlagen. Konfliktauflösung ist notwendig."
 #: lib/merge.tcl:156
 #, tcl-format
 msgid "%s (%s): Merge"
-msgstr ""
+msgstr "%s (%s): Zusammenführen"
 
 #: lib/merge.tcl:164
 #, tcl-format
@@ -2840,7 +2794,7 @@ msgid ""
 msgstr ""
 "Abbruch der Nachbesserung ist nicht möglich.\n"
 "\n"
-"Sie müssen die Nachbesserung der Version abschließen.\n"
+"Sie müssen die Nachbesserung diese Commits abschließen.\n"
 
 #: lib/merge.tcl:228
 msgid ""
@@ -2852,8 +2806,7 @@ msgid ""
 msgstr ""
 "Zusammenführen abbrechen?\n"
 "\n"
-"Wenn Sie abbrechen, gehen alle noch nicht eingetragenen Änderungen "
-"verloren.\n"
+"Wenn Sie abbrechen, gehen alle noch nicht committeten Änderungen verloren.\n"
 "\n"
 "Zusammenführen jetzt abbrechen?"
 
@@ -2867,8 +2820,7 @@ msgid ""
 msgstr ""
 "Änderungen zurücksetzen?\n"
 "\n"
-"Wenn Sie zurücksetzen, gehen alle noch nicht eingetragenen Änderungen "
-"verloren.\n"
+"Wenn Sie zurücksetzen, gehen alle noch nicht committeten Änderungen verloren.\n"
 "\n"
 "Änderungen jetzt zurücksetzen?"
 
@@ -2887,12 +2839,3 @@ msgstr "Abbruch fehlgeschlagen."
 #: lib/merge.tcl:279
 msgid "Abort completed.  Ready."
 msgstr "Abbruch durchgeführt. Bereit."
-
-#~ msgid "Displaying only %s of %s files."
-#~ msgstr "Nur %s von %s Dateien werden angezeigt."
-
-#~ msgid "New Commit"
-#~ msgstr "Neue Version"
-
-#~ msgid "Case-Sensitive"
-#~ msgstr "Groß-/Kleinschreibung unterscheiden"
diff --git a/po/glossary/de.po b/po/glossary/de.po
index 5af06bf4c1..ed392748c2 100644
--- a/po/glossary/de.po
+++ b/po/glossary/de.po
@@ -7,7 +7,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui glossary\n"
 "POT-Creation-Date: 2020-01-13 21:40+0100\n"
-"PO-Revision-Date: 2020-01-13 21:53+0100\n"
+"PO-Revision-Date: 2020-01-13 22:30+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German \n"
 "Language: de_DE\n"
@@ -67,15 +67,11 @@ msgstr "klonen"
 
 #. "A single point in the git history."
 msgid "commit [noun]"
-msgstr ""
-"Version; Eintragung; Änderung (Buchung?, Eintragung?, Übertragung?, "
-"Sendung?, Übergabe?, Einspielung?, Ablagevorgang?)"
+msgstr "Commit (Version?)"
 
 #. "The action of storing a new snapshot of the project's state in the git history."
 msgid "commit [verb]"
-msgstr ""
-"eintragen (TortoiseSVN: übertragen; Source Safe: einchecken; senden?, "
-"übergeben?, einspielen?, einpflegen?, ablegen?)"
+msgstr "committen (eintragen?, TortoiseSVN: übertragen; Source Safe: einchecken)"
 
 #. ""
 msgid "diff [noun]"
@@ -135,7 +131,7 @@ msgstr "Extern (Andere?, Gegenseite?, Entfernte?, Server?)"
 
 #. "A collection of refs (?) together with an object database containing all objects which are reachable from the refs... (oops, you've lost me here. Again, please an explanation for mere mortals?)"
 msgid "repository"
-msgstr "Projektarchiv"
+msgstr "Repository"
 
 #. ""
 msgid "reset"
@@ -143,12 +139,11 @@ msgstr "zurücksetzen (zurückkehren?)"
 
 #. ""
 msgid "revert"
-msgstr ""
-"verwerfen (bei git-reset), revidieren (bei git-revert, also mit neuem commit)"
+msgstr "verwerfen (bei git-reset bzw. checkout), umkehren (bei git-revert, also mit neuem commit)"
 
 #. "A particular state of files and directories which was stored in the object database."
 msgid "revision"
-msgstr "Version (TortoiseSVN: Revision; Source Safe: Version)"
+msgstr "Version (aber was macht das Wort revision hier im Git?? TortoiseSVN: Revision; Source Safe: Version)"
 
 #. ""
 msgid "sign off"
@@ -223,9 +218,8 @@ msgid "cleanup"
 msgstr ""
 
 #. "a message that gets attached with any commit"
-#, fuzzy
 msgid "commit message"
-msgstr "Beschreibung (Meldung?, Nachricht?; Source Safe: Kommentar)"
+msgstr "Commit-Beschreibung (Meldung?, Nachricht?; Source Safe: Kommentar)"
 
 #. "a commit that precedes the current one in git's graph of commits (not necessarily directly)"
 msgid "descendant"
-- 
gitgitgadget

