Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AEEC352A4
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 22:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1316B2083B
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 22:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAibsWnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgBIWBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:01:12 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:35453 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBIWBL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 17:01:11 -0500
Received: by mail-wm1-f50.google.com with SMTP id b17so8426663wmb.0
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 14:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LWkqVxSTvmB82VcopOF0qBIQEGiIEPrWYPwqXJKTOK8=;
        b=FAibsWnKSdu+Kksxz8v0rRbnWAB4CdkpRAuBLXkIb9Tw2Cul10I1WlYmNQd2DPr39y
         vKLzpZLO4eKzDxVEl1zJ2hOvdXn2BeDxuRWxKp1ztQ7Uo7QWPKt91VJjOhCPf2DHJx3S
         I3zFuD/saX2qp73a82IKCjCrQ00l+ERGP7/RfU7P4o9R9BsAuCc52OR3goRBucMKJNvp
         K4KEAEUEeVuOLSgJGrFY60rw+YLSvt5C7dJUldZMHe+/IaUqgbkZ+bBKyRh+Ujula41/
         pdfO+Vv9dkdc+XB97/hamLSHiT/Yfxkfs9b5VcvNmARHFsf1ZIpz+stLvNeEwSf3Arbm
         w1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LWkqVxSTvmB82VcopOF0qBIQEGiIEPrWYPwqXJKTOK8=;
        b=UxGD4RjwGmMxbeQCy38EpUyj9aX3x3l/2KRLJEQ5YGfdErgCb04gFDqioeQBMlzEZY
         ldHvi9NBPZzpZDmwCGFYtcXA++8VEu5ldhN4tHc94iWfdP0CLa89WN0V0JO/6EKHGOrm
         fBWys+DS4W3xJtFsVPk1uIzExkUYZ/jAKJY2NHgqPyRLtbnG4nXOIAQMqy/Glw3IoF7a
         oqDhAY7NLWyudjTf8yL5MsIKtqfR+v6HTrggPsWfFoAIeHqDyqS4hvrdStE/+GDgYSUJ
         r+tE6NEZPtn4VEEmzne4vtCPbqR23353XFYvK/NrpytfIO3zNbkeBoII+ZDzx+NRgYkE
         e/XQ==
X-Gm-Message-State: APjAAAWwcvzhu0ejVikAGl+I3XysD0wRv6uc6yonqy/CuG3A5jqcYl1v
        gSTjk8qRZMbYhNmHjZ3jjri+vjPI
X-Google-Smtp-Source: APXvYqyjpsLAz1Qm4vd8cHss8dZzeaV3luh+gcwNKA4ufwtI7cfuocrBeKhhYTwypFEPoqipwIakQQ==
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr11467310wmg.151.1581285663274;
        Sun, 09 Feb 2020 14:01:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm12893410wmj.2.2020.02.09.14.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:01:02 -0800 (PST)
Message-Id: <76fbb3d7cc0655a934480ce6434c3be17620d0e0.1581285659.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.525.v2.git.1581285658.gitgitgadget@gmail.com>
References: <pull.525.git.1579905218.gitgitgadget@gmail.com>
        <pull.525.v2.git.1581285658.gitgitgadget@gmail.com>
From:   "Christian Stimming via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Feb 2020 22:00:58 +0000
Subject: [PATCH v2 3/3] git-gui: update German translation
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

Update German translation (glossary and final translation) with
recent additions, but also switch several terms from uncommon
translations back to English vocabulary.

This most prominently concerns "commit" (noun, verb), "repository",
"branch", and some more. These uncommon translations have been introduced
long ago and never been changed since. In fact, the whole German
translation here hasn't been touched for a long time. However, in German
literature and magazines, git-gui is regularly noted for its uncommon
choice of translated vocabulary. This somewhat distracts from the actual
benefits of this tool. So it is probably better to abandon the uncommon
translations and rather stick to the common English vocabulary in git
version control.

Signed-off-by: Christian Stimming <christian@cstimming.de>
---
 po/de.po          | 672 ++++++++++++++++++++++------------------------
 po/glossary/de.po | 315 +++++++++++++++++++---
 2 files changed, 602 insertions(+), 385 deletions(-)

diff --git a/po/de.po b/po/de.po
index 6bbcb1d469..a8d5f61ca3 100644
--- a/po/de.po
+++ b/po/de.po
@@ -8,10 +8,10 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2020-02-08 22:54+0100\n"
-"PO-Revision-Date: 2010-01-26 22:25+0100\n"
-"Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
+"PO-Revision-Date: 2020-02-09 22:40+0100\n"
+"Last-Translator: Christian Stimming <christian@cstimming.de>\n"
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
+msgstr "Aufrufen des »prepare-commit-msg hook«..."
 
 #: git-gui.sh:1646
 msgid "Commit declined by prepare-commit-msg hook."
-msgstr ""
-"Eintragen abgelehnt durch Eintragen-Vorbereiten-Kontrolle (»prepare-commit "
-"hook«)."
+msgstr "Commit abgelehnt durch »prepare-commit-msg hook«."
 
 #: git-gui.sh:1804 lib/browser.tcl:252
 msgid "Ready."
@@ -107,6 +104,8 @@ msgstr "Bereit."
 msgid ""
 "Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files."
 msgstr ""
+"Anzeigelimit erreicht (gui.maxfilesdisplayed = %s) für Anzahl Einträge. Es "
+"werden nicht alle %s Dateien gezeigt."
 
 #: git-gui.sh:2091
 msgid "Unmodified"
@@ -118,42 +117,39 @@ msgstr "Verändert, nicht bereitgestellt"
 
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
-msgstr "Nicht unter Versionskontrolle, nicht bereitgestellt"
+msgstr "Unversioniert, nicht bereitgestellt"
 
 #: git-gui.sh:2110
 msgid "Missing"
@@ -177,9 +173,9 @@ msgid "Couldn't find gitk in PATH"
 msgstr "Gitk kann im PATH nicht gefunden werden."
 
 #: git-gui.sh:2210 git-gui.sh:2245
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Starting %s... please wait..."
-msgstr "Gitk wird gestartet... bitte warten."
+msgstr "%s wird gestartet... bitte warten."
 
 #: git-gui.sh:2224
 msgid "Couldn't find git gui in PATH"
@@ -187,7 +183,7 @@ msgstr "»Git gui« kann im PATH nicht gefunden werden."
 
 #: git-gui.sh:2726 lib/choose_repository.tcl:53
 msgid "Repository"
-msgstr "Projektarchiv"
+msgstr "Repository"
 
 #: git-gui.sh:2727
 msgid "Edit"
@@ -195,11 +191,11 @@ msgstr "Bearbeiten"
 
 #: git-gui.sh:2729 lib/choose_rev.tcl:567
 msgid "Branch"
-msgstr "Zweig"
+msgstr "Branch"
 
 #: git-gui.sh:2732 lib/choose_rev.tcl:554
 msgid "Commit@@noun"
-msgstr "Version"
+msgstr "Commit"
 
 #: git-gui.sh:2735 lib/merge.tcl:127 lib/merge.tcl:174
 msgid "Merge"
@@ -207,7 +203,7 @@ msgstr "Zusammenführen"
 
 #: git-gui.sh:2736 lib/choose_rev.tcl:563
 msgid "Remote"
-msgstr "Externe Archive"
+msgstr "Extern"
 
 #: git-gui.sh:2739
 msgid "Tools"
@@ -215,32 +211,32 @@ msgstr "Werkzeuge"
 
 #: git-gui.sh:2748
 msgid "Explore Working Copy"
-msgstr "Arbeitskopie im Dateimanager"
+msgstr "Arbeitskopie im Dateimanager öffnen"
 
 #: git-gui.sh:2763
 msgid "Git Bash"
-msgstr ""
+msgstr "Git Bash"
 
 #: git-gui.sh:2772
 msgid "Browse Current Branch's Files"
-msgstr "Aktuellen Zweig durchblättern"
+msgstr "Aktuellen Branch durchblättern"
 
 #: git-gui.sh:2776
 msgid "Browse Branch Files..."
-msgstr "Einen Zweig durchblättern..."
+msgstr "Branch durchblättern..."
 
 #: git-gui.sh:2781
 msgid "Visualize Current Branch's History"
-msgstr "Aktuellen Zweig darstellen"
+msgstr "Aktuellen Branch darstellen"
 
 #: git-gui.sh:2785
 msgid "Visualize All Branch History"
-msgstr "Alle Zweige darstellen"
+msgstr "Historie aller Branches darstellen"
 
 #: git-gui.sh:2792
 #, tcl-format
 msgid "Browse %s's Files"
-msgstr "Zweig »%s« durchblättern"
+msgstr "Branch »%s« durchblättern"
 
 #: git-gui.sh:2794
 #, tcl-format
@@ -303,7 +299,7 @@ msgstr "Erstellen..."
 
 #: git-gui.sh:2871
 msgid "Checkout..."
-msgstr "Umstellen..."
+msgstr "Auschecken..."
 
 #: git-gui.sh:2877
 msgid "Rename..."
@@ -315,7 +311,7 @@ msgstr "Löschen..."
 
 #: git-gui.sh:2887
 msgid "Reset..."
-msgstr "Zurücksetzen..."
+msgstr "Änderungen verwerfen..."
 
 #: git-gui.sh:2897
 msgid "Done"
@@ -323,11 +319,11 @@ msgstr "Fertig"
 
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
@@ -335,15 +331,15 @@ msgstr "Neu laden"
 
 #: git-gui.sh:2924
 msgid "Stage To Commit"
-msgstr "Zum Eintragen bereitstellen"
+msgstr "Für Commit bereitstellen"
 
 #: git-gui.sh:2930
 msgid "Stage Changed Files To Commit"
-msgstr "Geänderte Dateien bereitstellen"
+msgstr "Geänderte Dateien für Commit bereitstellen"
 
 #: git-gui.sh:2936
 msgid "Unstage From Commit"
-msgstr "Aus der Bereitstellung herausnehmen"
+msgstr "Aus Commit-Bereitstellung herausnehmen"
 
 #: git-gui.sh:2942 lib/index.tcl:521
 msgid "Revert Changes"
@@ -371,7 +367,7 @@ msgstr "Zusammenführen abbrechen..."
 
 #: git-gui.sh:2994 git-gui.sh:3022
 msgid "Add..."
-msgstr "Hinzufügen..."
+msgstr "Neues hinzufügen..."
 
 #: git-gui.sh:2998
 msgid "Push..."
@@ -379,7 +375,7 @@ msgstr "Versenden..."
 
 #: git-gui.sh:3002
 msgid "Delete Branch..."
-msgstr "Zweig löschen..."
+msgstr "Branch löschen..."
 
 #: git-gui.sh:3012 git-gui.sh:3666
 msgid "Options..."
