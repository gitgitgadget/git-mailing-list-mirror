Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25ABC2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 22:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A93920715
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 22:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAD8DnC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgBIWBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:01:14 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46296 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgBIWBM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 17:01:12 -0500
Received: by mail-wr1-f46.google.com with SMTP id z7so5120009wrl.13
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 14:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OS3liMEQbIStnkQCgwo9DtYoXLJCECiWegoHGQa5Ec0=;
        b=mAD8DnC5KDW1AyM3bmpjQ+EOANW6bBYHfDZdSzKnMzPTZOdhNiJ5jgfKzTIxUrMn+H
         8+uOglyRw1H+dtvmxsVgCK61TXN06AXPE4c7YaPLig/U7PkZn0fYwkQ4IQulPHnmT48f
         KQjXVc7QluRVfvpS4UHFMqLV0FCiJeGWcexIAVaiptqBMRD45DgzJX+Nf5dn4/hkHw8j
         oEh9XeVnV0PCn7ZLZ6K9iCj4aRWezKLRxQ4s97P4di50+PjAQkZEmAQ7TM2nCaXUgBv0
         gAuZ1QZNYc26jG0QjmR8LFNEZoOltAkK2jD82wlex/J4yRztlB8Ds+z7Yf+kacCFDmhE
         OLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OS3liMEQbIStnkQCgwo9DtYoXLJCECiWegoHGQa5Ec0=;
        b=KpbuX0Ema37EJAtzoqUpAviD3ihBGec3Cy0PdlV/HysI+fuYd7+icS5kK845YBtqA/
         nA5GfhaU3cN3aO06roTtivAuDXiVdX3Q1/7Eho01h6B9LH2vwDBrxl4wvV28Z2po+O4d
         CUkLRSpCvCPRpZmQCiGV29oIflXiEf/qoaqr265OFMlX04/TSloRoK2s+SgkaaZygHM4
         ltfpQjKdXQDm+cWJDKp1LkPmoJQ1v7fRZEE7kiVW0lbG+fn5Twf1PrlIeMc3HNM1Ix/V
         jhgj6OpNxKyEvT3IHY5nCfpHxjckLqlyIVU1v3LO4kYh03dCuzR4BTLONkT20TlboExI
         8AfA==
X-Gm-Message-State: APjAAAXXgSzb0r5d5CXvniniDH3k0vZWqVh8MM+YfntjC04TK/OCRpv6
        iYt8OmoEf3pIlBEzGrn+6xM1FnH+
X-Google-Smtp-Source: APXvYqwRnxa+ercEyB0hRI/Z4oCmCUYozcGRO36pi4VCVJbprHWddmN6Gw+nDEatFt/HZ1NzL9k3GA==
X-Received: by 2002:a5d:4a0f:: with SMTP id m15mr12747553wrq.415.1581285661654;
        Sun, 09 Feb 2020 14:01:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15sm13439741wrp.4.2020.02.09.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:01:00 -0800 (PST)
Message-Id: <f1ab13b08a28559b1fa173496e6feaa6c6bc6aac.1581285658.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.525.v2.git.1581285658.gitgitgadget@gmail.com>
References: <pull.525.git.1579905218.gitgitgadget@gmail.com>
        <pull.525.v2.git.1581285658.gitgitgadget@gmail.com>
From:   "Christian Stimming via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Feb 2020 22:00:56 +0000
Subject: [PATCH v2 1/3] git-gui: update pot template and German translation to
 current source code
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

No content changes so far, only the preparation for subsequent edits.

Signed-off-by: Christian Stimming <christian@cstimming.de>
---
 po/de.po       | 3520 ++++++++++++++++++++++++++----------------------
 po/git-gui.pot | 2526 ++++++++++++++++++----------------
 2 files changed, 3312 insertions(+), 2734 deletions(-)

diff --git a/po/de.po b/po/de.po
index baebff2fff..6bbcb1d469 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7,41 +7,42 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2010-01-26 22:22+0100\n"
+"POT-Creation-Date: 2020-02-08 22:54+0100\n"
 "PO-Revision-Date: 2010-01-26 22:25+0100\n"
 "Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
 "Language-Team: German\n"
+"Language: \n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
 
-#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.sh:903
-#: git-gui.sh:922
-msgid "git-gui: fatal error"
-msgstr "git-gui: Programmfehler"
-
-#: git-gui.sh:743
+#: git-gui.sh:847
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "Ungültige Zeichensatz-Angabe in %s:"
 
-#: git-gui.sh:779
+#: git-gui.sh:901
 msgid "Main Font"
 msgstr "Programmschriftart"
 
-#: git-gui.sh:780
+#: git-gui.sh:902
 msgid "Diff/Console Font"
 msgstr "Vergleich-Schriftart"
 
-#: git-gui.sh:794
+#: git-gui.sh:917 git-gui.sh:931 git-gui.sh:944 git-gui.sh:1034 git-gui.sh:1053
+#: git-gui.sh:3212
+msgid "git-gui: fatal error"
+msgstr "git-gui: Programmfehler"
+
+#: git-gui.sh:918
 msgid "Cannot find git in PATH."
 msgstr "Git kann im PATH nicht gefunden werden."
 
-#: git-gui.sh:821
+#: git-gui.sh:945
 msgid "Cannot parse Git version string:"
 msgstr "Git Versionsangabe kann nicht erkannt werden:"
 
-#: git-gui.sh:839
+#: git-gui.sh:970
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -60,479 +61,532 @@ msgstr ""
 "\n"
 "Soll angenommen werden, »%s« sei Version 1.5.0?\n"
 
-#: git-gui.sh:1128
+#: git-gui.sh:1267
 msgid "Git directory not found:"
 msgstr "Git-Verzeichnis nicht gefunden:"
 
-#: git-gui.sh:1146
+#: git-gui.sh:1301
 msgid "Cannot move to top of working directory:"
 msgstr ""
 "Es konnte nicht in das oberste Verzeichnis der Arbeitskopie gewechselt "
 "werden:"
 
-#: git-gui.sh:1154
+#: git-gui.sh:1309
 msgid "Cannot use bare repository:"
 msgstr "Bloßes Projektarchiv kann nicht benutzt werden:"
 
-#: git-gui.sh:1162
+#: git-gui.sh:1317
 msgid "No working directory"
 msgstr "Kein Arbeitsverzeichnis"
 
-#: git-gui.sh:1334 lib/checkout_op.tcl:306
+#: git-gui.sh:1491 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr "Dateistatus aktualisieren..."
 
-#: git-gui.sh:1390
+#: git-gui.sh:1551
 msgid "Scanning for modified files ..."
 msgstr "Nach geänderten Dateien suchen..."
 
-#: git-gui.sh:1454
+#: git-gui.sh:1629
 msgid "Calling prepare-commit-msg hook..."
-msgstr "Aufrufen der Eintragen-Vorbereiten-Kontrolle (»prepare-commit hook«)..."
+msgstr ""
+"Aufrufen der Eintragen-Vorbereiten-Kontrolle (»prepare-commit hook«)..."
 
-#: git-gui.sh:1471
+#: git-gui.sh:1646
 msgid "Commit declined by prepare-commit-msg hook."
 msgstr ""
 "Eintragen abgelehnt durch Eintragen-Vorbereiten-Kontrolle (»prepare-commit "
 "hook«)."
 
-#: git-gui.sh:1629 lib/browser.tcl:246
+#: git-gui.sh:1804 lib/browser.tcl:252
 msgid "Ready."
 msgstr "Bereit."
 
-#: git-gui.sh:1787
+#: git-gui.sh:1968
 #, tcl-format
-msgid "Displaying only %s of %s files."
-msgstr "Nur %s von %s Dateien werden angezeigt."
+msgid ""
+"Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files."
+msgstr ""
 
-#: git-gui.sh:1913
+#: git-gui.sh:2091
 msgid "Unmodified"
 msgstr "Unverändert"
 
-#: git-gui.sh:1915
+#: git-gui.sh:2093
 msgid "Modified, not staged"
 msgstr "Verändert, nicht bereitgestellt"
 
-#: git-gui.sh:1916 git-gui.sh:1924
+#: git-gui.sh:2094 git-gui.sh:2106
 msgid "Staged for commit"
 msgstr "Bereitgestellt zum Eintragen"
 
-#: git-gui.sh:1917 git-gui.sh:1925
+#: git-gui.sh:2095 git-gui.sh:2107
 msgid "Portions staged for commit"
 msgstr "Teilweise bereitgestellt zum Eintragen"
 
-#: git-gui.sh:1918 git-gui.sh:1926
+#: git-gui.sh:2096 git-gui.sh:2108
 msgid "Staged for commit, missing"
 msgstr "Bereitgestellt zum Eintragen, fehlend"
 
-#: git-gui.sh:1920
+#: git-gui.sh:2098
 msgid "File type changed, not staged"
 msgstr "Dateityp geändert, nicht bereitgestellt"
 
-#: git-gui.sh:1921
+#: git-gui.sh:2099 git-gui.sh:2100
+#, fuzzy
+msgid "File type changed, old type staged for commit"
+msgstr "Dateityp geändert, nicht bereitgestellt"
+
+#: git-gui.sh:2101
 msgid "File type changed, staged"
 msgstr "Dateityp geändert, bereitgestellt"
 
-#: git-gui.sh:1923
+#: git-gui.sh:2102
+#, fuzzy
+msgid "File type change staged, modification not staged"
+msgstr "Dateityp geändert, nicht bereitgestellt"
+
+#: git-gui.sh:2103
+#, fuzzy
+msgid "File type change staged, file missing"
+msgstr "Dateityp geändert, bereitgestellt"
+
+#: git-gui.sh:2105
 msgid "Untracked, not staged"
 msgstr "Nicht unter Versionskontrolle, nicht bereitgestellt"
 
-#: git-gui.sh:1928
+#: git-gui.sh:2110
 msgid "Missing"
 msgstr "Fehlend"
 
-#: git-gui.sh:1929
+#: git-gui.sh:2111
 msgid "Staged for removal"
 msgstr "Bereitgestellt zum Löschen"
 
-#: git-gui.sh:1930
+#: git-gui.sh:2112
 msgid "Staged for removal, still present"
 msgstr "Bereitgestellt zum Löschen, trotzdem vorhanden"
 
-#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
-#: git-gui.sh:1936 git-gui.sh:1937
+#: git-gui.sh:2114 git-gui.sh:2115 git-gui.sh:2116 git-gui.sh:2117
+#: git-gui.sh:2118 git-gui.sh:2119
 msgid "Requires merge resolution"
 msgstr "Konfliktauflösung nötig"
 
-#: git-gui.sh:1972
-msgid "Starting gitk... please wait..."
-msgstr "Gitk wird gestartet... bitte warten."
-
-#: git-gui.sh:1984
+#: git-gui.sh:2164
 msgid "Couldn't find gitk in PATH"
 msgstr "Gitk kann im PATH nicht gefunden werden."
 
-#: git-gui.sh:2043
+#: git-gui.sh:2210 git-gui.sh:2245
+#, fuzzy, tcl-format
+msgid "Starting %s... please wait..."
+msgstr "Gitk wird gestartet... bitte warten."
+
+#: git-gui.sh:2224
 msgid "Couldn't find git gui in PATH"
 msgstr "»Git gui« kann im PATH nicht gefunden werden."
 
-#: git-gui.sh:2455 lib/choose_repository.tcl:36
+#: git-gui.sh:2726 lib/choose_repository.tcl:53
 msgid "Repository"
 msgstr "Projektarchiv"
 
-#: git-gui.sh:2456
+#: git-gui.sh:2727
 msgid "Edit"
 msgstr "Bearbeiten"
 
-#: git-gui.sh:2458 lib/choose_rev.tcl:561
+#: git-gui.sh:2729 lib/choose_rev.tcl:567
 msgid "Branch"
 msgstr "Zweig"
 
-#: git-gui.sh:2461 lib/choose_rev.tcl:548
+#: git-gui.sh:2732 lib/choose_rev.tcl:554
 msgid "Commit@@noun"
 msgstr "Version"
 
-#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+#: git-gui.sh:2735 lib/merge.tcl:127 lib/merge.tcl:174
 msgid "Merge"
 msgstr "Zusammenführen"
 
-#: git-gui.sh:2465 lib/choose_rev.tcl:557
+#: git-gui.sh:2736 lib/choose_rev.tcl:563
 msgid "Remote"
 msgstr "Externe Archive"
 
-#: git-gui.sh:2468
+#: git-gui.sh:2739
 msgid "Tools"
 msgstr "Werkzeuge"
 
-#: git-gui.sh:2477
+#: git-gui.sh:2748
 msgid "Explore Working Copy"
 msgstr "Arbeitskopie im Dateimanager"
 
-#: git-gui.sh:2483
+#: git-gui.sh:2763
+msgid "Git Bash"
+msgstr ""
+
+#: git-gui.sh:2772
 msgid "Browse Current Branch's Files"
 msgstr "Aktuellen Zweig durchblättern"
 
-#: git-gui.sh:2487
+#: git-gui.sh:2776
 msgid "Browse Branch Files..."
 msgstr "Einen Zweig durchblättern..."
 
-#: git-gui.sh:2492
+#: git-gui.sh:2781
 msgid "Visualize Current Branch's History"
 msgstr "Aktuellen Zweig darstellen"
 
-#: git-gui.sh:2496
+#: git-gui.sh:2785
 msgid "Visualize All Branch History"
 msgstr "Alle Zweige darstellen"
 
-#: git-gui.sh:2503
+#: git-gui.sh:2792
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Zweig »%s« durchblättern"
 
-#: git-gui.sh:2505
+#: git-gui.sh:2794
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Historie von »%s« darstellen"
 
-#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2799 lib/database.tcl:40
 msgid "Database Statistics"
 msgstr "Datenbankstatistik"
 
-#: git-gui.sh:2513 lib/database.tcl:34
+#: git-gui.sh:2802 lib/database.tcl:33
 msgid "Compress Database"
 msgstr "Datenbank komprimieren"
 
-#: git-gui.sh:2516
+#: git-gui.sh:2805
 msgid "Verify Database"
 msgstr "Datenbank überprüfen"
 
-#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
-#: lib/shortcut.tcl:40 lib/shortcut.tcl:72
+#: git-gui.sh:2812 git-gui.sh:2816 git-gui.sh:2820
 msgid "Create Desktop Icon"
 msgstr "Desktop-Icon erstellen"
 
-#: git-gui.sh:2539 lib/choose_repository.tcl:183 lib/choose_repository.tcl:191
+#: git-gui.sh:2828 lib/choose_repository.tcl:209 lib/choose_repository.tcl:217
 msgid "Quit"
 msgstr "Beenden"
 
-#: git-gui.sh:2547
+#: git-gui.sh:2836
 msgid "Undo"
 msgstr "Rückgängig"
 
-#: git-gui.sh:2550
+#: git-gui.sh:2839
 msgid "Redo"
 msgstr "Wiederholen"
 
-#: git-gui.sh:2554 git-gui.sh:3109
+#: git-gui.sh:2843 git-gui.sh:3461
 msgid "Cut"
 msgstr "Ausschneiden"
 
-#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
+#: git-gui.sh:2846 git-gui.sh:3464 git-gui.sh:3540 git-gui.sh:3633
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "Kopieren"
 
-#: git-gui.sh:2560 git-gui.sh:3115
+#: git-gui.sh:2849 git-gui.sh:3467
 msgid "Paste"
 msgstr "Einfügen"
 
-#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
-#: lib/remote_branch_delete.tcl:38
+#: git-gui.sh:2852 git-gui.sh:3470 lib/remote_branch_delete.tcl:39
+#: lib/branch_delete.tcl:28
 msgid "Delete"
 msgstr "Löschen"
 
-#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
+#: git-gui.sh:2856 git-gui.sh:3474 git-gui.sh:3637 lib/console.tcl:71
 msgid "Select All"
 msgstr "Alle auswählen"
 
-#: git-gui.sh:2576
+#: git-gui.sh:2865
 msgid "Create..."
 msgstr "Erstellen..."
 
-#: git-gui.sh:2582
+#: git-gui.sh:2871
 msgid "Checkout..."
 msgstr "Umstellen..."
 
-#: git-gui.sh:2588
+#: git-gui.sh:2877
 msgid "Rename..."
 msgstr "Umbenennen..."
 
-#: git-gui.sh:2593
+#: git-gui.sh:2882
 msgid "Delete..."
 msgstr "Löschen..."
 
-#: git-gui.sh:2598
+#: git-gui.sh:2887
 msgid "Reset..."
 msgstr "Zurücksetzen..."
 
-#: git-gui.sh:2608
+#: git-gui.sh:2897
 msgid "Done"
 msgstr "Fertig"
 
-#: git-gui.sh:2610
+#: git-gui.sh:2899
 msgid "Commit@@verb"
 msgstr "Eintragen"
 
-#: git-gui.sh:2619 git-gui.sh:3050
-msgid "New Commit"
-msgstr "Neue Version"
-
-#: git-gui.sh:2627 git-gui.sh:3057
+#: git-gui.sh:2908 git-gui.sh:3400
 msgid "Amend Last Commit"
 msgstr "Letzte nachbessern"
 
-#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2918 git-gui.sh:3361 lib/remote_branch_delete.tcl:101
 msgid "Rescan"
 msgstr "Neu laden"
 
-#: git-gui.sh:2643
+#: git-gui.sh:2924
 msgid "Stage To Commit"
 msgstr "Zum Eintragen bereitstellen"
 
-#: git-gui.sh:2649
+#: git-gui.sh:2930
 msgid "Stage Changed Files To Commit"
 msgstr "Geänderte Dateien bereitstellen"
 
-#: git-gui.sh:2655
+#: git-gui.sh:2936
 msgid "Unstage From Commit"
 msgstr "Aus der Bereitstellung herausnehmen"
 
-#: git-gui.sh:2661 lib/index.tcl:412
+#: git-gui.sh:2942 lib/index.tcl:521
 msgid "Revert Changes"
 msgstr "Änderungen verwerfen"
 
-#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
+#: git-gui.sh:2950 git-gui.sh:3700 git-gui.sh:3731
 msgid "Show Less Context"
 msgstr "Weniger Zeilen anzeigen"
 
-#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
+#: git-gui.sh:2954 git-gui.sh:3704 git-gui.sh:3735
 msgid "Show More Context"
 msgstr "Mehr Zeilen anzeigen"
 
-#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
+#: git-gui.sh:2961 git-gui.sh:3374 git-gui.sh:3485
 msgid "Sign Off"
 msgstr "Abzeichnen"
 
-#: git-gui.sh:2696
+#: git-gui.sh:2977
 msgid "Local Merge..."
 msgstr "Lokales Zusammenführen..."
 
-#: git-gui.sh:2701
+#: git-gui.sh:2982
 msgid "Abort Merge..."
 msgstr "Zusammenführen abbrechen..."
 
-#: git-gui.sh:2713 git-gui.sh:2741
+#: git-gui.sh:2994 git-gui.sh:3022
 msgid "Add..."
 msgstr "Hinzufügen..."
 
-#: git-gui.sh:2717
+#: git-gui.sh:2998
 msgid "Push..."
 msgstr "Versenden..."
 
-#: git-gui.sh:2721
+#: git-gui.sh:3002
 msgid "Delete Branch..."
 msgstr "Zweig löschen..."
 
-#: git-gui.sh:2731 git-gui.sh:3292
+#: git-gui.sh:3012 git-gui.sh:3666
 msgid "Options..."
 msgstr "Optionen..."
 
-#: git-gui.sh:2742
+#: git-gui.sh:3023
 msgid "Remove..."
 msgstr "Entfernen..."
 
-#: git-gui.sh:2751 lib/choose_repository.tcl:50
+#: git-gui.sh:3032 lib/choose_repository.tcl:67
 msgid "Help"
 msgstr "Hilfe"
 
-#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
+#: git-gui.sh:3036 git-gui.sh:3040 lib/choose_repository.tcl:61
+#: lib/choose_repository.tcl:70 lib/about.tcl:14
 #, tcl-format
 msgid "About %s"
 msgstr "Über %s"
 
-#: git-gui.sh:2783
+#: git-gui.sh:3064
 msgid "Online Documentation"
 msgstr "Online-Dokumentation"
 
-#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.tcl:56
+#: git-gui.sh:3067 lib/choose_repository.tcl:64 lib/choose_repository.tcl:73
 msgid "Show SSH Key"
 msgstr "SSH-Schlüssel anzeigen"
 
-#: git-gui.sh:2893
+#: git-gui.sh:3097 git-gui.sh:3229
+msgid "usage:"
+msgstr ""
+
+#: git-gui.sh:3101 git-gui.sh:3233
+msgid "Usage"
+msgstr ""
+
+#: git-gui.sh:3182 lib/blame.tcl:575
+#, fuzzy
+msgid "Error"
+msgstr "Fehler"
+
+#: git-gui.sh:3213
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 "Fehler: Verzeichnis »%s« kann nicht gelesen werden: Datei oder Verzeichnis "
 "nicht gefunden"
 
-#: git-gui.sh:2926
+#: git-gui.sh:3246
 msgid "Current Branch:"
 msgstr "Aktueller Zweig:"
 
-#: git-gui.sh:2947
-msgid "Staged Changes (Will Commit)"
-msgstr "Bereitstellung (zum Eintragen)"
-
-#: git-gui.sh:2967
+#: git-gui.sh:3271
 msgid "Unstaged Changes"
 msgstr "Nicht bereitgestellte Änderungen"
 
-#: git-gui.sh:3017
+#: git-gui.sh:3293
+msgid "Staged Changes (Will Commit)"
+msgstr "Bereitstellung (zum Eintragen)"
+
+#: git-gui.sh:3367
 msgid "Stage Changed"
 msgstr "Alles bereitstellen"
 
-#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
+#: git-gui.sh:3386 lib/transport.tcl:137
 msgid "Push"
 msgstr "Versenden"
 
-#: git-gui.sh:3071
+#: git-gui.sh:3413
 msgid "Initial Commit Message:"
 msgstr "Erste Versionsbeschreibung:"
 
-#: git-gui.sh:3072
+#: git-gui.sh:3414
 msgid "Amended Commit Message:"
 msgstr "Nachgebesserte Beschreibung:"
 
-#: git-gui.sh:3073
+#: git-gui.sh:3415
 msgid "Amended Initial Commit Message:"
 msgstr "Nachgebesserte erste Beschreibung:"
 
-#: git-gui.sh:3074
+#: git-gui.sh:3416
 msgid "Amended Merge Commit Message:"
 msgstr "Nachgebesserte Zusammenführungs-Beschreibung:"
 
-#: git-gui.sh:3075
+#: git-gui.sh:3417
 msgid "Merge Commit Message:"
 msgstr "Zusammenführungs-Beschreibung:"
 
-#: git-gui.sh:3076
+#: git-gui.sh:3418
 msgid "Commit Message:"
 msgstr "Versionsbeschreibung:"
 
-#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
+#: git-gui.sh:3477 git-gui.sh:3641 lib/console.tcl:73
 msgid "Copy All"
 msgstr "Alle kopieren"
 
-#: git-gui.sh:3149 lib/blame.tcl:104
+#: git-gui.sh:3501 lib/blame.tcl:106
 msgid "File:"
 msgstr "Datei:"
 
-#: git-gui.sh:3255
+#: git-gui.sh:3549 lib/choose_repository.tcl:1100
+msgid "Open"
+msgstr "Öffnen"
+
+#: git-gui.sh:3629
 msgid "Refresh"
 msgstr "Aktualisieren"
 
-#: git-gui.sh:3276
+#: git-gui.sh:3650
 msgid "Decrease Font Size"
 msgstr "Schriftgröße verkleinern"
 
-#: git-gui.sh:3280
+#: git-gui.sh:3654
 msgid "Increase Font Size"
 msgstr "Schriftgröße vergrößern"
 
-#: git-gui.sh:3288 lib/blame.tcl:281
+#: git-gui.sh:3662 lib/blame.tcl:296
 msgid "Encoding"
 msgstr "Zeichenkodierung"
 
-#: git-gui.sh:3299
+#: git-gui.sh:3673
 msgid "Apply/Reverse Hunk"
 msgstr "Kontext anwenden/umkehren"
 
-#: git-gui.sh:3304
+#: git-gui.sh:3678
 msgid "Apply/Reverse Line"
 msgstr "Zeile anwenden/umkehren"
 
-#: git-gui.sh:3323
+#: git-gui.sh:3684 git-gui.sh:3794 git-gui.sh:3805
+#, fuzzy
+msgid "Revert Hunk"
+msgstr "Kontext anwenden/umkehren"
+
+#: git-gui.sh:3689 git-gui.sh:3801 git-gui.sh:3812
+#, fuzzy
+msgid "Revert Line"
+msgstr "Änderungen verwerfen"
+
+#: git-gui.sh:3694 git-gui.sh:3791
+msgid "Undo Last Revert"
+msgstr ""
+
+#: git-gui.sh:3713
 msgid "Run Merge Tool"
 msgstr "Zusammenführungswerkzeug"
 
-#: git-gui.sh:3328
+#: git-gui.sh:3718
 msgid "Use Remote Version"
 msgstr "Externe Version benutzen"
 
-#: git-gui.sh:3332
+#: git-gui.sh:3722
 msgid "Use Local Version"
 msgstr "Lokale Version benutzen"
 
-#: git-gui.sh:3336
+#: git-gui.sh:3726
 msgid "Revert To Base"
 msgstr "Ursprüngliche Version benutzen"
 
-#: git-gui.sh:3354
+#: git-gui.sh:3744
 msgid "Visualize These Changes In The Submodule"
 msgstr "Diese Änderungen im Untermodul darstellen"
 
-#: git-gui.sh:3358
+#: git-gui.sh:3748
 msgid "Visualize Current Branch History In The Submodule"
 msgstr "Aktuellen Zweig im Untermodul darstellen"
 
-#: git-gui.sh:3362
+#: git-gui.sh:3752
 msgid "Visualize All Branch History In The Submodule"
 msgstr "Alle Zweige im Untermodul darstellen"
 
-#: git-gui.sh:3367
+#: git-gui.sh:3757
 msgid "Start git gui In The Submodule"
 msgstr "Git gui im Untermodul starten"
 
-#: git-gui.sh:3389
+#: git-gui.sh:3793
 msgid "Unstage Hunk From Commit"
 msgstr "Kontext aus Bereitstellung herausnehmen"
 
-#: git-gui.sh:3391
+#: git-gui.sh:3797
 msgid "Unstage Lines From Commit"
 msgstr "Zeilen aus der Bereitstellung herausnehmen"
 
-#: git-gui.sh:3393
+#: git-gui.sh:3798 git-gui.sh:3809
+#, fuzzy
+msgid "Revert Lines"
+msgstr "Änderungen verwerfen"
+
+#: git-gui.sh:3800
 msgid "Unstage Line From Commit"
 msgstr "Zeile aus der Bereitstellung herausnehmen"
 
-#: git-gui.sh:3396
+#: git-gui.sh:3804
 msgid "Stage Hunk For Commit"
 msgstr "Kontext zur Bereitstellung hinzufügen"
 
-#: git-gui.sh:3398
+#: git-gui.sh:3808
 msgid "Stage Lines For Commit"
 msgstr "Zeilen zur Bereitstellung hinzufügen"
 
-#: git-gui.sh:3400
+#: git-gui.sh:3811
 msgid "Stage Line For Commit"
 msgstr "Zeile zur Bereitstellung hinzufügen"
 
-#: git-gui.sh:3424
+#: git-gui.sh:3861
 msgid "Initializing..."
 msgstr "Initialisieren..."
 
-#: git-gui.sh:3541
+#: git-gui.sh:4017
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -548,7 +602,7 @@ msgstr ""
 "von %s an Git weitergegeben werden:\n"
 "\n"
 
-#: git-gui.sh:3570
+#: git-gui.sh:4046
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -558,7 +612,7 @@ msgstr ""
 "Dies ist ein bekanntes Problem der Tcl-Version, die\n"
 "in Cygwin mitgeliefert wird."
 
-#: git-gui.sh:3575
+#: git-gui.sh:4051
 #, tcl-format
 msgid ""
 "\n"
@@ -574,341 +628,183 @@ msgstr ""
 "gewünschten Werte für die Einstellung user.name und \n"
 "user.email in Ihre Datei ~/.gitconfig einfügen.\n"
 
-#: lib/about.tcl:26
-msgid "git-gui - a graphical user interface for Git."
-msgstr "git-gui - eine grafische Oberfläche für Git."
-
-#: lib/blame.tcl:72
-msgid "File Viewer"
-msgstr "Datei-Browser"
-
-#: lib/blame.tcl:78
-msgid "Commit:"
-msgstr "Version:"
-
-#: lib/blame.tcl:271
-msgid "Copy Commit"
-msgstr "Version kopieren"
-
-#: lib/blame.tcl:275
-msgid "Find Text..."
-msgstr "Text suchen..."
-
-#: lib/blame.tcl:284
-msgid "Do Full Copy Detection"
-msgstr "Volle Kopie-Erkennung"
+#: lib/spellcheck.tcl:57
+msgid "Unsupported spell checker"
+msgstr "Rechtschreibprüfungsprogramm nicht unterstützt"
 
-#: lib/blame.tcl:288
-msgid "Show History Context"
-msgstr "Historien-Kontext anzeigen"
+#: lib/spellcheck.tcl:65
+msgid "Spell checking is unavailable"
+msgstr "Rechtschreibprüfung nicht verfügbar"
 
-#: lib/blame.tcl:291
-msgid "Blame Parent Commit"
-msgstr "Elternversion annotieren"
+#: lib/spellcheck.tcl:68
+msgid "Invalid spell checking configuration"
+msgstr "Unbenutzbare Konfiguration der Rechtschreibprüfung"
 
-#: lib/blame.tcl:450
+#: lib/spellcheck.tcl:70
 #, tcl-format
-msgid "Reading %s..."
-msgstr "%s lesen..."
-
-#: lib/blame.tcl:557
-msgid "Loading copy/move tracking annotations..."
-msgstr "Annotierungen für Kopieren/Verschieben werden geladen..."
-
-#: lib/blame.tcl:577
-msgid "lines annotated"
-msgstr "Zeilen annotiert"
+msgid "Reverting dictionary to %s."
+msgstr "Wörterbuch auf %s zurückgesetzt."
 
-#: lib/blame.tcl:769
-msgid "Loading original location annotations..."
-msgstr "Annotierungen für ursprünglichen Ort werden geladen..."
+#: lib/spellcheck.tcl:73
+msgid "Spell checker silently failed on startup"
+msgstr "Rechtschreibprüfungsprogramm mit Fehler abgebrochen"
 
-#: lib/blame.tcl:772
-msgid "Annotation complete."
-msgstr "Annotierung vollständig."
+#: lib/spellcheck.tcl:80
+msgid "Unrecognized spell checker"
+msgstr "Unbekanntes Rechtschreibprüfungsprogramm"
 
-#: lib/blame.tcl:802
-msgid "Busy"
-msgstr "Verarbeitung läuft"
+#: lib/spellcheck.tcl:186
+msgid "No Suggestions"
+msgstr "Keine Vorschläge"
 
-#: lib/blame.tcl:803
-msgid "Annotation process is already running."
-msgstr "Annotierung läuft bereits."
+#: lib/spellcheck.tcl:388
+msgid "Unexpected EOF from spell checker"
+msgstr "Unerwartetes EOF vom Rechtschreibprüfungsprogramm"
 
