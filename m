From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 3/9] stash: introduce is_stash_ref and assert_stash_ref functions.
Date: Tue, 10 Aug 2010 10:04:42 +1000
Message-ID: <1281398688-21008-4-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 02:06:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OicMM-0001TU-7C
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 02:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354Ab0HJAGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 20:06:19 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60333 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316Ab0HJAGS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 20:06:18 -0400
Received: by pwj7 with SMTP id 7so1536919pwj.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 17:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AzMASjr1ORgpxyicCG3ALWRiQlQAjhA1+IDmqlL0RlM=;
        b=htd2X92s+X8xTjGQsjdHE2tX85KSx9UCcC1vm5psTToto4SxnEmwwutCpTYfv7N820
         GhGjG4L2vIgGgEcQjkC9nbZbQY7xLwBJOjCGFLDfOQRW6kl9xQiw3fpo4V2k4OKzZgx8
         oH0fP/WSgZ0f4ZoCxTC+Nx717rH0R2Oj0StC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jP3i4qz23MYm0YDsq/wtFvblDhqVj+oPuJRhTBb3SEVZzbUD21GUvfIhh61vA5dgV7
         kbk+ERDDfZruQMZ9Y5rh1S3Avc6ZwKSu8bKHqtxgumixDB3nUsDUv8uEhhTy90KdRQ/f
         WeG1Q5MaT1K/VirsxUPI2FpIvZTENcYzrRisc=
Received: by 10.142.170.9 with SMTP id s9mr14377693wfe.141.1281398778379;
        Mon, 09 Aug 2010 17:06:18 -0700 (PDT)
Received: from localhost.localdomain ([120.16.203.103])
        by mx.google.com with ESMTPS id x18sm7096974wfd.8.2010.08.09.17.06.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 17:06:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.53.gddb82
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153061>

Introduce a function, is_stash_ref, which checks whether an
argument is valid stash reference (e.g. is of the form ['refs/']stash['@{'something'}])

Introduce a function, assert_stash_ref, which can be used to ensure
that certain commands are only called with stash references as
arguments.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index dbb7944..41a9359 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -223,6 +223,15 @@ show_stash () {
 	git diff $flags $b_commit $w_commit
 }
 
+is_stash_ref() {
+	revs="$(git rev-parse --revs-only --symbolic --verify --default ${ref_stash} "$@")" &&
+	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${revs%@*}")"
+}
+
+assert_stash_ref() {
+	is_stash_ref "$@" || die "$* is not a stash reference"
+}
+
 #
 # if this function returns, then:
 #   s is set to the stash commit
-- 
1.6.5.rc3.8.g8ba5e