@@ -409,14 +405,13 @@ msgstr "SSH-Schlüssel anzeigen"
 
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
 
@@ -429,7 +424,7 @@ msgstr ""
 
 #: git-gui.sh:3246
 msgid "Current Branch:"
-msgstr "Aktueller Zweig:"
+msgstr "Aktueller Branch:"
 
 #: git-gui.sh:3271
 msgid "Unstaged Changes"
@@ -437,7 +432,7 @@ msgstr "Nicht bereitgestellte Änderungen"
 
 #: git-gui.sh:3293
 msgid "Staged Changes (Will Commit)"
-msgstr "Bereitstellung (zum Eintragen)"
+msgstr "Bereitstellung (zum Committen)"
 
 #: git-gui.sh:3367
 msgid "Stage Changed"
@@ -449,7 +444,7 @@ msgstr "Versenden"
 
 #: git-gui.sh:3413
 msgid "Initial Commit Message:"
-msgstr "Erste Versionsbeschreibung:"
+msgstr "Erste Commit-Beschreibung:"
 
 #: git-gui.sh:3414
 msgid "Amended Commit Message:"
@@ -469,7 +464,7 @@ msgstr "Zusammenführungs-Beschreibung:"
 
 #: git-gui.sh:3418
 msgid "Commit Message:"
-msgstr "Versionsbeschreibung:"
+msgstr "Commit-Beschreibung:"
 
 #: git-gui.sh:3477 git-gui.sh:3641 lib/console.tcl:73
 msgid "Copy All"
@@ -501,25 +496,23 @@ msgstr "Zeichenkodierung"
 
 #: git-gui.sh:3673
 msgid "Apply/Reverse Hunk"
-msgstr "Kontext anwenden/umkehren"
+msgstr "Patch-Block anwenden/zurücknehmen"
 
 #: git-gui.sh:3678
 msgid "Apply/Reverse Line"
-msgstr "Zeile anwenden/umkehren"
+msgstr "Zeile anwenden/zurücknehmen"
 
 #: git-gui.sh:3684 git-gui.sh:3794 git-gui.sh:3805
-#, fuzzy
 msgid "Revert Hunk"
-msgstr "Kontext anwenden/umkehren"
+msgstr "Patch-Block zurücknehmen"
 
 #: git-gui.sh:3689 git-gui.sh:3801 git-gui.sh:3812
-#, fuzzy
 msgid "Revert Line"
-msgstr "Änderungen verwerfen"
+msgstr "Zeilenänderungen zurücknehmen"
 
 #: git-gui.sh:3694 git-gui.sh:3791
 msgid "Undo Last Revert"
-msgstr ""
+msgstr "Letztes Zurücknehmen rückgängig"
 
 #: git-gui.sh:3713
 msgid "Run Merge Tool"
@@ -535,36 +528,35 @@ msgstr "Lokale Version benutzen"
 
 #: git-gui.sh:3726
 msgid "Revert To Base"
-msgstr "Ursprüngliche Version benutzen"
+msgstr "Zurücksetzen auf ursprünglichen Commit"
 
 #: git-gui.sh:3744
 msgid "Visualize These Changes In The Submodule"
-msgstr "Diese Änderungen im Untermodul darstellen"
+msgstr "Diese Änderungen im Submodul darstellen"
 
 #: git-gui.sh:3748
 msgid "Visualize Current Branch History In The Submodule"
-msgstr "Aktuellen Zweig im Untermodul darstellen"
+msgstr "Aktuellen Branch im Submodul darstellen"
 
 #: git-gui.sh:3752
 msgid "Visualize All Branch History In The Submodule"
-msgstr "Alle Zweige im Untermodul darstellen"
+msgstr "Alle Branches im Submodul darstellen"
 
 #: git-gui.sh:3757
 msgid "Start git gui In The Submodule"
-msgstr "Git gui im Untermodul starten"
+msgstr "Git gui im Submodul starten"
 
 #: git-gui.sh:3793
 msgid "Unstage Hunk From Commit"
-msgstr "Kontext aus Bereitstellung herausnehmen"
+msgstr "Patch-Block aus Bereitstellung herausnehmen"
 
 #: git-gui.sh:3797
 msgid "Unstage Lines From Commit"
 msgstr "Zeilen aus der Bereitstellung herausnehmen"
 
 #: git-gui.sh:3798 git-gui.sh:3809
-#, fuzzy
 msgid "Revert Lines"
-msgstr "Änderungen verwerfen"
+msgstr "Zeilenänderung zurücknehmen"
 
 #: git-gui.sh:3800
 msgid "Unstage Line From Commit"
@@ -572,7 +564,7 @@ msgstr "Zeile aus der Bereitstellung herausnehmen"
 
 #: git-gui.sh:3804
 msgid "Stage Hunk For Commit"
-msgstr "Kontext zur Bereitstellung hinzufügen"
+msgstr "Patch-Block zur Bereitstellung hinzufügen"
 
 #: git-gui.sh:3808
 msgid "Stage Lines For Commit"
@@ -678,31 +670,29 @@ msgstr "Neue Änderungen von »%s« holen"
 #: lib/transport.tcl:18
 #, tcl-format
 msgid "remote prune %s"
-msgstr "Aufräumen von »%s«"
+msgstr "Gelöschte externe Branches aus »%s« entfernen"
 
 #: lib/transport.tcl:19
 #, tcl-format
 msgid "Pruning tracking branches deleted from %s"
-msgstr "Übernahmezweige aufräumen und entfernen, die in »%s« gelöscht wurden"
+msgstr "Gelöschte externe Trackingbranches aus »%s« werden entfernt"
 
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
+msgstr "Extern veraltete Branches entfernen aller Repositories"
 
 #: lib/transport.tcl:41
-#, fuzzy
 msgid "Pruning tracking branches deleted from all remotes"
-msgstr "Übernahmezweige aufräumen und entfernen, die in »%s« gelöscht wurden"
+msgstr ""
+"Gelöschte externe Trackingbranches aus allen Repositories werden entfernt"
 
 #: lib/transport.tcl:54 lib/transport.tcl:92 lib/transport.tcl:110
 #: lib/remote_add.tcl:162
@@ -727,7 +717,7 @@ msgstr "%s %s nach %s versenden"
 
 #: lib/transport.tcl:132
 msgid "Push Branches"
-msgstr "Zweige versenden"
+msgstr "Branches versenden"
 
 #: lib/transport.tcl:141 lib/checkout_op.tcl:580 lib/remote_add.tcl:34
 #: lib/browser.tcl:292 lib/branch_checkout.tcl:30 lib/branch_rename.tcl:32
@@ -739,19 +729,19 @@ msgstr "Abbrechen"
 
 #: lib/transport.tcl:147
 msgid "Source Branches"
-msgstr "Lokale Zweige"
+msgstr "Lokale Branches"
 
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
@@ -760,7 +750,8 @@ msgstr "Netzwerk-Einstellungen"
 #: lib/transport.tcl:207
 msgid "Force overwrite existing branch (may discard changes)"
 msgstr ""
-"Überschreiben von existierenden Zweigen erzwingen (könnte Änderungen löschen)"
+"Überschreiben von existierenden Branches erzwingen (könnte Änderungen "
+"löschen)"
 
 #: lib/transport.tcl:211
 msgid "Use thin pack (for slow network connections)"
@@ -768,12 +759,12 @@ msgstr "Kompaktes Datenformat benutzen (für langsame Netzverbindungen)"
 
 #: lib/transport.tcl:215
 msgid "Include tags"
-msgstr "Mit Markierungen übertragen"
+msgstr "Mit Tags versenden"
 
 #: lib/transport.tcl:229
 #, tcl-format
 msgid "%s (%s): Push"
-msgstr ""
+msgstr "%s (%s): Versenden"
 
 #: lib/checkout_op.tcl:85
 #, tcl-format
@@ -783,7 +774,7 @@ msgstr "Änderungen »%s« von »%s« anfordern"
 #: lib/checkout_op.tcl:133
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
-msgstr "Fehler: »%s« kann nicht als Zweig oder Version erkannt werden"
+msgstr "Fehler: »%s« kann nicht als Branch oder Version erkannt werden"
 
 #: lib/checkout_op.tcl:146 lib/sshkey.tcl:58 lib/console.tcl:81
 #: lib/database.tcl:30
@@ -793,7 +784,7 @@ msgstr "Schließen"
 #: lib/checkout_op.tcl:175
 #, tcl-format
 msgid "Branch '%s' does not exist."
-msgstr "Zweig »%s« existiert nicht."
+msgstr "Branch »%s« existiert nicht."
 
 #: lib/checkout_op.tcl:194
 #, tcl-format
@@ -803,7 +794,7 @@ msgstr "Fehler beim Einrichten der vereinfachten git-pull für »%s«."
 #: lib/checkout_op.tcl:202 lib/branch_rename.tcl:102
 #, tcl-format
 msgid "Branch '%s' already exists."
-msgstr "Zweig »%s« existiert bereits."
+msgstr "Branch »%s« existiert bereits."
 
 #: lib/checkout_op.tcl:229
 #, tcl-format
@@ -813,10 +804,10 @@ msgid ""
 "It cannot fast-forward to %s.\n"
 "A merge is required."
 msgstr ""
-"Zweig »%s« existiert bereits.\n"
+"Branch »%s« existiert bereits.\n"
 "\n"
-"Zweig kann nicht mit »%s« schnellzusammengeführt werden. Reguläres "
-"Zusammenführen ist notwendig."
+"Branch kann nicht auf »%s« vorgespult werden. Reguläres Zusammenführen ist "
+"notwendig."
 
 #: lib/checkout_op.tcl:243
 #, tcl-format
@@ -841,17 +832,17 @@ msgid ""
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
-"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
+"Der letzte geladene Status stimmt nicht mehr mit dem Repository überein.\n"
 "\n"
-"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
-"geändert.  Vor dem Wechseln des lokalen Zweigs muss neu geladen werden.\n"
+"Ein anderes Git-Programm hat das Repository seit dem letzten Laden "
+"geändert.  Vor dem Wechseln des lokalen Branches muss neu geladen werden.\n"
 "\n"
 "Es wird gleich neu geladen.\n"
 
 #: lib/checkout_op.tcl:345
 #, tcl-format
 msgid "Updating working directory to '%s'..."
-msgstr "Arbeitskopie umstellen auf »%s«..."
+msgstr "Arbeitskopie aktualisieren auf »%s«..."
 
 #: lib/checkout_op.tcl:346
 msgid "files checked out"