-#: lib/blame.tcl:842
-msgid "Running thorough copy detection..."
-msgstr "Intensive Kopie-Erkennung läuft..."
+#: lib/spellcheck.tcl:392
+msgid "Spell Checker Failed"
+msgstr "Rechtschreibprüfung fehlgeschlagen"
 
-#: lib/blame.tcl:910
-msgid "Loading annotation..."
-msgstr "Annotierung laden..."
+#: lib/transport.tcl:6 lib/remote_add.tcl:132
+#, tcl-format
+msgid "fetch %s"
+msgstr "»%s« anfordern"
 
-#: lib/blame.tcl:963
-msgid "Author:"
-msgstr "Autor:"
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "Neue Änderungen von »%s« holen"
 
-#: lib/blame.tcl:967
-msgid "Committer:"
-msgstr "Eintragender:"
+#: lib/transport.tcl:18
+#, tcl-format
+msgid "remote prune %s"
+msgstr "Aufräumen von »%s«"
 
-#: lib/blame.tcl:972
-msgid "Original File:"
-msgstr "Ursprüngliche Datei:"
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "Übernahmezweige aufräumen und entfernen, die in »%s« gelöscht wurden"
 
-#: lib/blame.tcl:1020
-msgid "Cannot find HEAD commit:"
-msgstr "Zweigspitze (»HEAD«) kann nicht gefunden werden:"
+#: lib/transport.tcl:25
+msgid "fetch all remotes"
+msgstr ""
 
-#: lib/blame.tcl:1075
-msgid "Cannot find parent commit:"
-msgstr "Elternversion kann nicht gefunden werden:"
+#: lib/transport.tcl:26
+#, fuzzy
+msgid "Fetching new changes from all remotes"
+msgstr "Neue Änderungen von »%s« holen"
 
-#: lib/blame.tcl:1090
-msgid "Unable to display parent"
-msgstr "Elternversion kann nicht angezeigt werden"
+#: lib/transport.tcl:40
+#, fuzzy
+msgid "remote prune all remotes"
+msgstr "Aufräumen von »%s«"
 
-#: lib/blame.tcl:1091 lib/diff.tcl:320
-msgid "Error loading diff:"
-msgstr "Fehler beim Laden des Vergleichs:"
+#: lib/transport.tcl:41
+#, fuzzy
+msgid "Pruning tracking branches deleted from all remotes"
+msgstr "Übernahmezweige aufräumen und entfernen, die in »%s« gelöscht wurden"
 
-#: lib/blame.tcl:1231
-msgid "Originally By:"
-msgstr "Ursprünglich von:"
+#: lib/transport.tcl:54 lib/transport.tcl:92 lib/transport.tcl:110
+#: lib/remote_add.tcl:162
+#, tcl-format
+msgid "push %s"
+msgstr "»%s« versenden..."
 
-#: lib/blame.tcl:1237
-msgid "In File:"
-msgstr "In Datei:"
+#: lib/transport.tcl:55
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "Änderungen nach »%s« versenden"
 
-#: lib/blame.tcl:1242
-msgid "Copied Or Moved Here By:"
-msgstr "Kopiert oder verschoben durch:"
+#: lib/transport.tcl:93
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "Spiegeln nach %s"
 
-#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
-msgid "Checkout Branch"
-msgstr "Auf Zweig umstellen"
+#: lib/transport.tcl:111
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "%s %s nach %s versenden"
 
-#: lib/branch_checkout.tcl:23
-msgid "Checkout"
-msgstr "Umstellen"
+#: lib/transport.tcl:132
+msgid "Push Branches"
+msgstr "Zweige versenden"
 
-#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
-#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:282
-#: lib/checkout_op.tcl:579 lib/choose_font.tcl:43 lib/merge.tcl:172
-#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.tcl:42
-#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
-#: lib/transport.tcl:108
+#: lib/transport.tcl:141 lib/checkout_op.tcl:580 lib/remote_add.tcl:34
+#: lib/browser.tcl:292 lib/branch_checkout.tcl:30 lib/branch_rename.tcl:32
+#: lib/choose_font.tcl:45 lib/option.tcl:127 lib/tools_dlg.tcl:41
+#: lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345 lib/remote_branch_delete.tcl:43
+#: lib/branch_create.tcl:37 lib/branch_delete.tcl:34 lib/merge.tcl:178
 msgid "Cancel"
 msgstr "Abbrechen"
 
-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:328
-msgid "Revision"
-msgstr "Version"
-
-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:280
-msgid "Options"
-msgstr "Optionen"
-
-#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
-msgid "Fetch Tracking Branch"
-msgstr "Übernahmezweig anfordern"
-
-#: lib/branch_checkout.tcl:44
-msgid "Detach From Local Branch"
-msgstr "Verbindung zu lokalem Zweig lösen"
-
-#: lib/branch_create.tcl:22
-msgid "Create Branch"
-msgstr "Zweig erstellen"
-
-#: lib/branch_create.tcl:27
-msgid "Create New Branch"
-msgstr "Neuen Zweig erstellen"
+#: lib/transport.tcl:147
+msgid "Source Branches"
+msgstr "Lokale Zweige"
 
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
-msgid "Create"
-msgstr "Erstellen"
+#: lib/transport.tcl:162
+msgid "Destination Repository"
+msgstr "Ziel-Projektarchiv"
 
-#: lib/branch_create.tcl:40
-msgid "Branch Name"
-msgstr "Zweigname"
+#: lib/transport.tcl:165 lib/remote_branch_delete.tcl:51
+msgid "Remote:"
+msgstr "Externes Archiv:"
 
-#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
-msgid "Name:"
-msgstr "Name:"
+#: lib/transport.tcl:187 lib/remote_branch_delete.tcl:72
+msgid "Arbitrary Location:"
+msgstr "Adresse:"
 
-#: lib/branch_create.tcl:58
-msgid "Match Tracking Branch Name"
-msgstr "Passend zu Übernahmezweig-Name"
+#: lib/transport.tcl:205
+msgid "Transfer Options"
+msgstr "Netzwerk-Einstellungen"
 
-#: lib/branch_create.tcl:66
-msgid "Starting Revision"
-msgstr "Anfangsversion"
+#: lib/transport.tcl:207
+msgid "Force overwrite existing branch (may discard changes)"
+msgstr ""
+"Überschreiben von existierenden Zweigen erzwingen (könnte Änderungen löschen)"
 
-#: lib/branch_create.tcl:72
-msgid "Update Existing Branch:"
-msgstr "Existierenden Zweig aktualisieren:"
+#: lib/transport.tcl:211
+msgid "Use thin pack (for slow network connections)"
+msgstr "Kompaktes Datenformat benutzen (für langsame Netzverbindungen)"
 
-#: lib/branch_create.tcl:75
-msgid "No"
-msgstr "Nein"
+#: lib/transport.tcl:215
+msgid "Include tags"
+msgstr "Mit Markierungen übertragen"
 
-#: lib/branch_create.tcl:80
-msgid "Fast Forward Only"
-msgstr "Nur Schnellzusammenführung"
+#: lib/transport.tcl:229
+#, tcl-format
+msgid "%s (%s): Push"
+msgstr ""
 
-#: lib/branch_create.tcl:85 lib/checkout_op.tcl:571
-msgid "Reset"
-msgstr "Zurücksetzen"
+#: lib/checkout_op.tcl:85
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "Änderungen »%s« von »%s« anfordern"
 
-#: lib/branch_create.tcl:97
-msgid "Checkout After Creation"
-msgstr "Arbeitskopie umstellen nach Erstellen"
+#: lib/checkout_op.tcl:133
+#, tcl-format
+msgid "fatal: Cannot resolve %s"
+msgstr "Fehler: »%s« kann nicht als Zweig oder Version erkannt werden"
 
-#: lib/branch_create.tcl:131
-msgid "Please select a tracking branch."
-msgstr "Bitte wählen Sie einen Übernahmezweig."
+#: lib/checkout_op.tcl:146 lib/sshkey.tcl:58 lib/console.tcl:81
+#: lib/database.tcl:30
+msgid "Close"
+msgstr "Schließen"
 
-#: lib/branch_create.tcl:140
+#: lib/checkout_op.tcl:175
 #, tcl-format
-msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "Übernahmezweig »%s« ist kein Zweig im externen Projektarchiv."
+msgid "Branch '%s' does not exist."
+msgstr "Zweig »%s« existiert nicht."
 
-#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
-msgid "Please supply a branch name."
-msgstr "Bitte geben Sie einen Zweignamen an."
+#: lib/checkout_op.tcl:194
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "Fehler beim Einrichten der vereinfachten git-pull für »%s«."
 
-#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
-#, tcl-format
-msgid "'%s' is not an acceptable branch name."
-msgstr "»%s« ist kein zulässiger Zweigname."
-
-#: lib/branch_delete.tcl:15
-msgid "Delete Branch"
-msgstr "Zweig löschen"
-
-#: lib/branch_delete.tcl:20
-msgid "Delete Local Branch"
-msgstr "Lokalen Zweig löschen"
-
-#: lib/branch_delete.tcl:37
-msgid "Local Branches"
-msgstr "Lokale Zweige"
-
-#: lib/branch_delete.tcl:52
-msgid "Delete Only If Merged Into"
-msgstr "Nur löschen, wenn zusammengeführt nach"
-
-#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
-msgid "Always (Do not perform merge checks)"
-msgstr "Immer (Keine Zusammenführungsprüfung)"
-
-#: lib/branch_delete.tcl:103
-#, tcl-format
-msgid "The following branches are not completely merged into %s:"
-msgstr "Folgende Zweige sind noch nicht mit »%s« zusammengeführt:"
-
-#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
-msgid ""
-"Recovering deleted branches is difficult.\n"
-"\n"
-"Delete the selected branches?"
-msgstr ""
-"Das Wiederherstellen von gelöschten Zweigen ist nur mit größerem Aufwand "
-"möglich.\n"
-"\n"
-"Sollen die ausgewählten Zweige gelöscht werden?"
-
-#: lib/branch_delete.tcl:141
-#, tcl-format
-msgid ""
-"Failed to delete branches:\n"
-"%s"
-msgstr ""
-"Fehler beim Löschen der Zweige:\n"
-"%s"
-
-#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
-msgid "Rename Branch"
-msgstr "Zweig umbenennen"
-
-#: lib/branch_rename.tcl:26
-msgid "Rename"
-msgstr "Umbenennen"
-
-#: lib/branch_rename.tcl:36
-msgid "Branch:"
-msgstr "Zweig:"
-
-#: lib/branch_rename.tcl:39
-msgid "New Name:"
-msgstr "Neuer Name:"
-
-#: lib/branch_rename.tcl:75
-msgid "Please select a branch to rename."
-msgstr "Bitte wählen Sie einen Zweig zum umbenennen."
-
-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
+#: lib/checkout_op.tcl:202 lib/branch_rename.tcl:102
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr "Zweig »%s« existiert bereits."
 
-#: lib/branch_rename.tcl:117
-#, tcl-format
-msgid "Failed to rename '%s'."
-msgstr "Fehler beim Umbenennen von »%s«."
-
-#: lib/browser.tcl:17
-msgid "Starting..."
-msgstr "Starten..."
-
-#: lib/browser.tcl:26
-msgid "File Browser"
-msgstr "Datei-Browser"
-
-#: lib/browser.tcl:126 lib/browser.tcl:143
-#, tcl-format
-msgid "Loading %s..."
-msgstr "%s laden..."
-
-#: lib/browser.tcl:187
-msgid "[Up To Parent]"
-msgstr "[Nach oben]"
-
-#: lib/browser.tcl:267 lib/browser.tcl:273
-msgid "Browse Branch Files"
-msgstr "Dateien des Zweigs durchblättern"
-
-#: lib/browser.tcl:278 lib/choose_repository.tcl:398
-#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
-#: lib/choose_repository.tcl:1028
-msgid "Browse"
-msgstr "Blättern"
-
-#: lib/checkout_op.tcl:85
-#, tcl-format
-msgid "Fetching %s from %s"
-msgstr "Änderungen »%s« von »%s« anfordern"
-
-#: lib/checkout_op.tcl:133
-#, tcl-format
-msgid "fatal: Cannot resolve %s"
-msgstr "Fehler: »%s« kann nicht als Zweig oder Version erkannt werden"
-
-#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
-#: lib/sshkey.tcl:53
-msgid "Close"
-msgstr "Schließen"
-
-#: lib/checkout_op.tcl:175
-#, tcl-format
-msgid "Branch '%s' does not exist."
-msgstr "Zweig »%s« existiert nicht."
-
-#: lib/checkout_op.tcl:194
-#, tcl-format
-msgid "Failed to configure simplified git-pull for '%s'."
-msgstr "Fehler beim Einrichten der vereinfachten git-pull für »%s«."
-
 #: lib/checkout_op.tcl:229
 #, tcl-format
 msgid ""
@@ -961,23 +857,23 @@ msgstr "Arbeitskopie umstellen auf »%s«..."
 msgid "files checked out"
 msgstr "Dateien aktualisiert"
 
-#: lib/checkout_op.tcl:376
+#: lib/checkout_op.tcl:377
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr ""
 "Auf Zweig »%s« umstellen abgebrochen (Zusammenführen der Dateien ist "
 "notwendig)."
 
-#: lib/checkout_op.tcl:377
+#: lib/checkout_op.tcl:378
 msgid "File level merge required."
 msgstr "Zusammenführen der Dateien ist notwendig."
 
-#: lib/checkout_op.tcl:381
+#: lib/checkout_op.tcl:382
 #, tcl-format
 msgid "Staying on branch '%s'."
 msgstr "Es wird auf Zweig »%s« verblieben."
 
-#: lib/checkout_op.tcl:452
+#: lib/checkout_op.tcl:453
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
@@ -989,32 +885,36 @@ msgstr ""
 "Wenn Sie auf einem Zweig arbeiten möchten, erstellen Sie bitte jetzt einen "
 "Zweig mit der Auswahl »Abgetrennte Arbeitskopie-Version«."
 
-#: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
+#: lib/checkout_op.tcl:504 lib/checkout_op.tcl:508
 #, tcl-format
 msgid "Checked out '%s'."
 msgstr "Umgestellt auf »%s«."
 
-#: lib/checkout_op.tcl:535
+#: lib/checkout_op.tcl:536
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
 msgstr "Zurücksetzen von »%s« nach »%s« wird folgende Versionen verwerfen:"
 
-#: lib/checkout_op.tcl:557
+#: lib/checkout_op.tcl:558
 msgid "Recovering lost commits may not be easy."
 msgstr ""
 "Verworfene Versionen können nur mit größerem Aufwand wiederhergestellt "
 "werden."
 
-#: lib/checkout_op.tcl:562
+#: lib/checkout_op.tcl:563
 #, tcl-format
 msgid "Reset '%s'?"
 msgstr "»%s« zurücksetzen?"
 
-#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
+#: lib/checkout_op.tcl:568 lib/tools_dlg.tcl:336 lib/merge.tcl:170
 msgid "Visualize"
 msgstr "Darstellen"
 
-#: lib/checkout_op.tcl:635
+#: lib/checkout_op.tcl:572 lib/branch_create.tcl:85
+msgid "Reset"
+msgstr "Zurücksetzen"
+
+#: lib/checkout_op.tcl:636
 #, tcl-format
 msgid ""
 "Failed to set current branch.\n"
@@ -1032,658 +932,511 @@ msgstr ""
 "\n"
 "Dies ist ein interner Programmfehler von %s. Programm wird jetzt abgebrochen."
 
-#: lib/choose_font.tcl:39
-msgid "Select"
-msgstr "Auswählen"
-
-#: lib/choose_font.tcl:53
-msgid "Font Family"
-msgstr "Schriftfamilie"
-
-#: lib/choose_font.tcl:74
-msgid "Font Size"
-msgstr "Schriftgröße"
-
-#: lib/choose_font.tcl:91
-msgid "Font Example"
-msgstr "Schriftbeispiel"
+#: lib/remote_add.tcl:20
+#, fuzzy, tcl-format
+msgid "%s (%s): Add Remote"
+msgstr "Externes Archiv hinzufügen"
 
-#: lib/choose_font.tcl:103
-msgid ""
-"This is example text.\n"
-"If you like this text, it can be your font."
-msgstr ""
-"Dies ist ein Beispieltext.\n"
-"Wenn Ihnen dieser Text gefällt, sollten Sie diese Schriftart wählen."
+#: lib/remote_add.tcl:25
+msgid "Add New Remote"
+msgstr "Neues externes Archiv hinzufügen"
 
-#: lib/choose_repository.tcl:28
-msgid "Git Gui"
-msgstr "Git Gui"
+#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
+msgid "Add"
+msgstr "Hinzufügen"
 
-#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
-msgid "Create New Repository"
-msgstr "Neues Projektarchiv"
+#: lib/remote_add.tcl:39
+msgid "Remote Details"
+msgstr "Einzelheiten des externen Archivs"
 
-#: lib/choose_repository.tcl:93
-msgid "New..."
-msgstr "Neu..."
+#: lib/remote_add.tcl:41 lib/tools_dlg.tcl:51 lib/branch_create.tcl:44
+msgid "Name:"
+msgstr "Name:"
 
-#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
-msgid "Clone Existing Repository"
-msgstr "Projektarchiv klonen"
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "Adresse:"
 
-#: lib/choose_repository.tcl:106
-msgid "Clone..."
-msgstr "Klonen..."
+#: lib/remote_add.tcl:60
+msgid "Further Action"
+msgstr "Weitere Aktion jetzt"
 
-#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
-msgid "Open Existing Repository"
-msgstr "Projektarchiv öffnen"
+#: lib/remote_add.tcl:63
+msgid "Fetch Immediately"
+msgstr "Gleich anfordern"
 
-#: lib/choose_repository.tcl:119
-msgid "Open..."
-msgstr "Öffnen..."
+#: lib/remote_add.tcl:69
+msgid "Initialize Remote Repository and Push"
+msgstr "Externes Archiv initialisieren und dahin versenden"
 
-#: lib/choose_repository.tcl:132
-msgid "Recent Repositories"
-msgstr "Zuletzt benutzte Projektarchive"
+#: lib/remote_add.tcl:75
+msgid "Do Nothing Else Now"
+msgstr "Nichts tun"
 
-#: lib/choose_repository.tcl:138
-msgid "Open Recent Repository:"
-msgstr "Zuletzt benutztes Projektarchiv öffnen:"
+#: lib/remote_add.tcl:100
+msgid "Please supply a remote name."
+msgstr "Bitte geben Sie einen Namen des externen Archivs an."
 
-#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
-#: lib/choose_repository.tcl:320
+#: lib/remote_add.tcl:113
 #, tcl-format
-msgid "Failed to create repository %s:"
-msgstr "Projektarchiv »%s« konnte nicht erstellt werden:"
+msgid "'%s' is not an acceptable remote name."
+msgstr "»%s« ist kein zulässiger Name eines externen Archivs."
 
-#: lib/choose_repository.tcl:391
-msgid "Directory:"
-msgstr "Verzeichnis:"
+#: lib/remote_add.tcl:124
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr ""
+"Fehler beim Hinzufügen des externen Archivs »%s« aus Herkunftsort »%s«."
 
-#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
-#: lib/choose_repository.tcl:1052
-msgid "Git Repository"
-msgstr "Git Projektarchiv"
+#: lib/remote_add.tcl:133
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "»%s« anfordern"
 
-#: lib/choose_repository.tcl:448
+#: lib/remote_add.tcl:156
 #, tcl-format
-msgid "Directory %s already exists."
-msgstr "Verzeichnis »%s« existiert bereits."
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr ""
+"Initialisieren eines externen Archivs an Adresse »%s« ist nicht möglich."
 
-#: lib/choose_repository.tcl:452
+#: lib/remote_add.tcl:163
 #, tcl-format
-msgid "File %s already exists."
-msgstr "Datei »%s« existiert bereits."
+msgid "Setting up the %s (at %s)"
+msgstr "Einrichten von »%s« an »%s«"
 
-#: lib/choose_repository.tcl:466
-msgid "Clone"
-msgstr "Klonen"
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "Starten..."
 
-#: lib/choose_repository.tcl:479
-msgid "Source Location:"
-msgstr "Herkunft:"
+#: lib/browser.tcl:27
+#, fuzzy, tcl-format
+msgid "%s (%s): File Browser"
+msgstr "Datei-Browser"
 
-#: lib/choose_repository.tcl:490
-msgid "Target Directory:"
-msgstr "Zielverzeichnis:"
+#: lib/browser.tcl:132 lib/browser.tcl:149
+#, tcl-format
+msgid "Loading %s..."
+msgstr "%s laden..."
 
-#: lib/choose_repository.tcl:502
-msgid "Clone Type:"
-msgstr "Art des Klonens:"
+#: lib/browser.tcl:193
+msgid "[Up To Parent]"
+msgstr "[Nach oben]"
 
-#: lib/choose_repository.tcl:508
-msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
-msgstr "Standard (schnell, teilweise redundant, Hardlinks)"
+#: lib/browser.tcl:275
+#, fuzzy, tcl-format
+msgid "%s (%s): Browse Branch Files"
+msgstr "Dateien des Zweigs durchblättern"
 
-#: lib/choose_repository.tcl:514
-msgid "Full Copy (Slower, Redundant Backup)"
-msgstr "Alles kopieren (langsamer, volle Redundanz)"
+#: lib/browser.tcl:282
+msgid "Browse Branch Files"
+msgstr "Dateien des Zweigs durchblättern"
 
-#: lib/choose_repository.tcl:520
-msgid "Shared (Fastest, Not Recommended, No Backup)"
-msgstr "Verknüpft (schnell, nicht empfohlen, kein Backup)"
+#: lib/browser.tcl:288 lib/choose_repository.tcl:437
+#: lib/choose_repository.tcl:524 lib/choose_repository.tcl:533
+#: lib/choose_repository.tcl:1115
+msgid "Browse"
+msgstr "Blättern"
 
-#: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
-#: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
-#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
-#, tcl-format
-msgid "Not a Git repository: %s"
-msgstr "Kein Git-Projektarchiv in »%s« gefunden."
+#: lib/browser.tcl:297 lib/branch_checkout.tcl:35 lib/tools_dlg.tcl:321
+msgid "Revision"
+msgstr "Version"
 
-#: lib/choose_repository.tcl:592
-msgid "Standard only available for local repository."
-msgstr "Standard ist nur für lokale Projektarchive verfügbar."
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "Bereitstellung kann nicht wieder freigegeben werden."
 
-#: lib/choose_repository.tcl:596
-msgid "Shared only available for local repository."
-msgstr "Verknüpft ist nur für lokale Projektarchive verfügbar."
+#: lib/index.tcl:30
+msgid "Index Error"
+msgstr "Fehler in Bereitstellung"
 
-#: lib/choose_repository.tcl:617
-#, tcl-format
-msgid "Location %s already exists."
-msgstr "Projektarchiv »%s« existiert bereits."
+#: lib/index.tcl:32
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically started to "
+"resynchronize git-gui."
+msgstr ""
+"Das Aktualisieren der Git-Bereitstellung ist fehlgeschlagen. Eine allgemeine "
+"Git-Aktualisierung wird jetzt gestartet, um git-gui wieder mit git zu "
+"synchronisieren."
 
-#: lib/choose_repository.tcl:628
-msgid "Failed to configure origin"
-msgstr "Der Ursprungsort konnte nicht eingerichtet werden"
+#: lib/index.tcl:43
+msgid "Continue"
+msgstr "Fortsetzen"
 
-#: lib/choose_repository.tcl:640
-msgid "Counting objects"
-msgstr "Objekte werden gezählt"
+#: lib/index.tcl:46
+msgid "Unlock Index"
+msgstr "Bereitstellung freigeben"
 
-#: lib/choose_repository.tcl:641
-msgid "buckets"
-msgstr "Buckets"
+#: lib/index.tcl:77 lib/index.tcl:146 lib/index.tcl:220 lib/index.tcl:587
+#: lib/choose_repository.tcl:999
+msgid "files"
+msgstr "Dateien"
 
-#: lib/choose_repository.tcl:665
-#, tcl-format
-msgid "Unable to copy objects/info/alternates: %s"
-msgstr "Kopien von Objekten/Info/Alternates konnten nicht erstellt werden: %s"
+#: lib/index.tcl:326
+#, fuzzy
+msgid "Unstaging selected files from commit"
+msgstr "Datei »%s« aus der Bereitstellung herausnehmen"
 
-#: lib/choose_repository.tcl:701
+#: lib/index.tcl:330
 #, tcl-format
-msgid "Nothing to clone from %s."
-msgstr "Von »%s« konnte nichts geklont werden."
+msgid "Unstaging %s from commit"
+msgstr "Datei »%s« aus der Bereitstellung herausnehmen"
 
-#: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
-#: lib/choose_repository.tcl:929
-msgid "The 'master' branch has not been initialized."
-msgstr "Der »master«-Zweig wurde noch nicht initialisiert."
+#: lib/index.tcl:369
+msgid "Ready to commit."
+msgstr "Bereit zum Eintragen."
 
-#: lib/choose_repository.tcl:716
-msgid "Hardlinks are unavailable.  Falling back to copying."
-msgstr "Hardlinks nicht verfügbar. Stattdessen wird kopiert."
+#: lib/index.tcl:378
+#, fuzzy
+msgid "Adding selected files"
+msgstr "Änderungen in gewählten Dateien verwerfen"
 
-#: lib/choose_repository.tcl:728
+#: lib/index.tcl:382
 #, tcl-format
-msgid "Cloning from %s"
-msgstr "Kopieren von »%s«"
-
-#: lib/choose_repository.tcl:759
-msgid "Copying objects"
-msgstr "Objektdatenbank kopieren"
-
-#: lib/choose_repository.tcl:760
-msgid "KiB"
-msgstr "KB"
+msgid "Adding %s"
+msgstr "»%s« hinzufügen..."
 
-#: lib/choose_repository.tcl:784
+#: lib/index.tcl:412
 #, tcl-format
-msgid "Unable to copy object: %s"
-msgstr "Objekt kann nicht kopiert werden: %s"
+msgid "Stage %d untracked files?"
+msgstr ""
 
-#: lib/choose_repository.tcl:794
-msgid "Linking objects"
-msgstr "Objekte verlinken"
+#: lib/index.tcl:420
+msgid "Adding all changed files"
+msgstr ""
 
-#: lib/choose_repository.tcl:795
-msgid "objects"
-msgstr "Objekte"
+#: lib/index.tcl:503
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "Änderungen in Datei »%s« verwerfen?"
 
-#: lib/choose_repository.tcl:803
+#: lib/index.tcl:508
 #, tcl-format
-msgid "Unable to hardlink object: %s"
-msgstr "Für Objekt konnte kein Hardlink erstellt werden: %s"
+msgid "Revert changes in these %i files?"
+msgstr "Änderungen in den gewählten %i Dateien verwerfen?"
 
-#: lib/choose_repository.tcl:858
-msgid "Cannot fetch branches and objects.  See console output for details."
+#: lib/index.tcl:517
+msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
-"Zweige und Objekte konnten nicht angefordert werden.  Kontrollieren Sie die "
-"Ausgaben auf der Konsole für weitere Angaben."
+"Alle nicht bereitgestellten Änderungen werden beim Verwerfen verloren gehen."
 
-#: lib/choose_repository.tcl:869
-msgid "Cannot fetch tags.  See console output for details."
+#: lib/index.tcl:520 lib/index.tcl:563
+msgid "Do Nothing"
+msgstr "Nichts tun"
+
+#: lib/index.tcl:545
+#, fuzzy, tcl-format
+msgid "Delete untracked file %s?"
+msgstr "Zweige auf »%s« werden gelöscht"
+
+#: lib/index.tcl:550
+#, fuzzy, tcl-format
+msgid "Delete these %i untracked files?"
+msgstr "Änderungen in den gewählten %i Dateien verwerfen?"
+
+#: lib/index.tcl:560
+msgid "Files will be permanently deleted."
 msgstr ""
-"Markierungen konnten nicht angefordert werden.  Kontrollieren Sie die "
-"Ausgaben auf der Konsole für weitere Angaben."
 
-#: lib/choose_repository.tcl:893
-msgid "Cannot determine HEAD.  See console output for details."
+#: lib/index.tcl:564
+#, fuzzy
+msgid "Delete Files"
+msgstr "Löschen"
+
+#: lib/index.tcl:586
+#, fuzzy
+msgid "Deleting"
+msgstr "Löschen"
+
+#: lib/index.tcl:665
+msgid "Encountered errors deleting files:\n"
 msgstr ""
-"Die Zweigspitze (HEAD) konnte nicht gefunden werden.  Kontrollieren Sie die "
-"Ausgaben auf der Konsole für weitere Angaben."
 
-#: lib/choose_repository.tcl:902
+#: lib/index.tcl:674
 #, tcl-format
-msgid "Unable to cleanup %s"
-msgstr "Verzeichnis »%s« kann nicht aufgeräumt werden."
+msgid "None of the %d selected files could be deleted."
+msgstr ""
 
-#: lib/choose_repository.tcl:908
-msgid "Clone failed."
-msgstr "Klonen fehlgeschlagen."
+#: lib/index.tcl:679
+#, tcl-format
+msgid "%d of the %d selected files could not be deleted."
+msgstr ""
 
-#: lib/choose_repository.tcl:915
-msgid "No default branch obtained."
-msgstr "Kein voreingestellter Zweig gefunden."
+#: lib/index.tcl:726
+msgid "Reverting selected files"
+msgstr "Änderungen in gewählten Dateien verwerfen"
 
-#: lib/choose_repository.tcl:926
+#: lib/index.tcl:730
 #, tcl-format
-msgid "Cannot resolve %s as a commit."
-msgstr "»%s« wurde nicht als Version gefunden."
+msgid "Reverting %s"
+msgstr "Änderungen in %s verwerfen"
 
-#: lib/choose_repository.tcl:938
-msgid "Creating working directory"
-msgstr "Arbeitskopie erstellen"
+#: lib/branch_checkout.tcl:16
+#, fuzzy, tcl-format
+msgid "%s (%s): Checkout Branch"
+msgstr "Auf Zweig umstellen"
 
-#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
-#: lib/index.tcl:198
-msgid "files"
-msgstr "Dateien"
+#: lib/branch_checkout.tcl:21
+msgid "Checkout Branch"
+msgstr "Auf Zweig umstellen"
 
-#: lib/choose_repository.tcl:968
-msgid "Initial file checkout failed."
-msgstr "Erstellen der Arbeitskopie fehlgeschlagen."
+#: lib/branch_checkout.tcl:26
+msgid "Checkout"
+msgstr "Umstellen"
 
-#: lib/choose_repository.tcl:1011
-msgid "Open"
-msgstr "Öffnen"
+#: lib/branch_checkout.tcl:39 lib/option.tcl:310 lib/branch_create.tcl:69
+msgid "Options"
+msgstr "Optionen"
 
-#: lib/choose_repository.tcl:1021
-msgid "Repository:"
-msgstr "Projektarchiv:"
+#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "Übernahmezweig anfordern"
 
-#: lib/choose_repository.tcl:1072
+#: lib/branch_checkout.tcl:47
+msgid "Detach From Local Branch"
+msgstr "Verbindung zu lokalem Zweig lösen"
+
+#: lib/status_bar.tcl:263
 #, tcl-format
-msgid "Failed to open repository %s:"
-msgstr "Projektarchiv »%s« konnte nicht geöffnet werden."
+msgid "%s ... %*i of %*i %s (%3i%%)"
+msgstr "%s ... %*i von %*i %s (%3i%%)"
 
