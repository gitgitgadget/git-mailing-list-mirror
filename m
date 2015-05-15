From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v7 1/5] command-list.txt: prepare with [commands] header
Date: Fri, 15 May 2015 20:35:00 +0200
Message-ID: <1431714904-16599-2-git-send-email-sebastien.guimmara@gmail.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri May 15 20:35:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtKSG-0002rk-Nz
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 20:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933865AbbEOSfV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 14:35:21 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35772 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933738AbbEOSfS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 14:35:18 -0400
Received: by wicmx19 with SMTP id mx19so73888204wic.0
        for <git@vger.kernel.org>; Fri, 15 May 2015 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZEfDrAj3rysrGHXfuFMv18xMBBbcptTyiXf0AUov1Fo=;
        b=S85Cci/rIvAwZRBVPLi322XMenfJ1vr7lDv1Z7Mhu9xdLf65jD770WvRJKGo1jB+q+
         HzT+6egCOE/J7WQLYshpheEF5FnVoXb4ipDfPx0I6k1eUnoODn/hHwuOlD4DiVgxN8o6
         ghGIQhqRpNlSEZQ7FlQ0MOWwKyYXWQNr7B55faGFgZznMQv+9jwf/lWCfDN9nkUzLCSc
         1g78mYSniRzxM/wfcx466fGnnf4/tMm5TAoF+1ut+7o31EOtHVNM3hlSq1/fOgCzEZqV
         RUF/evV5Kn9B0oC3JzzdTxK81Ehc4sJ/c4KXp8JxATfeo55EDbymMKOUEraW0TZGjW2u
         7S7Q==
X-Received: by 10.180.19.198 with SMTP id h6mr6841007wie.60.1431714916339;
        Fri, 15 May 2015 11:35:16 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id j12sm3674972wjn.48.2015.05.15.11.35.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 May 2015 11:35:15 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269168>

Add a [commands] header before the actual command list, then make the
following files ignore this header in their parsing:

	* cmd-list.perl
	* Makefile (check-docks target)

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 Documentation/cmd-list.perl         | 4 ++++
 Documentation/howto/new-command.txt | 4 +++-
 Makefile                            | 3 ++-
 command-list.txt                    | 1 +
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 04f9977..06a5fd6 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -38,6 +38,10 @@ sub format_one {
 	}
 }
=20
+while (<>) {
+	last if /^\[commands\]/;
+}
+
 my %cmds =3D ();
 for (sort <>) {
 	next if /^#/;
diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/=
new-command.txt
index d7de5a3..6d772bd 100644
--- a/Documentation/howto/new-command.txt
+++ b/Documentation/howto/new-command.txt
@@ -95,7 +95,9 @@ your language, document it in the INSTALL file.
 that categorizes commands by type, so they can be listed in appropriat=
e
 subsections in the documentation's summary command list.  Add an entry
 for yours.  To understand the categories, look at git-commands.txt
-in the main directory.
+in the main directory.  If the new command is part of the typical Git
+workflow and you believe it common enough to be mentioned in 'git help=
',
+map this command to a common group in the column [common].
=20
 7. Give the maintainer one paragraph to include in the RelNotes file
 to describe the new feature; a good place to do so is in the cover
diff --git a/Makefile b/Makefile
index 25a453b..0cb2045 100644
--- a/Makefile
+++ b/Makefile
@@ -2454,7 +2454,7 @@ check-docs::
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
 		echo "no doc: $$v"; \
-		sed -e '/^#/d' command-list.txt | \
+		sed -e '1,/^\[commands\]/d' -e '/^#/d' <command-list.txt | \
 		grep -q "^$$v[ 	]" || \
 		case "$$v" in \
 		git) ;; \
@@ -2463,6 +2463,7 @@ check-docs::
 	done; \
 	( \
 		sed -e '/^#/d' \
+		    -e '1,/^\[commands\]/d' \
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' command-list.txt; \
 		$(MAKE) -C Documentation print-man1 | \
diff --git a/command-list.txt b/command-list.txt
index 54d8d21..caed872 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,5 +1,6 @@
 # List of known git commands.
 # command name                          category [deprecated] [common]
+[commands]
 git-add                                 mainporcelain common
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
--=20
2.4.0