@@ -861,7 +852,7 @@ msgstr "Dateien aktualisiert"
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr ""
-"Auf Zweig »%s« umstellen abgebrochen (Zusammenführen der Dateien ist "
+"Branch »%s« Auschecken abgebrochen (Zusammenführen der Dateien ist "
 "notwendig)."
 
 #: lib/checkout_op.tcl:378
@@ -871,7 +862,7 @@ msgstr "Zusammenführen der Dateien ist notwendig."
 #: lib/checkout_op.tcl:382
 #, tcl-format
 msgid "Staying on branch '%s'."
-msgstr "Es wird auf Zweig »%s« verblieben."
+msgstr "Es wird auf Branch »%s« verblieben."
 
 #: lib/checkout_op.tcl:453
 msgid ""
@@ -880,10 +871,10 @@ msgid ""
 "If you wanted to be on a branch, create one now starting from 'This Detached "
 "Checkout'."
 msgstr ""
-"Die Arbeitskopie ist nicht auf einem lokalen Zweig.\n"
+"Die Arbeitskopie ist nicht auf einem lokalen Branch.\n"
 "\n"
-"Wenn Sie auf einem Zweig arbeiten möchten, erstellen Sie bitte jetzt einen "
-"Zweig mit der Auswahl »Abgetrennte Arbeitskopie-Version«."
+"Wenn Sie auf einem Branch arbeiten möchten, erstellen Sie bitte jetzt einen "
+"Branch mit der Auswahl »Losgelöste Arbeitskopie-Version«."
 
 #: lib/checkout_op.tcl:504 lib/checkout_op.tcl:508
 #, tcl-format
@@ -893,18 +884,17 @@ msgstr "Umgestellt auf »%s«."
 #: lib/checkout_op.tcl:536
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
-msgstr "Zurücksetzen von »%s« nach »%s« wird folgende Versionen verwerfen:"
+msgstr "Umsetzen von »%s« nach »%s« wird folgende Commits verlieren:"
 
 #: lib/checkout_op.tcl:558
 msgid "Recovering lost commits may not be easy."
 msgstr ""
-"Verworfene Versionen können nur mit größerem Aufwand wiederhergestellt "
-"werden."
+"Verlorene Commits können nur mit größerem Aufwand wiederhergestellt werden."
 
 #: lib/checkout_op.tcl:563
 #, tcl-format
 msgid "Reset '%s'?"
-msgstr "»%s« zurücksetzen?"
+msgstr "»%s« umsetzen?"
 
 #: lib/checkout_op.tcl:568 lib/tools_dlg.tcl:336 lib/merge.tcl:170
 msgid "Visualize"
@@ -912,7 +902,7 @@ msgstr "Darstellen"
 
 #: lib/checkout_op.tcl:572 lib/branch_create.tcl:85
 msgid "Reset"
-msgstr "Zurücksetzen"
+msgstr "Umsetzen (Reset)"
 
 #: lib/checkout_op.tcl:636
 #, tcl-format
@@ -924,7 +914,7 @@ msgid ""
 "\n"
 "This should not have occurred.  %s will now close and give up."
 msgstr ""
-"Lokaler Zweig kann nicht gesetzt werden.\n"
+"Lokaler Branch kann nicht gesetzt werden.\n"
 "\n"
 "Diese Arbeitskopie ist nur teilweise umgestellt. Die Dateien sind korrekt "
 "aktualisiert, aber einige interne Git-Dateien konnten nicht geändert "
@@ -933,13 +923,13 @@ msgstr ""
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
@@ -947,7 +937,7 @@ msgstr "Hinzufügen"
 
 #: lib/remote_add.tcl:39
 msgid "Remote Details"
-msgstr "Einzelheiten des externen Archivs"
+msgstr "Einzelheiten des externen Repository"
 
 #: lib/remote_add.tcl:41 lib/tools_dlg.tcl:51 lib/branch_create.tcl:44
 msgid "Name:"
@@ -959,34 +949,33 @@ msgstr "Adresse:"
 
 #: lib/remote_add.tcl:60
 msgid "Further Action"
-msgstr "Weitere Aktion jetzt"
+msgstr "Weitere Aktion"
 
 #: lib/remote_add.tcl:63
 msgid "Fetch Immediately"
-msgstr "Gleich anfordern"
+msgstr "Jetzt anfordern"
 
 #: lib/remote_add.tcl:69
 msgid "Initialize Remote Repository and Push"
-msgstr "Externes Archiv initialisieren und dahin versenden"
+msgstr "Externes Repository initialisieren und dahin versenden"
 
 #: lib/remote_add.tcl:75
 msgid "Do Nothing Else Now"
-msgstr "Nichts tun"
+msgstr "Keine weitere Aktion"
 
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
@@ -997,7 +986,7 @@ msgstr "»%s« anfordern"
 #, tcl-format
 msgid "Do not know how to initialize repository at location '%s'."
 msgstr ""
-"Initialisieren eines externen Archivs an Adresse »%s« ist nicht möglich."
+"Initialisieren eines externen Repositories an Adresse »%s« ist nicht möglich."
 
 #: lib/remote_add.tcl:163
 #, tcl-format
@@ -1009,9 +998,9 @@ msgid "Starting..."
 msgstr "Starten..."
 
 #: lib/browser.tcl:27
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): File Browser"
-msgstr "Datei-Browser"
+msgstr "%s (%s): Datei-Browser"
 
 #: lib/browser.tcl:132 lib/browser.tcl:149
 #, tcl-format
@@ -1023,13 +1012,13 @@ msgid "[Up To Parent]"
 msgstr "[Nach oben]"
 
 #: lib/browser.tcl:275
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Browse Branch Files"
-msgstr "Dateien des Zweigs durchblättern"
+msgstr "%s (%s): Dateien des Branches durchblättern"
 
 #: lib/browser.tcl:282
 msgid "Browse Branch Files"
-msgstr "Dateien des Zweigs durchblättern"
+msgstr "Dateien des Branches durchblättern"
 
 #: lib/browser.tcl:288 lib/choose_repository.tcl:437
 #: lib/choose_repository.tcl:524 lib/choose_repository.tcl:533
@@ -1072,9 +1061,8 @@ msgid "files"
 msgstr "Dateien"
 
 #: lib/index.tcl:326
-#, fuzzy
 msgid "Unstaging selected files from commit"
-msgstr "Datei »%s« aus der Bereitstellung herausnehmen"
+msgstr "Gewählte Dateien aus der Bereitstellung herausnehmen"
 
 #: lib/index.tcl:330
 #, tcl-format
@@ -1083,26 +1071,25 @@ msgstr "Datei »%s« aus der Bereitstellung herausnehmen"
 
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
 msgid "Stage %d untracked files?"
-msgstr ""
+msgstr "%d unversionierte Dateien bereitstellen?"
 
 #: lib/index.tcl:420
 msgid "Adding all changed files"
-msgstr ""
+msgstr "Alle geänderten Dateien hinzufügen"
 
 #: lib/index.tcl:503
 #, tcl-format
@@ -1112,7 +1099,7 @@ msgstr "Änderungen in Datei »%s« verwerfen?"
 #: lib/index.tcl:508
 #, tcl-format
 msgid "Revert changes in these %i files?"
-msgstr "Änderungen in den gewählten %i Dateien verwerfen?"
+msgstr "Änderungen in diesen %i Dateien verwerfen?"
 
 #: lib/index.tcl:517
 msgid "Any unstaged changes will be permanently lost by the revert."
@@ -1124,42 +1111,40 @@ msgid "Do Nothing"
 msgstr "Nichts tun"
 
 #: lib/index.tcl:545
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Delete untracked file %s?"
-msgstr "Zweige auf »%s« werden gelöscht"
+msgstr "Unversionierte Datei »%s« löschen?"
 
 #: lib/index.tcl:550
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Delete these %i untracked files?"
-msgstr "Änderungen in den gewählten %i Dateien verwerfen?"
+msgstr "Diese %i unversionierten Dateien löschen?"
 
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
@@ -1171,17 +1156,17 @@ msgid "Reverting %s"
 msgstr "Änderungen in %s verwerfen"
 
 #: lib/branch_checkout.tcl:16
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Checkout Branch"
-msgstr "Auf Zweig umstellen"
+msgstr "%s (%s): Branch auschecken"
 
 #: lib/branch_checkout.tcl:21
 msgid "Checkout Branch"
-msgstr "Auf Zweig umstellen"
+msgstr "Branch auschecken"
 
 #: lib/branch_checkout.tcl:26
 msgid "Checkout"
-msgstr "Umstellen"
+msgstr "Auschecken"
 
 #: lib/branch_checkout.tcl:39 lib/option.tcl:310 lib/branch_create.tcl:69
 msgid "Options"
@@ -1189,11 +1174,11 @@ msgstr "Optionen"
 
 #: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
 msgid "Fetch Tracking Branch"
-msgstr "Übernahmezweig anfordern"
+msgstr "Trackingbranch anfordern"
 
 #: lib/branch_checkout.tcl:47
 msgid "Detach From Local Branch"
-msgstr "Verbindung zu lokalem Zweig lösen"
+msgstr "Verbindung zu lokalem Branch lösen"
 
 #: lib/status_bar.tcl:263
 #, tcl-format
@@ -1206,28 +1191,28 @@ msgstr "Versenden nach"
 
 #: lib/remote.tcl:218
 msgid "Remove Remote"
-msgstr "Externes Archiv entfernen"
+msgstr "Externes Repository entfernen"
 
 #: lib/remote.tcl:223
 msgid "Prune from"
-msgstr "Aufräumen von"
+msgstr "Veraltete Branches entfernen"
 
 #: lib/remote.tcl:228
 msgid "Fetch from"
-msgstr "Anfordern von"
+msgstr "Anfordern"
 
 #: lib/remote.tcl:249 lib/remote.tcl:253 lib/remote.tcl:258 lib/remote.tcl:264
 msgid "All"
-msgstr ""
+msgstr "Alle"
 
 #: lib/branch_rename.tcl:15
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Rename Branch"
-msgstr "Zweig umbenennen"
+msgstr "%s (%s): Branch umbenennen"
 
 #: lib/branch_rename.tcl:23
 msgid "Rename Branch"
-msgstr "Zweig umbenennen"
+msgstr "Branch umbenennen"
 
 #: lib/branch_rename.tcl:28
 msgid "Rename"
@@ -1235,7 +1220,7 @@ msgstr "Umbenennen"
 
 #: lib/branch_rename.tcl:38
 msgid "Branch:"
-msgstr "Zweig:"
+msgstr "Branch:"
 
 #: lib/branch_rename.tcl:46
 msgid "New Name:"
@@ -1243,16 +1228,16 @@ msgstr "Neuer Name:"
 
 #: lib/branch_rename.tcl:81
 msgid "Please select a branch to rename."