-#: lib/choose_rev.tcl:53
-msgid "This Detached Checkout"
-msgstr "Abgetrennte Arbeitskopie-Version"
+#: lib/remote.tcl:200
+msgid "Push to"
+msgstr "Versenden nach"
 
-#: lib/choose_rev.tcl:60
-msgid "Revision Expression:"
-msgstr "Version Regexp-Ausdruck:"
+#: lib/remote.tcl:218
+msgid "Remove Remote"
+msgstr "Externes Archiv entfernen"
 
-#: lib/choose_rev.tcl:74
-msgid "Local Branch"
-msgstr "Lokaler Zweig"
+#: lib/remote.tcl:223
+msgid "Prune from"
+msgstr "Aufräumen von"
 
-#: lib/choose_rev.tcl:79
-msgid "Tracking Branch"
-msgstr "Übernahmezweig"
+#: lib/remote.tcl:228
+msgid "Fetch from"
+msgstr "Anfordern von"
 
-#: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
-msgid "Tag"
-msgstr "Markierung"
+#: lib/remote.tcl:249 lib/remote.tcl:253 lib/remote.tcl:258 lib/remote.tcl:264
+msgid "All"
+msgstr ""
 
-#: lib/choose_rev.tcl:317
-#, tcl-format
-msgid "Invalid revision: %s"
-msgstr "Ungültige Version: %s"
+#: lib/branch_rename.tcl:15
+#, fuzzy, tcl-format
+msgid "%s (%s): Rename Branch"
+msgstr "Zweig umbenennen"
 
-#: lib/choose_rev.tcl:338
-msgid "No revision selected."
-msgstr "Keine Version ausgewählt."
+#: lib/branch_rename.tcl:23
+msgid "Rename Branch"
+msgstr "Zweig umbenennen"
 
-#: lib/choose_rev.tcl:346
-msgid "Revision expression is empty."
-msgstr "Versions-Ausdruck ist leer."
+#: lib/branch_rename.tcl:28
+msgid "Rename"
+msgstr "Umbenennen"
 
-#: lib/choose_rev.tcl:531
-msgid "Updated"
-msgstr "Aktualisiert"
+#: lib/branch_rename.tcl:38
+msgid "Branch:"
+msgstr "Zweig:"
 
-#: lib/choose_rev.tcl:559
-msgid "URL"
-msgstr "URL"
+#: lib/branch_rename.tcl:46
+msgid "New Name:"
+msgstr "Neuer Name:"
 
-#: lib/commit.tcl:9
-msgid ""
-"There is nothing to amend.\n"
-"\n"
-"You are about to create the initial commit.  There is no commit before this "
-"to amend.\n"
-msgstr ""
-"Keine Version zur Nachbesserung vorhanden.\n"
-"\n"
-"Sie sind dabei, die erste Version zu übertragen. Es gibt keine existierende "
-"Version, die Sie nachbessern könnten.\n"
+#: lib/branch_rename.tcl:81
+msgid "Please select a branch to rename."
+msgstr "Bitte wählen Sie einen Zweig zum umbenennen."
 
-#: lib/commit.tcl:18
-msgid ""
-"Cannot amend while merging.\n"
-"\n"
-"You are currently in the middle of a merge that has not been fully "
-"completed.  You cannot amend the prior commit unless you first abort the "
-"current merge activity.\n"
-msgstr ""
-"Nachbesserung währen Zusammenführung nicht möglich.\n"
-"\n"
-"Sie haben das Zusammenführen von Versionen angefangen, aber noch nicht "
-"beendet. Sie können keine vorige Übertragung nachbessern, solange eine "
-"unfertige Zusammenführung existiert. Dazu müssen Sie die Zusammenführung "
-"beenden oder abbrechen.\n"
+#: lib/branch_rename.tcl:92 lib/branch_create.tcl:154
+msgid "Please supply a branch name."
+msgstr "Bitte geben Sie einen Zweignamen an."
 
-#: lib/commit.tcl:48
-msgid "Error loading commit data for amend:"
-msgstr "Fehler beim Laden der Versionsdaten für Nachbessern:"
+#: lib/branch_rename.tcl:112 lib/branch_create.tcl:165
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "»%s« ist kein zulässiger Zweigname."
 
-#: lib/commit.tcl:75
-msgid "Unable to obtain your identity:"
-msgstr "Benutzername konnte nicht bestimmt werden:"
+#: lib/branch_rename.tcl:123
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "Fehler beim Umbenennen von »%s«."
 
-#: lib/commit.tcl:80
-msgid "Invalid GIT_COMMITTER_IDENT:"
-msgstr "Ungültiger Wert von GIT_COMMITTER_INDENT:"
+#: lib/choose_font.tcl:41
+msgid "Select"
+msgstr "Auswählen"
 
-#: lib/commit.tcl:129
-#, tcl-format
-msgid "warning: Tcl does not support encoding '%s'."
-msgstr "Warning: Tcl/Tk unterstützt die Zeichencodierung »%s« nicht."
+#: lib/choose_font.tcl:55
+msgid "Font Family"
+msgstr "Schriftfamilie"
+
+#: lib/choose_font.tcl:76
+msgid "Font Size"
+msgstr "Schriftgröße"
 
-#: lib/commit.tcl:149
+#: lib/choose_font.tcl:93
+msgid "Font Example"
+msgstr "Schriftbeispiel"
+
+#: lib/choose_font.tcl:105
 msgid ""
-"Last scanned state does not match repository state.\n"
-"\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before another commit can be created.\n"
-"\n"
-"The rescan will be automatically started now.\n"
+"This is example text.\n"
+"If you like this text, it can be your font."
 msgstr ""
-"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
-"\n"
-"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
-"geändert.  Vor dem Eintragen einer neuen Version muss neu geladen werden.\n"
-"\n"
-"Es wird gleich neu geladen.\n"
+"Dies ist ein Beispieltext.\n"
+"Wenn Ihnen dieser Text gefällt, sollten Sie diese Schriftart wählen."
 
-#: lib/commit.tcl:172
+#: lib/option.tcl:11
 #, tcl-format
-msgid ""
-"Unmerged files cannot be committed.\n"
-"\n"
-"File %s has merge conflicts.  You must resolve them and stage the file "
-"before committing.\n"
-msgstr ""
-"Nicht zusammengeführte Dateien können nicht eingetragen werden.\n"
-"\n"
-"Die Datei »%s« hat noch nicht aufgelöste Zusammenführungs-Konflikte. Sie "
-"müssen diese Konflikte auflösen, bevor Sie eintragen können.\n"
+msgid "Invalid global encoding '%s'"
+msgstr "Ungültige globale Zeichenkodierung »%s«"
 
-#: lib/commit.tcl:180
+#: lib/option.tcl:19
 #, tcl-format
-msgid ""
-"Unknown file state %s detected.\n"
-"\n"
-"File %s cannot be committed by this program.\n"
-msgstr ""
-"Unbekannter Dateizustand »%s«.\n"
-"\n"
-"Datei »%s« kann nicht eingetragen werden.\n"
+msgid "Invalid repo encoding '%s'"
+msgstr "Ungültige Archiv-Zeichenkodierung »%s«"
 
-#: lib/commit.tcl:188
-msgid ""
-"No changes to commit.\n"
-"\n"
-"You must stage at least 1 file before you can commit.\n"
-msgstr ""
-"Keine Änderungen vorhanden, die eingetragen werden könnten.\n"
-"\n"
-"Sie müssen mindestens eine Datei bereitstellen, bevor Sie eintragen können.\n"
+#: lib/option.tcl:119
+msgid "Restore Defaults"
+msgstr "Voreinstellungen wiederherstellen"
 
-#: lib/commit.tcl:203
-msgid ""
-"Please supply a commit message.\n"
-"\n"
-"A good commit message has the following format:\n"
-"\n"
-"- First line: Describe in one sentence what you did.\n"
-"- Second line: Blank\n"
-"- Remaining lines: Describe why this change is good.\n"
-msgstr ""
-"Bitte geben Sie eine Versionsbeschreibung ein.\n"
-"\n"
-"Eine gute Versionsbeschreibung enthält folgende Abschnitte:\n"
-"\n"
-"- Erste Zeile: Eine Zusammenfassung, was man gemacht hat.\n"
-"\n"
-"- Zweite Zeile: Leerzeile\n"
-"\n"
-"- Rest: Eine ausführliche Beschreibung, warum diese Änderung hilfreich ist.\n"
-
-#: lib/commit.tcl:234
-msgid "Calling pre-commit hook..."
-msgstr "Aufrufen der Vor-Eintragen-Kontrolle (»pre-commit hook«)..."
-
-#: lib/commit.tcl:249
-msgid "Commit declined by pre-commit hook."
-msgstr "Eintragen abgelehnt durch Vor-Eintragen-Kontrolle (»pre-commit hook«)."
-
-#: lib/commit.tcl:272
-msgid "Calling commit-msg hook..."
-msgstr "Aufrufen der Versionsbeschreibungs-Kontrolle (»commit-message hook«)..."
-
-#: lib/commit.tcl:287
-msgid "Commit declined by commit-msg hook."
-msgstr ""
-"Eintragen abgelehnt durch Versionsbeschreibungs-Kontrolle (»commit-message "
-"hook«)."
-
-#: lib/commit.tcl:300
-msgid "Committing changes..."
-msgstr "Änderungen eintragen..."
-
-#: lib/commit.tcl:316
-msgid "write-tree failed:"
-msgstr "write-tree fehlgeschlagen:"
-
-#: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
-msgid "Commit failed."
-msgstr "Eintragen fehlgeschlagen."
+#: lib/option.tcl:123
+msgid "Save"
+msgstr "Speichern"
 
-#: lib/commit.tcl:334
+#: lib/option.tcl:133
 #, tcl-format
-msgid "Commit %s appears to be corrupt"
-msgstr "Version »%s« scheint beschädigt zu sein"
-
-#: lib/commit.tcl:339
-msgid ""
-"No changes to commit.\n"
-"\n"
-"No files were modified by this commit and it was not a merge commit.\n"
-"\n"
-"A rescan will be automatically started now.\n"
-msgstr ""
-"Keine Änderungen einzutragen.\n"
-"\n"
-"Es gibt keine geänderte Datei bei dieser Version und es wurde auch nichts "
-"zusammengeführt.\n"
-"\n"
-"Das Arbeitsverzeichnis wird daher jetzt neu geladen.\n"
+msgid "%s Repository"
+msgstr "Projektarchiv %s"
 
-#: lib/commit.tcl:346
-msgid "No changes to commit."
-msgstr "Keine Änderungen, die eingetragen werden können."
+#: lib/option.tcl:134
+msgid "Global (All Repositories)"
+msgstr "Global (Alle Projektarchive)"
 
-#: lib/commit.tcl:360
-msgid "commit-tree failed:"
-msgstr "commit-tree fehlgeschlagen:"
+#: lib/option.tcl:140
+msgid "User Name"
+msgstr "Benutzername"
 
-#: lib/commit.tcl:381
-msgid "update-ref failed:"
-msgstr "update-ref fehlgeschlagen:"
+#: lib/option.tcl:141
+msgid "Email Address"
+msgstr "E-Mail-Adresse"
 
-#: lib/commit.tcl:469
-#, tcl-format
-msgid "Created commit %s: %s"
-msgstr "Version %s übertragen: %s"
+#: lib/option.tcl:143
+msgid "Summarize Merge Commits"
+msgstr "Zusammenführungs-Versionen zusammenfassen"
 
-#: lib/console.tcl:59
-msgid "Working... please wait..."
-msgstr "Verarbeitung. Bitte warten..."
+#: lib/option.tcl:144
+msgid "Merge Verbosity"
+msgstr "Ausführlichkeit der Zusammenführen-Meldungen"
 
-#: lib/console.tcl:186
-msgid "Success"
-msgstr "Erfolgreich"
+#: lib/option.tcl:145
+msgid "Show Diffstat After Merge"
+msgstr "Vergleichsstatistik nach Zusammenführen anzeigen"
 
-#: lib/console.tcl:200
-msgid "Error: Command Failed"
-msgstr "Fehler: Kommando fehlgeschlagen"
+#: lib/option.tcl:146
+msgid "Use Merge Tool"
+msgstr "Zusammenführungswerkzeug"
 
-#: lib/database.tcl:43
-msgid "Number of loose objects"
-msgstr "Anzahl unverknüpfter Objekte"
+#: lib/option.tcl:148
+msgid "Trust File Modification Timestamps"
+msgstr "Auf Dateiänderungsdatum verlassen"
 
-#: lib/database.tcl:44
-msgid "Disk space used by loose objects"
-msgstr "Festplattenplatz von unverknüpften Objekten"
+#: lib/option.tcl:149
+msgid "Prune Tracking Branches During Fetch"
+msgstr "Übernahmezweige aufräumen während Anforderung"
 
-#: lib/database.tcl:45
-msgid "Number of packed objects"
-msgstr "Anzahl komprimierter Objekte"
+#: lib/option.tcl:150
+msgid "Match Tracking Branches"
+msgstr "Passend zu Übernahmezweig"
 
-#: lib/database.tcl:46
-msgid "Number of packs"
-msgstr "Anzahl Komprimierungseinheiten"
+#: lib/option.tcl:151
+msgid "Use Textconv For Diffs and Blames"
+msgstr ""
 
-#: lib/database.tcl:47
-msgid "Disk space used by packed objects"
-msgstr "Festplattenplatz von komprimierten Objekten"
+#: lib/option.tcl:152
+msgid "Blame Copy Only On Changed Files"
+msgstr "Kopie-Annotieren nur bei geänderten Dateien"
 
-#: lib/database.tcl:48
-msgid "Packed objects waiting for pruning"
-msgstr "Komprimierte Objekte, die zum Aufräumen vorgesehen sind"
+#: lib/option.tcl:153
+#, fuzzy
+msgid "Maximum Length of Recent Repositories List"
+msgstr "Zuletzt benutzte Projektarchive"
 
-#: lib/database.tcl:49
-msgid "Garbage files"
-msgstr "Dateien im Mülleimer"
+#: lib/option.tcl:154
+msgid "Minimum Letters To Blame Copy On"
+msgstr "Mindestzahl Zeichen für Kopie-Annotieren"
 
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "Objektdatenbank komprimieren"
+#: lib/option.tcl:155
+msgid "Blame History Context Radius (days)"
+msgstr "Anzahl Tage für Historien-Kontext"
 
-#: lib/database.tcl:83
-msgid "Verifying the object database with fsck-objects"
-msgstr "Die Objektdatenbank durch »fsck-objects« überprüfen lassen"
+#: lib/option.tcl:156
+msgid "Number of Diff Context Lines"
+msgstr "Anzahl der Kontextzeilen beim Vergleich"
 
-#: lib/database.tcl:107
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you compress "
-"the database.\n"
-"\n"
-"Compress the database now?"
+#: lib/option.tcl:157
+msgid "Additional Diff Parameters"
 msgstr ""
-"Dieses Projektarchiv enthält ungefähr %i nicht verknüpfte Objekte.\n"
-"\n"
-"Für eine optimale Performance wird empfohlen, die Datenbank des Projektarchivs zu komprimieren.\n"
-"\n"
-"Soll die Datenbank jetzt komprimiert werden?"
 
-#: lib/date.tcl:25
-#, tcl-format
-msgid "Invalid date from Git: %s"
-msgstr "Ungültiges Datum von Git: %s"
+#: lib/option.tcl:158
+msgid "Commit Message Text Width"
+msgstr "Textbreite der Versionsbeschreibung"
 
-#: lib/diff.tcl:64
-#, tcl-format
-msgid ""
-"No differences detected.\n"
-"\n"
-"%s has no changes.\n"
-"\n"
-"The modification date of this file was updated by another application, but "
-"the content within the file was not changed.\n"
-"\n"
-"A rescan will be automatically started to find other files which may have "
-"the same state."
-msgstr ""
-"Keine Änderungen feststellbar.\n"
-"\n"
-"»%s« enthält keine Änderungen. Zwar wurde das Änderungsdatum dieser Datei von "
-"einem anderen Programm modifiziert, aber der Inhalt der Datei ist "
-"unverändert.\n"
-"\n"
-"Das Arbeitsverzeichnis wird jetzt neu geladen, um diese Änderung bei allen "
-"Dateien zu prüfen."
+#: lib/option.tcl:159
+msgid "New Branch Name Template"
+msgstr "Namensvorschlag für neue Zweige"
 
-#: lib/diff.tcl:104
-#, tcl-format
-msgid "Loading diff of %s..."
-msgstr "Vergleich von »%s« laden..."
+#: lib/option.tcl:160
+msgid "Default File Contents Encoding"
+msgstr "Voreingestellte Zeichenkodierung"
 
-#: lib/diff.tcl:125
-msgid ""
-"LOCAL: deleted\n"
-"REMOTE:\n"
+#: lib/option.tcl:161
+msgid "Warn before committing to a detached head"
 msgstr ""
-"LOKAL: gelöscht\n"
-"ANDERES:\n"
 
-#: lib/diff.tcl:130
-msgid ""
-"REMOTE: deleted\n"
-"LOCAL:\n"
+#: lib/option.tcl:162
+msgid "Staging of untracked files"
 msgstr ""
-"ANDERES: gelöscht\n"
-"LOKAL:\n"
 
-#: lib/diff.tcl:137
-msgid "LOCAL:\n"
-msgstr "LOKAL:\n"
+#: lib/option.tcl:163
+msgid "Show untracked files"
+msgstr ""
 
-#: lib/diff.tcl:140
-msgid "REMOTE:\n"
-msgstr "ANDERES:\n"
+#: lib/option.tcl:164
+msgid "Tab spacing"
+msgstr ""
 
-#: lib/diff.tcl:202 lib/diff.tcl:319
+#: lib/option.tcl:182 lib/option.tcl:197 lib/option.tcl:220 lib/option.tcl:282
+#: lib/database.tcl:57
 #, tcl-format
-msgid "Unable to display %s"
-msgstr "Datei »%s« kann nicht angezeigt werden"
-
-#: lib/diff.tcl:203
-msgid "Error loading file:"
-msgstr "Fehler beim Laden der Datei:"
+msgid "%s:"
+msgstr ""
 
-#: lib/diff.tcl:210
-msgid "Git Repository (subproject)"
-msgstr "Git-Projektarchiv (Unterprojekt)"
+#: lib/option.tcl:210
+msgid "Change"
+msgstr "Ändern"
 
-#: lib/diff.tcl:222
-msgid "* Binary file (not showing content)."
-msgstr "* Binärdatei (Inhalt wird nicht angezeigt)"
+#: lib/option.tcl:254
+msgid "Spelling Dictionary:"
+msgstr "Wörterbuch Rechtschreibprüfung:"
 
-#: lib/diff.tcl:227
-#, tcl-format
-msgid ""
-"* Untracked file is %d bytes.\n"
-"* Showing only first %d bytes.\n"
-msgstr ""
-"* Datei nicht unter Versionskontrolle, Dateigröße %d Bytes.\n"
-"* Nur erste %d Bytes werden angezeigt.\n"
+#: lib/option.tcl:284
+msgid "Change Font"
+msgstr "Schriftart ändern"
 
-#: lib/diff.tcl:233
+#: lib/option.tcl:288
 #, tcl-format
-msgid ""
-"\n"
-"* Untracked file clipped here by %s.\n"
-"* To see the entire file, use an external editor.\n"
-msgstr ""
-"\n"
-"* Datei nicht unter Versionskontrolle, hier abgeschnitten durch %s.\n"
-"* Zum Ansehen der vollständigen Datei externen Editor benutzen.\n"
-
-#: lib/diff.tcl:482
-msgid "Failed to unstage selected hunk."
-msgstr ""
-"Fehler beim Herausnehmen des gewählten Kontexts aus der Bereitstellung."
+msgid "Choose %s"
+msgstr "%s wählen"
 
-#: lib/diff.tcl:489
-msgid "Failed to stage selected hunk."
-msgstr "Fehler beim Bereitstellen des gewählten Kontexts."
+#: lib/option.tcl:294
+msgid "pt."
+msgstr "pt."
 
-#: lib/diff.tcl:568
-msgid "Failed to unstage selected line."
-msgstr "Fehler beim Herausnehmen der gewählten Zeile aus der Bereitstellung."
+#: lib/option.tcl:308
+msgid "Preferences"
+msgstr "Einstellungen"
 
-#: lib/diff.tcl:576
-msgid "Failed to stage selected line."
-msgstr "Fehler beim Bereitstellen der gewählten Zeile."
+#: lib/option.tcl:345
+msgid "Failed to completely save options:"
+msgstr "Optionen konnten nicht gespeichert werden:"
 
 #: lib/encoding.tcl:443
 msgid "Default"
@@ -1698,229 +1451,40 @@ msgstr "Systemweit (%s)"
 msgid "Other"
 msgstr "Andere"
 
-#: lib/error.tcl:20 lib/error.tcl:114
-msgid "error"
-msgstr "Fehler"
+#: lib/tools.tcl:76
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "Um »%s« zu starten, muss eine Datei ausgewählt sein."
 
-#: lib/error.tcl:36
-msgid "warning"
-msgstr "Warnung"
+#: lib/tools.tcl:92
+#, fuzzy, tcl-format
+msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
+msgstr "Wollen Sie %s wirklich starten?"
 
-#: lib/error.tcl:94
-msgid "You must correct the above errors before committing."
-msgstr ""
-"Sie müssen die obigen Fehler zuerst beheben, bevor Sie eintragen können."
-
-#: lib/index.tcl:6
-msgid "Unable to unlock the index."
-msgstr "Bereitstellung kann nicht wieder freigegeben werden."
-
-#: lib/index.tcl:15
-msgid "Index Error"
-msgstr "Fehler in Bereitstellung"
-
-#: lib/index.tcl:17
-msgid ""
-"Updating the Git index failed.  A rescan will be automatically started to "
-"resynchronize git-gui."
-msgstr ""
-"Das Aktualisieren der Git-Bereitstellung ist fehlgeschlagen. Eine allgemeine "
-"Git-Aktualisierung wird jetzt gestartet, um git-gui wieder mit git zu "
-"synchronisieren."
-
-#: lib/index.tcl:28
-msgid "Continue"
-msgstr "Fortsetzen"
-
-#: lib/index.tcl:31
-msgid "Unlock Index"
-msgstr "Bereitstellung freigeben"
-
-#: lib/index.tcl:289
-#, tcl-format
-msgid "Unstaging %s from commit"
-msgstr "Datei »%s« aus der Bereitstellung herausnehmen"
-
-#: lib/index.tcl:328
-msgid "Ready to commit."
-msgstr "Bereit zum Eintragen."
-
-#: lib/index.tcl:341
-#, tcl-format
-msgid "Adding %s"
-msgstr "»%s« hinzufügen..."
-
-#: lib/index.tcl:398
-#, tcl-format
-msgid "Revert changes in file %s?"
-msgstr "Änderungen in Datei »%s« verwerfen?"
-
-#: lib/index.tcl:400
-#, tcl-format
-msgid "Revert changes in these %i files?"
-msgstr "Änderungen in den gewählten %i Dateien verwerfen?"
-
-#: lib/index.tcl:408
-msgid "Any unstaged changes will be permanently lost by the revert."
-msgstr ""
-"Alle nicht bereitgestellten Änderungen werden beim Verwerfen verloren gehen."
-
-#: lib/index.tcl:411
-msgid "Do Nothing"
-msgstr "Nichts tun"
-
-#: lib/index.tcl:429
-msgid "Reverting selected files"
-msgstr "Änderungen in gewählten Dateien verwerfen"
-
-#: lib/index.tcl:433
-#, tcl-format
-msgid "Reverting %s"
-msgstr "Änderungen in %s verwerfen"
-
-#: lib/merge.tcl:13
-msgid ""
-"Cannot merge while amending.\n"
-"\n"
-"You must finish amending this commit before starting any type of merge.\n"
-msgstr ""
-"Zusammenführen kann nicht gleichzeitig mit Nachbessern durchgeführt werden.\n"
-"\n"
-"Sie müssen zuerst die Nachbesserungs-Version abschließen, bevor Sie "
-"zusammenführen können.\n"
-
-#: lib/merge.tcl:27
-msgid ""
-"Last scanned state does not match repository state.\n"
-"\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before a merge can be performed.\n"
-"\n"
-"The rescan will be automatically started now.\n"
-msgstr ""
-"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
-"\n"
-"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
-"geändert.  Vor einem Zusammenführen muss neu geladen werden.\n"
-"\n"
-"Es wird gleich neu geladen.\n"
-
-#: lib/merge.tcl:45
+#: lib/tools.tcl:96
 #, tcl-format
-msgid ""
-"You are in the middle of a conflicted merge.\n"
-"\n"
-"File %s has merge conflicts.\n"
-"\n"
-"You must resolve them, stage the file, and commit to complete the current "
-"merge.  Only then can you begin another merge.\n"
-msgstr ""
-"Zusammenführung mit Konflikten.\n"
-"\n"
-"Die Datei »%s« enthält Konflikte beim Zusammenführen. Sie müssen diese "
-"Konflikte per Hand auflösen. Anschließend müssen Sie die Datei wieder "
-"bereitstellen und eintragen, um die Zusammenführung abzuschließen. Erst "
-"danach kann eine neue Zusammenführung begonnen werden.\n"
+msgid "Are you sure you want to run %s?"
+msgstr "Wollen Sie %s wirklich starten?"
 
-#: lib/merge.tcl:55
+#: lib/tools.tcl:118
 #, tcl-format
-msgid ""
-"You are in the middle of a change.\n"
-"\n"
-"File %s is modified.\n"
-"\n"
-"You should complete the current commit before starting a merge.  Doing so "
-"will help you abort a failed merge, should the need arise.\n"
-msgstr ""
-"Es liegen Änderungen vor.\n"
-"\n"
-"Die Datei »%s« wurde geändert.  Sie sollten zuerst die bereitgestellte "
-"Version abschließen, bevor Sie eine Zusammenführung beginnen.  Mit dieser "
-"Reihenfolge können Sie mögliche Konflikte beim Zusammenführen wesentlich "
-"einfacher beheben oder abbrechen.\n"
+msgid "Tool: %s"
+msgstr "Werkzeug: %s"
 
-#: lib/merge.tcl:107
+#: lib/tools.tcl:119
 #, tcl-format
-msgid "%s of %s"
-msgstr "%s von %s"
+msgid "Running: %s"
+msgstr "Starten: %s"
 
-#: lib/merge.tcl:120
+#: lib/tools.tcl:158
 #, tcl-format
-msgid "Merging %s and %s..."
-msgstr "Zusammenführen von %s und %s..."
-
-#: lib/merge.tcl:131
-msgid "Merge completed successfully."
-msgstr "Zusammenführen erfolgreich abgeschlossen."
-
-#: lib/merge.tcl:133
-msgid "Merge failed.  Conflict resolution is required."
-msgstr "Zusammenführen fehlgeschlagen. Konfliktauflösung ist notwendig."
+msgid "Tool completed successfully: %s"
+msgstr "Werkzeug erfolgreich abgeschlossen: %s"
 
-#: lib/merge.tcl:158
+#: lib/tools.tcl:160
 #, tcl-format
-msgid "Merge Into %s"
-msgstr "Zusammenführen in »%s«"
-
-#: lib/merge.tcl:177
-msgid "Revision To Merge"
-msgstr "Zusammenzuführende Version"
-
-#: lib/merge.tcl:212
-msgid ""
-"Cannot abort while amending.\n"
-"\n"
-"You must finish amending this commit.\n"
-msgstr ""
-"Abbruch der Nachbesserung ist nicht möglich.\n"
-"\n"
-"Sie müssen die Nachbesserung der Version abschließen.\n"
-
-#: lib/merge.tcl:222
-msgid ""
-"Abort merge?\n"
-"\n"
-"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
-"\n"
-"Continue with aborting the current merge?"
-msgstr ""
-"Zusammenführen abbrechen?\n"
-"\n"
-"Wenn Sie abbrechen, gehen alle noch nicht eingetragenen Änderungen "
-"verloren.\n"
-"\n"
-"Zusammenführen jetzt abbrechen?"
-
-#: lib/merge.tcl:228
-msgid ""
-"Reset changes?\n"
-"\n"
-"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
-"\n"
-"Continue with resetting the current changes?"
-msgstr ""
-"Änderungen zurücksetzen?\n"
-"\n"
-"Wenn Sie zurücksetzen, gehen alle noch nicht eingetragenen Änderungen "
-"verloren.\n"
-"\n"
-"Änderungen jetzt zurücksetzen?"
-
-#: lib/merge.tcl:239
-msgid "Aborting"
-msgstr "Abbruch"
-
-#: lib/merge.tcl:239
-msgid "files reset"
-msgstr "Dateien zurückgesetzt"
-
-#: lib/merge.tcl:267
-msgid "Abort failed."
-msgstr "Abbruch fehlgeschlagen."
-
-#: lib/merge.tcl:269
-msgid "Abort completed.  Ready."
-msgstr "Abbruch durchgeführt. Bereit."
+msgid "Tool failed: %s"
+msgstr "Werkzeug fehlgeschlagen: %s"
 
 #: lib/mergetool.tcl:8
 msgid "Force resolution to the base version?"
@@ -1970,21 +1534,21 @@ msgstr ""
 msgid "Conflict file does not exist"
 msgstr "Konflikt-Datei existiert nicht"
 
-#: lib/mergetool.tcl:264
+#: lib/mergetool.tcl:246
 #, tcl-format
 msgid "Not a GUI merge tool: '%s'"
 msgstr "Kein GUI Zusammenführungswerkzeug: »%s«"
 
-#: lib/mergetool.tcl:268
+#: lib/mergetool.tcl:275
 #, tcl-format
 msgid "Unsupported merge tool '%s'"
 msgstr "Unbekanntes Zusammenführungswerkzeug: »%s«"
 
-#: lib/mergetool.tcl:303
+#: lib/mergetool.tcl:310
 msgid "Merge tool is already running, terminate it?"
 msgstr "Zusammenführungswerkzeug läuft bereits. Soll es abgebrochen werden?"
 
-#: lib/mergetool.tcl:323
+#: lib/mergetool.tcl:330
 #, tcl-format
 msgid ""
 "Error retrieving versions:\n"
@@ -1993,7 +1557,7 @@ msgstr ""
 "Fehler beim Abrufen der Dateiversionen:\n"
 "%s"
 
-#: lib/mergetool.tcl:343
+#: lib/mergetool.tcl:350
 #, tcl-format
 msgid ""
 "Could not start the merge tool:\n"
@@ -2004,243 +1568,180 @@ msgstr ""
 "\n"
 "%s"
 
-#: lib/mergetool.tcl:347
+#: lib/mergetool.tcl:354
 msgid "Running merge tool..."
 msgstr "Zusammenführungswerkzeug starten..."
 
-#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
+#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
 msgid "Merge tool failed."
 msgstr "Zusammenführungswerkzeug fehlgeschlagen."
 
-#: lib/option.tcl:11
-#, tcl-format
-msgid "Invalid global encoding '%s'"
-msgstr "Ungültige globale Zeichenkodierung »%s«"
-
-#: lib/option.tcl:19
-#, tcl-format
-msgid "Invalid repo encoding '%s'"
-msgstr "Ungültige Archiv-Zeichenkodierung »%s«"
+#: lib/tools_dlg.tcl:22
+#, fuzzy, tcl-format
+msgid "%s (%s): Add Tool"
+msgstr "Werkzeug hinzufügen"
 
