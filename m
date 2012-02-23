From: Luc Pionchon <pionchon.luc@gmail.com>
Subject: [PATCH] pretty: add '*' modifier to add LF after non-empty
Date: Thu, 23 Feb 2012 15:10:37 +0200
Message-ID: <1330002637-9347-1-git-send-email-pionchon.luc@gmail.com>
Cc: gitster@pobox.com, Luc Pionchon <pionchon.luc@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 14:11:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0YSJ-0000wE-KI
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 14:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab2BWNLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 08:11:15 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35899 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751684Ab2BWNLP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 08:11:15 -0500
Received: by lagu2 with SMTP id u2so1440840lag.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 05:11:13 -0800 (PST)
Received-SPF: pass (google.com: domain of pionchon.luc@gmail.com designates 10.152.45.134 as permitted sender) client-ip=10.152.45.134;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pionchon.luc@gmail.com designates 10.152.45.134 as permitted sender) smtp.mail=pionchon.luc@gmail.com; dkim=pass header.i=pionchon.luc@gmail.com
Received: from mr.google.com ([10.152.45.134])
        by 10.152.45.134 with SMTP id n6mr1082796lam.45.1330002673590 (num_hops = 1);
        Thu, 23 Feb 2012 05:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=sUc9BN6jR5ZqcKJ2EvUqdfh/T850B3CavL43AHKQe5w=;
        b=hJ7VF+lSiKd0Rb9wN2iiAdqM0eYybbjYl9kd0AVHx7HrVg8x93viW/1g2VwGJu1dGk
         uZjXbQ+g4elA1oMeKiSyU/1jWnc8ZBj1iS/HxSCKHKgaKgu/JUu0V0VUxAXU6DrMf+BO
         xL7rnZBIyAaMP56uc3i6k1m8Qy1xVIwTAVg4c=
Received: by 10.152.45.134 with SMTP id n6mr915239lam.45.1330002673526;
        Thu, 23 Feb 2012 05:11:13 -0800 (PST)
Received: from localhost.localdomain (a88-114-28-50.elisa-laajakaista.fi. [88.114.28.50])
        by mx.google.com with ESMTPS id uc6sm1689711lbb.3.2012.02.23.05.11.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 05:11:12 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191361>

Add the '*' modifier, similar to the '+' modifier,
to add a line-feed after a non-empty placeholder.

Allow to print a head-line which content can be empty.
For example for decorations:

    $ git log --graph --pretty=format:"%C(green)%*d %C(reset)%s"
                                                ^^^

    *  (HEAD, origin/master, origin/HEAD, master)
    |  Update draft release notes to 1.7.10
    *    Merge branch 'jc/maint-request-pull-for-tag'
    |\  
    | *  (origin/jc/maint-request-pull-for-tag)
    | |  request-pull: explicitly ask tags/$name to be pulled
    * |    Merge branch 'bl/gitweb-project-filter'
    |\ \  
    | * |  (origin/bl/gitweb-project-filter)
    | | |  gitweb: Make project search respect project_filter


Signed-off-by: Luc Pionchon <pionchon.luc@gmail.com>
---
 Documentation/pretty-formats.txt |    4 ++++
 pretty.c                         |    6 ++++++
 t/t6006-rev-list-format.sh       |   10 ++++++++++
 3 files changed, 20 insertions(+), 0 deletions(-)

Hi,

I now started to use git.  When formatting my 'log' output, I have been looking for a modifier to add a line feed after a (potentially empty) placeholder.  Git allows to add a line feed before, but not after a placeholder.  This is a small patch that adds the feature.  I hope it is useful to others.


diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 880b6f2..9114d49 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -159,6 +159,10 @@ If you add a `{plus}` (plus sign) after '%' of a placeholder, a line-feed
 is inserted immediately before the expansion if and only if the
 placeholder expands to a non-empty string.
 
+If you add a `*` (asterisk sign) after '%' of a placeholder, a line-feed
+is inserted immediately after the expansion if and only if the
+placeholder expands to a non-empty string.
+
 If you add a `-` (minus sign) after '%' of a placeholder, line-feeds that
 immediately precede the expansion are deleted if and only if the
 placeholder expands to an empty string.
diff --git a/pretty.c b/pretty.c
index 8688b8f..5ebaf88 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1132,6 +1132,7 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 		NO_MAGIC,
 		ADD_LF_BEFORE_NON_EMPTY,
 		DEL_LF_BEFORE_EMPTY,
+		ADD_LF_AFTER_NON_EMPTY,
 		ADD_SP_BEFORE_NON_EMPTY
 	} magic = NO_MAGIC;
 
@@ -1142,6 +1143,9 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case '+':
 		magic = ADD_LF_BEFORE_NON_EMPTY;
 		break;
+	case '*':
+		magic = ADD_LF_AFTER_NON_EMPTY;
+		break;
 	case ' ':
 		magic = ADD_SP_BEFORE_NON_EMPTY;
 		break;
@@ -1162,6 +1166,8 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	} else if (orig_len != sb->len) {
 		if (magic == ADD_LF_BEFORE_NON_EMPTY)
 			strbuf_insert(sb, orig_len, "\n", 1);
+		else if (magic == ADD_LF_AFTER_NON_EMPTY)
+			strbuf_addstr(sb, "\n");
 		else if (magic == ADD_SP_BEFORE_NON_EMPTY)
 			strbuf_insert(sb, orig_len, " ", 1);
 	}
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 4442790..c692061 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -208,6 +208,16 @@ test_expect_success 'add LF before non-empty (2)' '
 	grep "^$" actual
 '
 
+test_expect_success 'add LF after non-empty (1) (empty)' '
+	git show -s --pretty=format:"%*d%s%nfoo%n" HEAD^^ >actual &&
+	test $(wc -l <actual) = 2
+'
+
+test_expect_success 'add LF after non-empty (2) (non empty)' '
+	git show -s --pretty=format:"%*d%s%nfoo%n" HEAD >actual &&
+	test $(wc -l <actual) = 3
+'
+
 test_expect_success 'add SP before non-empty (1)' '
 	git show -s --pretty=format:"%s% bThanks" HEAD^^ >actual &&
 	test $(wc -w <actual) = 2
-- 
1.7.4.1