-msgstr "Bitte wählen Sie einen Zweig zum umbenennen."
+msgstr "Bitte wählen Sie einen Branch zum umbenennen."
 
 #: lib/branch_rename.tcl:92 lib/branch_create.tcl:154
 msgid "Please supply a branch name."
-msgstr "Bitte geben Sie einen Zweignamen an."
+msgstr "Bitte geben Sie einen Branchnamen an."
 
 #: lib/branch_rename.tcl:112 lib/branch_create.tcl:165
 #, tcl-format
 msgid "'%s' is not an acceptable branch name."
-msgstr "»%s« ist kein zulässiger Zweigname."
+msgstr "»%s« ist kein zulässiger Branchname."
 
 #: lib/branch_rename.tcl:123
 #, tcl-format
@@ -1291,7 +1276,7 @@ msgstr "Ungültige globale Zeichenkodierung »%s«"
 #: lib/option.tcl:19
 #, tcl-format
 msgid "Invalid repo encoding '%s'"
-msgstr "Ungültige Archiv-Zeichenkodierung »%s«"
+msgstr "Ungültige Repository-Zeichenkodierung »%s«"
 
 #: lib/option.tcl:119
 msgid "Restore Defaults"
@@ -1304,11 +1289,11 @@ msgstr "Speichern"
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
@@ -1320,7 +1305,7 @@ msgstr "E-Mail-Adresse"
 
 #: lib/option.tcl:143
 msgid "Summarize Merge Commits"
-msgstr "Zusammenführungs-Versionen zusammenfassen"
+msgstr "Zusammenführungs-Commits zusammenfassen"
 
 #: lib/option.tcl:144
 msgid "Merge Verbosity"
@@ -1340,24 +1325,23 @@ msgstr "Auf Dateiänderungsdatum verlassen"
 
 #: lib/option.tcl:149
 msgid "Prune Tracking Branches During Fetch"
-msgstr "Übernahmezweige aufräumen während Anforderung"
+msgstr "Veraltete Trackingbranches entfernen während Anforderung"
 
 #: lib/option.tcl:150
 msgid "Match Tracking Branches"
-msgstr "Passend zu Übernahmezweig"
+msgstr "Neue Branches automatisch als Trackingbranch"
 
 #: lib/option.tcl:151
 msgid "Use Textconv For Diffs and Blames"
-msgstr ""
+msgstr "Benutze »textconv« für Vergleich und Annotieren"
 
 #: lib/option.tcl:152
 msgid "Blame Copy Only On Changed Files"
 msgstr "Kopie-Annotieren nur bei geänderten Dateien"
 
 #: lib/option.tcl:153
-#, fuzzy
 msgid "Maximum Length of Recent Repositories List"
-msgstr "Zuletzt benutzte Projektarchive"
+msgstr "Anzahl Einträge in »Letzte Repositories«"
 
 #: lib/option.tcl:154
 msgid "Minimum Letters To Blame Copy On"
@@ -1365,7 +1349,7 @@ msgstr "Mindestzahl Zeichen für Kopie-Annotieren"
 
 #: lib/option.tcl:155
 msgid "Blame History Context Radius (days)"
-msgstr "Anzahl Tage für Historien-Kontext"
+msgstr "Anzahl Tage für Annotieren-Historien-Kontext"
 
 #: lib/option.tcl:156
 msgid "Number of Diff Context Lines"
@@ -1373,15 +1357,15 @@ msgstr "Anzahl der Kontextzeilen beim Vergleich"
 
 #: lib/option.tcl:157
 msgid "Additional Diff Parameters"
-msgstr ""
+msgstr "Zusätzliche Vergleich-/diff-Parameter"
 
 #: lib/option.tcl:158
 msgid "Commit Message Text Width"
-msgstr "Textbreite der Versionsbeschreibung"
+msgstr "Textbreite der Commit-Beschreibung"
 
 #: lib/option.tcl:159
 msgid "New Branch Name Template"
-msgstr "Namensvorschlag für neue Zweige"
+msgstr "Namensvorlage für neue Branches"
 
 #: lib/option.tcl:160
 msgid "Default File Contents Encoding"
@@ -1389,25 +1373,25 @@ msgstr "Voreingestellte Zeichenkodierung"
 
 #: lib/option.tcl:161
 msgid "Warn before committing to a detached head"
-msgstr ""
+msgstr "Warnen vor Committen auf losgelöste Branchspitze"
 
 #: lib/option.tcl:162
 msgid "Staging of untracked files"
-msgstr ""
+msgstr "Unversionierte Dateien bereitstellen"
 
 #: lib/option.tcl:163
 msgid "Show untracked files"
-msgstr ""
+msgstr "Unversionierte Dateien anzeigen"
 
 #: lib/option.tcl:164
 msgid "Tab spacing"
-msgstr ""
+msgstr "Tabulator-Breite"
 
 #: lib/option.tcl:182 lib/option.tcl:197 lib/option.tcl:220 lib/option.tcl:282
 #: lib/database.tcl:57
 #, tcl-format
 msgid "%s:"
-msgstr ""
+msgstr "%s:"
 
 #: lib/option.tcl:210
 msgid "Change"
@@ -1457,9 +1441,9 @@ msgid "Running %s requires a selected file."
 msgstr "Um »%s« zu starten, muss eine Datei ausgewählt sein."
 
 #: lib/tools.tcl:92
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
-msgstr "Wollen Sie %s wirklich starten?"
+msgstr "Wollen Sie %1$s wirklich auf Datei »%2$s« starten?"
 
 #: lib/tools.tcl:96
 #, tcl-format
@@ -1492,11 +1476,11 @@ msgstr "Konflikt durch Basisversion ersetzen?"
 
 #: lib/mergetool.tcl:9
 msgid "Force resolution to this branch?"
-msgstr "Konflikt durch diesen Zweig ersetzen?"
+msgstr "Konflikt durch diesen Branch ersetzen?"
 
 #: lib/mergetool.tcl:10
 msgid "Force resolution to the other branch?"
-msgstr "Konflikt durch anderen Zweig ersetzen?"
+msgstr "Konflikt durch anderen Branch ersetzen?"
 
 #: lib/mergetool.tcl:14
 #, tcl-format
@@ -1577,9 +1561,9 @@ msgid "Merge tool failed."
 msgstr "Zusammenführungswerkzeug fehlgeschlagen."
 
 #: lib/tools_dlg.tcl:22
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Add Tool"
-msgstr "Werkzeug hinzufügen"
+msgstr "%s (%s): Werkzeug hinzufügen"
 
 #: lib/tools_dlg.tcl:28
 msgid "Add New Tool Command"
@@ -1641,9 +1625,9 @@ msgstr ""
 "%s"
 
 #: lib/tools_dlg.tcl:187
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Remove Tool"
-msgstr "Werkzeug entfernen"
+msgstr "%s (%s): Werkzeug entfernen"
 
 #: lib/tools_dlg.tcl:193
 msgid "Remove Tool Commands"
@@ -1655,12 +1639,12 @@ msgstr "Entfernen"
 
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
@@ -1689,16 +1673,16 @@ msgstr "Voriger"
 
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
@@ -1709,21 +1693,21 @@ msgid "Cannot write icon:"
 msgstr "Fehler beim Erstellen des Icons:"
 
 #: lib/remote_branch_delete.tcl:29
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Delete Branch Remotely"
-msgstr "Zweig in externem Archiv löschen"
+msgstr "%s (%s): Branch in externem Repository löschen"
 
 #: lib/remote_branch_delete.tcl:34
 msgid "Delete Branch Remotely"
-msgstr "Zweig in externem Archiv löschen"
+msgstr "Branch in externem Repository löschen"
 
 #: lib/remote_branch_delete.tcl:48
 msgid "From Repository"
-msgstr "In Projektarchiv"
+msgstr "In Repository"
 
 #: lib/remote_branch_delete.tcl:88
 msgid "Branches"
-msgstr "Zweige"
+msgstr "Branches"
 
 #: lib/remote_branch_delete.tcl:110
 msgid "Delete Only If"
@@ -1739,7 +1723,7 @@ msgstr "Immer (Keine Zusammenführungsprüfung)"
 
 #: lib/remote_branch_delete.tcl:153
 msgid "A branch is required for 'Merged Into'."
-msgstr "Für »Zusammenführen mit« muss ein Zweig angegeben werden."
+msgstr "Für »Zusammenführen mit« muss ein Branch angegeben werden."
 
 #: lib/remote_branch_delete.tcl:185
 #, tcl-format
@@ -1748,7 +1732,7 @@ msgid ""
 "\n"
 " - %s"
 msgstr ""
-"Folgende Zweige sind noch nicht mit »%s« zusammengeführt:\n"
+"Folgende Branches sind noch nicht mit »%s« zusammengeführt:\n"
 "\n"
 " - %s"
 
@@ -1759,12 +1743,12 @@ msgid ""
 "necessary commits.  Try fetching from %s first."
 msgstr ""
 "Ein oder mehrere Zusammenführungen sind fehlgeschlagen, da Sie nicht die "
-"notwendigen Versionen vorher angefordert haben.  Sie sollten versuchen, "
-"zuerst von »%s« anzufordern."
+"notwendigen Commits vorher angefordert haben.  Sie sollten versuchen, zuerst "
+"von »%s« anzufordern."
 
 #: lib/remote_branch_delete.tcl:208
 msgid "Please select one or more branches to delete."
-msgstr "Bitte wählen Sie mindestens einen Zweig, der gelöscht werden soll."
+msgstr "Bitte wählen Sie mindestens einen Branch, der gelöscht werden soll."
 
 #: lib/remote_branch_delete.tcl:218 lib/branch_delete.tcl:115
 msgid ""
@@ -1772,19 +1756,19 @@ msgid ""
 "\n"
 "Delete the selected branches?"
 msgstr ""
-"Das Wiederherstellen von gelöschten Zweigen ist nur mit größerem Aufwand "
+"Das Wiederherstellen von gelöschten Branches ist nur mit größerem Aufwand "
 "möglich.\n"
 "\n"
-"Sollen die ausgewählten Zweige gelöscht werden?"
+"Sollen die ausgewählten Branches gelöscht werden?"
 
 #: lib/remote_branch_delete.tcl:227
 #, tcl-format
 msgid "Deleting branches from %s"
-msgstr "Zweige auf »%s« werden gelöscht"
+msgstr "Branches auf »%s« werden gelöscht"
 
 #: lib/remote_branch_delete.tcl:300
 msgid "No repository selected."
-msgstr "Kein Projektarchiv ausgewählt."
+msgstr "Kein Repository ausgewählt."
 
 #: lib/remote_branch_delete.tcl:305
 #, tcl-format
