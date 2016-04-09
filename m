From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 00/16] port branch.c to use ref-filter's printing options
Date: Sun, 10 Apr 2016 00:14:59 +0530
Message-ID: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 20:45:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoxsr-0003PV-Q3
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 20:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758415AbcDISpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 14:45:20 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35658 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278AbcDISpT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 14:45:19 -0400
Received: by mail-io0-f196.google.com with SMTP id q128so20552312iof.2
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZfpJCjTuoWOCwxoIbb9DMjM5d9+sDqpaSupz4mk8/ks=;
        b=Lecb2wzY1LEvpSqT6866RbqGuicdYQecp5xnZ+2wvo7Cq8zY2l6PmFekP1+GXsLRv+
         s1GTVPaA+93r3jOY+fVq2taQCjdRZC/8D158/WnLaXQYCDsVHc5jVZfbdilUQHIJQ+om
         p5sAqrkjMx9O6uc2yN9G4XjIyhIAa7jyJUSgP5h4c61lPit8NTEIUuy4EAzhAggHV4A5
         TgF4GOAO0KwbsfJPANutfQLn0deM/Dfyy2A40nqRg87Gpl9sMpGRsVIsuL5C7fSW9kBP
         Fu3suzGkmOIJjITF2IuEJbcFgXzYYBTG6KG0yuEkWTHYqjacjPzZoKkvmIvKhmJtgtKH
         lDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZfpJCjTuoWOCwxoIbb9DMjM5d9+sDqpaSupz4mk8/ks=;
        b=Q+S8NIwOIPI6g99WKSlpL0NQ4eaD7kDWcIFCEHv+3EUE6OCytOcb5dpMPnPjnDt3PG
         7nvdRMJwlH3iceWUytkku2tMVkiXN0sTYKJ22/mVPCkc1elGMWHI/54SnGOe+sqOwPQB
         52r6pUZwjgCL3/6rfUJ/aKL+eg6sO0DIjRJdc/ySx7tpi0gS5ufVZeI4+Fz/1MELNII/
         3djbuEF0UnrbW9+E43L/xv1QKl3y/u4N0inmcJUViVVHt2H/6jJPy6Fw5bBBTsvZ/ZEg
         dy9UVIC3EwFccQHNKC0GI/IUxAN8bS4Kyc4UmtjjQLuT1hqZyJX5AfMc9axAe6W+mD5C
         nVag==
X-Gm-Message-State: AD7BkJLr6BAeeHM4bC9qtsYLzqFdV52NPKnRB+Y2Spsei4CqQrPyPxQ1vhYFAVya4A/CxA==
X-Received: by 10.107.136.102 with SMTP id k99mr16815477iod.88.1460227518172;
        Sat, 09 Apr 2016 11:45:18 -0700 (PDT)
Received: from localhost.localdomain ([106.51.241.12])
        by smtp.gmail.com with ESMTPSA id be7sm7132351igb.1.2016.04.09.11.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 11:45:17 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291106>

This is part of unification of the commands 'git tag -l, git branch -l
and git for-each-ref'. This ports over branch.c to use ref-filter's
printing options.

Initially posted here: $(gmane/279226). It was decided that this series
would follow up after refactoring ref-filter parsing mechanism, which
is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).

v1 can be found here: $(gmane/288342)
v2 can be found here: $(gmane/288863)
v3 can be found here: $(gmane/290299)

Changes in this version:
1. Rebased on top of Erics changes, this was breaking tests. Thanks
to Dennis Kaarsemaker and Ramsay Jones for reporting this in.
2. Show local branch symrefs if available, changed this in the format
for `git branch -l`.

Thanks to Junio, Matthieu, Dennis and Ramsay for all suggestions on the
previous iteration.

Karthik Nayak (16):
  ref-filter: implement %(if), %(then), and %(else) atoms
  ref-filter: include reference to 'used_atom' within 'atom_value'
  ref-filter: implement %(if:equals=<string>) and
    %(if:notequals=<string>)
  ref-filter: modify "%(objectname:short)" to take length
  ref-filter: move get_head_description() from branch.c
  ref-filter: introduce format_ref_array_item()
  ref-filter: make %(upstream:track) prints "[gone]" for invalid
    upstreams
  ref-filter: add support for %(upstream:track,nobracket)
  ref-filter: make "%(symref)" atom work with the ':short' modifier
  ref-filter: introduce symref_atom_parser()
  ref-filter: introduce refname_atom_parser()
  ref-filter: add support for %(refname:dir) and %(refname:base)
  ref-filter: allow porcelain to translate messages in the output
  branch, tag: use porcelain output
  branch: use ref-filter printing APIs
  branch: implement '--format' option

 Documentation/git-branch.txt       |   7 +-
 Documentation/git-for-each-ref.txt |  63 +++++-
 builtin/branch.c                   | 268 ++++++----------------
 builtin/tag.c                      |   2 +
 ref-filter.c                       | 447 +++++++++++++++++++++++++++++++------
 ref-filter.h                       |   7 +
 t/t3203-branch-output.sh           |  12 +
 t/t6040-tracking-info.sh           |   2 +-
 t/t6300-for-each-ref.sh            |  40 +++-
 t/t6302-for-each-ref-filter.sh     |  94 ++++++++
 10 files changed, 664 insertions(+), 278 deletions(-)

Interdiff:

diff --git a/builtin/branch.c b/builtin/branch.c
index fb05b39..665ee57 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -320,7 +320,8 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 			    branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
 			    remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
 	} else {
-		strbuf_addf(&local, "%%(refname:strip=2)%s", branch_get_color(BRANCH_COLOR_RESET));
+		strbuf_addf(&local, "%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
+			    branch_get_color(BRANCH_COLOR_RESET));
 		strbuf_addf(&remote, "%s%s%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
 			    branch_get_color(BRANCH_COLOR_REMOTE), remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
 	}
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 841f0c1..206ad67 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -349,6 +349,8 @@ test_expect_success 'check %(if)...%(then)...%(end) atoms' '
 	A U Thor: refs/heads/side
 	A U Thor: refs/odd/spot
 	
+	
+	
 	A U Thor: refs/tags/foo1.10
 	A U Thor: refs/tags/foo1.3
 	A U Thor: refs/tags/foo1.6
@@ -367,7 +369,9 @@ test_expect_success 'check %(if)...%(then)...%(else)...%(end) atoms' '
 	A U Thor: refs/heads/master
 	A U Thor: refs/heads/side
 	A U Thor: refs/odd/spot
-	No author: refs/tags/double-tag
+	No author: refs/tags/annotated-tag
+	No author: refs/tags/doubly-annotated-tag
+	No author: refs/tags/doubly-signed-tag
 	A U Thor: refs/tags/foo1.10
 	A U Thor: refs/tags/foo1.3
 	A U Thor: refs/tags/foo1.6
@@ -385,7 +389,9 @@ test_expect_success 'ignore spaces in %(if) atom usage' '
 	master: Head ref
 	side: Not Head ref
 	odd/spot: Not Head ref
-	double-tag: Not Head ref
+	annotated-tag: Not Head ref
+	doubly-annotated-tag: Not Head ref
+	doubly-signed-tag: Not Head ref
 	foo1.10: Not Head ref
 	foo1.3: Not Head ref
 	foo1.6: Not Head ref


-- 
2.8.0
