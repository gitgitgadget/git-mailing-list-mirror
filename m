From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [tig PATCH] Predefined external command: git commit
Date: Sat, 21 Feb 2009 01:28:41 +0100
Message-ID: <1235176121-17483-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Feb 21 01:37:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LafsB-0003ez-LZ
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 01:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbZBUAgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 19:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZBUAgK
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 19:36:10 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:39085 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbZBUAgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 19:36:09 -0500
Received: by bwz5 with SMTP id 5so3155178bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 16:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+zqUJpoPLW5HIjndjnHFtkAfn8jzNzCgGnkBolun3d8=;
        b=TJH7s8k7NQMBpXBU16rPv3CMC/Bqmv7QWh17z09GBm7Yp4Mcy6SPb7+DVjjmXjvt1q
         gLaMrknrp6MEELYjG2oRnBh7Ut4Qa0q+4x2nlYgpKhSh5VksWHGDA0tvQAzaB9uhncnH
         XoJbiAn+YMsF31RDLg7wHdQ7e0pNst1tHmxjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qiTUfmZRxC7x7jzNf8KwP3Et7Z98fpf9oWcgPAM2X0fffSlGAcW2p2wDRp+k8Ue9QH
         r7Oh8OBeniUvbd9NNAdJdeM2PH4pJLKSwFjfx0uIXkKCHbtTcK2zKzSD4jU60+dejgtU
         C2CwQK90GPDF/x3hDtAjgK3uPfWxZseoW3zGc=
Received: by 10.103.238.4 with SMTP id p4mr2125457mur.68.1235176125396;
        Fri, 20 Feb 2009 16:28:45 -0800 (PST)
Received: from localhost (host-78-13-59-64.cust-adsl.tiscali.it [78.13.59.64])
        by mx.google.com with ESMTPS id e10sm4668877muf.11.2009.02.20.16.28.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 16:28:44 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.258.g1d592.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110908>

Status view allows management of the stage area, and the user is likely
to issue a commit as soon as (s)he's satisfied with the result. Mapping
'git commit' to the 'C' key in status view makes this straightforward
and allows a very streamlined workflow from within git.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

It might make sense to map 'A' to 'git commit --amend', too, even though
that key is currently taken by author display toggle.

 manual.txt |    9 +++++----
 tig.c      |    2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/manual.txt b/manual.txt
index 74fa3f8..104989f 100644
--- a/manual.txt
+++ b/manual.txt
@@ -449,11 +449,12 @@ a script or program. They are bound to keys and use information from the
 current browsing state, such as the current commit ID. Tig comes with
 the following built-in external commands:
 
-`-------`--------------------------------------------------------------------
-Key	Action
+`-------`-------`------------------------------------------------------------
+Keymap	Key	Action
 -----------------------------------------------------------------------------
-C	git cherry-pick %(commit)
-G	git gc
+MAIN	C	git cherry-pick %(commit)
+STATUS	C	git commit
+GENERIC	G	git gc
 -----------------------------------------------------------------------------
 
 [[refspec]]
diff --git a/tig.c b/tig.c
index 9349f69..c22f271 100644
--- a/tig.c
+++ b/tig.c
@@ -1365,6 +1365,7 @@ static void
 add_builtin_run_requests(void)
 {
 	const char *cherry_pick[] = { "git", "cherry-pick", "%(commit)", NULL };
+	const char *commit[] = { "git", "commit", NULL };
 	const char *gc[] = { "git", "gc", NULL };
 	struct {
 		enum keymap keymap;
@@ -1373,6 +1374,7 @@ add_builtin_run_requests(void)
 		const char **argv;
 	} reqs[] = {
 		{ KEYMAP_MAIN,	  'C', ARRAY_SIZE(cherry_pick) - 1, cherry_pick },
+		{ KEYMAP_STATUS,  'C', ARRAY_SIZE(commit) - 1, commit },
 		{ KEYMAP_GENERIC, 'G', ARRAY_SIZE(gc) - 1, gc },
 	};
 	int i;
-- 
1.6.2.rc1.258.g1d592.dirty