@@ -1797,7 +1781,7 @@ msgstr "Git Gui"
 
 #: lib/choose_repository.tcl:104 lib/choose_repository.tcl:427
 msgid "Create New Repository"
-msgstr "Neues Projektarchiv"
+msgstr "Repository neu erstellen"
 
 #: lib/choose_repository.tcl:110
 msgid "New..."
@@ -1805,7 +1789,7 @@ msgstr "Neu..."
 
 #: lib/choose_repository.tcl:117 lib/choose_repository.tcl:511
 msgid "Clone Existing Repository"
-msgstr "Projektarchiv klonen"
+msgstr "Repository klonen"
 
 #: lib/choose_repository.tcl:128
 msgid "Clone..."
@@ -1813,7 +1797,7 @@ msgstr "Klonen..."
 
 #: lib/choose_repository.tcl:135 lib/choose_repository.tcl:1105
 msgid "Open Existing Repository"
-msgstr "Projektarchiv öffnen"
+msgstr "Repository öffnen"
 
 #: lib/choose_repository.tcl:141
 msgid "Open..."
@@ -1821,17 +1805,17 @@ msgstr "Öffnen..."
 
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
@@ -1844,7 +1828,7 @@ msgstr "Verzeichnis:"
 #: lib/choose_repository.tcl:462 lib/choose_repository.tcl:588
 #: lib/choose_repository.tcl:1139
 msgid "Git Repository"
-msgstr "Git Projektarchiv"
+msgstr "Git Repository"
 
 #: lib/choose_repository.tcl:487
 #, tcl-format
@@ -1862,7 +1846,7 @@ msgstr "Klonen"
 
 #: lib/choose_repository.tcl:519
 msgid "Source Location:"
-msgstr "Herkunft:"
+msgstr "Herkunfts-Adresse:"
 
 #: lib/choose_repository.tcl:528
 msgid "Target Directory:"
@@ -1886,27 +1870,27 @@ msgstr "Verknüpft (schnell, nicht empfohlen, kein Backup)"
 
 #: lib/choose_repository.tcl:560
 msgid "Recursively clone submodules too"
-msgstr ""
+msgstr "Rekursiv weitere Submodule klonen"
 
 #: lib/choose_repository.tcl:594 lib/choose_repository.tcl:641
 #: lib/choose_repository.tcl:790 lib/choose_repository.tcl:864
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
@@ -1933,7 +1917,7 @@ msgstr "Von »%s« konnte nichts geklont werden."
 #: lib/choose_repository.tcl:742 lib/choose_repository.tcl:962
 #: lib/choose_repository.tcl:974
 msgid "The 'master' branch has not been initialized."
-msgstr "Der »master«-Zweig wurde noch nicht initialisiert."
+msgstr "Der »master«-Branch wurde noch nicht initialisiert."
 
 #: lib/choose_repository.tcl:755
 msgid "Hardlinks are unavailable.  Falling back to copying."
@@ -1973,19 +1957,19 @@ msgstr "Für Objekt konnte kein Hardlink erstellt werden: %s"
 #: lib/choose_repository.tcl:903
 msgid "Cannot fetch branches and objects.  See console output for details."
 msgstr ""
-"Zweige und Objekte konnten nicht angefordert werden.  Kontrollieren Sie die "
-"Ausgaben auf der Konsole für weitere Angaben."
+"Branches und Objekte konnten nicht angefordert werden.  Kontrollieren Sie "
+"die Ausgaben auf der Konsole für weitere Angaben."
 
 #: lib/choose_repository.tcl:914
 msgid "Cannot fetch tags.  See console output for details."
 msgstr ""
-"Markierungen konnten nicht angefordert werden.  Kontrollieren Sie die "
-"Ausgaben auf der Konsole für weitere Angaben."
+"Tags konnten nicht angefordert werden.  Kontrollieren Sie die Ausgaben auf "
+"der Konsole für weitere Angaben."
 
 #: lib/choose_repository.tcl:938
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr ""
-"Die Zweigspitze (HEAD) konnte nicht gefunden werden.  Kontrollieren Sie die "
+"Die Branchspitze (HEAD) konnte nicht gefunden werden.  Kontrollieren Sie die "
 "Ausgaben auf der Konsole für weitere Angaben."
 
 #: lib/choose_repository.tcl:947
@@ -1999,12 +1983,12 @@ msgstr "Klonen fehlgeschlagen."
 
 #: lib/choose_repository.tcl:960
 msgid "No default branch obtained."
-msgstr "Kein voreingestellter Zweig gefunden."
+msgstr "Kein voreingestellter Branch gefunden."
 
 #: lib/choose_repository.tcl:971
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
-msgstr "»%s« wurde nicht als Version gefunden."
+msgstr "»%s« wurde nicht als Commit gefunden."
 
 #: lib/choose_repository.tcl:998
 msgid "Creating working directory"
@@ -2015,48 +1999,46 @@ msgid "Initial file checkout failed."
 msgstr "Erstellen der Arbeitskopie fehlgeschlagen."
 
 #: lib/choose_repository.tcl:1072
-#, fuzzy
 msgid "Cloning submodules"
-msgstr "Kopieren von »%s«"
+msgstr "Klone Submodul"
 
 #: lib/choose_repository.tcl:1087
 msgid "Cannot clone submodules."
-msgstr ""
+msgstr "Submodul konnte nicht geklont werden."
 
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
@@ -2068,7 +2050,7 @@ msgstr "Historien-Kontext anzeigen"
 
 #: lib/blame.tcl:306
 msgid "Blame Parent Commit"
-msgstr "Elternversion annotieren"
+msgstr "Elterncommit annotieren"
 
 #: lib/blame.tcl:468
 #, tcl-format
@@ -2113,7 +2095,7 @@ msgstr "Autor:"
 
 #: lib/blame.tcl:1014
 msgid "Committer:"
-msgstr "Eintragender:"
+msgstr "Committer:"
 
 #: lib/blame.tcl:1019
 msgid "Original File:"
@@ -2121,15 +2103,15 @@ msgstr "Ursprüngliche Datei:"
 
 #: lib/blame.tcl:1067
 msgid "Cannot find HEAD commit:"
-msgstr "Zweigspitze (»HEAD«) kann nicht gefunden werden:"
+msgstr "Branchspitze (»HEAD commit«) kann nicht gefunden werden:"
 
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
@@ -2180,14 +2162,14 @@ msgid ""
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
@@ -2196,7 +2178,7 @@ msgstr "LOKAL:\n"
 
 #: lib/diff.tcl:158
 msgid "REMOTE:\n"
-msgstr "ANDERES:\n"
+msgstr "EXTERN:\n"
 
 #: lib/diff.tcl:220 lib/diff.tcl:344
 #, tcl-format
@@ -2209,7 +2191,7 @@ msgstr "Fehler beim Laden der Datei:"
 
 #: lib/diff.tcl:227
 msgid "Git Repository (subproject)"
-msgstr "Git-Projektarchiv (Unterprojekt)"
+msgstr "Git-Repository (Subprojekt)"
 
 #: lib/diff.tcl:239
 msgid "* Binary file (not showing content)."
@@ -2221,7 +2203,7 @@ msgid ""
 "* Untracked file is %d bytes.\n"
 "* Showing only first %d bytes.\n"
 msgstr ""
-"* Datei nicht unter Versionskontrolle, Dateigröße %d Bytes.\n"
+"* Unversionierte Datei hat %d Bytes.\n"
 "* Nur erste %d Bytes werden angezeigt.\n"
 
 #: lib/diff.tcl:250
@@ -2232,40 +2214,37 @@ msgid ""
 "* To see the entire file, use an external editor.\n"
 msgstr ""
 "\n"
-"* Datei nicht unter Versionskontrolle, hier abgeschnitten durch %s.\n"
+"* Unversionierte Datei, hier abgeschnitten durch %s.\n"
 "* Zum Ansehen der vollständigen Datei externen Editor benutzen.\n"
 
 #: lib/diff.tcl:583
 msgid "Failed to unstage selected hunk."
 msgstr ""
-"Fehler beim Herausnehmen des gewählten Kontexts aus der Bereitstellung."
+"Fehler beim Herausnehmen des gewählten Patch-Blocks aus der Bereitstellung."
 
 #: lib/diff.tcl:591
-#, fuzzy
 msgid "Failed to revert selected hunk."
-msgstr "Fehler beim Bereitstellen des gewählten Kontexts."
+msgstr "Fehler beim Zurücknehmen des gewählten Patch-Blocks."
 
 #: lib/diff.tcl:594
 msgid "Failed to stage selected hunk."
-msgstr "Fehler beim Bereitstellen des gewählten Kontexts."
+msgstr "Fehler beim Bereitstellen des gewählten Patch-Blocks."
 
 #: lib/diff.tcl:687
 msgid "Failed to unstage selected line."
 msgstr "Fehler beim Herausnehmen der gewählten Zeile aus der Bereitstellung."
 
 #: lib/diff.tcl:696
-#, fuzzy
 msgid "Failed to revert selected line."
-msgstr "Fehler beim Bereitstellen der gewählten Zeile."
+msgstr "Fehler beim Zurücknehmen der gewählten Zeile."
 
 #: lib/diff.tcl:700
 msgid "Failed to stage selected line."
 msgstr "Fehler beim Bereitstellen der gewählten Zeile."
 
 #: lib/diff.tcl:889
-#, fuzzy
 msgid "Failed to undo last revert."
-msgstr "Aktualisieren von »%s« fehlgeschlagen."
+msgstr "Fehler beim Rückgängigmachen des letzten Zurücknehmen-Commits"
 
 #: lib/sshkey.tcl:34
 msgid "No keys found."
@@ -2317,21 +2296,21 @@ msgid "Your key is in: %s"
 msgstr "Ihr Schlüssel ist abgelegt in: %s"
 
 #: lib/branch_create.tcl:23
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Create Branch"
-msgstr "Zweig erstellen"
+msgstr "%s (%s): Branch erstellen"
 
 #: lib/branch_create.tcl:28
 msgid "Create New Branch"
-msgstr "Neuen Zweig erstellen"
+msgstr "Neuen Branch erstellen"
 
 #: lib/branch_create.tcl:42
 msgid "Branch Name"
-msgstr "Zweigname"
+msgstr "Branchname"
 
 #: lib/branch_create.tcl:57
 msgid "Match Tracking Branch Name"
-msgstr "Passend zu Übernahmezweig-Name"
+msgstr "Passend zu Trackingbranch-Name"
 
 #: lib/branch_create.tcl:66
 msgid "Starting Revision"
@@ -2339,7 +2318,7 @@ msgstr "Anfangsversion"
 
 #: lib/branch_create.tcl:72
 msgid "Update Existing Branch:"