-#: lib/option.tcl:117
-msgid "Restore Defaults"
-msgstr "Voreinstellungen wiederherstellen"
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "Neues Kommando für Werkzeug hinzufügen"
 
-#: lib/option.tcl:121
-msgid "Save"
-msgstr "Speichern"
+#: lib/tools_dlg.tcl:34
+msgid "Add globally"
+msgstr "Global hinzufügen"
 
-#: lib/option.tcl:131
-#, tcl-format
-msgid "%s Repository"
-msgstr "Projektarchiv %s"
+#: lib/tools_dlg.tcl:46
+msgid "Tool Details"
+msgstr "Einzelheiten des Werkzeugs"
 
-#: lib/option.tcl:132
-msgid "Global (All Repositories)"
-msgstr "Global (Alle Projektarchive)"
+#: lib/tools_dlg.tcl:49
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "Benutzen Sie einen Schrägstrich »/«, um Untermenüs zu erstellen:"
 
-#: lib/option.tcl:138
-msgid "User Name"
-msgstr "Benutzername"
+#: lib/tools_dlg.tcl:60
+msgid "Command:"
+msgstr "Kommando:"
 
-#: lib/option.tcl:139
-msgid "Email Address"
-msgstr "E-Mail-Adresse"
+#: lib/tools_dlg.tcl:71
+msgid "Show a dialog before running"
+msgstr "Bestätigungsfrage vor Starten anzeigen"
 
-#: lib/option.tcl:141
-msgid "Summarize Merge Commits"
-msgstr "Zusammenführungs-Versionen zusammenfassen"
+#: lib/tools_dlg.tcl:77
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "Benutzer nach Version fragen (setzt $REVISION)"
 
-#: lib/option.tcl:142
-msgid "Merge Verbosity"
-msgstr "Ausführlichkeit der Zusammenführen-Meldungen"
+#: lib/tools_dlg.tcl:82
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "Benutzer nach zusätzlichen Argumenten fragen (setzt $ARGS)"
 
-#: lib/option.tcl:143
-msgid "Show Diffstat After Merge"
-msgstr "Vergleichsstatistik nach Zusammenführen anzeigen"
+#: lib/tools_dlg.tcl:89
+msgid "Don't show the command output window"
+msgstr "Kein Ausgabefenster zeigen"
 
-#: lib/option.tcl:144
-msgid "Use Merge Tool"
-msgstr "Zusammenführungswerkzeug"
+#: lib/tools_dlg.tcl:94
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "Nur starten, wenn ein Vergleich gewählt ist ($FILENAME ist nicht leer)"
 
-#: lib/option.tcl:146
-msgid "Trust File Modification Timestamps"
-msgstr "Auf Dateiänderungsdatum verlassen"
+#: lib/tools_dlg.tcl:118
+msgid "Please supply a name for the tool."
+msgstr "Bitte geben Sie einen Werkzeugnamen an."
 
-#: lib/option.tcl:147
-msgid "Prune Tracking Branches During Fetch"
-msgstr "Übernahmezweige aufräumen während Anforderung"
+#: lib/tools_dlg.tcl:126
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "Werkzeug »%s« existiert bereits."
 
-#: lib/option.tcl:148
-msgid "Match Tracking Branches"
-msgstr "Passend zu Übernahmezweig"
-
-#: lib/option.tcl:149
-msgid "Blame Copy Only On Changed Files"
-msgstr "Kopie-Annotieren nur bei geänderten Dateien"
-
-#: lib/option.tcl:150
-msgid "Minimum Letters To Blame Copy On"
-msgstr "Mindestzahl Zeichen für Kopie-Annotieren"
-
-#: lib/option.tcl:151
-msgid "Blame History Context Radius (days)"
-msgstr "Anzahl Tage für Historien-Kontext"
-
-#: lib/option.tcl:152
-msgid "Number of Diff Context Lines"
-msgstr "Anzahl der Kontextzeilen beim Vergleich"
-
-#: lib/option.tcl:153
-msgid "Commit Message Text Width"
-msgstr "Textbreite der Versionsbeschreibung"
-
-#: lib/option.tcl:154
-msgid "New Branch Name Template"
-msgstr "Namensvorschlag für neue Zweige"
-
-#: lib/option.tcl:155
-msgid "Default File Contents Encoding"
-msgstr "Voreingestellte Zeichenkodierung"
-
-#: lib/option.tcl:203
-msgid "Change"
-msgstr "Ändern"
-
-#: lib/option.tcl:230
-msgid "Spelling Dictionary:"
-msgstr "Wörterbuch Rechtschreibprüfung:"
-
-#: lib/option.tcl:254
-msgid "Change Font"
-msgstr "Schriftart ändern"
-
-#: lib/option.tcl:258
+#: lib/tools_dlg.tcl:148
 #, tcl-format
-msgid "Choose %s"
-msgstr "%s wählen"
-
-#: lib/option.tcl:264
-msgid "pt."
-msgstr "pt."
-
-#: lib/option.tcl:278
-msgid "Preferences"
-msgstr "Einstellungen"
-
-#: lib/option.tcl:314
-msgid "Failed to completely save options:"
-msgstr "Optionen konnten nicht gespeichert werden:"
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr ""
+"Werkzeug konnte nicht hinzugefügt werden:\n"
+"\n"
+"%s"
 
-#: lib/remote_add.tcl:19
-msgid "Add Remote"
-msgstr "Externes Archiv hinzufügen"
+#: lib/tools_dlg.tcl:187
+#, fuzzy, tcl-format
+msgid "%s (%s): Remove Tool"
+msgstr "Werkzeug entfernen"
 
-#: lib/remote_add.tcl:24
-msgid "Add New Remote"
-msgstr "Neues externes Archiv hinzufügen"
+#: lib/tools_dlg.tcl:193
+msgid "Remove Tool Commands"
+msgstr "Werkzeugkommandos entfernen"
 
-#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
-msgid "Add"
-msgstr "Hinzufügen"
+#: lib/tools_dlg.tcl:198
+msgid "Remove"
+msgstr "Entfernen"
 
-#: lib/remote_add.tcl:37
-msgid "Remote Details"
-msgstr "Einzelheiten des externen Archivs"
+#: lib/tools_dlg.tcl:231
+msgid "(Blue denotes repository-local tools)"
+msgstr "(Werkzeuge für lokales Archiv werden in Blau angezeigt)"
 
-#: lib/remote_add.tcl:50
-msgid "Location:"
-msgstr "Adresse:"
+#: lib/tools_dlg.tcl:283
+#, fuzzy, tcl-format
+msgid "%s (%s):"
+msgstr "Systemweit (%s)"
 
-#: lib/remote_add.tcl:62
-msgid "Further Action"
-msgstr "Weitere Aktion jetzt"
+#: lib/tools_dlg.tcl:292
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "Kommando aufrufen: %s"
 
-#: lib/remote_add.tcl:65
-msgid "Fetch Immediately"
-msgstr "Gleich anfordern"
+#: lib/tools_dlg.tcl:306
+msgid "Arguments"
+msgstr "Argumente"
 
-#: lib/remote_add.tcl:71
-msgid "Initialize Remote Repository and Push"
-msgstr "Externes Archiv initialisieren und dahin versenden"
+#: lib/tools_dlg.tcl:341
+msgid "OK"
+msgstr "Ok"
 
-#: lib/remote_add.tcl:77
-msgid "Do Nothing Else Now"
-msgstr "Nichts tun"
+#: lib/search.tcl:48
+msgid "Find:"
+msgstr "Suchen:"
 
-#: lib/remote_add.tcl:101
-msgid "Please supply a remote name."
-msgstr "Bitte geben Sie einen Namen des externen Archivs an."
+#: lib/search.tcl:50
+msgid "Next"
+msgstr "Nächster"
 
-#: lib/remote_add.tcl:114
-#, tcl-format
-msgid "'%s' is not an acceptable remote name."
-msgstr "»%s« ist kein zulässiger Name eines externen Archivs."
+#: lib/search.tcl:51
+msgid "Prev"
+msgstr "Voriger"
 
-#: lib/remote_add.tcl:125
-#, tcl-format
-msgid "Failed to add remote '%s' of location '%s'."
-msgstr "Fehler beim Hinzufügen des externen Archivs »%s« aus Herkunftsort »%s«."
+#: lib/search.tcl:52
+msgid "RegExp"
+msgstr ""
 
-#: lib/remote_add.tcl:133 lib/transport.tcl:6
-#, tcl-format
-msgid "fetch %s"
-msgstr "»%s« anfordern"
+#: lib/search.tcl:54
+msgid "Case"
+msgstr ""
 
-#: lib/remote_add.tcl:134
-#, tcl-format
-msgid "Fetching the %s"
-msgstr "»%s« anfordern"
+#: lib/shortcut.tcl:8 lib/shortcut.tcl:43 lib/shortcut.tcl:75
+#, fuzzy, tcl-format
+msgid "%s (%s): Create Desktop Icon"
+msgstr "Desktop-Icon erstellen"
 
-#: lib/remote_add.tcl:157
-#, tcl-format
-msgid "Do not know how to initialize repository at location '%s'."
-msgstr "Initialisieren eines externen Archivs an Adresse »%s« ist nicht möglich."
+#: lib/shortcut.tcl:24 lib/shortcut.tcl:65
+msgid "Cannot write shortcut:"
+msgstr "Fehler beim Schreiben der Verknüpfung:"
 
-#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
-#: lib/transport.tcl:81
-#, tcl-format
-msgid "push %s"
-msgstr "»%s« versenden..."
+#: lib/shortcut.tcl:140
+msgid "Cannot write icon:"
+msgstr "Fehler beim Erstellen des Icons:"
 
-#: lib/remote_add.tcl:164
-#, tcl-format
-msgid "Setting up the %s (at %s)"
-msgstr "Einrichten von »%s« an »%s«"
+#: lib/remote_branch_delete.tcl:29
+#, fuzzy, tcl-format
+msgid "%s (%s): Delete Branch Remotely"
+msgstr "Zweig in externem Archiv löschen"
 
-#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
+#: lib/remote_branch_delete.tcl:34
 msgid "Delete Branch Remotely"
 msgstr "Zweig in externem Archiv löschen"
 
-#: lib/remote_branch_delete.tcl:47
+#: lib/remote_branch_delete.tcl:48
 msgid "From Repository"
 msgstr "In Projektarchiv"
 
-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
-msgid "Remote:"
-msgstr "Externes Archiv:"
-
-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
-msgid "Arbitrary Location:"
-msgstr "Adresse:"
-
-#: lib/remote_branch_delete.tcl:84
+#: lib/remote_branch_delete.tcl:88
 msgid "Branches"
 msgstr "Zweige"
 
-#: lib/remote_branch_delete.tcl:109
+#: lib/remote_branch_delete.tcl:110
 msgid "Delete Only If"
 msgstr "Nur löschen, wenn"
 
-#: lib/remote_branch_delete.tcl:111
+#: lib/remote_branch_delete.tcl:112
 msgid "Merged Into:"
 msgstr "Zusammengeführt mit:"
 
-#: lib/remote_branch_delete.tcl:152
+#: lib/remote_branch_delete.tcl:120 lib/branch_delete.tcl:53
+msgid "Always (Do not perform merge checks)"
+msgstr "Immer (Keine Zusammenführungsprüfung)"
+
+#: lib/remote_branch_delete.tcl:153
 msgid "A branch is required for 'Merged Into'."
 msgstr "Für »Zusammenführen mit« muss ein Zweig angegeben werden."
 
-#: lib/remote_branch_delete.tcl:184
+#: lib/remote_branch_delete.tcl:185
 #, tcl-format
 msgid ""
 "The following branches are not completely merged into %s:\n"
@@ -2251,7 +1752,7 @@ msgstr ""
 "\n"
 " - %s"
 
-#: lib/remote_branch_delete.tcl:189
+#: lib/remote_branch_delete.tcl:190
 #, tcl-format
 msgid ""
 "One or more of the merge tests failed because you have not fetched the "
@@ -2261,332 +1762,1137 @@ msgstr ""
 "notwendigen Versionen vorher angefordert haben.  Sie sollten versuchen, "
 "zuerst von »%s« anzufordern."
 
-#: lib/remote_branch_delete.tcl:207
+#: lib/remote_branch_delete.tcl:208
 msgid "Please select one or more branches to delete."
 msgstr "Bitte wählen Sie mindestens einen Zweig, der gelöscht werden soll."
 
-#: lib/remote_branch_delete.tcl:226
+#: lib/remote_branch_delete.tcl:218 lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Das Wiederherstellen von gelöschten Zweigen ist nur mit größerem Aufwand "
+"möglich.\n"
+"\n"
+"Sollen die ausgewählten Zweige gelöscht werden?"
+
+#: lib/remote_branch_delete.tcl:227
 #, tcl-format
 msgid "Deleting branches from %s"
 msgstr "Zweige auf »%s« werden gelöscht"
 
-#: lib/remote_branch_delete.tcl:292
+#: lib/remote_branch_delete.tcl:300
 msgid "No repository selected."
 msgstr "Kein Projektarchiv ausgewählt."
 
-#: lib/remote_branch_delete.tcl:297
+#: lib/remote_branch_delete.tcl:305
 #, tcl-format
 msgid "Scanning %s..."
 msgstr "»%s« laden..."
 
-#: lib/remote.tcl:163
-msgid "Remove Remote"
-msgstr "Externes Archiv entfernen"
+#: lib/choose_repository.tcl:45
+msgid "Git Gui"
+msgstr "Git Gui"
 
-#: lib/remote.tcl:168
-msgid "Prune from"
-msgstr "Aufräumen von"
+#: lib/choose_repository.tcl:104 lib/choose_repository.tcl:427
+msgid "Create New Repository"
+msgstr "Neues Projektarchiv"
 
-#: lib/remote.tcl:173
-msgid "Fetch from"
-msgstr "Anfordern von"
+#: lib/choose_repository.tcl:110
+msgid "New..."
+msgstr "Neu..."
 
-#: lib/remote.tcl:215
-msgid "Push to"
-msgstr "Versenden nach"
+#: lib/choose_repository.tcl:117 lib/choose_repository.tcl:511
+msgid "Clone Existing Repository"
+msgstr "Projektarchiv klonen"
 
-#: lib/search.tcl:21
-msgid "Find:"
-msgstr "Suchen:"
+#: lib/choose_repository.tcl:128
+msgid "Clone..."
+msgstr "Klonen..."
 
-#: lib/search.tcl:23
-msgid "Next"
-msgstr "Nächster"
+#: lib/choose_repository.tcl:135 lib/choose_repository.tcl:1105
+msgid "Open Existing Repository"
+msgstr "Projektarchiv öffnen"
 
-#: lib/search.tcl:24
-msgid "Prev"
-msgstr "Voriger"
+#: lib/choose_repository.tcl:141
+msgid "Open..."
+msgstr "Öffnen..."
 
-#: lib/search.tcl:25
-msgid "Case-Sensitive"
-msgstr "Groß-/Kleinschreibung unterscheiden"
+#: lib/choose_repository.tcl:154
+msgid "Recent Repositories"
+msgstr "Zuletzt benutzte Projektarchive"
 
-#: lib/shortcut.tcl:21 lib/shortcut.tcl:62
-msgid "Cannot write shortcut:"
-msgstr "Fehler beim Schreiben der Verknüpfung:"
+#: lib/choose_repository.tcl:164
+msgid "Open Recent Repository:"
+msgstr "Zuletzt benutztes Projektarchiv öffnen:"
 
-#: lib/shortcut.tcl:137
-msgid "Cannot write icon:"
-msgstr "Fehler beim Erstellen des Icons:"
+#: lib/choose_repository.tcl:331 lib/choose_repository.tcl:338
+#: lib/choose_repository.tcl:345
+#, tcl-format
+msgid "Failed to create repository %s:"
+msgstr "Projektarchiv »%s« konnte nicht erstellt werden:"
 
-#: lib/spellcheck.tcl:57
-msgid "Unsupported spell checker"
-msgstr "Rechtschreibprüfungsprogramm nicht unterstützt"
+#: lib/choose_repository.tcl:422 lib/branch_create.tcl:33
+msgid "Create"
+msgstr "Erstellen"
 
-#: lib/spellcheck.tcl:65
-msgid "Spell checking is unavailable"
-msgstr "Rechtschreibprüfung nicht verfügbar"
+#: lib/choose_repository.tcl:432
+msgid "Directory:"
+msgstr "Verzeichnis:"
 
-#: lib/spellcheck.tcl:68
-msgid "Invalid spell checking configuration"
-msgstr "Unbenutzbare Konfiguration der Rechtschreibprüfung"
+#: lib/choose_repository.tcl:462 lib/choose_repository.tcl:588
+#: lib/choose_repository.tcl:1139
+msgid "Git Repository"
+msgstr "Git Projektarchiv"
 
-#: lib/spellcheck.tcl:70
+#: lib/choose_repository.tcl:487
 #, tcl-format
-msgid "Reverting dictionary to %s."
-msgstr "Wörterbuch auf %s zurückgesetzt."
+msgid "Directory %s already exists."
+msgstr "Verzeichnis »%s« existiert bereits."
 
-#: lib/spellcheck.tcl:73
-msgid "Spell checker silently failed on startup"
-msgstr "Rechtschreibprüfungsprogramm mit Fehler abgebrochen"
+#: lib/choose_repository.tcl:491
+#, tcl-format
+msgid "File %s already exists."
+msgstr "Datei »%s« existiert bereits."
 
-#: lib/spellcheck.tcl:80
-msgid "Unrecognized spell checker"
-msgstr "Unbekanntes Rechtschreibprüfungsprogramm"
+#: lib/choose_repository.tcl:506
+msgid "Clone"
+msgstr "Klonen"
 
-#: lib/spellcheck.tcl:186
-msgid "No Suggestions"
-msgstr "Keine Vorschläge"
+#: lib/choose_repository.tcl:519
+msgid "Source Location:"
+msgstr "Herkunft:"
 
-#: lib/spellcheck.tcl:388
-msgid "Unexpected EOF from spell checker"
-msgstr "Unerwartetes EOF vom Rechtschreibprüfungsprogramm"
+#: lib/choose_repository.tcl:528
+msgid "Target Directory:"
+msgstr "Zielverzeichnis:"
 
-#: lib/spellcheck.tcl:392
-msgid "Spell Checker Failed"
-msgstr "Rechtschreibprüfung fehlgeschlagen"
+#: lib/choose_repository.tcl:538
+msgid "Clone Type:"
+msgstr "Art des Klonens:"
 
-#: lib/sshkey.tcl:31
-msgid "No keys found."
-msgstr "Keine Schlüssel gefunden."
+#: lib/choose_repository.tcl:543
+msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+msgstr "Standard (schnell, teilweise redundant, Hardlinks)"
 
-#: lib/sshkey.tcl:34
-#, tcl-format
-msgid "Found a public key in: %s"
-msgstr "Öffentlicher Schlüssel gefunden in: %s"
+#: lib/choose_repository.tcl:548
+msgid "Full Copy (Slower, Redundant Backup)"
+msgstr "Alles kopieren (langsamer, volle Redundanz)"
 
-#: lib/sshkey.tcl:40
-msgid "Generate Key"
-msgstr "Schlüssel erzeugen"
+#: lib/choose_repository.tcl:553
+msgid "Shared (Fastest, Not Recommended, No Backup)"
+msgstr "Verknüpft (schnell, nicht empfohlen, kein Backup)"
 
-#: lib/sshkey.tcl:56
-msgid "Copy To Clipboard"
-msgstr "In Zwischenablage kopieren"
+#: lib/choose_repository.tcl:560
+msgid "Recursively clone submodules too"
+msgstr ""
 
-#: lib/sshkey.tcl:70
-msgid "Your OpenSSH Public Key"
-msgstr "Ihr OpenSSH öffenlicher Schlüssel"
+#: lib/choose_repository.tcl:594 lib/choose_repository.tcl:641
+#: lib/choose_repository.tcl:790 lib/choose_repository.tcl:864
+#: lib/choose_repository.tcl:1145 lib/choose_repository.tcl:1153
+#, tcl-format
+msgid "Not a Git repository: %s"
+msgstr "Kein Git-Projektarchiv in »%s« gefunden."
 
-#: lib/sshkey.tcl:78
-msgid "Generating..."
-msgstr "Erzeugen..."
+#: lib/choose_repository.tcl:630
+msgid "Standard only available for local repository."
+msgstr "Standard ist nur für lokale Projektarchive verfügbar."
 
-#: lib/sshkey.tcl:84
-#, tcl-format
-msgid ""
-"Could not start ssh-keygen:\n"
-"\n"
-"%s"
-msgstr ""
-"Konnte »ssh-keygen« nicht starten:\n"
-"\n"
-"%s"
+#: lib/choose_repository.tcl:634
+msgid "Shared only available for local repository."
+msgstr "Verknüpft ist nur für lokale Projektarchive verfügbar."
 
-#: lib/sshkey.tcl:111
-msgid "Generation failed."
-msgstr "Schlüsselerzeugung fehlgeschlagen."
+#: lib/choose_repository.tcl:655
+#, tcl-format
+msgid "Location %s already exists."
+msgstr "Projektarchiv »%s« existiert bereits."
 
-#: lib/sshkey.tcl:118
-msgid "Generation succeeded, but no keys found."
-msgstr "Schlüsselerzeugung erfolgreich, aber keine Schlüssel gefunden."
+#: lib/choose_repository.tcl:666
+msgid "Failed to configure origin"
+msgstr "Der Ursprungsort konnte nicht eingerichtet werden"
+
+#: lib/choose_repository.tcl:678
+msgid "Counting objects"
+msgstr "Objekte werden gezählt"
+
+#: lib/choose_repository.tcl:679
+msgid "buckets"
+msgstr "Buckets"
 
-#: lib/sshkey.tcl:121
+#: lib/choose_repository.tcl:703
 #, tcl-format
-msgid "Your key is in: %s"
-msgstr "Ihr Schlüssel ist abgelegt in: %s"
+msgid "Unable to copy objects/info/alternates: %s"
+msgstr "Kopien von Objekten/Info/Alternates konnten nicht erstellt werden: %s"
 
-#: lib/status_bar.tcl:83
+#: lib/choose_repository.tcl:740
 #, tcl-format
-msgid "%s ... %*i of %*i %s (%3i%%)"
-msgstr "%s ... %*i von %*i %s (%3i%%)"
+msgid "Nothing to clone from %s."
+msgstr "Von »%s« konnte nichts geklont werden."
 
-#: lib/tools_dlg.tcl:22
-msgid "Add Tool"
-msgstr "Werkzeug hinzufügen"
+#: lib/choose_repository.tcl:742 lib/choose_repository.tcl:962
+#: lib/choose_repository.tcl:974
+msgid "The 'master' branch has not been initialized."
+msgstr "Der »master«-Zweig wurde noch nicht initialisiert."
 
-#: lib/tools_dlg.tcl:28
-msgid "Add New Tool Command"
-msgstr "Neues Kommando für Werkzeug hinzufügen"
+#: lib/choose_repository.tcl:755
+msgid "Hardlinks are unavailable.  Falling back to copying."
+msgstr "Hardlinks nicht verfügbar. Stattdessen wird kopiert."
 
-#: lib/tools_dlg.tcl:33
-msgid "Add globally"
-msgstr "Global hinzufügen"
+#: lib/choose_repository.tcl:769
+#, tcl-format
+msgid "Cloning from %s"
+msgstr "Kopieren von »%s«"
 
-#: lib/tools_dlg.tcl:45
-msgid "Tool Details"
-msgstr "Einzelheiten des Werkzeugs"
+#: lib/choose_repository.tcl:800
+msgid "Copying objects"
+msgstr "Objektdatenbank kopieren"
 
-#: lib/tools_dlg.tcl:48
-msgid "Use '/' separators to create a submenu tree:"
-msgstr "Benutzen Sie einen Schrägstrich »/«, um Untermenüs zu erstellen:"
+#: lib/choose_repository.tcl:801
+msgid "KiB"
+msgstr "KB"
 
-#: lib/tools_dlg.tcl:61
-msgid "Command:"
-msgstr "Kommando:"
+#: lib/choose_repository.tcl:825
+#, tcl-format
+msgid "Unable to copy object: %s"
+msgstr "Objekt kann nicht kopiert werden: %s"
 
-#: lib/tools_dlg.tcl:74
-msgid "Show a dialog before running"
-msgstr "Bestätigungsfrage vor Starten anzeigen"
+#: lib/choose_repository.tcl:837
+msgid "Linking objects"
+msgstr "Objekte verlinken"
 
-#: lib/tools_dlg.tcl:80
-msgid "Ask the user to select a revision (sets $REVISION)"
-msgstr "Benutzer nach Version fragen (setzt $REVISION)"
+#: lib/choose_repository.tcl:838
+msgid "objects"
+msgstr "Objekte"
 
-#: lib/tools_dlg.tcl:85
-msgid "Ask the user for additional arguments (sets $ARGS)"
-msgstr "Benutzer nach zusätzlichen Argumenten fragen (setzt $ARGS)"
+#: lib/choose_repository.tcl:846
+#, tcl-format
+msgid "Unable to hardlink object: %s"
+msgstr "Für Objekt konnte kein Hardlink erstellt werden: %s"
 
-#: lib/tools_dlg.tcl:92
-msgid "Don't show the command output window"
-msgstr "Kein Ausgabefenster zeigen"
+#: lib/choose_repository.tcl:903
+msgid "Cannot fetch branches and objects.  See console output for details."
+msgstr ""
+"Zweige und Objekte konnten nicht angefordert werden.  Kontrollieren Sie die "
+"Ausgaben auf der Konsole für weitere Angaben."
 
-#: lib/tools_dlg.tcl:97
-msgid "Run only if a diff is selected ($FILENAME not empty)"
-msgstr "Nur starten, wenn ein Vergleich gewählt ist ($FILENAME ist nicht leer)"
+#: lib/choose_repository.tcl:914
+msgid "Cannot fetch tags.  See console output for details."
+msgstr ""
+"Markierungen konnten nicht angefordert werden.  Kontrollieren Sie die "
+"Ausgaben auf der Konsole für weitere Angaben."
 
-#: lib/tools_dlg.tcl:121
-msgid "Please supply a name for the tool."
-msgstr "Bitte geben Sie einen Werkzeugnamen an."
+#: lib/choose_repository.tcl:938
+msgid "Cannot determine HEAD.  See console output for details."
+msgstr ""
+"Die Zweigspitze (HEAD) konnte nicht gefunden werden.  Kontrollieren Sie die "
+"Ausgaben auf der Konsole für weitere Angaben."
 
-#: lib/tools_dlg.tcl:129
+#: lib/choose_repository.tcl:947
 #, tcl-format
-msgid "Tool '%s' already exists."
-msgstr "Werkzeug »%s« existiert bereits."
+msgid "Unable to cleanup %s"
+msgstr "Verzeichnis »%s« kann nicht aufgeräumt werden."
 
-#: lib/tools_dlg.tcl:151
+#: lib/choose_repository.tcl:953
+msgid "Clone failed."
+msgstr "Klonen fehlgeschlagen."
+
+#: lib/choose_repository.tcl:960
+msgid "No default branch obtained."
+msgstr "Kein voreingestellter Zweig gefunden."
+
+#: lib/choose_repository.tcl:971
 #, tcl-format
-msgid ""
-"Could not add tool:\n"
-"%s"
-msgstr ""
-"Werkzeug konnte nicht hinzugefügt werden:\n"
-"\n"
-"%s"
+msgid "Cannot resolve %s as a commit."
+msgstr "»%s« wurde nicht als Version gefunden."
 
-#: lib/tools_dlg.tcl:190
-msgid "Remove Tool"
-msgstr "Werkzeug entfernen"
+#: lib/choose_repository.tcl:998
+msgid "Creating working directory"
+msgstr "Arbeitskopie erstellen"
 
-#: lib/tools_dlg.tcl:196
-msgid "Remove Tool Commands"
-msgstr "Werkzeugkommandos entfernen"
+#: lib/choose_repository.tcl:1028
+msgid "Initial file checkout failed."
+msgstr "Erstellen der Arbeitskopie fehlgeschlagen."
 
-#: lib/tools_dlg.tcl:200
-msgid "Remove"
-msgstr "Entfernen"
+#: lib/choose_repository.tcl:1072
+#, fuzzy
+msgid "Cloning submodules"
+msgstr "Kopieren von »%s«"
 
-#: lib/tools_dlg.tcl:236
-msgid "(Blue denotes repository-local tools)"
-msgstr "(Werkzeuge für lokales Archiv werden in Blau angezeigt)"
+#: lib/choose_repository.tcl:1087
+msgid "Cannot clone submodules."
+msgstr ""
+
+#: lib/choose_repository.tcl:1110
+msgid "Repository:"
+msgstr "Projektarchiv:"
 
-#: lib/tools_dlg.tcl:297
+#: lib/choose_repository.tcl:1159
 #, tcl-format
-msgid "Run Command: %s"
-msgstr "Kommando aufrufen: %s"
+msgid "Failed to open repository %s:"
+msgstr "Projektarchiv »%s« konnte nicht geöffnet werden."
 
-#: lib/tools_dlg.tcl:311
-msgid "Arguments"
-msgstr "Argumente"
+#: lib/about.tcl:26
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui - eine grafische Oberfläche für Git."
 
-#: lib/tools_dlg.tcl:348
-msgid "OK"
-msgstr "Ok"
+#: lib/blame.tcl:74
+#, fuzzy, tcl-format
+msgid "%s (%s): File Viewer"
+msgstr "Datei-Browser"
 
-#: lib/tools.tcl:75
-#, tcl-format
-msgid "Running %s requires a selected file."
-msgstr "Um »%s« zu starten, muss eine Datei ausgewählt sein."
+#: lib/blame.tcl:80
+msgid "Commit:"
+msgstr "Version:"
 
-#: lib/tools.tcl:90
-#, tcl-format
-msgid "Are you sure you want to run %s?"
-msgstr "Wollen Sie %s wirklich starten?"
+#: lib/blame.tcl:282
+msgid "Copy Commit"
+msgstr "Version kopieren"
 
-#: lib/tools.tcl:110
-#, tcl-format
-msgid "Tool: %s"
-msgstr "Werkzeug: %s"
+#: lib/blame.tcl:286
+msgid "Find Text..."
+msgstr "Text suchen..."
 
-#: lib/tools.tcl:111
-#, tcl-format
-msgid "Running: %s"
-msgstr "Starten: %s"
+#: lib/blame.tcl:290
+#, fuzzy
+msgid "Goto Line..."
+msgstr "Klonen..."
 
-#: lib/tools.tcl:149
-#, tcl-format
-msgid "Tool completed successfully: %s"
-msgstr "Werkzeug erfolgreich abgeschlossen: %s"
+#: lib/blame.tcl:299
+msgid "Do Full Copy Detection"
+msgstr "Volle Kopie-Erkennung"
 
-#: lib/tools.tcl:151
-#, tcl-format
-msgid "Tool failed: %s"
-msgstr "Werkzeug fehlgeschlagen: %s"
+#: lib/blame.tcl:303
+msgid "Show History Context"
+msgstr "Historien-Kontext anzeigen"
 
-#: lib/transport.tcl:7
-#, tcl-format
-msgid "Fetching new changes from %s"
-msgstr "Neue Änderungen von »%s« holen"
+#: lib/blame.tcl:306
+msgid "Blame Parent Commit"
+msgstr "Elternversion annotieren"
 
-#: lib/transport.tcl:18
+#: lib/blame.tcl:468
 #, tcl-format
