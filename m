From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH] git-branch: display "was sha1" on branch deletion rather than 
	just "sha1"
Date: Sat, 21 Mar 2009 19:09:17 -0500
Message-ID: <ee63ef30903211709s24f8294dq9ea52bcae72b755a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 01:11:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlBI2-00024i-BZ
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 01:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbZCVAJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 20:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbZCVAJU
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 20:09:20 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:38947 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZCVAJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 20:09:20 -0400
Received: by gxk4 with SMTP id 4so4375882gxk.13
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 17:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=H0dCbl/0Kpo4NOHnzB+ldXRc3cN/bUFQIYXTRi4bUE4=;
        b=IPEBrIS3SdXvabfDsGcyr2YkC7/toCrPW8WuxjshgVG+jINY49O2boJPURdTzOpXT8
         VFMV9AuntJoWvWjrjzyUbskcWSCp0RkimTFLrSS5WV1ggEXtrXYazKM9kU/FGRg7SOHu
         ThPRqA2xzeevgsP0NuAe0Ziy5QaTX/QjRjKps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=qRg2tNhzQfxEDrnb0Sbm+Jtwj8tehfqZa1NE6+FliQIOFq81IgscA3GMx7mv6L4Bjy
         srZzCWNTpi81ubMxNuUsWug2mFNghGrfDuqJsVrUqoJkgCHVBJCRBJuvgv6JC450lIPF
         v/o0sg3K0vXRK1lpNdcvi4Qap3JgvPlnkkZCw=
Received: by 10.150.136.10 with SMTP id j10mr8316254ybd.29.1237680557418; Sat, 
	21 Mar 2009 17:09:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114105>

Make it more pleasant to read about a branch deletion by adding "was".
Jeff King suggested this, and I ignored it.  He was right.

Update t3200 test again to match the change in output.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin-branch.c  |    2 +-
 t/t3200-branch.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 14d4b91..07a440e 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -171,7 +171,7 @@ static int delete_branches(int argc, const char
**argv, int force, int kinds)
 			ret = 1;
 		} else {
 			struct strbuf buf = STRBUF_INIT;
-			printf("Deleted %sbranch %s (%s).\n", remote,
+			printf("Deleted %sbranch %s (was %s).\n", remote,
 			       bname.buf,
 			       find_unique_abbrev(sha1, DEFAULT_ABBREV));
 			strbuf_addf(&buf, "branch.%s", bname.buf);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 61a2010..1b1e9ec 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -195,7 +195,7 @@ test_expect_success 'test deleting branch deletes
branch config' \
 test_expect_success 'test deleting branch without config' \
     'git branch my7 s &&
      sha1=$(git rev-parse my7 | cut -c 1-7) &&
-     test "$(git branch -d my7 2>&1)" = "Deleted branch my7 ($sha1)."'
+     test "$(git branch -d my7 2>&1)" = "Deleted branch my7 (was $sha1)."'

 test_expect_success 'test --track without .fetch entries' \
     'git branch --track my8 &&
-- 
1.6.2.12.g83676
