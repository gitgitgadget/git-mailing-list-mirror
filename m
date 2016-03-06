From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 08/15] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date: Sun,  6 Mar 2016 17:34:55 +0530
Message-ID: <1457265902-7949-9-git-send-email-Karthik.188@gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:05:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXRH-00020g-Ky
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbcCFMFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:05:33 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35548 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbcCFMF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:05:26 -0500
Received: by mail-pa0-f43.google.com with SMTP id bj10so62310025pad.2
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qbNTPSK9RWGAIGVdgCFA2LxORDhfmpIUSihBSOaeqk0=;
        b=bIRqtGUbEQXdUTTkxr+sD+YNJMlkX8juDtBYjQEna4NNy3wEoZW2JFCktu+kAZSYjQ
         KCoipYHdsH0Teei/N3EjSVGiKt7wODualHkWQ8XTMkR0ki6ZiUNdg9mGDKJG1kXsD7/a
         sWyClO1xq+ha14xFV5QGUYSs4AXOjXnEm0aLdBbHQA3MmYVkZGvcjoPjqfPZuX2pne/G
         7PUcaMWMPL6eVagahOHDT2APxA3FHaoIqcCP9iXP9m+LnLQh8cXJxLlbHAXEpAAK1PKD
         kx47txIw4zs8F6jRTU45sl8CBrlJHSddMa/w16/108qyIN5lE+wQVYKFpditq7KrAbFI
         2ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qbNTPSK9RWGAIGVdgCFA2LxORDhfmpIUSihBSOaeqk0=;
        b=NAwQSBmEJp0uX0OYe9C5SSR9XBqXRtZbBUm+CMNGct+Ay188QdazP8e0uTBalCSPRA
         CzOU3n3EWrxyp43+zwh+Pa1du4wzgeT3uTK8xNAd6J88wQUC8gH2HvveI20SER5O8KDh
         5DOuRTJudxn+8XyXndXTSCQSlusue/FFKpLTDldJFrD/rc5l8Kam8XUjvk+XkP4TJtZw
         YW1gUijXxZ3FPGfTuR9T9dhQLkhQ1HhSF09o3p8oqK/fFeXTQ4VhJJ6Ta4DnD3RuDAs8
         0VpF6loUML+WfmPhY5EnOqsYQ2u3DSRGU/CyZC1aIoOWn/6FfOTYz2PVqxDrcYHHyWek
         zQTg==
X-Gm-Message-State: AD7BkJJvhO/3X1DjldeO6cXbgn2i3H5G31+5gkPVFqiAuWl1XcsXCy0J6as9OZLlK6lRPA==
X-Received: by 10.66.220.162 with SMTP id px2mr26033908pac.15.1457265925547;
        Sun, 06 Mar 2016 04:05:25 -0800 (PST)
Received: from localhost.localdomain ([106.51.240.143])
        by smtp.gmail.com with ESMTPSA id n66sm17536850pfj.39.2016.03.06.04.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:05:25 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288349>

The "%(symref)" atom doesn't work when used with the ':short' modifier
because we strictly match only 'symref' for setting the 'need_symref'
indicator. Fix this by using 'starts_with()' rather than 'strcmp()'.

Add tests for %(symref) and %(symref:short) while we're here.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c            |  2 +-
 t/t6300-for-each-ref.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 0e6ab75..ab860a3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -323,7 +323,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(used_atom[at].name, "symref"))
+	if (starts_with(used_atom[at].name, "symref"))
 		need_symref = 1;
 	return at;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2c5f177..b06ea1c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -38,6 +38,7 @@ test_atom() {
 	case "$1" in
 		head) ref=refs/heads/master ;;
 		 tag) ref=refs/tags/testtag ;;
+		 sym) ref=refs/heads/sym ;;
 		   *) ref=$1 ;;
 	esac
 	printf '%s\n' "$3" >expected
@@ -565,4 +566,27 @@ test_expect_success 'Verify sort with multiple keys' '
 		refs/tags/bogo refs/tags/master > actual &&
 	test_cmp expected actual
 '
+
+test_expect_success 'Add symbolic ref for the following tests' '
+	git symbolic-ref refs/heads/sym refs/heads/master
+'
+
+cat >expected <<EOF
+refs/heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref) atom' '
+	git for-each-ref --format="%(symref)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref:short) atom' '
+	git for-each-ref --format="%(symref:short)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.7.2