-msgid "remote prune %s"
-msgstr "Aufräumen von »%s«"
+msgid "Reading %s..."
+msgstr "%s lesen..."
 
-#: lib/transport.tcl:19
-#, tcl-format
-msgid "Pruning tracking branches deleted from %s"
-msgstr "Übernahmezweige aufräumen und entfernen, die in »%s« gelöscht wurden"
+#: lib/blame.tcl:596
+msgid "Loading copy/move tracking annotations..."
+msgstr "Annotierungen für Kopieren/Verschieben werden geladen..."
 
-#: lib/transport.tcl:26
-#, tcl-format
-msgid "Pushing changes to %s"
-msgstr "Änderungen nach »%s« versenden"
+#: lib/blame.tcl:613
+msgid "lines annotated"
+msgstr "Zeilen annotiert"
 
-#: lib/transport.tcl:64
-#, tcl-format
-msgid "Mirroring to %s"
-msgstr "Spiegeln nach %s"
+#: lib/blame.tcl:815
+msgid "Loading original location annotations..."
+msgstr "Annotierungen für ursprünglichen Ort werden geladen..."
 
-#: lib/transport.tcl:82
-#, tcl-format
-msgid "Pushing %s %s to %s"
-msgstr "%s %s nach %s versenden"
+#: lib/blame.tcl:818
+msgid "Annotation complete."
+msgstr "Annotierung vollständig."
 
-#: lib/transport.tcl:100
-msgid "Push Branches"
-msgstr "Zweige versenden"
+#: lib/blame.tcl:849
+msgid "Busy"
+msgstr "Verarbeitung läuft"
 
-#: lib/transport.tcl:114
-msgid "Source Branches"
-msgstr "Lokale Zweige"
+#: lib/blame.tcl:850
+msgid "Annotation process is already running."
+msgstr "Annotierung läuft bereits."
 
-#: lib/transport.tcl:131
-msgid "Destination Repository"
-msgstr "Ziel-Projektarchiv"
+#: lib/blame.tcl:889
+msgid "Running thorough copy detection..."
+msgstr "Intensive Kopie-Erkennung läuft..."
 
-#: lib/transport.tcl:169
-msgid "Transfer Options"
-msgstr "Netzwerk-Einstellungen"
+#: lib/blame.tcl:957
+msgid "Loading annotation..."
+msgstr "Annotierung laden..."
 
-#: lib/transport.tcl:171
-msgid "Force overwrite existing branch (may discard changes)"
-msgstr ""
-"Überschreiben von existierenden Zweigen erzwingen (könnte Änderungen löschen)"
+#: lib/blame.tcl:1010
+msgid "Author:"
+msgstr "Autor:"
 
-#: lib/transport.tcl:175
-msgid "Use thin pack (for slow network connections)"
-msgstr "Kompaktes Datenformat benutzen (für langsame Netzverbindungen)"
+#: lib/blame.tcl:1014
+msgid "Committer:"
+msgstr "Eintragender:"
 
-#: lib/transport.tcl:179
-msgid "Include tags"
-msgstr "Mit Markierungen übertragen"
+#: lib/blame.tcl:1019
+msgid "Original File:"
+msgstr "Ursprüngliche Datei:"
+
+#: lib/blame.tcl:1067
+msgid "Cannot find HEAD commit:"
+msgstr "Zweigspitze (»HEAD«) kann nicht gefunden werden:"
+
+#: lib/blame.tcl:1122
+msgid "Cannot find parent commit:"
+msgstr "Elternversion kann nicht gefunden werden:"
+
+#: lib/blame.tcl:1137
+msgid "Unable to display parent"
+msgstr "Elternversion kann nicht angezeigt werden"
+
+#: lib/blame.tcl:1138 lib/diff.tcl:345
+msgid "Error loading diff:"
+msgstr "Fehler beim Laden des Vergleichs:"
+
+#: lib/blame.tcl:1279
+msgid "Originally By:"
+msgstr "Ursprünglich von:"
+
+#: lib/blame.tcl:1285
+msgid "In File:"
+msgstr "In Datei:"
+
+#: lib/blame.tcl:1290
+msgid "Copied Or Moved Here By:"
+msgstr "Kopiert oder verschoben durch:"
+
+#: lib/diff.tcl:77
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may have "
+"the same state."
+msgstr ""
+"Keine Änderungen feststellbar.\n"
+"\n"
+"»%s« enthält keine Änderungen. Zwar wurde das Änderungsdatum dieser Datei "
+"von einem anderen Programm modifiziert, aber der Inhalt der Datei ist "
+"unverändert.\n"
+"\n"
+"Das Arbeitsverzeichnis wird jetzt neu geladen, um diese Änderung bei allen "
+"Dateien zu prüfen."
+
+#: lib/diff.tcl:117
+#, tcl-format
+msgid "Loading diff of %s..."
+msgstr "Vergleich von »%s« laden..."
+
+#: lib/diff.tcl:143
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+"LOKAL: gelöscht\n"
+"ANDERES:\n"
+
+#: lib/diff.tcl:148
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+"ANDERES: gelöscht\n"
+"LOKAL:\n"
+
+#: lib/diff.tcl:155
+msgid "LOCAL:\n"
+msgstr "LOKAL:\n"
+
+#: lib/diff.tcl:158
+msgid "REMOTE:\n"
+msgstr "ANDERES:\n"
+
+#: lib/diff.tcl:220 lib/diff.tcl:344
+#, tcl-format
+msgid "Unable to display %s"
+msgstr "Datei »%s« kann nicht angezeigt werden"
+
+#: lib/diff.tcl:221
+msgid "Error loading file:"
+msgstr "Fehler beim Laden der Datei:"
+
+#: lib/diff.tcl:227
+msgid "Git Repository (subproject)"
+msgstr "Git-Projektarchiv (Unterprojekt)"
+
+#: lib/diff.tcl:239
+msgid "* Binary file (not showing content)."
+msgstr "* Binärdatei (Inhalt wird nicht angezeigt)"
+
+#: lib/diff.tcl:244
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"* Datei nicht unter Versionskontrolle, Dateigröße %d Bytes.\n"
+"* Nur erste %d Bytes werden angezeigt.\n"
+
+#: lib/diff.tcl:250
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"* Datei nicht unter Versionskontrolle, hier abgeschnitten durch %s.\n"
+"* Zum Ansehen der vollständigen Datei externen Editor benutzen.\n"
+
+#: lib/diff.tcl:583
+msgid "Failed to unstage selected hunk."
+msgstr ""
+"Fehler beim Herausnehmen des gewählten Kontexts aus der Bereitstellung."
+
+#: lib/diff.tcl:591
+#, fuzzy
+msgid "Failed to revert selected hunk."
+msgstr "Fehler beim Bereitstellen des gewählten Kontexts."
+
+#: lib/diff.tcl:594
+msgid "Failed to stage selected hunk."
+msgstr "Fehler beim Bereitstellen des gewählten Kontexts."
+
+#: lib/diff.tcl:687
+msgid "Failed to unstage selected line."
+msgstr "Fehler beim Herausnehmen der gewählten Zeile aus der Bereitstellung."
+
+#: lib/diff.tcl:696
+#, fuzzy
+msgid "Failed to revert selected line."
+msgstr "Fehler beim Bereitstellen der gewählten Zeile."
+
+#: lib/diff.tcl:700
+msgid "Failed to stage selected line."
+msgstr "Fehler beim Bereitstellen der gewählten Zeile."
+
+#: lib/diff.tcl:889
+#, fuzzy
+msgid "Failed to undo last revert."
+msgstr "Aktualisieren von »%s« fehlgeschlagen."
+
+#: lib/sshkey.tcl:34
+msgid "No keys found."
+msgstr "Keine Schlüssel gefunden."
+
+#: lib/sshkey.tcl:37
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "Öffentlicher Schlüssel gefunden in: %s"
+
+#: lib/sshkey.tcl:43
+msgid "Generate Key"
+msgstr "Schlüssel erzeugen"
+
+#: lib/sshkey.tcl:61
+msgid "Copy To Clipboard"
+msgstr "In Zwischenablage kopieren"
+
+#: lib/sshkey.tcl:75
+msgid "Your OpenSSH Public Key"
+msgstr "Ihr OpenSSH öffenlicher Schlüssel"
+
+#: lib/sshkey.tcl:83
+msgid "Generating..."
+msgstr "Erzeugen..."
+
+#: lib/sshkey.tcl:89
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"Konnte »ssh-keygen« nicht starten:\n"
+"\n"
+"%s"
+
+#: lib/sshkey.tcl:116
+msgid "Generation failed."
+msgstr "Schlüsselerzeugung fehlgeschlagen."
+
+#: lib/sshkey.tcl:123
+msgid "Generation succeeded, but no keys found."
+msgstr "Schlüsselerzeugung erfolgreich, aber keine Schlüssel gefunden."
+
+#: lib/sshkey.tcl:126
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "Ihr Schlüssel ist abgelegt in: %s"
+
+#: lib/branch_create.tcl:23
+#, fuzzy, tcl-format
+msgid "%s (%s): Create Branch"
+msgstr "Zweig erstellen"
+
+#: lib/branch_create.tcl:28
+msgid "Create New Branch"
+msgstr "Neuen Zweig erstellen"
+
+#: lib/branch_create.tcl:42
+msgid "Branch Name"
+msgstr "Zweigname"
+
+#: lib/branch_create.tcl:57
+msgid "Match Tracking Branch Name"
+msgstr "Passend zu Übernahmezweig-Name"
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "Anfangsversion"
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "Existierenden Zweig aktualisieren:"
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "Nein"
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "Nur Schnellzusammenführung"
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "Arbeitskopie umstellen nach Erstellen"
+
+#: lib/branch_create.tcl:132
+msgid "Please select a tracking branch."
+msgstr "Bitte wählen Sie einen Übernahmezweig."
+
+#: lib/branch_create.tcl:141
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "Übernahmezweig »%s« ist kein Zweig im externen Projektarchiv."
+
+#: lib/console.tcl:59
+msgid "Working... please wait..."
+msgstr "Verarbeitung. Bitte warten..."
+
+#: lib/console.tcl:186
+msgid "Success"
+msgstr "Erfolgreich"
+
+#: lib/console.tcl:200
+msgid "Error: Command Failed"
+msgstr "Fehler: Kommando fehlgeschlagen"
+
+#: lib/line.tcl:17
+msgid "Goto Line:"
+msgstr ""
+
+#: lib/line.tcl:23
+msgid "Go"
+msgstr ""
+
+#: lib/choose_rev.tcl:52
+msgid "This Detached Checkout"
+msgstr "Abgetrennte Arbeitskopie-Version"
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "Version Regexp-Ausdruck:"
+
+#: lib/choose_rev.tcl:72
+msgid "Local Branch"
+msgstr "Lokaler Zweig"
+
+#: lib/choose_rev.tcl:77
+msgid "Tracking Branch"
+msgstr "Übernahmezweig"
+
+#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
+msgid "Tag"
+msgstr "Markierung"
+
+#: lib/choose_rev.tcl:321
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Ungültige Version: %s"
+
+#: lib/choose_rev.tcl:342
+msgid "No revision selected."
+msgstr "Keine Version ausgewählt."
+
+#: lib/choose_rev.tcl:350
+msgid "Revision expression is empty."
+msgstr "Versions-Ausdruck ist leer."
+
+#: lib/choose_rev.tcl:537
+msgid "Updated"
+msgstr "Aktualisiert"
+
+#: lib/choose_rev.tcl:565
+msgid "URL"
+msgstr "URL"
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit before this "
+"to amend.\n"
+msgstr ""
+"Keine Version zur Nachbesserung vorhanden.\n"
+"\n"
+"Sie sind dabei, die erste Version zu übertragen. Es gibt keine existierende "
+"Version, die Sie nachbessern könnten.\n"
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort the "
+"current merge activity.\n"
+msgstr ""
+"Nachbesserung währen Zusammenführung nicht möglich.\n"
+"\n"
+"Sie haben das Zusammenführen von Versionen angefangen, aber noch nicht "
+"beendet. Sie können keine vorige Übertragung nachbessern, solange eine "
+"unfertige Zusammenführung existiert. Dazu müssen Sie die Zusammenführung "
+"beenden oder abbrechen.\n"
+
+#: lib/commit.tcl:56
+msgid "Error loading commit data for amend:"
+msgstr "Fehler beim Laden der Versionsdaten für Nachbessern:"
+
+#: lib/commit.tcl:83
+msgid "Unable to obtain your identity:"
+msgstr "Benutzername konnte nicht bestimmt werden:"
+
+#: lib/commit.tcl:88
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "Ungültiger Wert von GIT_COMMITTER_INDENT:"
+
+#: lib/commit.tcl:138
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "Warning: Tcl/Tk unterstützt die Zeichencodierung »%s« nicht."
+
+#: lib/commit.tcl:158
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
+"\n"
+"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
+"geändert.  Vor dem Eintragen einer neuen Version muss neu geladen werden.\n"
+"\n"
+"Es wird gleich neu geladen.\n"
+
+#: lib/commit.tcl:182
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the file "
+"before committing.\n"
+msgstr ""
+"Nicht zusammengeführte Dateien können nicht eingetragen werden.\n"
+"\n"
+"Die Datei »%s« hat noch nicht aufgelöste Zusammenführungs-Konflikte. Sie "
+"müssen diese Konflikte auflösen, bevor Sie eintragen können.\n"
+
+#: lib/commit.tcl:190
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"Unbekannter Dateizustand »%s«.\n"
+"\n"
+"Datei »%s« kann nicht eingetragen werden.\n"
+
+#: lib/commit.tcl:198
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"Keine Änderungen vorhanden, die eingetragen werden könnten.\n"
+"\n"
+"Sie müssen mindestens eine Datei bereitstellen, bevor Sie eintragen können.\n"
+
+#: lib/commit.tcl:213
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentence what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
+msgstr ""
+"Bitte geben Sie eine Versionsbeschreibung ein.\n"
+"\n"
+"Eine gute Versionsbeschreibung enthält folgende Abschnitte:\n"
+"\n"
+"- Erste Zeile: Eine Zusammenfassung, was man gemacht hat.\n"
+"\n"
+"- Zweite Zeile: Leerzeile\n"
+"\n"
+"- Rest: Eine ausführliche Beschreibung, warum diese Änderung hilfreich ist.\n"
+
+#: lib/commit.tcl:244
+msgid "Calling pre-commit hook..."
+msgstr "Aufrufen der Vor-Eintragen-Kontrolle (»pre-commit hook«)..."
+
+#: lib/commit.tcl:259
+msgid "Commit declined by pre-commit hook."
+msgstr "Eintragen abgelehnt durch Vor-Eintragen-Kontrolle (»pre-commit hook«)."
+
+#: lib/commit.tcl:278
+msgid ""
+"You are about to commit on a detached head. This is a potentially dangerous "
+"thing to do because if you switch to another branch you will lose your "
+"changes and it can be difficult to retrieve them later from the reflog. You "
+"should probably cancel this commit and create a new branch to continue.\n"
+" \n"
+" Do you really want to proceed with your Commit?"
+msgstr ""
+
+#: lib/commit.tcl:299
+msgid "Calling commit-msg hook..."
+msgstr ""
+"Aufrufen der Versionsbeschreibungs-Kontrolle (»commit-message hook«)..."
+
+#: lib/commit.tcl:314
+msgid "Commit declined by commit-msg hook."
+msgstr ""
+"Eintragen abgelehnt durch Versionsbeschreibungs-Kontrolle (»commit-message "
+"hook«)."
+
+#: lib/commit.tcl:327
+msgid "Committing changes..."
+msgstr "Änderungen eintragen..."
+
+#: lib/commit.tcl:344
+msgid "write-tree failed:"
+msgstr "write-tree fehlgeschlagen:"
+
+#: lib/commit.tcl:345 lib/commit.tcl:395 lib/commit.tcl:422
+msgid "Commit failed."
+msgstr "Eintragen fehlgeschlagen."
+
+#: lib/commit.tcl:362
+#, tcl-format
+msgid "Commit %s appears to be corrupt"
+msgstr "Version »%s« scheint beschädigt zu sein"
+
+#: lib/commit.tcl:367
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"Keine Änderungen einzutragen.\n"
+"\n"
+"Es gibt keine geänderte Datei bei dieser Version und es wurde auch nichts "
+"zusammengeführt.\n"
+"\n"
+"Das Arbeitsverzeichnis wird daher jetzt neu geladen.\n"
+
+#: lib/commit.tcl:374
+msgid "No changes to commit."
+msgstr "Keine Änderungen, die eingetragen werden können."
+
+#: lib/commit.tcl:394
+msgid "commit-tree failed:"
+msgstr "commit-tree fehlgeschlagen:"
+
+#: lib/commit.tcl:421
+msgid "update-ref failed:"
+msgstr "update-ref fehlgeschlagen:"
+
+#: lib/commit.tcl:514
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "Version %s übertragen: %s"
+
+#: lib/branch_delete.tcl:16
+#, fuzzy, tcl-format
+msgid "%s (%s): Delete Branch"
+msgstr "Zweig löschen"
+
+#: lib/branch_delete.tcl:21
+msgid "Delete Local Branch"
+msgstr "Lokalen Zweig löschen"
+
+#: lib/branch_delete.tcl:39
+msgid "Local Branches"
+msgstr "Lokale Zweige"
+
+#: lib/branch_delete.tcl:51
+msgid "Delete Only If Merged Into"
+msgstr "Nur löschen, wenn zusammengeführt nach"
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr "Folgende Zweige sind noch nicht mit »%s« zusammengeführt:"
+
+#: lib/branch_delete.tcl:131
+#, tcl-format
+msgid " - %s:"
+msgstr ""
+
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"Fehler beim Löschen der Zweige:\n"
+"%s"
+
+#: lib/date.tcl:25
+#, tcl-format
+msgid "Invalid date from Git: %s"
+msgstr "Ungültiges Datum von Git: %s"
+
+#: lib/database.tcl:42
+msgid "Number of loose objects"
+msgstr "Anzahl unverknüpfter Objekte"
+
+#: lib/database.tcl:43
+msgid "Disk space used by loose objects"
+msgstr "Festplattenplatz von unverknüpften Objekten"
+
+#: lib/database.tcl:44
+msgid "Number of packed objects"
+msgstr "Anzahl komprimierter Objekte"
+
+#: lib/database.tcl:45
+msgid "Number of packs"
+msgstr "Anzahl Komprimierungseinheiten"
+
+#: lib/database.tcl:46
+msgid "Disk space used by packed objects"
+msgstr "Festplattenplatz von komprimierten Objekten"
+
+#: lib/database.tcl:47
+msgid "Packed objects waiting for pruning"
+msgstr "Komprimierte Objekte, die zum Aufräumen vorgesehen sind"
+
+#: lib/database.tcl:48
+msgid "Garbage files"
+msgstr "Dateien im Mülleimer"
+
+#: lib/database.tcl:66
+#, fuzzy, tcl-format
+msgid "%s (%s): Database Statistics"
+msgstr "Datenbankstatistik"
+
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "Objektdatenbank komprimieren"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "Die Objektdatenbank durch »fsck-objects« überprüfen lassen"
+
+#: lib/database.tcl:107
+#, tcl-format
+msgid ""
+"This repository currently has approximately %i loose objects.\n"
+"\n"
+"To maintain optimal performance it is strongly recommended that you compress "
+"the database.\n"
+"\n"
+"Compress the database now?"
+msgstr ""
+"Dieses Projektarchiv enthält ungefähr %i nicht verknüpfte Objekte.\n"
+"\n"
+"Für eine optimale Performance wird empfohlen, die Datenbank des "
+"Projektarchivs zu komprimieren.\n"
+"\n"
+"Soll die Datenbank jetzt komprimiert werden?"
+
+#: lib/error.tcl:20
+#, fuzzy, tcl-format
+msgid "%s: error"
+msgstr "Fehler"
+
+#: lib/error.tcl:36
+#, fuzzy, tcl-format
+msgid "%s: warning"
+msgstr "Warnung"
+
+#: lib/error.tcl:80
+#, fuzzy, tcl-format
+msgid "%s hook failed:"
+msgstr "Werkzeug fehlgeschlagen: %s"
+
+#: lib/error.tcl:96
+msgid "You must correct the above errors before committing."
+msgstr ""
+"Sie müssen die obigen Fehler zuerst beheben, bevor Sie eintragen können."
+
+#: lib/error.tcl:116
+#, tcl-format
+msgid "%s (%s): error"
+msgstr ""
+
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
+msgstr ""
+"Zusammenführen kann nicht gleichzeitig mit Nachbessern durchgeführt werden.\n"
+"\n"
+"Sie müssen zuerst die Nachbesserungs-Version abschließen, bevor Sie "
+"zusammenführen können.\n"
+
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Der letzte geladene Status stimmt nicht mehr mit dem Projektarchiv überein.\n"
+"\n"
+"Ein anderes Git-Programm hat das Projektarchiv seit dem letzten Laden "
+"geändert.  Vor einem Zusammenführen muss neu geladen werden.\n"
+"\n"
+"Es wird gleich neu geladen.\n"
+
+#: lib/merge.tcl:45
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the current "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+"Zusammenführung mit Konflikten.\n"
+"\n"
+"Die Datei »%s« enthält Konflikte beim Zusammenführen. Sie müssen diese "
+"Konflikte per Hand auflösen. Anschließend müssen Sie die Datei wieder "
+"bereitstellen und eintragen, um die Zusammenführung abzuschließen. Erst "
+"danach kann eine neue Zusammenführung begonnen werden.\n"
+
+#: lib/merge.tcl:55
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doing so "
+"will help you abort a failed merge, should the need arise.\n"
+msgstr ""
+"Es liegen Änderungen vor.\n"
+"\n"
+"Die Datei »%s« wurde geändert.  Sie sollten zuerst die bereitgestellte "
+"Version abschließen, bevor Sie eine Zusammenführung beginnen.  Mit dieser "
+"Reihenfolge können Sie mögliche Konflikte beim Zusammenführen wesentlich "
+"einfacher beheben oder abbrechen.\n"
+
+#: lib/merge.tcl:108
+#, tcl-format
+msgid "%s of %s"
+msgstr "%s von %s"
+
+#: lib/merge.tcl:126
+#, tcl-format
+msgid "Merging %s and %s..."
+msgstr "Zusammenführen von %s und %s..."
+
+#: lib/merge.tcl:137
+msgid "Merge completed successfully."
+msgstr "Zusammenführen erfolgreich abgeschlossen."
+
+#: lib/merge.tcl:139
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "Zusammenführen fehlgeschlagen. Konfliktauflösung ist notwendig."
+
+#: lib/merge.tcl:156
+#, tcl-format
+msgid "%s (%s): Merge"
+msgstr ""
+
+#: lib/merge.tcl:164
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "Zusammenführen in »%s«"
+
+#: lib/merge.tcl:183
+msgid "Revision To Merge"
+msgstr "Zusammenzuführende Version"
+
+#: lib/merge.tcl:218
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"Abbruch der Nachbesserung ist nicht möglich.\n"
+"\n"
+"Sie müssen die Nachbesserung der Version abschließen.\n"
+
+#: lib/merge.tcl:228
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"Zusammenführen abbrechen?\n"
+"\n"
+"Wenn Sie abbrechen, gehen alle noch nicht eingetragenen Änderungen "
+"verloren.\n"
+"\n"
+"Zusammenführen jetzt abbrechen?"
+
+#: lib/merge.tcl:234
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr ""
+"Änderungen zurücksetzen?\n"
+"\n"
+"Wenn Sie zurücksetzen, gehen alle noch nicht eingetragenen Änderungen "
+"verloren.\n"
+"\n"
+"Änderungen jetzt zurücksetzen?"
+
+#: lib/merge.tcl:246
+msgid "Aborting"
+msgstr "Abbruch"
+
+#: lib/merge.tcl:247
+msgid "files reset"
+msgstr "Dateien zurückgesetzt"
+
+#: lib/merge.tcl:277
+msgid "Abort failed."
+msgstr "Abbruch fehlgeschlagen."
+
+#: lib/merge.tcl:279
+msgid "Abort completed.  Ready."
+msgstr "Abbruch durchgeführt. Bereit."
+
+#~ msgid "Displaying only %s of %s files."
+#~ msgstr "Nur %s von %s Dateien werden angezeigt."
+
+#~ msgid "New Commit"
+#~ msgstr "Neue Version"
+
+#~ msgid "Case-Sensitive"
+#~ msgstr "Groß-/Kleinschreibung unterscheiden"
diff --git a/po/git-gui.pot b/po/git-gui.pot
index 0c94f9c2c6..b79ed4e133 100644
--- a/po/git-gui.pot
+++ b/po/git-gui.pot
@@ -8,41 +8,42 @@ msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2010-01-26 15:47-0800\n"
+"POT-Creation-Date: 2020-02-08 22:54+0100\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
+"Language: \n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=CHARSET\n"
 "Content-Transfer-Encoding: 8bit\n"
 
-#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.sh:903
-#: git-gui.sh:922
-msgid "git-gui: fatal error"
-msgstr ""
-
-#: git-gui.sh:743
+#: git-gui.sh:847
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr ""
 
-#: git-gui.sh:779
+#: git-gui.sh:901
 msgid "Main Font"
 msgstr ""
 
-#: git-gui.sh:780
+#: git-gui.sh:902
 msgid "Diff/Console Font"
 msgstr ""
 
-#: git-gui.sh:794
+#: git-gui.sh:917 git-gui.sh:931 git-gui.sh:944 git-gui.sh:1034 git-gui.sh:1053
+#: git-gui.sh:3212
+msgid "git-gui: fatal error"
+msgstr ""
+
+#: git-gui.sh:918
 msgid "Cannot find git in PATH."
 msgstr ""
 
-#: git-gui.sh:821
+#: git-gui.sh:945
 msgid "Cannot parse Git version string:"
 msgstr ""
 
-#: git-gui.sh:839
+#: git-gui.sh:970
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -54,473 +55,518 @@ msgid ""
 "Assume '%s' is version 1.5.0?\n"
 msgstr ""
 
-#: git-gui.sh:1128
+#: git-gui.sh:1267
 msgid "Git directory not found:"
 msgstr ""
 
-#: git-gui.sh:1146
+#: git-gui.sh:1301
 msgid "Cannot move to top of working directory:"
 msgstr ""
 
-#: git-gui.sh:1154
+#: git-gui.sh:1309
 msgid "Cannot use bare repository:"
 msgstr ""
 
-#: git-gui.sh:1162
+#: git-gui.sh:1317
 msgid "No working directory"
 msgstr ""
 
-#: git-gui.sh:1334 lib/checkout_op.tcl:306
+#: git-gui.sh:1491 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr ""
 
-#: git-gui.sh:1390
+#: git-gui.sh:1551
 msgid "Scanning for modified files ..."
 msgstr ""
 
-#: git-gui.sh:1454
+#: git-gui.sh:1629
 msgid "Calling prepare-commit-msg hook..."
 msgstr ""
 
-#: git-gui.sh:1471
+#: git-gui.sh:1646
 msgid "Commit declined by prepare-commit-msg hook."
 msgstr ""
 
-#: git-gui.sh:1629 lib/browser.tcl:246
+#: git-gui.sh:1804 lib/browser.tcl:252
 msgid "Ready."
 msgstr ""
 
-#: git-gui.sh:1787
+#: git-gui.sh:1968
 #, tcl-format
-msgid "Displaying only %s of %s files."
+msgid ""
+"Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files."
 msgstr ""
 
-#: git-gui.sh:1913
+#: git-gui.sh:2091
 msgid "Unmodified"
 msgstr ""
 
-#: git-gui.sh:1915
+#: git-gui.sh:2093
 msgid "Modified, not staged"
 msgstr ""
 
-#: git-gui.sh:1916 git-gui.sh:1924
+#: git-gui.sh:2094 git-gui.sh:2106
 msgid "Staged for commit"
 msgstr ""
 
-#: git-gui.sh:1917 git-gui.sh:1925
+#: git-gui.sh:2095 git-gui.sh:2107
 msgid "Portions staged for commit"
 msgstr ""
 
-#: git-gui.sh:1918 git-gui.sh:1926
+#: git-gui.sh:2096 git-gui.sh:2108
 msgid "Staged for commit, missing"
 msgstr ""
 
-#: git-gui.sh:1920
+#: git-gui.sh:2098
 msgid "File type changed, not staged"
 msgstr ""
 
-#: git-gui.sh:1921
+#: git-gui.sh:2099 git-gui.sh:2100
+msgid "File type changed, old type staged for commit"
+msgstr ""
+
+#: git-gui.sh:2101
 msgid "File type changed, staged"
 msgstr ""
 
-#: git-gui.sh:1923
+#: git-gui.sh:2102
+msgid "File type change staged, modification not staged"
+msgstr ""
+
+#: git-gui.sh:2103
+msgid "File type change staged, file missing"
+msgstr ""
+
+#: git-gui.sh:2105
 msgid "Untracked, not staged"
 msgstr ""
 
-#: git-gui.sh:1928
+#: git-gui.sh:2110
 msgid "Missing"
 msgstr ""
 
-#: git-gui.sh:1929
+#: git-gui.sh:2111
 msgid "Staged for removal"
 msgstr ""
 
-#: git-gui.sh:1930
+#: git-gui.sh:2112
 msgid "Staged for removal, still present"
 msgstr ""
 
-#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
-#: git-gui.sh:1936 git-gui.sh:1937
+#: git-gui.sh:2114 git-gui.sh:2115 git-gui.sh:2116 git-gui.sh:2117
+#: git-gui.sh:2118 git-gui.sh:2119
 msgid "Requires merge resolution"
 msgstr ""
 
-#: git-gui.sh:1972
-msgid "Starting gitk... please wait..."
+#: git-gui.sh:2164
+msgid "Couldn't find gitk in PATH"
 msgstr ""
 
-#: git-gui.sh:1984
-msgid "Couldn't find gitk in PATH"
+#: git-gui.sh:2210 git-gui.sh:2245
+#, tcl-format
+msgid "Starting %s... please wait..."
 msgstr ""
 
-#: git-gui.sh:2043
+#: git-gui.sh:2224
 msgid "Couldn't find git gui in PATH"
 msgstr ""
 
-#: git-gui.sh:2455 lib/choose_repository.tcl:36
+#: git-gui.sh:2726 lib/choose_repository.tcl:53
 msgid "Repository"
 msgstr ""
 
-#: git-gui.sh:2456
+#: git-gui.sh:2727
 msgid "Edit"
 msgstr ""
 
-#: git-gui.sh:2458 lib/choose_rev.tcl:561
+#: git-gui.sh:2729 lib/choose_rev.tcl:567
 msgid "Branch"
 msgstr ""
 
-#: git-gui.sh:2461 lib/choose_rev.tcl:548
+#: git-gui.sh:2732 lib/choose_rev.tcl:554
 msgid "Commit@@noun"
 msgstr ""
 
-#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+#: git-gui.sh:2735 lib/merge.tcl:127 lib/merge.tcl:174
 msgid "Merge"
 msgstr ""
 
-#: git-gui.sh:2465 lib/choose_rev.tcl:557
+#: git-gui.sh:2736 lib/choose_rev.tcl:563
 msgid "Remote"
 msgstr ""
 
-#: git-gui.sh:2468
+#: git-gui.sh:2739
 msgid "Tools"
 msgstr ""
 
-#: git-gui.sh:2477
+#: git-gui.sh:2748
 msgid "Explore Working Copy"
 msgstr ""
 
