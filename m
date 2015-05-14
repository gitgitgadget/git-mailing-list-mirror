From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH 1/5] command-list.txt: prepare with [commands] header
Date: Thu, 14 May 2015 14:59:06 +0200
Message-ID: <1431608351-9413-2-git-send-email-sebastien.guimmara@gmail.com>
References: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 14 15:00:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsskW-0007Na-PT
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 15:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbbENNAD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2015 09:00:03 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36548 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933175AbbENNAA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 09:00:00 -0400
Received: by wizk4 with SMTP id k4so240091725wiz.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 05:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4zN05IwhOz9wlVJb8W9ubhPKdIqUPZlzFCOLoM+tuz0=;
        b=D3ErYSPq9plvFpbOeOIIs4eU9thF/rmDl9tA4x1gSkitsvv5yjjs9btxUBmEt/KsQD
         vQphyhajNyiWKjuxlnGSiFRL76ngRAbO2h59wRk+corwkzVI2S1e094V+pkF8d+77lde
         fwfC8Q/qw+XW3NtZpTR1y4dhgUzcmdVMCIPPonMVEDQJKYWhbE5hVym0fp7qYI2krGEY
         m3na0bn512Zdm4tK6kB5rI6xyhaQqReGoQu4e+BV1iyvCQ+bR8TsG5afYoBFsFuuSAIX
         6Ce7oGj8meD1YpjO4rabPKbPaaZHJdX0rOLxUMuBm+NP7QyvyRafFycKiN15khlvWkaG
         W6TA==
X-Received: by 10.194.63.80 with SMTP id e16mr8138557wjs.56.1431608398818;
        Thu, 14 May 2015 05:59:58 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id pj5sm32671676wjb.40.2015.05.14.05.59.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 05:59:58 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269032>

Add a [commands] header before the actual command list, then make the
following files ignore this header in their parsing:

	* cmd-list.perl
	* Makefile (check-docks target)

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 Documentation/cmd-list.perl | 4 ++++
 Makefile                    | 3 ++-
 command-list.txt            | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

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
diff --git a/Makefile b/Makefile
index 5f3987f..7c57369 100644
--- a/Makefile
+++ b/Makefile
@@ -2447,7 +2447,7 @@ check-docs::
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
 		echo "no doc: $$v"; \
-		sed -e '/^#/d' command-list.txt | \
+		sed -e '1,/^\[commands\]/d' -e '/^#/d' <command-list.txt | \
 		grep -q "^$$v[ 	]" || \
 		case "$$v" in \
 		git) ;; \
@@ -2456,6 +2456,7 @@ check-docs::
 	done; \
 	( \
 		sed -e '/^#/d' \
+		    -e '1,/^\[commands\]/d' \
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' command-list.txt; \
 		$(MAKE) -C Documentation print-man1 | \
diff --git a/command-list.txt b/command-list.txt
index f1eae08..40fbe2f 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,5 +1,6 @@
 # List of known git commands.
 # command name				category [deprecated] [common]
+[commands]
 git-add                                 mainporcelain common
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
--=20
2.4.0