-msgstr "Existierenden Zweig aktualisieren:"
+msgstr "Existierenden Branch aktualisieren:"
 
 #: lib/branch_create.tcl:75
 msgid "No"
@@ -2347,20 +2326,20 @@ msgstr "Nein"
 
 #: lib/branch_create.tcl:80
 msgid "Fast Forward Only"
-msgstr "Nur Schnellzusammenführung"
+msgstr "Nur Vorspulen"
 
 #: lib/branch_create.tcl:97
 msgid "Checkout After Creation"
-msgstr "Arbeitskopie umstellen nach Erstellen"
+msgstr "Branch auschecken nach Erstellen"
 
 #: lib/branch_create.tcl:132
 msgid "Please select a tracking branch."
-msgstr "Bitte wählen Sie einen Übernahmezweig."
+msgstr "Bitte wählen Sie einen Trackingbranch."
 
 #: lib/branch_create.tcl:141
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "Übernahmezweig »%s« ist kein Zweig im externen Projektarchiv."
+msgstr "Trackingbranch »%s« ist kein Branch im externen Repository."
 
 #: lib/console.tcl:59
 msgid "Working... please wait..."
@@ -2376,31 +2355,31 @@ msgstr "Fehler: Kommando fehlgeschlagen"
 
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
-msgstr "Abgetrennte Arbeitskopie-Version"
+msgstr "Losgelöste Arbeitskopie-Version"
 
 #: lib/choose_rev.tcl:60
 msgid "Revision Expression:"
-msgstr "Version Regexp-Ausdruck:"
+msgstr "Version Regex-Ausdruck:"
 
 #: lib/choose_rev.tcl:72
 msgid "Local Branch"
-msgstr "Lokaler Zweig"
+msgstr "Lokaler Branch"
 
 #: lib/choose_rev.tcl:77
 msgid "Tracking Branch"
-msgstr "Übernahmezweig"
+msgstr "Trackingbranch"
 
 #: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
 msgid "Tag"
-msgstr "Markierung"
+msgstr "Tag"
 
 #: lib/choose_rev.tcl:321
 #, tcl-format
@@ -2430,10 +2409,10 @@ msgid ""
 "You are about to create the initial commit.  There is no commit before this "
 "to amend.\n"
 msgstr ""
-"Keine Version zur Nachbesserung vorhanden.\n"
+"Kein Commit zur Nachbesserung vorhanden.\n"
 "\n"
-"Sie sind dabei, die erste Version zu übertragen. Es gibt keine existierende "
-"Version, die Sie nachbessern könnten.\n"
+"Sie sind dabei, den ersten Commit zu erstellen. Es gibt keinen existierenden "
+"Commit, den Sie nachbessern könnten.\n"
 
 #: lib/commit.tcl:18
 msgid ""
@@ -2443,16 +2422,16 @@ msgid ""
 "completed.  You cannot amend the prior commit unless you first abort the "
 "current merge activity.\n"
 msgstr ""
-"Nachbesserung währen Zusammenführung nicht möglich.\n"
+"Nachbesserung bei Zusammenführung nicht möglich.\n"
 "\n"
-"Sie haben das Zusammenführen von Versionen angefangen, aber noch nicht "
-"beendet. Sie können keine vorige Übertragung nachbessern, solange eine "
+"Sie haben das Zusammenführen von Commits angefangen, aber noch nicht "
+"beendet. Sie können keinen vorigen Commit nachbessern, solange eine "
 "unfertige Zusammenführung existiert. Dazu müssen Sie die Zusammenführung "
 "beenden oder abbrechen.\n"
 
 #: lib/commit.tcl:56
 msgid "Error loading commit data for amend:"
-msgstr "Fehler beim Laden der Versionsdaten für Nachbessern:"
+msgstr "Fehler beim Laden der Commitdaten für Nachbessern:"
 
 #: lib/commit.tcl:83
 msgid "Unable to obtain your identity:"
@@ -2476,10 +2455,10 @@ msgid ""
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
-"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
+"Der letzte geladene Status stimmt nicht mehr mit dem Repository überein.\n"
 "\n"
-"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
-"geändert.  Vor dem Eintragen einer neuen Version muss neu geladen werden.\n"
+"Ein anderes Git-Programm hat das Repository seit dem letzten Laden "
+"geändert.  Vor dem nächsten Commit muss neu geladen werden.\n"
 "\n"
 "Es wird gleich neu geladen.\n"
 
@@ -2491,10 +2470,11 @@ msgid ""
 "File %s has merge conflicts.  You must resolve them and stage the file "
 "before committing.\n"
 msgstr ""
-"Nicht zusammengeführte Dateien können nicht eingetragen werden.\n"
+"Nicht zusammengeführte Dateien können nicht committet werden.\n"
 "\n"
 "Die Datei »%s« hat noch nicht aufgelöste Zusammenführungs-Konflikte. Sie "
-"müssen diese Konflikte auflösen, bevor Sie eintragen können.\n"
+"müssen diese Konflikte auflösen und die Dateien in die Bereitstellung "
+"hinzufügen, bevor Sie committen können.\n"
 
 #: lib/commit.tcl:190
 #, tcl-format
@@ -2505,7 +2485,7 @@ msgid ""
 msgstr ""
 "Unbekannter Dateizustand »%s«.\n"
 "\n"
-"Datei »%s« kann nicht eingetragen werden.\n"
+"Datei »%s« kann nicht committet werden.\n"
 
 #: lib/commit.tcl:198
 msgid ""
@@ -2513,9 +2493,9 @@ msgid ""
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
@@ -2539,11 +2519,11 @@ msgstr ""
 
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
@@ -2554,21 +2534,26 @@ msgid ""
 " \n"
 " Do you really want to proceed with your Commit?"
 msgstr ""
+"Sie sind dabei, einen Commit auf losgelöste Branchspitze (»commit to "
+"detached head«) zu erstellen. Das ist riskant, denn wenn Sie zu einem "
+"anderen Branch wechseln, würden Sie diese Änderungen verlieren und es ist "
+"nachträglich schwierig, diese aus dem Commit-Log (»reflog«) wiederzufinden. "
+"Es wird empfohlen, diesen Commit abzubrechen und zunächst einen neuen Branch "
+"zu erstellen.\n"
+"\n"
+" Wollen Sie den Commit trotzdem in dieser Form erstellen?"
 
 #: lib/commit.tcl:299
 msgid "Calling commit-msg hook..."
-msgstr ""
-"Aufrufen der Versionsbeschreibungs-Kontrolle (»commit-message hook«)..."
+msgstr "Aufrufen des »commit-msg hook«..."
 
 #: lib/commit.tcl:314
 msgid "Commit declined by commit-msg hook."
-msgstr ""
-"Eintragen abgelehnt durch Versionsbeschreibungs-Kontrolle (»commit-message "
-"hook«)."
+msgstr "Committen abgelehnt durch »commit-msg hook«."
 
 #: lib/commit.tcl:327
 msgid "Committing changes..."
-msgstr "Änderungen eintragen..."
+msgstr "Änderungen committen..."
 
 #: lib/commit.tcl:344
 msgid "write-tree failed:"
@@ -2576,7 +2561,7 @@ msgstr "write-tree fehlgeschlagen:"
 
 #: lib/commit.tcl:345 lib/commit.tcl:395 lib/commit.tcl:422
 msgid "Commit failed."
-msgstr "Eintragen fehlgeschlagen."
+msgstr "Committen fehlgeschlagen."
 
 #: lib/commit.tcl:362
 #, tcl-format
@@ -2591,16 +2576,16 @@ msgid ""
 "\n"
 "A rescan will be automatically started now.\n"
 msgstr ""
-"Keine Änderungen einzutragen.\n"
+"Keine Änderungen zum committen.\n"
 "\n"
-"Es gibt keine geänderte Datei bei dieser Version und es wurde auch nichts "
+"Es gibt keine geänderte Datei in diesem Commit und es wurde auch nichts "
 "zusammengeführt.\n"
 "\n"
 "Das Arbeitsverzeichnis wird daher jetzt neu geladen.\n"
 
 #: lib/commit.tcl:374
 msgid "No changes to commit."
-msgstr "Keine Änderungen, die eingetragen werden können."
+msgstr "Keine Änderungen, die committet werden können."
 
 #: lib/commit.tcl:394
 msgid "commit-tree failed:"
@@ -2613,20 +2598,20 @@ msgstr "update-ref fehlgeschlagen:"
 #: lib/commit.tcl:514
 #, tcl-format
 msgid "Created commit %s: %s"
-msgstr "Version %s übertragen: %s"
+msgstr "Commit %s erstellt: %s"
 
 #: lib/branch_delete.tcl:16
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Delete Branch"
-msgstr "Zweig löschen"
+msgstr "%s (%s): Branch löschen"
 
 #: lib/branch_delete.tcl:21
 msgid "Delete Local Branch"
-msgstr "Lokalen Zweig löschen"
+msgstr "Lokalen Branch löschen"
 
 #: lib/branch_delete.tcl:39
 msgid "Local Branches"
-msgstr "Lokale Zweige"
+msgstr "Lokale Branches"
 
 #: lib/branch_delete.tcl:51
 msgid "Delete Only If Merged Into"
@@ -2635,12 +2620,12 @@ msgstr "Nur löschen, wenn zusammengeführt nach"
 #: lib/branch_delete.tcl:103
 #, tcl-format
 msgid "The following branches are not completely merged into %s:"
-msgstr "Folgende Zweige sind noch nicht mit »%s« zusammengeführt:"
+msgstr "Folgende Branches sind noch nicht mit »%s« zusammengeführt:"
 
 #: lib/branch_delete.tcl:131
 #, tcl-format
 msgid " - %s:"
-msgstr ""
+msgstr " - %s:"
 
 #: lib/branch_delete.tcl:141
 #, tcl-format
@@ -2648,7 +2633,7 @@ msgid ""
 "Failed to delete branches:\n"
 "%s"
 msgstr ""
-"Fehler beim Löschen der Zweige:\n"
+"Fehler beim Löschen der Branches:\n"
 "%s"
 
 #: lib/date.tcl:25
@@ -2685,9 +2670,9 @@ msgid "Garbage files"
 msgstr "Dateien im Mülleimer"
 
 #: lib/database.tcl:66
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "%s (%s): Database Statistics"
-msgstr "Datenbankstatistik"
+msgstr "%s (%s): Datenbankstatistik"
 
 #: lib/database.tcl:72
 msgid "Compressing the object database"
@@ -2707,37 +2692,37 @@ msgid ""
 "\n"
 "Compress the database now?"
 msgstr ""