-#: git-gui.sh:2483
+#: git-gui.sh:2763
+msgid "Git Bash"
+msgstr ""
+
+#: git-gui.sh:2772
 msgid "Browse Current Branch's Files"
 msgstr ""
 
-#: git-gui.sh:2487
+#: git-gui.sh:2776
 msgid "Browse Branch Files..."
 msgstr ""
 
-#: git-gui.sh:2492
+#: git-gui.sh:2781
 msgid "Visualize Current Branch's History"
 msgstr ""
 
-#: git-gui.sh:2496
+#: git-gui.sh:2785
 msgid "Visualize All Branch History"
 msgstr ""
 
-#: git-gui.sh:2503
+#: git-gui.sh:2792
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr ""
 
-#: git-gui.sh:2505
+#: git-gui.sh:2794
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr ""
 
-#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2799 lib/database.tcl:40
 msgid "Database Statistics"
 msgstr ""
 
-#: git-gui.sh:2513 lib/database.tcl:34
+#: git-gui.sh:2802 lib/database.tcl:33
 msgid "Compress Database"
 msgstr ""
 
-#: git-gui.sh:2516
+#: git-gui.sh:2805
 msgid "Verify Database"
 msgstr ""
 
-#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
-#: lib/shortcut.tcl:40 lib/shortcut.tcl:72
+#: git-gui.sh:2812 git-gui.sh:2816 git-gui.sh:2820
 msgid "Create Desktop Icon"
 msgstr ""
 
-#: git-gui.sh:2539 lib/choose_repository.tcl:183 lib/choose_repository.tcl:191
+#: git-gui.sh:2828 lib/choose_repository.tcl:209 lib/choose_repository.tcl:217
 msgid "Quit"
 msgstr ""
 
-#: git-gui.sh:2547
+#: git-gui.sh:2836
 msgid "Undo"
 msgstr ""
 
-#: git-gui.sh:2550
+#: git-gui.sh:2839
 msgid "Redo"
 msgstr ""
 
-#: git-gui.sh:2554 git-gui.sh:3109
+#: git-gui.sh:2843 git-gui.sh:3461
 msgid "Cut"
 msgstr ""
 
-#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
+#: git-gui.sh:2846 git-gui.sh:3464 git-gui.sh:3540 git-gui.sh:3633
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr ""
 
-#: git-gui.sh:2560 git-gui.sh:3115
+#: git-gui.sh:2849 git-gui.sh:3467
 msgid "Paste"
 msgstr ""
 
-#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
-#: lib/remote_branch_delete.tcl:38
+#: git-gui.sh:2852 git-gui.sh:3470 lib/remote_branch_delete.tcl:39
+#: lib/branch_delete.tcl:28
 msgid "Delete"
 msgstr ""
 
-#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
+#: git-gui.sh:2856 git-gui.sh:3474 git-gui.sh:3637 lib/console.tcl:71
 msgid "Select All"
 msgstr ""
 
-#: git-gui.sh:2576
+#: git-gui.sh:2865
 msgid "Create..."
 msgstr ""
 
-#: git-gui.sh:2582
+#: git-gui.sh:2871
 msgid "Checkout..."
 msgstr ""
 
-#: git-gui.sh:2588
+#: git-gui.sh:2877
 msgid "Rename..."
 msgstr ""
 
-#: git-gui.sh:2593
+#: git-gui.sh:2882
 msgid "Delete..."
 msgstr ""
 
-#: git-gui.sh:2598
+#: git-gui.sh:2887
 msgid "Reset..."
 msgstr ""
 
-#: git-gui.sh:2608
+#: git-gui.sh:2897
 msgid "Done"
 msgstr ""
 
-#: git-gui.sh:2610
+#: git-gui.sh:2899
 msgid "Commit@@verb"
 msgstr ""
 
-#: git-gui.sh:2619 git-gui.sh:3050
-msgid "New Commit"
-msgstr ""
-
-#: git-gui.sh:2627 git-gui.sh:3057
+#: git-gui.sh:2908 git-gui.sh:3400
 msgid "Amend Last Commit"
 msgstr ""
 
-#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2918 git-gui.sh:3361 lib/remote_branch_delete.tcl:101
 msgid "Rescan"
 msgstr ""
 
-#: git-gui.sh:2643
+#: git-gui.sh:2924
 msgid "Stage To Commit"
 msgstr ""
 
-#: git-gui.sh:2649
+#: git-gui.sh:2930
 msgid "Stage Changed Files To Commit"
 msgstr ""
 
-#: git-gui.sh:2655
+#: git-gui.sh:2936
 msgid "Unstage From Commit"
 msgstr ""
 
-#: git-gui.sh:2661 lib/index.tcl:412
+#: git-gui.sh:2942 lib/index.tcl:521
 msgid "Revert Changes"
 msgstr ""
 
-#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
+#: git-gui.sh:2950 git-gui.sh:3700 git-gui.sh:3731
 msgid "Show Less Context"
 msgstr ""
 
-#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
+#: git-gui.sh:2954 git-gui.sh:3704 git-gui.sh:3735
 msgid "Show More Context"
 msgstr ""
 
-#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
+#: git-gui.sh:2961 git-gui.sh:3374 git-gui.sh:3485
 msgid "Sign Off"
 msgstr ""
 
-#: git-gui.sh:2696
+#: git-gui.sh:2977
 msgid "Local Merge..."
 msgstr ""
 
-#: git-gui.sh:2701
+#: git-gui.sh:2982
 msgid "Abort Merge..."
 msgstr ""
 
-#: git-gui.sh:2713 git-gui.sh:2741
+#: git-gui.sh:2994 git-gui.sh:3022
 msgid "Add..."
 msgstr ""
 
-#: git-gui.sh:2717
+#: git-gui.sh:2998
 msgid "Push..."
 msgstr ""
 
-#: git-gui.sh:2721
+#: git-gui.sh:3002
 msgid "Delete Branch..."
 msgstr ""
 
-#: git-gui.sh:2731 git-gui.sh:3292
+#: git-gui.sh:3012 git-gui.sh:3666
 msgid "Options..."
 msgstr ""
 
-#: git-gui.sh:2742
+#: git-gui.sh:3023
 msgid "Remove..."
 msgstr ""
 
-#: git-gui.sh:2751 lib/choose_repository.tcl:50
+#: git-gui.sh:3032 lib/choose_repository.tcl:67
 msgid "Help"
 msgstr ""
 
-#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
+#: git-gui.sh:3036 git-gui.sh:3040 lib/choose_repository.tcl:61
+#: lib/choose_repository.tcl:70 lib/about.tcl:14
 #, tcl-format
 msgid "About %s"
 msgstr ""
 
-#: git-gui.sh:2783
+#: git-gui.sh:3064
 msgid "Online Documentation"
 msgstr ""
 
-#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.tcl:56
+#: git-gui.sh:3067 lib/choose_repository.tcl:64 lib/choose_repository.tcl:73
 msgid "Show SSH Key"
 msgstr ""
 
-#: git-gui.sh:2893
+#: git-gui.sh:3097 git-gui.sh:3229
+msgid "usage:"
+msgstr ""
+
+#: git-gui.sh:3101 git-gui.sh:3233
+msgid "Usage"
+msgstr ""
+
+#: git-gui.sh:3182 lib/blame.tcl:575
+msgid "Error"
+msgstr ""
+
+#: git-gui.sh:3213
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 
-#: git-gui.sh:2926
+#: git-gui.sh:3246
 msgid "Current Branch:"
 msgstr ""
 
-#: git-gui.sh:2947
-msgid "Staged Changes (Will Commit)"
+#: git-gui.sh:3271
+msgid "Unstaged Changes"
 msgstr ""
 
-#: git-gui.sh:2967
-msgid "Unstaged Changes"
+#: git-gui.sh:3293
+msgid "Staged Changes (Will Commit)"
 msgstr ""
 
-#: git-gui.sh:3017
+#: git-gui.sh:3367
 msgid "Stage Changed"
 msgstr ""
 
-#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
+#: git-gui.sh:3386 lib/transport.tcl:137
 msgid "Push"
 msgstr ""
 
-#: git-gui.sh:3071
+#: git-gui.sh:3413
 msgid "Initial Commit Message:"
 msgstr ""
 
-#: git-gui.sh:3072
+#: git-gui.sh:3414
 msgid "Amended Commit Message:"
 msgstr ""
 
-#: git-gui.sh:3073
+#: git-gui.sh:3415
 msgid "Amended Initial Commit Message:"
 msgstr ""
 
-#: git-gui.sh:3074
+#: git-gui.sh:3416
 msgid "Amended Merge Commit Message:"
 msgstr ""
 
-#: git-gui.sh:3075
+#: git-gui.sh:3417
 msgid "Merge Commit Message:"
 msgstr ""
 
-#: git-gui.sh:3076
+#: git-gui.sh:3418
 msgid "Commit Message:"
 msgstr ""
 
-#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
+#: git-gui.sh:3477 git-gui.sh:3641 lib/console.tcl:73
 msgid "Copy All"
 msgstr ""
 
-#: git-gui.sh:3149 lib/blame.tcl:104
+#: git-gui.sh:3501 lib/blame.tcl:106
 msgid "File:"
 msgstr ""
 
-#: git-gui.sh:3255
+#: git-gui.sh:3549 lib/choose_repository.tcl:1100
+msgid "Open"
+msgstr ""
+
+#: git-gui.sh:3629
 msgid "Refresh"
 msgstr ""
 
-#: git-gui.sh:3276
+#: git-gui.sh:3650
 msgid "Decrease Font Size"
 msgstr ""
 
-#: git-gui.sh:3280
+#: git-gui.sh:3654
 msgid "Increase Font Size"
 msgstr ""
 
-#: git-gui.sh:3288 lib/blame.tcl:281
+#: git-gui.sh:3662 lib/blame.tcl:296
 msgid "Encoding"
 msgstr ""
 
-#: git-gui.sh:3299
+#: git-gui.sh:3673
 msgid "Apply/Reverse Hunk"
 msgstr ""
 
-#: git-gui.sh:3304
+#: git-gui.sh:3678
 msgid "Apply/Reverse Line"
 msgstr ""
 
-#: git-gui.sh:3323
+#: git-gui.sh:3684 git-gui.sh:3794 git-gui.sh:3805
+msgid "Revert Hunk"
+msgstr ""
+
+#: git-gui.sh:3689 git-gui.sh:3801 git-gui.sh:3812
+msgid "Revert Line"
+msgstr ""
+
+#: git-gui.sh:3694 git-gui.sh:3791
+msgid "Undo Last Revert"
+msgstr ""
+
+#: git-gui.sh:3713
 msgid "Run Merge Tool"
 msgstr ""
 
-#: git-gui.sh:3328
+#: git-gui.sh:3718
 msgid "Use Remote Version"
 msgstr ""
 
-#: git-gui.sh:3332
+#: git-gui.sh:3722
 msgid "Use Local Version"
 msgstr ""
 
-#: git-gui.sh:3336
+#: git-gui.sh:3726
 msgid "Revert To Base"
 msgstr ""
 
-#: git-gui.sh:3354
+#: git-gui.sh:3744
 msgid "Visualize These Changes In The Submodule"
 msgstr ""
 
-#: git-gui.sh:3358
+#: git-gui.sh:3748
 msgid "Visualize Current Branch History In The Submodule"
 msgstr ""
 
-#: git-gui.sh:3362
+#: git-gui.sh:3752
 msgid "Visualize All Branch History In The Submodule"
 msgstr ""
 
-#: git-gui.sh:3367
+#: git-gui.sh:3757
 msgid "Start git gui In The Submodule"
 msgstr ""
 
-#: git-gui.sh:3389
+#: git-gui.sh:3793
 msgid "Unstage Hunk From Commit"
 msgstr ""
 
-#: git-gui.sh:3391
+#: git-gui.sh:3797
 msgid "Unstage Lines From Commit"
 msgstr ""
 
-#: git-gui.sh:3393
+#: git-gui.sh:3798 git-gui.sh:3809
+msgid "Revert Lines"
+msgstr ""
+
+#: git-gui.sh:3800
 msgid "Unstage Line From Commit"
 msgstr ""
 
-#: git-gui.sh:3396
+#: git-gui.sh:3804
 msgid "Stage Hunk For Commit"
 msgstr ""
 
-#: git-gui.sh:3398
+#: git-gui.sh:3808
 msgid "Stage Lines For Commit"
 msgstr ""
 
-#: git-gui.sh:3400
+#: git-gui.sh:3811
 msgid "Stage Line For Commit"
 msgstr ""
 
-#: git-gui.sh:3424
+#: git-gui.sh:3861
 msgid "Initializing..."
 msgstr ""
 
-#: git-gui.sh:3541
+#: git-gui.sh:4017
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -531,14 +577,14 @@ msgid ""
 "\n"
 msgstr ""
 
-#: git-gui.sh:3570
+#: git-gui.sh:4046
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
 "Tcl binary distributed by Cygwin."
 msgstr ""
 
-#: git-gui.sh:3575
+#: git-gui.sh:4051
 #, tcl-format
 msgid ""
 "\n"
@@ -549,1846 +595,2072 @@ msgid ""
 "~/.gitconfig file.\n"
 msgstr ""
 
-#: lib/about.tcl:26
-msgid "git-gui - a graphical user interface for Git."
+#: lib/spellcheck.tcl:57
+msgid "Unsupported spell checker"
 msgstr ""
 
-#: lib/blame.tcl:72
-msgid "File Viewer"
+#: lib/spellcheck.tcl:65
+msgid "Spell checking is unavailable"
 msgstr ""
 
-#: lib/blame.tcl:78
-msgid "Commit:"
+#: lib/spellcheck.tcl:68
+msgid "Invalid spell checking configuration"
 msgstr ""
 
-#: lib/blame.tcl:271
-msgid "Copy Commit"
+#: lib/spellcheck.tcl:70
+#, tcl-format
+msgid "Reverting dictionary to %s."
 msgstr ""
 
-#: lib/blame.tcl:275
-msgid "Find Text..."
+#: lib/spellcheck.tcl:73
+msgid "Spell checker silently failed on startup"
 msgstr ""
 
-#: lib/blame.tcl:284
-msgid "Do Full Copy Detection"
+#: lib/spellcheck.tcl:80
+msgid "Unrecognized spell checker"
 msgstr ""
 
-#: lib/blame.tcl:288
-msgid "Show History Context"
+#: lib/spellcheck.tcl:186
+msgid "No Suggestions"
 msgstr ""
 
-#: lib/blame.tcl:291
-msgid "Blame Parent Commit"
+#: lib/spellcheck.tcl:388
+msgid "Unexpected EOF from spell checker"
 msgstr ""
 
-#: lib/blame.tcl:450
-#, tcl-format
-msgid "Reading %s..."
+#: lib/spellcheck.tcl:392
+msgid "Spell Checker Failed"
 msgstr ""
 
-#: lib/blame.tcl:557
-msgid "Loading copy/move tracking annotations..."
+#: lib/transport.tcl:6 lib/remote_add.tcl:132
+#, tcl-format
+msgid "fetch %s"
 msgstr ""
 
-#: lib/blame.tcl:577
-msgid "lines annotated"
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
 msgstr ""
 
-#: lib/blame.tcl:769
-msgid "Loading original location annotations..."
+#: lib/transport.tcl:18
+#, tcl-format
+msgid "remote prune %s"
 msgstr ""
 
-#: lib/blame.tcl:772
-msgid "Annotation complete."
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
 msgstr ""
 
-#: lib/blame.tcl:802
-msgid "Busy"
+#: lib/transport.tcl:25
+msgid "fetch all remotes"
 msgstr ""
 
-#: lib/blame.tcl:803
-msgid "Annotation process is already running."
+#: lib/transport.tcl:26
+msgid "Fetching new changes from all remotes"
 msgstr ""
 
-#: lib/blame.tcl:842
-msgid "Running thorough copy detection..."
+#: lib/transport.tcl:40
+msgid "remote prune all remotes"
 msgstr ""
 
-#: lib/blame.tcl:910
-msgid "Loading annotation..."
+#: lib/transport.tcl:41
+msgid "Pruning tracking branches deleted from all remotes"
 msgstr ""
 
-#: lib/blame.tcl:963
-msgid "Author:"
+#: lib/transport.tcl:54 lib/transport.tcl:92 lib/transport.tcl:110
+#: lib/remote_add.tcl:162
+#, tcl-format
+msgid "push %s"
 msgstr ""
 
-#: lib/blame.tcl:967
-msgid "Committer:"
+#: lib/transport.tcl:55
+#, tcl-format
+msgid "Pushing changes to %s"
 msgstr ""
 
-#: lib/blame.tcl:972
-msgid "Original File:"
+#: lib/transport.tcl:93
+#, tcl-format
+msgid "Mirroring to %s"
 msgstr ""
 
-#: lib/blame.tcl:1020
-msgid "Cannot find HEAD commit:"
+#: lib/transport.tcl:111
+#, tcl-format
+msgid "Pushing %s %s to %s"
 msgstr ""
 
-#: lib/blame.tcl:1075
-msgid "Cannot find parent commit:"
+#: lib/transport.tcl:132
+msgid "Push Branches"
 msgstr ""
 
-#: lib/blame.tcl:1090
-msgid "Unable to display parent"
+#: lib/transport.tcl:141 lib/checkout_op.tcl:580 lib/remote_add.tcl:34
+#: lib/browser.tcl:292 lib/branch_checkout.tcl:30 lib/branch_rename.tcl:32
+#: lib/choose_font.tcl:45 lib/option.tcl:127 lib/tools_dlg.tcl:41
+#: lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345 lib/remote_branch_delete.tcl:43
+#: lib/branch_create.tcl:37 lib/branch_delete.tcl:34 lib/merge.tcl:178
+msgid "Cancel"
 msgstr ""
 
-#: lib/blame.tcl:1091 lib/diff.tcl:320
-msgid "Error loading diff:"
+#: lib/transport.tcl:147
+msgid "Source Branches"
 msgstr ""
 
-#: lib/blame.tcl:1231
-msgid "Originally By:"
+#: lib/transport.tcl:162
+msgid "Destination Repository"
 msgstr ""
 
-#: lib/blame.tcl:1237
-msgid "In File:"
+#: lib/transport.tcl:165 lib/remote_branch_delete.tcl:51
+msgid "Remote:"
 msgstr ""
 
-#: lib/blame.tcl:1242
-msgid "Copied Or Moved Here By:"
+#: lib/transport.tcl:187 lib/remote_branch_delete.tcl:72
+msgid "Arbitrary Location:"
 msgstr ""
 
-#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
-msgid "Checkout Branch"
+#: lib/transport.tcl:205
+msgid "Transfer Options"
 msgstr ""
 
-#: lib/branch_checkout.tcl:23
-msgid "Checkout"
+#: lib/transport.tcl:207
+msgid "Force overwrite existing branch (may discard changes)"
 msgstr ""
 
-#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
-#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:282
-#: lib/checkout_op.tcl:579 lib/choose_font.tcl:43 lib/merge.tcl:172
-#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.tcl:42
-#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
-#: lib/transport.tcl:108
-msgid "Cancel"
+#: lib/transport.tcl:211
+msgid "Use thin pack (for slow network connections)"
 msgstr ""
 
-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:328
-msgid "Revision"
+#: lib/transport.tcl:215
+msgid "Include tags"
 msgstr ""
 
-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:280
-msgid "Options"
+#: lib/transport.tcl:229
+#, tcl-format
+msgid "%s (%s): Push"
 msgstr ""
 
-#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
-msgid "Fetch Tracking Branch"
+#: lib/checkout_op.tcl:85
+#, tcl-format
+msgid "Fetching %s from %s"
 msgstr ""
 
-#: lib/branch_checkout.tcl:44
-msgid "Detach From Local Branch"
+#: lib/checkout_op.tcl:133
+#, tcl-format
+msgid "fatal: Cannot resolve %s"
 msgstr ""
 
-#: lib/branch_create.tcl:22
-msgid "Create Branch"
+#: lib/checkout_op.tcl:146 lib/sshkey.tcl:58 lib/console.tcl:81
+#: lib/database.tcl:30
+msgid "Close"
 msgstr ""
 
-#: lib/branch_create.tcl:27
-msgid "Create New Branch"
+#: lib/checkout_op.tcl:175
+#, tcl-format
+msgid "Branch '%s' does not exist."
 msgstr ""
 
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
-msgid "Create"
+#: lib/checkout_op.tcl:194
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
 msgstr ""
 
-#: lib/branch_create.tcl:40
-msgid "Branch Name"
+#: lib/checkout_op.tcl:202 lib/branch_rename.tcl:102
+#, tcl-format
+msgid "Branch '%s' already exists."
 msgstr ""
 
-#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
-msgid "Name:"
+#: lib/checkout_op.tcl:229
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
 msgstr ""
 
-#: lib/branch_create.tcl:58
-msgid "Match Tracking Branch Name"
+#: lib/checkout_op.tcl:243
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
 msgstr ""
 
-#: lib/branch_create.tcl:66
-msgid "Starting Revision"
+#: lib/checkout_op.tcl:262
+#, tcl-format
+msgid "Failed to update '%s'."
 msgstr ""
 
-#: lib/branch_create.tcl:72
-msgid "Update Existing Branch:"
+#: lib/checkout_op.tcl:274
+msgid "Staging area (index) is already locked."
 msgstr ""
 
-#: lib/branch_create.tcl:75
-msgid "No"
+#: lib/checkout_op.tcl:289
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before the current branch can be changed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
 msgstr ""
 
-#: lib/branch_create.tcl:80
-msgid "Fast Forward Only"
+#: lib/checkout_op.tcl:345
+#, tcl-format
+msgid "Updating working directory to '%s'..."
 msgstr ""
 
-#: lib/branch_create.tcl:85 lib/checkout_op.tcl:571
-msgid "Reset"
+#: lib/checkout_op.tcl:346
+msgid "files checked out"
 msgstr ""
 
-#: lib/branch_create.tcl:97
-msgid "Checkout After Creation"
+#: lib/checkout_op.tcl:377
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr ""
 
-#: lib/branch_create.tcl:131
-msgid "Please select a tracking branch."
+#: lib/checkout_op.tcl:378
+msgid "File level merge required."
 msgstr ""
 
-#: lib/branch_create.tcl:140
+#: lib/checkout_op.tcl:382
 #, tcl-format
-msgid "Tracking branch %s is not a branch in the remote repository."
+msgid "Staying on branch '%s'."
 msgstr ""
 
-#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
-msgid "Please supply a branch name."
+#: lib/checkout_op.tcl:453
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This Detached "
+"Checkout'."
 msgstr ""
 
-#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#: lib/checkout_op.tcl:504 lib/checkout_op.tcl:508
 #, tcl-format
-msgid "'%s' is not an acceptable branch name."
+msgid "Checked out '%s'."
 msgstr ""
 
-#: lib/branch_delete.tcl:15
-msgid "Delete Branch"
+#: lib/checkout_op.tcl:536
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
 msgstr ""
 
-#: lib/branch_delete.tcl:20
-msgid "Delete Local Branch"
+#: lib/checkout_op.tcl:558
+msgid "Recovering lost commits may not be easy."
 msgstr ""
 
-#: lib/branch_delete.tcl:37
-msgid "Local Branches"
+#: lib/checkout_op.tcl:563
+#, tcl-format
+msgid "Reset '%s'?"
 msgstr ""
 
-#: lib/branch_delete.tcl:52
-msgid "Delete Only If Merged Into"
+#: lib/checkout_op.tcl:568 lib/tools_dlg.tcl:336 lib/merge.tcl:170
+msgid "Visualize"
 msgstr ""
 
-#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
-msgid "Always (Do not perform merge checks)"
+#: lib/checkout_op.tcl:572 lib/branch_create.tcl:85
+msgid "Reset"
 msgstr ""
 
-#: lib/branch_delete.tcl:103
+#: lib/checkout_op.tcl:636
 #, tcl-format
-msgid "The following branches are not completely merged into %s:"
-msgstr ""
-
-#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
 msgid ""
-"Recovering deleted branches is difficult.\n"
+"Failed to set current branch.\n"
 "\n"
-"Delete the selected branches?"
+"This working directory is only partially switched.  We successfully updated "
+"your files, but failed to update an internal Git file.\n"
+"\n"
+"This should not have occurred.  %s will now close and give up."
 msgstr ""
 
-#: lib/branch_delete.tcl:141
+#: lib/remote_add.tcl:20
 #, tcl-format
-msgid ""
-"Failed to delete branches:\n"
-"%s"
+msgid "%s (%s): Add Remote"
 msgstr ""
 
-#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
-msgid "Rename Branch"
+#: lib/remote_add.tcl:25
+msgid "Add New Remote"
 msgstr ""
 
-#: lib/branch_rename.tcl:26
-msgid "Rename"
+#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
+msgid "Add"
 msgstr ""
 
-#: lib/branch_rename.tcl:36
-msgid "Branch:"
+#: lib/remote_add.tcl:39
+msgid "Remote Details"
 msgstr ""
 
-#: lib/branch_rename.tcl:39
-msgid "New Name:"
+#: lib/remote_add.tcl:41 lib/tools_dlg.tcl:51 lib/branch_create.tcl:44
+msgid "Name:"
 msgstr ""
 
-#: lib/branch_rename.tcl:75
-msgid "Please select a branch to rename."
+#: lib/remote_add.tcl:50
+msgid "Location:"
 msgstr ""
 
-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
-#, tcl-format
-msgid "Branch '%s' already exists."
+#: lib/remote_add.tcl:60
+msgid "Further Action"
 msgstr ""
 
-#: lib/branch_rename.tcl:117
-#, tcl-format
-msgid "Failed to rename '%s'."
+#: lib/remote_add.tcl:63
+msgid "Fetch Immediately"
 msgstr ""
 
-#: lib/browser.tcl:17
-msgid "Starting..."
+#: lib/remote_add.tcl:69
+msgid "Initialize Remote Repository and Push"
 msgstr ""
 
-#: lib/browser.tcl:26
-msgid "File Browser"
+#: lib/remote_add.tcl:75
+msgid "Do Nothing Else Now"
 msgstr ""
 
-#: lib/browser.tcl:126 lib/browser.tcl:143
-#, tcl-format
-msgid "Loading %s..."
+#: lib/remote_add.tcl:100
+msgid "Please supply a remote name."
 msgstr ""
 
-#: lib/browser.tcl:187
-msgid "[Up To Parent]"
+#: lib/remote_add.tcl:113
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
 msgstr ""
 
-#: lib/browser.tcl:267 lib/browser.tcl:273
-msgid "Browse Branch Files"
+#: lib/remote_add.tcl:124
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
 msgstr ""
 
-#: lib/browser.tcl:278 lib/choose_repository.tcl:398
-#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
-#: lib/choose_repository.tcl:1028
-msgid "Browse"
+#: lib/remote_add.tcl:133
+#, tcl-format
+msgid "Fetching the %s"
 msgstr ""
 
-#: lib/checkout_op.tcl:85
+#: lib/remote_add.tcl:156
 #, tcl-format
-msgid "Fetching %s from %s"
+msgid "Do not know how to initialize repository at location '%s'."
 msgstr ""
 
-#: lib/checkout_op.tcl:133
+#: lib/remote_add.tcl:163
 #, tcl-format
-msgid "fatal: Cannot resolve %s"
+msgid "Setting up the %s (at %s)"
 msgstr ""
 
-#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
-#: lib/sshkey.tcl:53
-msgid "Close"
+#: lib/browser.tcl:17
+msgid "Starting..."
 msgstr ""
 
-#: lib/checkout_op.tcl:175
+#: lib/browser.tcl:27
 #, tcl-format
-msgid "Branch '%s' does not exist."
+msgid "%s (%s): File Browser"
 msgstr ""
 
-#: lib/checkout_op.tcl:194
+#: lib/browser.tcl:132 lib/browser.tcl:149
 #, tcl-format
-msgid "Failed to configure simplified git-pull for '%s'."
+msgid "Loading %s..."
 msgstr ""
 
-#: lib/checkout_op.tcl:229
-#, tcl-format
-msgid ""
-"Branch '%s' already exists.\n"
-"\n"
-"It cannot fast-forward to %s.\n"
-"A merge is required."
+#: lib/browser.tcl:193
+msgid "[Up To Parent]"
 msgstr ""
 
-#: lib/checkout_op.tcl:243
+#: lib/browser.tcl:275
 #, tcl-format
-msgid "Merge strategy '%s' not supported."
+msgid "%s (%s): Browse Branch Files"
 msgstr ""
 
-#: lib/checkout_op.tcl:262
-#, tcl-format
-msgid "Failed to update '%s'."
+#: lib/browser.tcl:282
+msgid "Browse Branch Files"
 msgstr ""
 
-#: lib/checkout_op.tcl:274
-msgid "Staging area (index) is already locked."
+#: lib/browser.tcl:288 lib/choose_repository.tcl:437
+#: lib/choose_repository.tcl:524 lib/choose_repository.tcl:533
+#: lib/choose_repository.tcl:1115
+msgid "Browse"
 msgstr ""
 
-#: lib/checkout_op.tcl:289
-msgid ""
-"Last scanned state does not match repository state.\n"
-"\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before the current branch can be changed.\n"
-"\n"
-"The rescan will be automatically started now.\n"
+#: lib/browser.tcl:297 lib/branch_checkout.tcl:35 lib/tools_dlg.tcl:321
+msgid "Revision"
 msgstr ""
 
-#: lib/checkout_op.tcl:345
-#, tcl-format
-msgid "Updating working directory to '%s'..."
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
 msgstr ""
 
-#: lib/checkout_op.tcl:346
-msgid "files checked out"
+#: lib/index.tcl:30
+msgid "Index Error"
 msgstr ""
 
-#: lib/checkout_op.tcl:376
-#, tcl-format
-msgid "Aborted checkout of '%s' (file level merging is required)."
+#: lib/index.tcl:32
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically started to "
+"resynchronize git-gui."
 msgstr ""
 
-#: lib/checkout_op.tcl:377
-msgid "File level merge required."
+#: lib/index.tcl:43
+msgid "Continue"
 msgstr ""
 
-#: lib/checkout_op.tcl:381
-#, tcl-format
-msgid "Staying on branch '%s'."
+#: lib/index.tcl:46
+msgid "Unlock Index"
 msgstr ""
 
-#: lib/checkout_op.tcl:452
-msgid ""
-"You are no longer on a local branch.\n"
-"\n"
-"If you wanted to be on a branch, create one now starting from 'This Detached "
-"Checkout'."
+#: lib/index.tcl:77 lib/index.tcl:146 lib/index.tcl:220 lib/index.tcl:587
+#: lib/choose_repository.tcl:999
+msgid "files"
 msgstr ""
 
-#: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
-#, tcl-format
-msgid "Checked out '%s'."
+#: lib/index.tcl:326
+msgid "Unstaging selected files from commit"
 msgstr ""
 
-#: lib/checkout_op.tcl:535
+#: lib/index.tcl:330
 #, tcl-format
-msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgid "Unstaging %s from commit"
 msgstr ""
 
-#: lib/checkout_op.tcl:557
-msgid "Recovering lost commits may not be easy."
+#: lib/index.tcl:369
+msgid "Ready to commit."
 msgstr ""
 
-#: lib/checkout_op.tcl:562
-#, tcl-format
-msgid "Reset '%s'?"
+#: lib/index.tcl:378
+msgid "Adding selected files"
 msgstr ""
 
-#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
-msgid "Visualize"
+#: lib/index.tcl:382
+#, tcl-format
+msgid "Adding %s"
 msgstr ""
 
