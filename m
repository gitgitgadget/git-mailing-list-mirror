From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 05/12] grep/icase: avoid kwsset on literal non-ascii strings
Date: Sun, 14 Feb 2016 18:49:49 +0700
Message-ID: <1455450596-11904-6-git-send-email-pclouds@gmail.com>
References: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
 <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 12:51:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvDY-0001OQ-CM
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 12:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbcBNLvv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 06:51:51 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35705 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbcBNLvi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 06:51:38 -0500
Received: by mail-pa0-f67.google.com with SMTP id fl4so5964608pad.2
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 03:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zoiOnIUXDfLBlKMTE19BAzNNaObCNHCaPCxPocV8E5s=;
        b=GpP++IDEJ9BqaCetUizxji3+wxvPYebEg1lUWAIKdCYvMaaZVlfNQOhCyyegK0RR20
         G+9k7ZMNyxpoGoAgZ1O9kR7Uo631GlML4YXTQfjZoA0LRcOpRr1JgW+y5bPgux+J+uM4
         FnZ+wGJ7BhyxviAtjihDYgmWtqKO8gaczuoP+ym13PBWsAWOS1/OoVtrftTtVGV+LxSc
         EbwoMMEbKjZR03UFOxQ7rWPL9+1HP1vpqDfdQ3gtzZqK4eKOTtguwOJZg+WooaK/EHpd
         H3LOIrg/S3of31L45YVd8Ygf8IiHeM1Hko6KBNHJES00YFAdLJvc9U/pAb/NbrAbd8YC
         ErxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=zoiOnIUXDfLBlKMTE19BAzNNaObCNHCaPCxPocV8E5s=;
        b=g3KudCmgzQ/f4d6RgFoRh6fS8+em3P0hxemqiDppBqfsIZm29ZiBBHtCiKJC24F6Y2
         PN+TbSMiaiT5tjXRxy6d6YPhfXEhQ5ljG3WvF6toLSRULsu4DOnjFwCKD6Ofr/RXQrVy
         iTzPIUa9YlQFHnHazStuEq8hsdhJQmFP9Eej4I7EZaNDmzZkCpHU8BP4r8sqAbC/pEfs
         WPpcPztui4CzF1xWhbPnJwIZf3KrIiYFJefDelbKVqlp8mq5pB82dV7n/jwEU3kLcI/h
         MowK3BICZw0+DWQeewt5iT8HYoVMACMJbPr2AmuO9BQ/Tr3b6MDtdXOvSkoSip+HX8Qy
         59vg==
X-Gm-Message-State: AG10YOSQZquuWzBsy14NOfDESZwCDSNHk7g5ytP0b+X34OVSiTBJ6oZzuNyies5gU3dE1w==
X-Received: by 10.66.124.131 with SMTP id mi3mr15579450pab.7.1455450698341;
        Sun, 14 Feb 2016 03:51:38 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 67sm29654481pfi.2.2016.02.14.03.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2016 03:51:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Feb 2016 18:51:57 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286142>

When we detect the pattern is just a literal string, we avoid heavy
regex engine and use fast substring search implemented in kwsset.c.
But kws uses git-ctype which is locale-independent so it does not know
how to fold case properly outside ascii range. Let regcomp or pcre
take care of this case instead. Slower, but accurate.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c                                   |  7 ++++++-
 t/t7812-grep-icase-non-ascii.sh (new +x) | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100755 t/t7812-grep-icase-non-ascii.sh

diff --git a/grep.c b/grep.c
index 609f218..f192727 100644
--- a/grep.c
+++ b/grep.c
@@ -4,6 +4,7 @@
 #include "xdiff-interface.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "commit.h"
=20
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs);
@@ -398,14 +399,18 @@ static int is_fixed(const char *s, size_t len)
=20
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
+	int icase, ascii_only;
 	int err;
=20
 	p->word_regexp =3D opt->word_regexp;
 	p->ignore_case =3D opt->ignore_case;
+	icase	       =3D opt->regflags & REG_ICASE || p->ignore_case;
+	ascii_only     =3D !has_non_ascii(p->pattern);
=20
 	if (opt->fixed) {
 		p->fixed =3D 1;
-	} else if (is_fixed(p->pattern, p->patternlen))
+	} else if ((!icase || ascii_only) &&
+		   is_fixed(p->pattern, p->patternlen))
 		p->fixed =3D 1;
 	else
 		p->fixed =3D 0;
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
new file mode 100755
index 0000000..6eff490
--- /dev/null
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description=3D'grep icase on non-English locales'
+
+. ./lib-gettext.sh
+
+test_expect_success GETTEXT_LOCALE 'setup' '
+	printf "TILRAUN: Hall=C3=B3 Heimur!" >file &&
+	git add file &&
+	LC_ALL=3D"$is_IS_locale" &&
+	export LC_ALL
+'
+
+test_have_prereq GETTEXT_LOCALE &&
+test-regex "HALL=C3=93" "Hall=C3=B3" ICASE &&
+test_set_prereq REGEX_LOCALE
+
+test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
+	git grep -i "TILRAUN: Hall=C3=B3 Heimur!" &&
+	git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
+'
+
+test_done
--=20
2.7.0.377.g4cd97dd