-"Dieses Projektarchiv enthält ungefähr %i nicht verknüpfte Objekte.\n"
+"Dieses Repository enthält ungefähr %i nicht verknüpfte Objekte.\n"
 "\n"
-"Für eine optimale Performance wird empfohlen, die Datenbank des "
-"Projektarchivs zu komprimieren.\n"
+"Für eine optimale Performance wird empfohlen, die Datenbank des Repository "
+"zu komprimieren.\n"
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
 msgstr ""
-"Sie müssen die obigen Fehler zuerst beheben, bevor Sie eintragen können."
+"Sie müssen die obigen Fehler zuerst beheben, bevor Sie committen können."
 
 #: lib/error.tcl:116
 #, tcl-format
 msgid "%s (%s): error"
-msgstr ""
+msgstr "%s (%s): Fehler"
 
 #: lib/merge.tcl:13
 msgid ""
@@ -2747,7 +2732,7 @@ msgid ""
 msgstr ""
 "Zusammenführen kann nicht gleichzeitig mit Nachbessern durchgeführt werden.\n"
 "\n"
-"Sie müssen zuerst die Nachbesserungs-Version abschließen, bevor Sie "
+"Sie müssen zuerst den Nachbesserungs-Commit abschließen, bevor Sie "
 "zusammenführen können.\n"
 
 #: lib/merge.tcl:27
@@ -2759,9 +2744,9 @@ msgid ""
 "\n"
 "The rescan will be automatically started now.\n"
 msgstr ""
-"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
+"Der letzte geladene Status stimmt nicht mehr mit dem Repository überein.\n"
 "\n"
-"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
+"Ein anderes Git-Programm hat das Repository seit dem letzten Laden "
 "geändert.  Vor einem Zusammenführen muss neu geladen werden.\n"
 "\n"
 "Es wird gleich neu geladen.\n"
@@ -2778,10 +2763,11 @@ msgid ""
 msgstr ""
 "Zusammenführung mit Konflikten.\n"
 "\n"
-"Die Datei »%s« enthält Konflikte beim Zusammenführen. Sie müssen diese "
-"Konflikte per Hand auflösen. Anschließend müssen Sie die Datei wieder "
-"bereitstellen und eintragen, um die Zusammenführung abzuschließen. Erst "
-"danach kann eine neue Zusammenführung begonnen werden.\n"
+"Die Datei »%s« enthält Konflikte beim Zusammenführen.\n"
+"\n"
+"Sie müssen diese Konflikte per Hand auflösen. Anschließend müssen Sie die "
+"Datei wieder bereitstellen und committen, um die Zusammenführung "
+"abzuschließen. Erst danach kann eine neue Zusammenführung begonnen werden.\n"
 
 #: lib/merge.tcl:55
 #, tcl-format
@@ -2795,10 +2781,11 @@ msgid ""
 msgstr ""
 "Es liegen Änderungen vor.\n"
 "\n"
-"Die Datei »%s« wurde geändert.  Sie sollten zuerst die bereitgestellte "
-"Version abschließen, bevor Sie eine Zusammenführung beginnen.  Mit dieser "
-"Reihenfolge können Sie mögliche Konflikte beim Zusammenführen wesentlich "
-"einfacher beheben oder abbrechen.\n"
+"Die Datei »%s« wurde geändert.\n"
+"\n"
+"Sie sollten zuerst den bereitgestellten Commit abschließen, bevor Sie eine "
+"Zusammenführung beginnen.  Mit dieser Reihenfolge können Sie mögliche "
+"Konflikte beim Zusammenführen wesentlich einfacher beheben oder abbrechen.\n"
 
 #: lib/merge.tcl:108
 #, tcl-format
@@ -2821,7 +2808,7 @@ msgstr "Zusammenführen fehlgeschlagen. Konfliktauflösung ist notwendig."
 #: lib/merge.tcl:156
 #, tcl-format
 msgid "%s (%s): Merge"
-msgstr ""
+msgstr "%s (%s): Zusammenführen"
 
 #: lib/merge.tcl:164
 #, tcl-format
@@ -2840,7 +2827,7 @@ msgid ""
 msgstr ""
 "Abbruch der Nachbesserung ist nicht möglich.\n"
 "\n"
-"Sie müssen die Nachbesserung der Version abschließen.\n"
+"Sie müssen die Nachbesserung diese Commits abschließen.\n"
 
 #: lib/merge.tcl:228
 msgid ""
@@ -2852,8 +2839,7 @@ msgid ""
 msgstr ""
 "Zusammenführen abbrechen?\n"
 "\n"
-"Wenn Sie abbrechen, gehen alle noch nicht eingetragenen Änderungen "
-"verloren.\n"
+"Wenn Sie abbrechen, gehen alle noch nicht committeten Änderungen verloren.\n"
 "\n"
 "Zusammenführen jetzt abbrechen?"
 
@@ -2865,12 +2851,11 @@ msgid ""
 "\n"
 "Continue with resetting the current changes?"
 msgstr ""
-"Änderungen zurücksetzen?\n"
+"Änderungen verwerfen?\n"
 "\n"
-"Wenn Sie zurücksetzen, gehen alle noch nicht eingetragenen Änderungen "
-"verloren.\n"
+"Alle noch nicht committeten Änderungen würden verloren gehen.\n"
 "\n"
-"Änderungen jetzt zurücksetzen?"
+"Änderungen jetzt verwerfen?"
 
 #: lib/merge.tcl:246
 msgid "Aborting"
@@ -2887,12 +2872,3 @@ msgstr "Abbruch fehlgeschlagen."
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
index 35764d1d22..4c5f233ee5 100644
--- a/po/glossary/de.po
+++ b/po/glossary/de.po
@@ -6,10 +6,11 @@
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui glossary\n"
-"POT-Creation-Date: 2008-01-07 21:20+0100\n"
-"PO-Revision-Date: 2008-02-16 21:48+0100\n"
+"POT-Creation-Date: 2020-01-26 22:26+0100\n"
+"PO-Revision-Date: 2020-02-09 21:22+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German \n"
+"Language: de_DE\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
@@ -19,6 +20,9 @@ msgid ""
 "English Term (Dear translator: This file will never be visible to the user!)"
 msgstr ""
 "Deutsche Übersetzung.\n"
+"Git-core glossary:\n"
+"  https://github.com/ruester/git-po-de/wiki/Translation-Guidelines\n"
+"\n"
 "Andere deutsche SCM:\n"
 "  http://tortoisesvn.net/docs/release/TortoiseSVN_de/index.html und http://"
 "tortoisesvn.tigris.org/svn/tortoisesvn/trunk/Languages/Tortoise_de.po "
@@ -32,33 +36,77 @@ msgstr ""
 "  http://rapidsvn.tigris.org/svn/rapidsvn/trunk/src/locale/de/rapidsvn.po "
 "(username=guest, password empty, schlecht)"
 
+#. "prematurely stop and abandon an operation"
+msgid "abort"
+msgstr "abbrechen"
+
 #. ""
 msgid "amend"
 msgstr "nachbessern (ergänzen)"
 
+#. "a commit that succeeds the current one in git's graph of commits (not necessarily directly)"
+msgid "ancestor"
+msgstr "Vorgänger-Commit"
+
 #. ""
 msgid "annotate"
 msgstr "annotieren"
 
+#. "The person who initially created (authored) a commit"
+msgid "author"
+msgstr "Autor"
+
+#. "a repository with only .git directory, without working directory"
+msgid "bare repository"
+msgstr "bloßes Projektarchiv"
+
+#. "a parent version of the current file"
+msgid "base"
+msgstr "Ursprung"
+
+#. ""
+msgid "bisect"
+msgstr "binäre Suche [noun], binäre Suche benutzen [verb]"
+
+#. "get the authors responsible for each line in a file"
+msgid "blame"
+msgstr "annotieren"
+
+#.      ""
+msgid "blob"
+msgstr "Blob"
+
 #. "A 'branch' is an active line of development."
 msgid "branch [noun]"
-msgstr "Zweig"
+msgstr "Branch"
 
 #. ""
 msgid "branch [verb]"
-msgstr "verzweigen"
+msgstr "branchen"
 
 #. ""
 msgid "checkout [noun]"
 msgstr ""
-"Arbeitskopie (Erstellung einer Arbeitskopie; Auscheck? Ausspielung? Abruf? "
-"Source Safe: Auscheckvorgang)"
+"Arbeitskopie (Checkout; Erstellung einer Arbeitskopie; Auscheck? Source "
+"Safe: Auscheckvorgang)"
 
 #. "The action of updating the working tree to a revision which was stored in the object database."
 msgid "checkout [verb]"
 msgstr ""
-"Arbeitskopie erstellen; Zweig umstellen [checkout a branch] (auschecken? "
-"ausspielen? abrufen? Source Safe: auschecken)"
+"Arbeitskopie erstellen; Branch auschecken [checkout a branch] (umstellen? "
+"Source Safe: auschecken)"
+
+#. "to select and apply a single commit to the current HEAD without merging"
+msgid "cherry-pick"
+msgstr "cherry-pick (pflücken?)"
+
+#. "a commit that directly succeeds the current one in git's graph of commits"
+msgid "child commit"
+msgstr "Kind-Commit"
+
+#. "clean the state of the git repository, often after manually stopped operation"
+msgid "cleanup"
+msgstr "aufräumen"
 
 #. ""
 msgid "clone [verb]"
@@ -66,39 +114,98 @@ msgstr "klonen"
 
 #. "A single point in the git history."
 msgid "commit [noun]"
-msgstr ""
-"Version; Eintragung; Änderung (Buchung?, Eintragung?, Übertragung?, "
-"Sendung?, Übergabe?, Einspielung?, Ablagevorgang?)"
+msgstr "Commit (Version?)"
 
 #. "The action of storing a new snapshot of the project's state in the git history."
 msgid "commit [verb]"
 msgstr ""
-"eintragen (TortoiseSVN: übertragen; Source Safe: einchecken; senden?, "
-"übergeben?, einspielen?, einpflegen?, ablegen?)"
+"committen (eintragen?, TortoiseSVN: übertragen; Source Safe: einchecken)"
+
+#. "a message that gets attached with any commit"
+msgid "commit message"
+msgstr "Commit-Beschreibung (Meldung?, Nachricht?; Source Safe: Kommentar)"
+
+#.   "The person who committed a commit (to the current branch), which might be different than the author."
+msgid "committer"
+msgstr "Committer"
+
+#. "a commit that precedes the current one in git's graph of commits (not necessarily directly)"
+msgid "descendant"
+msgstr "Nachfolger-Commit"
+
+#.       "checkout of a revision rather than some head"
+msgid "detached HEAD"
+msgstr "losgelöster HEAD / Branchspitze"
+
+#. "checkout of a revision rather than some head"
+msgid "detached checkout"
+msgstr "losgelöster Commit (von Branch losgelöster Commit?)"
 
 #. ""
 msgid "diff [noun]"