-#: lib/checkout_op.tcl:635
+#: lib/index.tcl:412
 #, tcl-format
-msgid ""
-"Failed to set current branch.\n"
-"\n"
-"This working directory is only partially switched.  We successfully updated "
-"your files, but failed to update an internal Git file.\n"
-"\n"
-"This should not have occurred.  %s will now close and give up."
+msgid "Stage %d untracked files?"
 msgstr ""
 
-#: lib/choose_font.tcl:39
-msgid "Select"
+#: lib/index.tcl:420
+msgid "Adding all changed files"
 msgstr ""
 
-#: lib/choose_font.tcl:53
-msgid "Font Family"
+#: lib/index.tcl:503
+#, tcl-format
+msgid "Revert changes in file %s?"
 msgstr ""
 
-#: lib/choose_font.tcl:74
-msgid "Font Size"
+#: lib/index.tcl:508
+#, tcl-format
+msgid "Revert changes in these %i files?"
 msgstr ""
 
-#: lib/choose_font.tcl:91
-msgid "Font Example"
+#: lib/index.tcl:517
+msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 
-#: lib/choose_font.tcl:103
-msgid ""
-"This is example text.\n"
-"If you like this text, it can be your font."
+#: lib/index.tcl:520 lib/index.tcl:563
+msgid "Do Nothing"
 msgstr ""
 
-#: lib/choose_repository.tcl:28
-msgid "Git Gui"
+#: lib/index.tcl:545
+#, tcl-format
+msgid "Delete untracked file %s?"
 msgstr ""
 
-#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
-msgid "Create New Repository"
+#: lib/index.tcl:550
+#, tcl-format
+msgid "Delete these %i untracked files?"
 msgstr ""
 
-#: lib/choose_repository.tcl:93
-msgid "New..."
+#: lib/index.tcl:560
+msgid "Files will be permanently deleted."
 msgstr ""
 
-#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
-msgid "Clone Existing Repository"
+#: lib/index.tcl:564
+msgid "Delete Files"
 msgstr ""
 
-#: lib/choose_repository.tcl:106
-msgid "Clone..."
+#: lib/index.tcl:586
+msgid "Deleting"
 msgstr ""
 
-#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
-msgid "Open Existing Repository"
+#: lib/index.tcl:665
+msgid "Encountered errors deleting files:\n"
 msgstr ""
 
-#: lib/choose_repository.tcl:119
-msgid "Open..."
+#: lib/index.tcl:674
+#, tcl-format
+msgid "None of the %d selected files could be deleted."
 msgstr ""
 
-#: lib/choose_repository.tcl:132
-msgid "Recent Repositories"
+#: lib/index.tcl:679
+#, tcl-format
+msgid "%d of the %d selected files could not be deleted."
 msgstr ""
 
-#: lib/choose_repository.tcl:138
-msgid "Open Recent Repository:"
+#: lib/index.tcl:726
+msgid "Reverting selected files"
 msgstr ""
 
-#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
-#: lib/choose_repository.tcl:320
+#: lib/index.tcl:730
 #, tcl-format
-msgid "Failed to create repository %s:"
+msgid "Reverting %s"
 msgstr ""
 
-#: lib/choose_repository.tcl:391
-msgid "Directory:"
+#: lib/branch_checkout.tcl:16
+#, tcl-format
+msgid "%s (%s): Checkout Branch"
 msgstr ""
 
-#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
-#: lib/choose_repository.tcl:1052
-msgid "Git Repository"
+#: lib/branch_checkout.tcl:21
+msgid "Checkout Branch"
 msgstr ""
 
-#: lib/choose_repository.tcl:448
-#, tcl-format
-msgid "Directory %s already exists."
+#: lib/branch_checkout.tcl:26
+msgid "Checkout"
 msgstr ""
 
-#: lib/choose_repository.tcl:452
-#, tcl-format
-msgid "File %s already exists."
+#: lib/branch_checkout.tcl:39 lib/option.tcl:310 lib/branch_create.tcl:69
+msgid "Options"
 msgstr ""
 
-#: lib/choose_repository.tcl:466
-msgid "Clone"
+#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
 msgstr ""
 
-#: lib/choose_repository.tcl:479
-msgid "Source Location:"
+#: lib/branch_checkout.tcl:47
+msgid "Detach From Local Branch"
 msgstr ""
 
-#: lib/choose_repository.tcl:490
-msgid "Target Directory:"
+#: lib/status_bar.tcl:263
+#, tcl-format
+msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr ""
 
-#: lib/choose_repository.tcl:502
-msgid "Clone Type:"
+#: lib/remote.tcl:200
+msgid "Push to"
 msgstr ""
 
-#: lib/choose_repository.tcl:508
-msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+#: lib/remote.tcl:218
+msgid "Remove Remote"
 msgstr ""
 
-#: lib/choose_repository.tcl:514
-msgid "Full Copy (Slower, Redundant Backup)"
+#: lib/remote.tcl:223
+msgid "Prune from"
 msgstr ""
 
-#: lib/choose_repository.tcl:520
-msgid "Shared (Fastest, Not Recommended, No Backup)"
+#: lib/remote.tcl:228
+msgid "Fetch from"
+msgstr ""
+
+#: lib/remote.tcl:249 lib/remote.tcl:253 lib/remote.tcl:258 lib/remote.tcl:264
+msgid "All"
 msgstr ""
 
-#: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
-#: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
-#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
+#: lib/branch_rename.tcl:15
 #, tcl-format
-msgid "Not a Git repository: %s"
+msgid "%s (%s): Rename Branch"
 msgstr ""
 
-#: lib/choose_repository.tcl:592
-msgid "Standard only available for local repository."
+#: lib/branch_rename.tcl:23
+msgid "Rename Branch"
 msgstr ""
 
-#: lib/choose_repository.tcl:596
-msgid "Shared only available for local repository."
+#: lib/branch_rename.tcl:28
+msgid "Rename"
 msgstr ""
 
-#: lib/choose_repository.tcl:617
-#, tcl-format
-msgid "Location %s already exists."
+#: lib/branch_rename.tcl:38
+msgid "Branch:"
 msgstr ""
 
-#: lib/choose_repository.tcl:628
-msgid "Failed to configure origin"
+#: lib/branch_rename.tcl:46
+msgid "New Name:"
 msgstr ""
 
-#: lib/choose_repository.tcl:640
-msgid "Counting objects"
+#: lib/branch_rename.tcl:81
+msgid "Please select a branch to rename."
 msgstr ""
 
-#: lib/choose_repository.tcl:641
-msgid "buckets"
+#: lib/branch_rename.tcl:92 lib/branch_create.tcl:154
+msgid "Please supply a branch name."
 msgstr ""
 
-#: lib/choose_repository.tcl:665
+#: lib/branch_rename.tcl:112 lib/branch_create.tcl:165
 #, tcl-format
-msgid "Unable to copy objects/info/alternates: %s"
+msgid "'%s' is not an acceptable branch name."
 msgstr ""
 
-#: lib/choose_repository.tcl:701
+#: lib/branch_rename.tcl:123
 #, tcl-format
-msgid "Nothing to clone from %s."
+msgid "Failed to rename '%s'."
 msgstr ""
 
-#: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
-#: lib/choose_repository.tcl:929
-msgid "The 'master' branch has not been initialized."
+#: lib/choose_font.tcl:41
+msgid "Select"
 msgstr ""
 
-#: lib/choose_repository.tcl:716
-msgid "Hardlinks are unavailable.  Falling back to copying."
+#: lib/choose_font.tcl:55
+msgid "Font Family"
 msgstr ""
 
-#: lib/choose_repository.tcl:728
-#, tcl-format
-msgid "Cloning from %s"
+#: lib/choose_font.tcl:76
+msgid "Font Size"
 msgstr ""
 
-#: lib/choose_repository.tcl:759
-msgid "Copying objects"
+#: lib/choose_font.tcl:93
+msgid "Font Example"
 msgstr ""
 
-#: lib/choose_repository.tcl:760
-msgid "KiB"
+#: lib/choose_font.tcl:105
+msgid ""
+"This is example text.\n"
+"If you like this text, it can be your font."
 msgstr ""
 
-#: lib/choose_repository.tcl:784
+#: lib/option.tcl:11
 #, tcl-format
-msgid "Unable to copy object: %s"
+msgid "Invalid global encoding '%s'"
 msgstr ""
 
-#: lib/choose_repository.tcl:794
-msgid "Linking objects"
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
 msgstr ""
 
-#: lib/choose_repository.tcl:795
-msgid "objects"
+#: lib/option.tcl:119
+msgid "Restore Defaults"
+msgstr ""
+
+#: lib/option.tcl:123
+msgid "Save"
 msgstr ""
 
-#: lib/choose_repository.tcl:803
+#: lib/option.tcl:133
 #, tcl-format
-msgid "Unable to hardlink object: %s"
+msgid "%s Repository"
 msgstr ""
 
-#: lib/choose_repository.tcl:858
-msgid "Cannot fetch branches and objects.  See console output for details."
+#: lib/option.tcl:134
+msgid "Global (All Repositories)"
 msgstr ""
 
-#: lib/choose_repository.tcl:869
-msgid "Cannot fetch tags.  See console output for details."
+#: lib/option.tcl:140
+msgid "User Name"
 msgstr ""
 
-#: lib/choose_repository.tcl:893
-msgid "Cannot determine HEAD.  See console output for details."
+#: lib/option.tcl:141
+msgid "Email Address"
 msgstr ""
 
-#: lib/choose_repository.tcl:902
-#, tcl-format
-msgid "Unable to cleanup %s"
+#: lib/option.tcl:143
+msgid "Summarize Merge Commits"
 msgstr ""
 
-#: lib/choose_repository.tcl:908
-msgid "Clone failed."
+#: lib/option.tcl:144
+msgid "Merge Verbosity"
 msgstr ""
 
-#: lib/choose_repository.tcl:915
-msgid "No default branch obtained."
+#: lib/option.tcl:145
+msgid "Show Diffstat After Merge"
 msgstr ""
 
-#: lib/choose_repository.tcl:926
-#, tcl-format
-msgid "Cannot resolve %s as a commit."
+#: lib/option.tcl:146
+msgid "Use Merge Tool"
 msgstr ""
 
-#: lib/choose_repository.tcl:938
-msgid "Creating working directory"
+#: lib/option.tcl:148
+msgid "Trust File Modification Timestamps"
 msgstr ""
 
-#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
-#: lib/index.tcl:198
-msgid "files"
+#: lib/option.tcl:149
+msgid "Prune Tracking Branches During Fetch"
 msgstr ""
 
-#: lib/choose_repository.tcl:968
-msgid "Initial file checkout failed."
+#: lib/option.tcl:150
+msgid "Match Tracking Branches"
 msgstr ""
 
-#: lib/choose_repository.tcl:1011
-msgid "Open"
+#: lib/option.tcl:151
+msgid "Use Textconv For Diffs and Blames"
 msgstr ""
 
-#: lib/choose_repository.tcl:1021
-msgid "Repository:"
+#: lib/option.tcl:152
+msgid "Blame Copy Only On Changed Files"
 msgstr ""
 
-#: lib/choose_repository.tcl:1072
-#, tcl-format
-msgid "Failed to open repository %s:"
+#: lib/option.tcl:153
+msgid "Maximum Length of Recent Repositories List"
 msgstr ""
 
-#: lib/choose_rev.tcl:53
-msgid "This Detached Checkout"
+#: lib/option.tcl:154
+msgid "Minimum Letters To Blame Copy On"
 msgstr ""
 
-#: lib/choose_rev.tcl:60
-msgid "Revision Expression:"
+#: lib/option.tcl:155
+msgid "Blame History Context Radius (days)"
 msgstr ""
 
-#: lib/choose_rev.tcl:74
-msgid "Local Branch"
+#: lib/option.tcl:156
+msgid "Number of Diff Context Lines"
 msgstr ""
 
-#: lib/choose_rev.tcl:79
-msgid "Tracking Branch"
+#: lib/option.tcl:157
+msgid "Additional Diff Parameters"
 msgstr ""
 
-#: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
-msgid "Tag"
+#: lib/option.tcl:158
+msgid "Commit Message Text Width"
 msgstr ""
 
-#: lib/choose_rev.tcl:317
-#, tcl-format
-msgid "Invalid revision: %s"
+#: lib/option.tcl:159
+msgid "New Branch Name Template"
 msgstr ""
 
-#: lib/choose_rev.tcl:338
-msgid "No revision selected."
+#: lib/option.tcl:160
+msgid "Default File Contents Encoding"
 msgstr ""
 
-#: lib/choose_rev.tcl:346
-msgid "Revision expression is empty."
+#: lib/option.tcl:161
+msgid "Warn before committing to a detached head"
 msgstr ""
 
-#: lib/choose_rev.tcl:531
-msgid "Updated"
+#: lib/option.tcl:162
+msgid "Staging of untracked files"
 msgstr ""
 
-#: lib/choose_rev.tcl:559
-msgid "URL"
+#: lib/option.tcl:163
+msgid "Show untracked files"
 msgstr ""
 
-#: lib/commit.tcl:9
-msgid ""
-"There is nothing to amend.\n"
-"\n"
-"You are about to create the initial commit.  There is no commit before this "
-"to amend.\n"
+#: lib/option.tcl:164
+msgid "Tab spacing"
 msgstr ""
 
-#: lib/commit.tcl:18
-msgid ""
-"Cannot amend while merging.\n"
-"\n"
-"You are currently in the middle of a merge that has not been fully "
-"completed.  You cannot amend the prior commit unless you first abort the "
-"current merge activity.\n"
+#: lib/option.tcl:182 lib/option.tcl:197 lib/option.tcl:220 lib/option.tcl:282
+#: lib/database.tcl:57
+#, tcl-format
+msgid "%s:"
 msgstr ""
 
-#: lib/commit.tcl:48
-msgid "Error loading commit data for amend:"
+#: lib/option.tcl:210
+msgid "Change"
 msgstr ""
 
-#: lib/commit.tcl:75
-msgid "Unable to obtain your identity:"
+#: lib/option.tcl:254
+msgid "Spelling Dictionary:"
 msgstr ""
 
-#: lib/commit.tcl:80
-msgid "Invalid GIT_COMMITTER_IDENT:"
+#: lib/option.tcl:284
+msgid "Change Font"
 msgstr ""
 
-#: lib/commit.tcl:129
+#: lib/option.tcl:288
 #, tcl-format
-msgid "warning: Tcl does not support encoding '%s'."
+msgid "Choose %s"
 msgstr ""
 
-#: lib/commit.tcl:149
-msgid ""
-"Last scanned state does not match repository state.\n"
-"\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before another commit can be created.\n"
-"\n"
-"The rescan will be automatically started now.\n"
+#: lib/option.tcl:294
+msgid "pt."
 msgstr ""
 
-#: lib/commit.tcl:172
+#: lib/option.tcl:308
+msgid "Preferences"
+msgstr ""
+
+#: lib/option.tcl:345
+msgid "Failed to completely save options:"
+msgstr ""
+
+#: lib/encoding.tcl:443
+msgid "Default"
+msgstr ""
+
+#: lib/encoding.tcl:448
 #, tcl-format
-msgid ""
-"Unmerged files cannot be committed.\n"
-"\n"
-"File %s has merge conflicts.  You must resolve them and stage the file "
-"before committing.\n"
+msgid "System (%s)"
+msgstr ""
+
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
 msgstr ""
 
-#: lib/commit.tcl:180
+#: lib/tools.tcl:76
 #, tcl-format
-msgid ""
-"Unknown file state %s detected.\n"
-"\n"
-"File %s cannot be committed by this program.\n"
+msgid "Running %s requires a selected file."
 msgstr ""
 
-#: lib/commit.tcl:188
-msgid ""
-"No changes to commit.\n"
-"\n"
-"You must stage at least 1 file before you can commit.\n"
+#: lib/tools.tcl:92
+#, tcl-format
+msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
+msgstr ""
+
+#: lib/tools.tcl:96
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr ""
+
+#: lib/tools.tcl:118
+#, tcl-format
+msgid "Tool: %s"
 msgstr ""
 
-#: lib/commit.tcl:203
+#: lib/tools.tcl:119
+#, tcl-format
+msgid "Running: %s"
+msgstr ""
+
+#: lib/tools.tcl:158
+#, tcl-format
+msgid "Tool completed successfully: %s"
+msgstr ""
+
+#: lib/tools.tcl:160
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr ""
+
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
+msgstr ""
+
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
+msgstr ""
+
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
+msgstr ""
+
+#: lib/mergetool.tcl:14
+#, tcl-format
 msgid ""
-"Please supply a commit message.\n"
+"Note that the diff shows only conflicting changes.\n"
 "\n"
-"A good commit message has the following format:\n"
+"%s will be overwritten.\n"
 "\n"
-"- First line: Describe in one sentence what you did.\n"
-"- Second line: Blank\n"
-"- Remaining lines: Describe why this change is good.\n"
+"This operation can be undone only by restarting the merge."
 msgstr ""
 
-#: lib/commit.tcl:234
-msgid "Calling pre-commit hook..."
+#: lib/mergetool.tcl:45
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
 msgstr ""
 
-#: lib/commit.tcl:249
-msgid "Commit declined by pre-commit hook."
+#: lib/mergetool.tcl:60
+#, tcl-format
+msgid "Adding resolution for %s"
 msgstr ""
 
-#: lib/commit.tcl:272
-msgid "Calling commit-msg hook..."
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
 msgstr ""
 
-#: lib/commit.tcl:287
-msgid "Commit declined by commit-msg hook."
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
 msgstr ""
 
-#: lib/commit.tcl:300
-msgid "Committing changes..."
+#: lib/mergetool.tcl:246
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
 msgstr ""
 
-#: lib/commit.tcl:316
-msgid "write-tree failed:"
+#: lib/mergetool.tcl:275
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
 msgstr ""
 
-#: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
-msgid "Commit failed."
+#: lib/mergetool.tcl:310
+msgid "Merge tool is already running, terminate it?"
 msgstr ""
 
-#: lib/commit.tcl:334
+#: lib/mergetool.tcl:330
 #, tcl-format
-msgid "Commit %s appears to be corrupt"
+msgid ""
+"Error retrieving versions:\n"
+"%s"
 msgstr ""
 
-#: lib/commit.tcl:339
+#: lib/mergetool.tcl:350
+#, tcl-format
 msgid ""
-"No changes to commit.\n"
-"\n"
-"No files were modified by this commit and it was not a merge commit.\n"
+"Could not start the merge tool:\n"
 "\n"
-"A rescan will be automatically started now.\n"
-msgstr ""
-
-#: lib/commit.tcl:346
-msgid "No changes to commit."
+"%s"
 msgstr ""
 
-#: lib/commit.tcl:360
-msgid "commit-tree failed:"
+#: lib/mergetool.tcl:354
+msgid "Running merge tool..."
 msgstr ""
 
-#: lib/commit.tcl:381
-msgid "update-ref failed:"
+#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
+msgid "Merge tool failed."
 msgstr ""
 
-#: lib/commit.tcl:469
+#: lib/tools_dlg.tcl:22
 #, tcl-format
-msgid "Created commit %s: %s"
+msgid "%s (%s): Add Tool"
 msgstr ""
 
-#: lib/console.tcl:59
-msgid "Working... please wait..."
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
 msgstr ""
 
-#: lib/console.tcl:186
-msgid "Success"
+#: lib/tools_dlg.tcl:34
+msgid "Add globally"
 msgstr ""
 
-#: lib/console.tcl:200
-msgid "Error: Command Failed"
+#: lib/tools_dlg.tcl:46
+msgid "Tool Details"
 msgstr ""
 
-#: lib/database.tcl:43
-msgid "Number of loose objects"
+#: lib/tools_dlg.tcl:49
+msgid "Use '/' separators to create a submenu tree:"
 msgstr ""
 
-#: lib/database.tcl:44
-msgid "Disk space used by loose objects"
+#: lib/tools_dlg.tcl:60
+msgid "Command:"
 msgstr ""
 
-#: lib/database.tcl:45
-msgid "Number of packed objects"
+#: lib/tools_dlg.tcl:71
+msgid "Show a dialog before running"
 msgstr ""
 
-#: lib/database.tcl:46
-msgid "Number of packs"
+#: lib/tools_dlg.tcl:77
+msgid "Ask the user to select a revision (sets $REVISION)"
 msgstr ""
 
-#: lib/database.tcl:47
-msgid "Disk space used by packed objects"
+#: lib/tools_dlg.tcl:82
+msgid "Ask the user for additional arguments (sets $ARGS)"
 msgstr ""
 
-#: lib/database.tcl:48
-msgid "Packed objects waiting for pruning"
+#: lib/tools_dlg.tcl:89
+msgid "Don't show the command output window"
 msgstr ""
 
-#: lib/database.tcl:49
-msgid "Garbage files"
+#: lib/tools_dlg.tcl:94
+msgid "Run only if a diff is selected ($FILENAME not empty)"
 msgstr ""
 
-#: lib/database.tcl:72
-msgid "Compressing the object database"
+#: lib/tools_dlg.tcl:118
+msgid "Please supply a name for the tool."
 msgstr ""
 
-#: lib/database.tcl:83
-msgid "Verifying the object database with fsck-objects"
+#: lib/tools_dlg.tcl:126
+#, tcl-format
+msgid "Tool '%s' already exists."
 msgstr ""
 
-#: lib/database.tcl:107
+#: lib/tools_dlg.tcl:148
 #, tcl-format
 msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you compress "
-"the database.\n"
-"\n"
-"Compress the database now?"
+"Could not add tool:\n"
+"%s"
 msgstr ""
 
-#: lib/date.tcl:25
+#: lib/tools_dlg.tcl:187
 #, tcl-format
-msgid "Invalid date from Git: %s"
+msgid "%s (%s): Remove Tool"
+msgstr ""
+
+#: lib/tools_dlg.tcl:193
+msgid "Remove Tool Commands"
+msgstr ""
+
+#: lib/tools_dlg.tcl:198
+msgid "Remove"
 msgstr ""
 
-#: lib/diff.tcl:64
+#: lib/tools_dlg.tcl:231
+msgid "(Blue denotes repository-local tools)"
+msgstr ""
+
+#: lib/tools_dlg.tcl:283
 #, tcl-format
-msgid ""
-"No differences detected.\n"
-"\n"
-"%s has no changes.\n"
-"\n"
-"The modification date of this file was updated by another application, but "
-"the content within the file was not changed.\n"
-"\n"
-"A rescan will be automatically started to find other files which may have "
-"the same state."
+msgid "%s (%s):"
 msgstr ""
 
-#: lib/diff.tcl:104
+#: lib/tools_dlg.tcl:292
 #, tcl-format
-msgid "Loading diff of %s..."
+msgid "Run Command: %s"
 msgstr ""
 
-#: lib/diff.tcl:125
-msgid ""
-"LOCAL: deleted\n"
-"REMOTE:\n"
+#: lib/tools_dlg.tcl:306
+msgid "Arguments"
 msgstr ""
 
-#: lib/diff.tcl:130
-msgid ""
-"REMOTE: deleted\n"
-"LOCAL:\n"
+#: lib/tools_dlg.tcl:341
+msgid "OK"
 msgstr ""
 
-#: lib/diff.tcl:137
-msgid "LOCAL:\n"
+#: lib/search.tcl:48
+msgid "Find:"
 msgstr ""
 
-#: lib/diff.tcl:140
-msgid "REMOTE:\n"
+#: lib/search.tcl:50
+msgid "Next"
 msgstr ""
 
-#: lib/diff.tcl:202 lib/diff.tcl:319
-#, tcl-format
-msgid "Unable to display %s"
+#: lib/search.tcl:51
+msgid "Prev"
 msgstr ""
 
-#: lib/diff.tcl:203
-msgid "Error loading file:"
+#: lib/search.tcl:52
+msgid "RegExp"
 msgstr ""
 
-#: lib/diff.tcl:210
-msgid "Git Repository (subproject)"
+#: lib/search.tcl:54
+msgid "Case"
 msgstr ""
 
-#: lib/diff.tcl:222
-msgid "* Binary file (not showing content)."
+#: lib/shortcut.tcl:8 lib/shortcut.tcl:43 lib/shortcut.tcl:75
+#, tcl-format
+msgid "%s (%s): Create Desktop Icon"
 msgstr ""
 
-#: lib/diff.tcl:227
+#: lib/shortcut.tcl:24 lib/shortcut.tcl:65
+msgid "Cannot write shortcut:"
+msgstr ""
+
+#: lib/shortcut.tcl:140
+msgid "Cannot write icon:"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:29
 #, tcl-format
-msgid ""
-"* Untracked file is %d bytes.\n"
-"* Showing only first %d bytes.\n"
+msgid "%s (%s): Delete Branch Remotely"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:34
+msgid "Delete Branch Remotely"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:48
+msgid "From Repository"
 msgstr ""
 
-#: lib/diff.tcl:233
+#: lib/remote_branch_delete.tcl:88
+msgid "Branches"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:110
+msgid "Delete Only If"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:112
+msgid "Merged Into:"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:120 lib/branch_delete.tcl:53
+msgid "Always (Do not perform merge checks)"
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:153
+msgid "A branch is required for 'Merged Into'."
+msgstr ""
+
+#: lib/remote_branch_delete.tcl:185
 #, tcl-format
 msgid ""
+"The following branches are not completely merged into %s:\n"
 "\n"
-"* Untracked file clipped here by %s.\n"
-"* To see the entire file, use an external editor.\n"
+" - %s"
 msgstr ""
 
-#: lib/diff.tcl:482
-msgid "Failed to unstage selected hunk."
+#: lib/remote_branch_delete.tcl:190
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched the "
+"necessary commits.  Try fetching from %s first."
 msgstr ""
 
-#: lib/diff.tcl:489
-msgid "Failed to stage selected hunk."
+#: lib/remote_branch_delete.tcl:208
+msgid "Please select one or more branches to delete."
 msgstr ""
 
-#: lib/diff.tcl:568
-msgid "Failed to unstage selected line."
+#: lib/remote_branch_delete.tcl:218 lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
 msgstr ""
 
-#: lib/diff.tcl:576
-msgid "Failed to stage selected line."
+#: lib/remote_branch_delete.tcl:227
+#, tcl-format
+msgid "Deleting branches from %s"
 msgstr ""
 
-#: lib/encoding.tcl:443
-msgid "Default"
+#: lib/remote_branch_delete.tcl:300
+msgid "No repository selected."
 msgstr ""
 
-#: lib/encoding.tcl:448
+#: lib/remote_branch_delete.tcl:305
 #, tcl-format
-msgid "System (%s)"
+msgid "Scanning %s..."
 msgstr ""
 
-#: lib/encoding.tcl:459 lib/encoding.tcl:465
-msgid "Other"
+#: lib/choose_repository.tcl:45
+msgid "Git Gui"
 msgstr ""
 
-#: lib/error.tcl:20 lib/error.tcl:114
-msgid "error"
+#: lib/choose_repository.tcl:104 lib/choose_repository.tcl:427
+msgid "Create New Repository"
 msgstr ""
 
-#: lib/error.tcl:36
-msgid "warning"
+#: lib/choose_repository.tcl:110
+msgid "New..."
 msgstr ""
 
-#: lib/error.tcl:94
-msgid "You must correct the above errors before committing."
+#: lib/choose_repository.tcl:117 lib/choose_repository.tcl:511
+msgid "Clone Existing Repository"
 msgstr ""
 
-#: lib/index.tcl:6
-msgid "Unable to unlock the index."
+#: lib/choose_repository.tcl:128
+msgid "Clone..."
 msgstr ""
 
-#: lib/index.tcl:15
-msgid "Index Error"
+#: lib/choose_repository.tcl:135 lib/choose_repository.tcl:1105
+msgid "Open Existing Repository"
 msgstr ""
 
-#: lib/index.tcl:17
-msgid ""
-"Updating the Git index failed.  A rescan will be automatically started to "
-"resynchronize git-gui."
+#: lib/choose_repository.tcl:141
+msgid "Open..."
 msgstr ""
 
-#: lib/index.tcl:28
-msgid "Continue"
+#: lib/choose_repository.tcl:154
+msgid "Recent Repositories"
 msgstr ""
 
-#: lib/index.tcl:31
-msgid "Unlock Index"
+#: lib/choose_repository.tcl:164
+msgid "Open Recent Repository:"
 msgstr ""
 
-#: lib/index.tcl:289
+#: lib/choose_repository.tcl:331 lib/choose_repository.tcl:338
+#: lib/choose_repository.tcl:345
 #, tcl-format
-msgid "Unstaging %s from commit"
+msgid "Failed to create repository %s:"
 msgstr ""
 
-#: lib/index.tcl:328
-msgid "Ready to commit."
+#: lib/choose_repository.tcl:422 lib/branch_create.tcl:33
+msgid "Create"
 msgstr ""
 
-#: lib/index.tcl:341
-#, tcl-format
-msgid "Adding %s"
+#: lib/choose_repository.tcl:432
+msgid "Directory:"
+msgstr ""
+
+#: lib/choose_repository.tcl:462 lib/choose_repository.tcl:588
+#: lib/choose_repository.tcl:1139
+msgid "Git Repository"
 msgstr ""
 
-#: lib/index.tcl:398
+#: lib/choose_repository.tcl:487
 #, tcl-format
-msgid "Revert changes in file %s?"
+msgid "Directory %s already exists."
 msgstr ""
 
-#: lib/index.tcl:400
+#: lib/choose_repository.tcl:491
 #, tcl-format
-msgid "Revert changes in these %i files?"
+msgid "File %s already exists."
 msgstr ""
 
-#: lib/index.tcl:408
-msgid "Any unstaged changes will be permanently lost by the revert."
+#: lib/choose_repository.tcl:506
+msgid "Clone"
 msgstr ""
 
-#: lib/index.tcl:411
-msgid "Do Nothing"
+#: lib/choose_repository.tcl:519
+msgid "Source Location:"
 msgstr ""
 
-#: lib/index.tcl:429
-msgid "Reverting selected files"
+#: lib/choose_repository.tcl:528
+msgid "Target Directory:"
+msgstr ""
+
+#: lib/choose_repository.tcl:538
+msgid "Clone Type:"
+msgstr ""
+
+#: lib/choose_repository.tcl:543
+msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+msgstr ""
+
+#: lib/choose_repository.tcl:548
+msgid "Full Copy (Slower, Redundant Backup)"
+msgstr ""
+
+#: lib/choose_repository.tcl:553
+msgid "Shared (Fastest, Not Recommended, No Backup)"
+msgstr ""
+
+#: lib/choose_repository.tcl:560
+msgid "Recursively clone submodules too"
 msgstr ""
 
-#: lib/index.tcl:433
+#: lib/choose_repository.tcl:594 lib/choose_repository.tcl:641
+#: lib/choose_repository.tcl:790 lib/choose_repository.tcl:864
+#: lib/choose_repository.tcl:1145 lib/choose_repository.tcl:1153
 #, tcl-format
-msgid "Reverting %s"
+msgid "Not a Git repository: %s"
 msgstr ""
 
-#: lib/merge.tcl:13
-msgid ""
-"Cannot merge while amending.\n"
-"\n"
-"You must finish amending this commit before starting any type of merge.\n"
+#: lib/choose_repository.tcl:630
+msgid "Standard only available for local repository."
 msgstr ""
 
-#: lib/merge.tcl:27
-msgid ""
-"Last scanned state does not match repository state.\n"
-"\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before a merge can be performed.\n"
-"\n"
-"The rescan will be automatically started now.\n"
+#: lib/choose_repository.tcl:634
+msgid "Shared only available for local repository."
 msgstr ""
 
-#: lib/merge.tcl:45
+#: lib/choose_repository.tcl:655
 #, tcl-format
-msgid ""
-"You are in the middle of a conflicted merge.\n"
-"\n"
-"File %s has merge conflicts.\n"
-"\n"
-"You must resolve them, stage the file, and commit to complete the current "
-"merge.  Only then can you begin another merge.\n"
+msgid "Location %s already exists."
 msgstr ""
 
-#: lib/merge.tcl:55
+#: lib/choose_repository.tcl:666
+msgid "Failed to configure origin"
+msgstr ""
+
+#: lib/choose_repository.tcl:678
+msgid "Counting objects"
+msgstr ""
+
+#: lib/choose_repository.tcl:679
+msgid "buckets"
+msgstr ""
+
+#: lib/choose_repository.tcl:703
 #, tcl-format
-msgid ""
-"You are in the middle of a change.\n"
-"\n"
-"File %s is modified.\n"
-"\n"
-"You should complete the current commit before starting a merge.  Doing so "
-"will help you abort a failed merge, should the need arise.\n"
+msgid "Unable to copy objects/info/alternates: %s"
 msgstr ""
 
-#: lib/merge.tcl:107
+#: lib/choose_repository.tcl:740
 #, tcl-format
-msgid "%s of %s"
+msgid "Nothing to clone from %s."
+msgstr ""
+
+#: lib/choose_repository.tcl:742 lib/choose_repository.tcl:962
+#: lib/choose_repository.tcl:974
+msgid "The 'master' branch has not been initialized."
 msgstr ""
 
-#: lib/merge.tcl:120
+#: lib/choose_repository.tcl:755
+msgid "Hardlinks are unavailable.  Falling back to copying."
+msgstr ""
+
+#: lib/choose_repository.tcl:769
 #, tcl-format
-msgid "Merging %s and %s..."
+msgid "Cloning from %s"
 msgstr ""
 
-#: lib/merge.tcl:131
-msgid "Merge completed successfully."
+#: lib/choose_repository.tcl:800
+msgid "Copying objects"
 msgstr ""
 
-#: lib/merge.tcl:133
-msgid "Merge failed.  Conflict resolution is required."
+#: lib/choose_repository.tcl:801
+msgid "KiB"
 msgstr ""
 
-#: lib/merge.tcl:158
+#: lib/choose_repository.tcl:825
 #, tcl-format
-msgid "Merge Into %s"
+msgid "Unable to copy object: %s"
 msgstr ""
 
-#: lib/merge.tcl:177
-msgid "Revision To Merge"
+#: lib/choose_repository.tcl:837
+msgid "Linking objects"
 msgstr ""
 
-#: lib/merge.tcl:212
-msgid ""
-"Cannot abort while amending.\n"
-"\n"
-"You must finish amending this commit.\n"
+#: lib/choose_repository.tcl:838
+msgid "objects"
 msgstr ""
 
-#: lib/merge.tcl:222
-msgid ""
-"Abort merge?\n"
-"\n"
-"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
-"\n"
-"Continue with aborting the current merge?"
+#: lib/choose_repository.tcl:846
+#, tcl-format
+msgid "Unable to hardlink object: %s"
 msgstr ""
 
-#: lib/merge.tcl:228
-msgid ""
-"Reset changes?\n"
-"\n"
-"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
-"\n"
-"Continue with resetting the current changes?"
+#: lib/choose_repository.tcl:903
+msgid "Cannot fetch branches and objects.  See console output for details."
 msgstr ""
 
-#: lib/merge.tcl:239
-msgid "Aborting"
+#: lib/choose_repository.tcl:914
+msgid "Cannot fetch tags.  See console output for details."
 msgstr ""
 
-#: lib/merge.tcl:239
-msgid "files reset"
+#: lib/choose_repository.tcl:938
+msgid "Cannot determine HEAD.  See console output for details."
 msgstr ""
 
-#: lib/merge.tcl:267
-msgid "Abort failed."
+#: lib/choose_repository.tcl:947
+#, tcl-format
+msgid "Unable to cleanup %s"
 msgstr ""
 
-#: lib/merge.tcl:269
-msgid "Abort completed.  Ready."
+#: lib/choose_repository.tcl:953
+msgid "Clone failed."
 msgstr ""
 
-#: lib/mergetool.tcl:8
-msgid "Force resolution to the base version?"
+#: lib/choose_repository.tcl:960
+msgid "No default branch obtained."
 msgstr ""
 
-#: lib/mergetool.tcl:9
-msgid "Force resolution to this branch?"
+#: lib/choose_repository.tcl:971
+#, tcl-format
+msgid "Cannot resolve %s as a commit."
+msgstr ""
+
+#: lib/choose_repository.tcl:998
+msgid "Creating working directory"
+msgstr ""
+
+#: lib/choose_repository.tcl:1028
+msgid "Initial file checkout failed."
+msgstr ""
+
+#: lib/choose_repository.tcl:1072
+msgid "Cloning submodules"
+msgstr ""
+
+#: lib/choose_repository.tcl:1087
+msgid "Cannot clone submodules."
+msgstr ""
+
+#: lib/choose_repository.tcl:1110
+msgid "Repository:"
+msgstr ""
+
+#: lib/choose_repository.tcl:1159
+#, tcl-format
+msgid "Failed to open repository %s:"
 msgstr ""
 
-#: lib/mergetool.tcl:10
-msgid "Force resolution to the other branch?"
+#: lib/about.tcl:26
+msgid "git-gui - a graphical user interface for Git."
 msgstr ""
 
-#: lib/mergetool.tcl:14
+#: lib/blame.tcl:74
 #, tcl-format
-msgid ""
-"Note that the diff shows only conflicting changes.\n"
-"\n"
-"%s will be overwritten.\n"
-"\n"
-"This operation can be undone only by restarting the merge."
+msgid "%s (%s): File Viewer"
 msgstr ""
 
-#: lib/mergetool.tcl:45
-#, tcl-format
-msgid "File %s seems to have unresolved conflicts, still stage?"
+#: lib/blame.tcl:80
+msgid "Commit:"
 msgstr ""
 
-#: lib/mergetool.tcl:60
-#, tcl-format
-msgid "Adding resolution for %s"
+#: lib/blame.tcl:282
+msgid "Copy Commit"
 msgstr ""
 
-#: lib/mergetool.tcl:141
-msgid "Cannot resolve deletion or link conflicts using a tool"
+#: lib/blame.tcl:286
+msgid "Find Text..."
 msgstr ""
 
-#: lib/mergetool.tcl:146
-msgid "Conflict file does not exist"
+#: lib/blame.tcl:290
+msgid "Goto Line..."
 msgstr ""
 
-#: lib/mergetool.tcl:264
-#, tcl-format
-msgid "Not a GUI merge tool: '%s'"
+#: lib/blame.tcl:299
+msgid "Do Full Copy Detection"
 msgstr ""
 
-#: lib/mergetool.tcl:268
-#, tcl-format
-msgid "Unsupported merge tool '%s'"
+#: lib/blame.tcl:303
+msgid "Show History Context"
 msgstr ""
 
-#: lib/mergetool.tcl:303
-msgid "Merge tool is already running, terminate it?"
+#: lib/blame.tcl:306
+msgid "Blame Parent Commit"
 msgstr ""
 
-#: lib/mergetool.tcl:323
+#: lib/blame.tcl:468
 #, tcl-format
-msgid ""
-"Error retrieving versions:\n"
-"%s"
+msgid "Reading %s..."
 msgstr ""
 
-#: lib/mergetool.tcl:343
-#, tcl-format
-msgid ""
-"Could not start the merge tool:\n"
-"\n"
-"%s"
+#: lib/blame.tcl:596
+msgid "Loading copy/move tracking annotations..."
 msgstr ""
 
-#: lib/mergetool.tcl:347
-msgid "Running merge tool..."
+#: lib/blame.tcl:613
+msgid "lines annotated"
 msgstr ""
 
-#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
-msgid "Merge tool failed."
+#: lib/blame.tcl:815
+msgid "Loading original location annotations..."
 msgstr ""
 
-#: lib/option.tcl:11
-#, tcl-format
-msgid "Invalid global encoding '%s'"
+#: lib/blame.tcl:818
+msgid "Annotation complete."
 msgstr ""
 
-#: lib/option.tcl:19
-#, tcl-format
-msgid "Invalid repo encoding '%s'"
+#: lib/blame.tcl:849
+msgid "Busy"
 msgstr ""
 
-#: lib/option.tcl:117
-msgid "Restore Defaults"
+#: lib/blame.tcl:850
+msgid "Annotation process is already running."
 msgstr ""
 
-#: lib/option.tcl:121
-msgid "Save"
+#: lib/blame.tcl:889
+msgid "Running thorough copy detection..."
 msgstr ""
 
-#: lib/option.tcl:131
-#, tcl-format
-msgid "%s Repository"
+#: lib/blame.tcl:957
+msgid "Loading annotation..."
 msgstr ""
 
-#: lib/option.tcl:132
-msgid "Global (All Repositories)"
+#: lib/blame.tcl:1010
+msgid "Author:"
 msgstr ""
 
-#: lib/option.tcl:138
-msgid "User Name"
+#: lib/blame.tcl:1014
+msgid "Committer:"
 msgstr ""
 
-#: lib/option.tcl:139
-msgid "Email Address"
+#: lib/blame.tcl:1019
+msgid "Original File:"
 msgstr ""
 
-#: lib/option.tcl:141
-msgid "Summarize Merge Commits"
+#: lib/blame.tcl:1067
+msgid "Cannot find HEAD commit:"
 msgstr ""
 
-#: lib/option.tcl:142
-msgid "Merge Verbosity"
+#: lib/blame.tcl:1122
+msgid "Cannot find parent commit:"
 msgstr ""
 
-#: lib/option.tcl:143
-msgid "Show Diffstat After Merge"
+#: lib/blame.tcl:1137
+msgid "Unable to display parent"
 msgstr ""
 
-#: lib/option.tcl:144
-msgid "Use Merge Tool"
+#: lib/blame.tcl:1138 lib/diff.tcl:345
+msgid "Error loading diff:"
 msgstr ""
 
-#: lib/option.tcl:146
-msgid "Trust File Modification Timestamps"
+#: lib/blame.tcl:1279
+msgid "Originally By:"
 msgstr ""
 
-#: lib/option.tcl:147
-msgid "Prune Tracking Branches During Fetch"
+#: lib/blame.tcl:1285
+msgid "In File:"
 msgstr ""
 
-#: lib/option.tcl:148
-msgid "Match Tracking Branches"
+#: lib/blame.tcl:1290
+msgid "Copied Or Moved Here By:"
 msgstr ""
 
-#: lib/option.tcl:149
-msgid "Blame Copy Only On Changed Files"
+#: lib/diff.tcl:77
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may have "
+"the same state."
 msgstr ""
 
-#: lib/option.tcl:150
-msgid "Minimum Letters To Blame Copy On"
+#: lib/diff.tcl:117
+#, tcl-format
+msgid "Loading diff of %s..."
 msgstr ""
 
-#: lib/option.tcl:151
-msgid "Blame History Context Radius (days)"
+#: lib/diff.tcl:143
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
 msgstr ""
 
-#: lib/option.tcl:152
-msgid "Number of Diff Context Lines"
+#: lib/diff.tcl:148
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
 msgstr ""
 
-#: lib/option.tcl:153
-msgid "Commit Message Text Width"
+#: lib/diff.tcl:155
+msgid "LOCAL:\n"
 msgstr ""
 
-#: lib/option.tcl:154
-msgid "New Branch Name Template"
+#: lib/diff.tcl:158
+msgid "REMOTE:\n"
 msgstr ""
 
-#: lib/option.tcl:155
-msgid "Default File Contents Encoding"
+#: lib/diff.tcl:220 lib/diff.tcl:344
+#, tcl-format
+msgid "Unable to display %s"
 msgstr ""
 
-#: lib/option.tcl:203
-msgid "Change"
+#: lib/diff.tcl:221
+msgid "Error loading file:"
 msgstr ""
 
-#: lib/option.tcl:230
-msgid "Spelling Dictionary:"
+#: lib/diff.tcl:227
+msgid "Git Repository (subproject)"
 msgstr ""
 
-#: lib/option.tcl:254
-msgid "Change Font"
+#: lib/diff.tcl:239
+msgid "* Binary file (not showing content)."
 msgstr ""
 
-#: lib/option.tcl:258
+#: lib/diff.tcl:244
 #, tcl-format
-msgid "Choose %s"
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
 msgstr ""
 
-#: lib/option.tcl:264
-msgid "pt."
+#: lib/diff.tcl:250
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
 msgstr ""
 
-#: lib/option.tcl:278
-msgid "Preferences"
+#: lib/diff.tcl:583
+msgid "Failed to unstage selected hunk."
 msgstr ""
 
-#: lib/option.tcl:314
-msgid "Failed to completely save options:"
+#: lib/diff.tcl:591
+msgid "Failed to revert selected hunk."
 msgstr ""
 
-#: lib/remote.tcl:163
-msgid "Remove Remote"
+#: lib/diff.tcl:594
+msgid "Failed to stage selected hunk."
 msgstr ""
 
-#: lib/remote.tcl:168
-msgid "Prune from"
+#: lib/diff.tcl:687
+msgid "Failed to unstage selected line."
 msgstr ""
 
-#: lib/remote.tcl:173
-msgid "Fetch from"
+#: lib/diff.tcl:696
+msgid "Failed to revert selected line."
 msgstr ""
 
-#: lib/remote.tcl:215
-msgid "Push to"
+#: lib/diff.tcl:700
+msgid "Failed to stage selected line."
 msgstr ""
 
-#: lib/remote_add.tcl:19
-msgid "Add Remote"
+#: lib/diff.tcl:889
+msgid "Failed to undo last revert."
 msgstr ""
 
-#: lib/remote_add.tcl:24
-msgid "Add New Remote"
+#: lib/sshkey.tcl:34
+msgid "No keys found."
 msgstr ""
 
-#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
-msgid "Add"
+#: lib/sshkey.tcl:37
+#, tcl-format
+msgid "Found a public key in: %s"
 msgstr ""
 
-#: lib/remote_add.tcl:37
-msgid "Remote Details"
+#: lib/sshkey.tcl:43
+msgid "Generate Key"
 msgstr ""
 
-#: lib/remote_add.tcl:50
-msgid "Location:"
+#: lib/sshkey.tcl:61
+msgid "Copy To Clipboard"
 msgstr ""
 
-#: lib/remote_add.tcl:62
-msgid "Further Action"
+#: lib/sshkey.tcl:75
+msgid "Your OpenSSH Public Key"
 msgstr ""
 
-#: lib/remote_add.tcl:65
-msgid "Fetch Immediately"
+#: lib/sshkey.tcl:83
+msgid "Generating..."
 msgstr ""
 
-#: lib/remote_add.tcl:71
-msgid "Initialize Remote Repository and Push"
+#: lib/sshkey.tcl:89
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
 msgstr ""
 
-#: lib/remote_add.tcl:77
-msgid "Do Nothing Else Now"
+#: lib/sshkey.tcl:116
+msgid "Generation failed."
 msgstr ""
 
-#: lib/remote_add.tcl:101
-msgid "Please supply a remote name."
+#: lib/sshkey.tcl:123
+msgid "Generation succeeded, but no keys found."
 msgstr ""
 
-#: lib/remote_add.tcl:114
+#: lib/sshkey.tcl:126
 #, tcl-format
-msgid "'%s' is not an acceptable remote name."
+msgid "Your key is in: %s"
 msgstr ""
 
-#: lib/remote_add.tcl:125
+#: lib/branch_create.tcl:23
 #, tcl-format
-msgid "Failed to add remote '%s' of location '%s'."
+msgid "%s (%s): Create Branch"
 msgstr ""
 
-#: lib/remote_add.tcl:133 lib/transport.tcl:6
-#, tcl-format
-msgid "fetch %s"
+#: lib/branch_create.tcl:28
+msgid "Create New Branch"
 msgstr ""
 
-#: lib/remote_add.tcl:134
-#, tcl-format
-msgid "Fetching the %s"
+#: lib/branch_create.tcl:42
+msgid "Branch Name"
 msgstr ""
 
-#: lib/remote_add.tcl:157
-#, tcl-format
-msgid "Do not know how to initialize repository at location '%s'."
+#: lib/branch_create.tcl:57
+msgid "Match Tracking Branch Name"
 msgstr ""
 
-#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
-#: lib/transport.tcl:81
-#, tcl-format
-msgid "push %s"
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
 msgstr ""
 
-#: lib/remote_add.tcl:164
-#, tcl-format
-msgid "Setting up the %s (at %s)"
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
-msgid "Delete Branch Remotely"
+#: lib/branch_create.tcl:75
+msgid "No"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:47
-msgid "From Repository"
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
-msgid "Remote:"
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
-msgid "Arbitrary Location:"
+#: lib/branch_create.tcl:132
+msgid "Please select a tracking branch."
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:84
-msgid "Branches"
+#: lib/branch_create.tcl:141
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:109
-msgid "Delete Only If"
+#: lib/console.tcl:59
+msgid "Working... please wait..."
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:111
-msgid "Merged Into:"
+#: lib/console.tcl:186
+msgid "Success"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:152
-msgid "A branch is required for 'Merged Into'."
+#: lib/console.tcl:200
+msgid "Error: Command Failed"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:184
-#, tcl-format
-msgid ""
-"The following branches are not completely merged into %s:\n"
-"\n"
-" - %s"
+#: lib/line.tcl:17
+msgid "Goto Line:"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:189
-#, tcl-format
-msgid ""
-"One or more of the merge tests failed because you have not fetched the "
-"necessary commits.  Try fetching from %s first."
+#: lib/line.tcl:23
+msgid "Go"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:207
-msgid "Please select one or more branches to delete."
+#: lib/choose_rev.tcl:52
+msgid "This Detached Checkout"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:226
-#, tcl-format
-msgid "Deleting branches from %s"
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:292
-msgid "No repository selected."
+#: lib/choose_rev.tcl:72
+msgid "Local Branch"
+msgstr ""
+
+#: lib/choose_rev.tcl:77
+msgid "Tracking Branch"
+msgstr ""
+
+#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
+msgid "Tag"
 msgstr ""
 
-#: lib/remote_branch_delete.tcl:297
+#: lib/choose_rev.tcl:321
 #, tcl-format
-msgid "Scanning %s..."
+msgid "Invalid revision: %s"
 msgstr ""
 
-#: lib/search.tcl:21
-msgid "Find:"
+#: lib/choose_rev.tcl:342
+msgid "No revision selected."
 msgstr ""
 
-#: lib/search.tcl:23
-msgid "Next"
+#: lib/choose_rev.tcl:350
+msgid "Revision expression is empty."
+msgstr ""
+
+#: lib/choose_rev.tcl:537
+msgid "Updated"
+msgstr ""
+
+#: lib/choose_rev.tcl:565
+msgid "URL"
 msgstr ""
 
-#: lib/search.tcl:24
-msgid "Prev"
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit before this "
+"to amend.\n"
 msgstr ""
 
-#: lib/search.tcl:25
-msgid "Case-Sensitive"
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort the "
+"current merge activity.\n"
 msgstr ""
 
-#: lib/shortcut.tcl:21 lib/shortcut.tcl:62
-msgid "Cannot write shortcut:"
+#: lib/commit.tcl:56
+msgid "Error loading commit data for amend:"
 msgstr ""
 
-#: lib/shortcut.tcl:137
-msgid "Cannot write icon:"
+#: lib/commit.tcl:83
+msgid "Unable to obtain your identity:"
 msgstr ""
 
-#: lib/spellcheck.tcl:57
-msgid "Unsupported spell checker"
+#: lib/commit.tcl:88
+msgid "Invalid GIT_COMMITTER_IDENT:"
 msgstr ""
 
-#: lib/spellcheck.tcl:65
-msgid "Spell checking is unavailable"
+#: lib/commit.tcl:138
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
 msgstr ""
 
-#: lib/spellcheck.tcl:68
-msgid "Invalid spell checking configuration"
+#: lib/commit.tcl:158
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
 msgstr ""
 
-#: lib/spellcheck.tcl:70
+#: lib/commit.tcl:182
 #, tcl-format
-msgid "Reverting dictionary to %s."
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the file "
+"before committing.\n"
 msgstr ""
 
-#: lib/spellcheck.tcl:73
-msgid "Spell checker silently failed on startup"
+#: lib/commit.tcl:190
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
 msgstr ""
 
-#: lib/spellcheck.tcl:80
-msgid "Unrecognized spell checker"
+#: lib/commit.tcl:198
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
 msgstr ""
 
-#: lib/spellcheck.tcl:186
-msgid "No Suggestions"
+#: lib/commit.tcl:213
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentence what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
 msgstr ""
 
-#: lib/spellcheck.tcl:388
-msgid "Unexpected EOF from spell checker"
+#: lib/commit.tcl:244
+msgid "Calling pre-commit hook..."
 msgstr ""
 
-#: lib/spellcheck.tcl:392
-msgid "Spell Checker Failed"
+#: lib/commit.tcl:259
+msgid "Commit declined by pre-commit hook."
 msgstr ""
 
-#: lib/sshkey.tcl:31
-msgid "No keys found."
+#: lib/commit.tcl:278
+msgid ""
+"You are about to commit on a detached head. This is a potentially dangerous "
+"thing to do because if you switch to another branch you will lose your "
+"changes and it can be difficult to retrieve them later from the reflog. You "
+"should probably cancel this commit and create a new branch to continue.\n"
+" \n"
+" Do you really want to proceed with your Commit?"
 msgstr ""
 
-#: lib/sshkey.tcl:34
-#, tcl-format
-msgid "Found a public key in: %s"
+#: lib/commit.tcl:299
+msgid "Calling commit-msg hook..."
 msgstr ""
 
-#: lib/sshkey.tcl:40
-msgid "Generate Key"
+#: lib/commit.tcl:314
+msgid "Commit declined by commit-msg hook."
 msgstr ""
 
-#: lib/sshkey.tcl:56
-msgid "Copy To Clipboard"
+#: lib/commit.tcl:327
+msgid "Committing changes..."
 msgstr ""
 
-#: lib/sshkey.tcl:70
-msgid "Your OpenSSH Public Key"
+#: lib/commit.tcl:344
+msgid "write-tree failed:"
 msgstr ""
 
-#: lib/sshkey.tcl:78
-msgid "Generating..."
+#: lib/commit.tcl:345 lib/commit.tcl:395 lib/commit.tcl:422
+msgid "Commit failed."
 msgstr ""
 
-#: lib/sshkey.tcl:84
+#: lib/commit.tcl:362
 #, tcl-format
+msgid "Commit %s appears to be corrupt"
+msgstr ""
+
+#: lib/commit.tcl:367
 msgid ""
-"Could not start ssh-keygen:\n"
+"No changes to commit.\n"
 "\n"
-"%s"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
 msgstr ""
 
-#: lib/sshkey.tcl:111
-msgid "Generation failed."
+#: lib/commit.tcl:374
+msgid "No changes to commit."
 msgstr ""
 
-#: lib/sshkey.tcl:118
-msgid "Generation succeeded, but no keys found."
+#: lib/commit.tcl:394
+msgid "commit-tree failed:"
 msgstr ""
 
-#: lib/sshkey.tcl:121
-#, tcl-format
-msgid "Your key is in: %s"
+#: lib/commit.tcl:421
+msgid "update-ref failed:"
 msgstr ""
 
-#: lib/status_bar.tcl:83
+#: lib/commit.tcl:514
 #, tcl-format
-msgid "%s ... %*i of %*i %s (%3i%%)"
+msgid "Created commit %s: %s"
 msgstr ""
 
-#: lib/tools.tcl:75
+#: lib/branch_delete.tcl:16
 #, tcl-format
-msgid "Running %s requires a selected file."
+msgid "%s (%s): Delete Branch"
 msgstr ""
 
-#: lib/tools.tcl:90
-#, tcl-format
-msgid "Are you sure you want to run %s?"
+#: lib/branch_delete.tcl:21
+msgid "Delete Local Branch"
+msgstr ""
+
+#: lib/branch_delete.tcl:39
+msgid "Local Branches"
+msgstr ""
+
+#: lib/branch_delete.tcl:51
+msgid "Delete Only If Merged Into"
 msgstr ""
 
-#: lib/tools.tcl:110
+#: lib/branch_delete.tcl:103
 #, tcl-format
-msgid "Tool: %s"
+msgid "The following branches are not completely merged into %s:"
 msgstr ""
 
-#: lib/tools.tcl:111
+#: lib/branch_delete.tcl:131
 #, tcl-format
-msgid "Running: %s"
+msgid " - %s:"
 msgstr ""
 
-#: lib/tools.tcl:149
+#: lib/branch_delete.tcl:141
 #, tcl-format
-msgid "Tool completed successfully: %s"
+msgid ""
+"Failed to delete branches:\n"
+"%s"
 msgstr ""
 
-#: lib/tools.tcl:151
+#: lib/date.tcl:25
 #, tcl-format
-msgid "Tool failed: %s"
+msgid "Invalid date from Git: %s"
 msgstr ""
 
-#: lib/tools_dlg.tcl:22
-msgid "Add Tool"
+#: lib/database.tcl:42
+msgid "Number of loose objects"
 msgstr ""
 
-#: lib/tools_dlg.tcl:28
-msgid "Add New Tool Command"
+#: lib/database.tcl:43
+msgid "Disk space used by loose objects"
 msgstr ""
 
-#: lib/tools_dlg.tcl:33
-msgid "Add globally"
+#: lib/database.tcl:44
+msgid "Number of packed objects"
 msgstr ""
 
-#: lib/tools_dlg.tcl:45
-msgid "Tool Details"
+#: lib/database.tcl:45
+msgid "Number of packs"
 msgstr ""
 
-#: lib/tools_dlg.tcl:48
-msgid "Use '/' separators to create a submenu tree:"
+#: lib/database.tcl:46
+msgid "Disk space used by packed objects"
 msgstr ""
 
-#: lib/tools_dlg.tcl:61
-msgid "Command:"
+#: lib/database.tcl:47
+msgid "Packed objects waiting for pruning"
 msgstr ""
 
-#: lib/tools_dlg.tcl:74
-msgid "Show a dialog before running"
+#: lib/database.tcl:48
+msgid "Garbage files"
 msgstr ""
 
-#: lib/tools_dlg.tcl:80
-msgid "Ask the user to select a revision (sets $REVISION)"
+#: lib/database.tcl:66
+#, tcl-format
+msgid "%s (%s): Database Statistics"
 msgstr ""
 
-#: lib/tools_dlg.tcl:85
-msgid "Ask the user for additional arguments (sets $ARGS)"
+#: lib/database.tcl:72
+msgid "Compressing the object database"
 msgstr ""
 
-#: lib/tools_dlg.tcl:92
-msgid "Don't show the command output window"
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
 msgstr ""
 
-#: lib/tools_dlg.tcl:97
-msgid "Run only if a diff is selected ($FILENAME not empty)"
+#: lib/database.tcl:107
+#, tcl-format
+msgid ""
+"This repository currently has approximately %i loose objects.\n"
+"\n"
+"To maintain optimal performance it is strongly recommended that you compress "
+"the database.\n"
+"\n"
+"Compress the database now?"
 msgstr ""
 
-#: lib/tools_dlg.tcl:121
-msgid "Please supply a name for the tool."
+#: lib/error.tcl:20
+#, tcl-format
+msgid "%s: error"
 msgstr ""
 
-#: lib/tools_dlg.tcl:129
+#: lib/error.tcl:36
 #, tcl-format
-msgid "Tool '%s' already exists."
+msgid "%s: warning"
 msgstr ""
 
-#: lib/tools_dlg.tcl:151
+#: lib/error.tcl:80
 #, tcl-format
-msgid ""
-"Could not add tool:\n"
-"%s"
+msgid "%s hook failed:"
 msgstr ""
 
-#: lib/tools_dlg.tcl:190
-msgid "Remove Tool"
+#: lib/error.tcl:96
+msgid "You must correct the above errors before committing."
 msgstr ""
 
-#: lib/tools_dlg.tcl:196
-msgid "Remove Tool Commands"
+#: lib/error.tcl:116
+#, tcl-format
+msgid "%s (%s): error"
 msgstr ""
 
-#: lib/tools_dlg.tcl:200
-msgid "Remove"
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
 msgstr ""
 
-#: lib/tools_dlg.tcl:236
-msgid "(Blue denotes repository-local tools)"
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
 msgstr ""
 
-#: lib/tools_dlg.tcl:297
+#: lib/merge.tcl:45
 #, tcl-format
-msgid "Run Command: %s"
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the current "
+"merge.  Only then can you begin another merge.\n"
 msgstr ""
 
-#: lib/tools_dlg.tcl:311
-msgid "Arguments"
+#: lib/merge.tcl:55
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doing so "
+"will help you abort a failed merge, should the need arise.\n"
 msgstr ""
 
-#: lib/tools_dlg.tcl:348
-msgid "OK"
+#: lib/merge.tcl:108
+#, tcl-format
+msgid "%s of %s"
 msgstr ""
 
-#: lib/transport.tcl:7
+#: lib/merge.tcl:126
 #, tcl-format
-msgid "Fetching new changes from %s"
+msgid "Merging %s and %s..."
 msgstr ""
 
-#: lib/transport.tcl:18
-#, tcl-format
-msgid "remote prune %s"
+#: lib/merge.tcl:137
+msgid "Merge completed successfully."
 msgstr ""
 
-#: lib/transport.tcl:19
-#, tcl-format
-msgid "Pruning tracking branches deleted from %s"
+#: lib/merge.tcl:139
+msgid "Merge failed.  Conflict resolution is required."
 msgstr ""
 
-#: lib/transport.tcl:26
+#: lib/merge.tcl:156
 #, tcl-format
-msgid "Pushing changes to %s"
+msgid "%s (%s): Merge"
 msgstr ""
 
-#: lib/transport.tcl:64
+#: lib/merge.tcl:164
 #, tcl-format
-msgid "Mirroring to %s"
+msgid "Merge Into %s"
 msgstr ""
 
-#: lib/transport.tcl:82
-#, tcl-format
-msgid "Pushing %s %s to %s"
+#: lib/merge.tcl:183
+msgid "Revision To Merge"
 msgstr ""
 
-#: lib/transport.tcl:100
-msgid "Push Branches"
+#: lib/merge.tcl:218
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
 msgstr ""
 
-#: lib/transport.tcl:114
-msgid "Source Branches"
+#: lib/merge.tcl:228
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
 msgstr ""
 
-#: lib/transport.tcl:131
-msgid "Destination Repository"
+#: lib/merge.tcl:234
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with resetting the current changes?"
 msgstr ""
 
-#: lib/transport.tcl:169
-msgid "Transfer Options"
+#: lib/merge.tcl:246
+msgid "Aborting"
 msgstr ""
 
-#: lib/transport.tcl:171
-msgid "Force overwrite existing branch (may discard changes)"
+#: lib/merge.tcl:247
+msgid "files reset"
 msgstr ""
 
-#: lib/transport.tcl:175
-msgid "Use thin pack (for slow network connections)"
+#: lib/merge.tcl:277
+msgid "Abort failed."
 msgstr ""
 
-#: lib/transport.tcl:179
-msgid "Include tags"
+#: lib/merge.tcl:279
+msgid "Abort completed.  Ready."
 msgstr ""
-- 
gitgitgadget