-msgstr "Vergleich (Source Safe: Unterschiede)"
+msgstr "Vergleich (Diff? Source Safe: Unterschiede)"
 
 #. ""
 msgid "diff [verb]"
 msgstr "vergleichen"
 
-#. "A fast-forward is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
-msgid "fast forward merge"
-msgstr "Schnellzusammenführung"
+#.   ""
+msgid "directory"
+msgstr "Verzeichnis"
+
+#. "A fast-forward merge is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
+msgid "fast-forward"
+msgstr "vorspulen"
 
 #. "Fetching a branch means to get the branch's head from a remote repository, to find out which objects are missing from the local object database, and to get them, too."
 msgid "fetch"
 msgstr "anfordern (holen?)"
 
+#. "any merge strategy that works on a file by file basis"
+msgid "file level merging"
+msgstr "Datei-basiertes zusammenführen"
+
+#.      ""
+msgid "file"
+msgstr "Datei"
+
+#. "the last revision in a branch"
+msgid "head"
+msgstr "HEAD / Branchspitze"
+
+#. "script that gets executed automatically on some event"
+msgid "hook"
+msgstr "Hook (in der dt. Informatik wohl als Einschubmethode bezeichnet)"
+
 #. "One context of consecutive lines in a whole patch, which consists of many such hunks"
 msgid "hunk"
-msgstr "Kontext"
+msgstr "Patch-Block (Kontext?)"
 
 #. "A collection of files. The index is a stored version of your working tree."
 msgid "index (in git-gui: staging area)"
-msgstr "Bereitstellung"
+msgstr ""
+"Bereitstellung (sofern der git index gemeint ist. In git-gui sowieso: "
+"staging area)"
+
+#. "the first checkout during a clone operation"
+msgid "initial checkout"
+msgstr "Erstellen der Arbeitskopie, auschecken"
+
+#. "The very first commit in a repository"
+msgid "initial commit"
+msgstr "Allererster Commit"
+
+#. "a branch that resides in the local git repository"
+msgid "local branch"
+msgstr "Lokaler Branch"
+
+#. "a Git object that is not part of any pack"
+msgid "loose object"
+msgstr "loses Objekt"
+
+#. "a branch called by convention 'master' that exists in a newly created git repository"
+msgid "master branch"
+msgstr "Master-Branch"
 
 #. "A successful merge results in the creation of a new commit representing the result of the merge."
 msgid "merge [noun]"
@@ -112,78 +219,212 @@ msgstr "zusammenführen"
 msgid "message"
 msgstr "Beschreibung (Meldung?, Nachricht?; Source Safe: Kommentar)"
 
-#. "Deletes all stale tracking branches under <name>. These stale branches have already been removed from the remote repository referenced by <name>, but are still locally available in 'remotes/<name>'."
+#. "a remote called by convention 'origin' that the current git repository has been cloned from"
+msgid "origin"
+msgstr "origin"
+
+#.       ""
+msgid "orphan commit"
+msgstr "verwaister Commit"
+
+#.  ""
+msgid "orphan reference"
+msgstr "verwaiste Referenz"
+
+#. "a file containing many git objects packed together"
+msgid "pack [noun]"
+msgstr "Pack-Datei"
+
+#.     "the process of creating a pack file"
+msgid "pack [verb]"
+msgstr "Pack-Datei erstellen"
+
+#. "a Git object part of some pack"
+msgid "packed object"
+msgstr "gepacktes Objekt"
+
+#. "a commit that directly precedes the current one in git's graph of commits"
+msgid "parent commit"
+msgstr "Eltern-Commit"
+
+msgid "patch"
+msgstr "Patch"
+
+#. "The path to a file"
+msgid "path"
+msgstr "Pfad"
+
+#. "Delete all stale tracking branches under <name>. These stale branches have already been removed from the remote repository referenced by <name>, but are still locally available in 'remotes/<name>'."
 msgid "prune"
-msgstr "aufräumen (entfernen?)"
+msgstr "veraltete Branches entfernen (aufräumen?, entfernen?)"
 
 #. "Pulling a branch means to fetch it and merge it."
 msgid "pull"
-msgstr "übernehmen (ziehen?)"
+msgstr ""
+"übernehmen (pull? ziehen? Vorsicht: zusammenführen = merge, aber pull kann "
+"auch rebase bewirken)"
 
 #. "Pushing a branch means to get the branch's head ref from a remote repository, and ... (well, can someone please explain it for mere mortals?)"
 msgid "push"
 msgstr "versenden (ausliefern? hochladen? verschicken? schieben?)"
 
+#. "The process of rebasing one set of commits on top of another branch's head"
+msgid "rebase [noun]"
+msgstr "der Rebase (das Umpflanzen)"
+
+#. "Re-apply one set of commits on top of another branch's head. Contrary to merge."
+msgid "rebase [verb]"
+msgstr "rebase (umpflanzen)"
+
 #. ""
 msgid "redo"
 msgstr "wiederholen"
 
-#. "An other repository ('remote'). One might have a set of remotes whose branches one tracks."
-msgid "remote"
-msgstr "Andere Archive (Gegenseite?, Entfernte?, Server?)"
+#.   ""
+msgid "reference"
+msgstr "Referenz"
+
+#. "the log file containing all states of the HEAD reference (in other words past pristine states of the working copy)"
+msgid "reflog"
+msgstr "Commit-Log, »reflog«"
+
+msgid "refmap"
+msgstr "Refmap"
+
+#. ""
+msgid "refspec"
+msgstr "Refspec"
+
+#. "The adjective for anything which is outside of the current (local) repository"
+msgid "remote [adj]"
+msgstr "Extern (Andere?, Gegenseite?, Entfernte?, Server?)"
+
+#.       "A branch in any other ('remote') repository"
+msgid "remote branch"
+msgstr "Externer branch"
+
+#.   "An other repository ('remote'). One might have a set of remotes whose branches one tracks."
+msgid "remote repository"
+msgstr "Externes Repository"
 
 #. "A collection of refs (?) together with an object database containing all objects which are reachable from the refs... (oops, you've lost me here. Again, please an explanation for mere mortals?)"
 msgid "repository"
-msgstr "Projektarchiv"
+msgstr "Repository"
 
 #. ""
 msgid "reset"
-msgstr "zurücksetzen (zurückkehren?)"
+msgstr "umsetzen (reset to commit), Änderungen verwerfen (reset to HEAD)"
+
+#. "decide which changes from alternative versions of a file should persist in Git"
+msgid "resolve (a conflict)"
+msgstr "auflösen (einen Konflikt)"
+
+#. "abandon changes and go to pristine version"
+msgid "revert changes"
+msgstr ""
+"verwerfen (bei git-reset bzw. checkout), zurücknehmen (bei git-revert, also "
+"mit neuem commit; umkehren?)"
 
 #. ""
 msgid "revert"
-msgstr "verwerfen (bei git-reset), revidieren (bei git-revert, also mit neuem commit)"
+msgstr ""
+"verwerfen (bei git-reset bzw. checkout), zurücknehmen (bei git-revert, also "
+"mit neuem commit; umkehren?)"
+
+#. "expression that signifies a revision in git"
+msgid "revision expression"
+msgstr "Version Regexp-Ausdruck"
 
 #. "A particular state of files and directories which was stored in the object database."
 msgid "revision"
-msgstr "Version (TortoiseSVN: Revision; Source Safe: Version)"
+msgstr ""
+"Version (aber was macht das Wort revision hier im Git?? TortoiseSVN: "
+"Revision; Source Safe: Version)"
 
 #. ""
 msgid "sign off"
-msgstr "abzeichnen (gegenzeichnen?, freizeichnen?, absegnen?)"
+msgstr "abzeichnen (signieren? gegenzeichnen?, freizeichnen?)"
 
-#. ""
+#.     "see: staging area. In some areas of git this is called 'index'."
+msgid "stage [noun], index"
+msgstr "Bereitstellung"
+
+#. "add some content of files and directories to the staging area in preparation for a commit"
+msgid "stage [verb]"
+msgstr "bereitstellen"
+
+#. "The place where changes from files are marked to be included for the next commit. In some areas of git this is called 'index'."
 msgid "staging area"
 msgstr "Bereitstellung"
 
+#. "The place (stack) where changes can be temporarily saved without committing"
+msgid "stash [noun]"
+msgstr "der Stash"
+
+#. "temporarily save changes in a stack without committing"
+msgid "stash [verb]"
+msgstr "in Stash speichern; \"stash\" benutzen"
+
 #. ""
 msgid "status"
 msgstr "Status"
 
-#. "A ref pointing to a tag or commit object"
+#. ""
+msgid "submodule"
+msgstr "Submodul (Untermodul?)"
+
+#. "A ref pointing to some commit object. In other words: A label on a specific commit."
 msgid "tag [noun]"
-msgstr "Markierung"
+msgstr "Tag (Markierung?)"
 
-#. ""
+#. "The process of creating a tag at a specific commit object"
 msgid "tag [verb]"
-msgstr "markieren"
+msgstr "taggen (markieren?)"
+
+#. "The person who created a tag"
+msgid "tagger"
+msgstr "Tag-Ersteller (Markierungs-Ersteller?)"
+
+#. "file whose content is tracked/not tracked by git"
+msgid "tracked/untracked"
+msgstr "versioniert/unversioniert"
 
 #. "A regular git branch that is used to follow changes from another repository."
 msgid "tracking branch"
-msgstr "Übernahmezweig"
+msgstr "Tracking-Branch (Verfolgungsbranch? Übernahmebranch?)"
+
+#. ""
+msgid "trailer"
+msgstr "Anhang"
+
+#. "1. tree object, 2. directory tree"
+msgid "tree"
+msgstr "1. Baum-Objekt, 2. Verzeichnisbaum"
 
 #. ""
 msgid "undo"
 msgstr "rückgängig"
 
+#. "Remove content of files from the staging area again so that it will not be part of the next commit"
+msgid "unstage"
+msgstr "aus Bereitstellung herausnehmen"
+
+#. "Retrieving the temporarily saved changes back again from the stash"
+msgid "unstash [verb]"
+msgstr "aus Stash zurückladen"
+
 #. ""
 msgid "update"
 msgstr "aktualisieren"
 
+#. ""
+msgid "upstream branch"
+msgstr "Upstream-Branch"
+
 #. ""
 msgid "verify"
 msgstr "überprüfen"
 
 #. "The tree of actual checked out files."
-msgid "working copy, working tree"
+msgid "working directory, working copy, working tree"
 msgstr "Arbeitskopie"
-- 
gitgitgadget
