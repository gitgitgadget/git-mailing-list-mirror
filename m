From: Peng Tao <bergwolf@gmail.com>
Subject: [PATCH] fix git format-patch --cc=<email> format
Date: Sat, 28 Feb 2009 20:42:24 +0800
Message-ID: <1235824944-4967-1-git-send-email-bergwolf@gmail.com>
Cc: gitster@pobox.com, Peng Tao <bergwolf@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 13:44:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdOY9-0008BJ-ND
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 13:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbZB1Mmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 07:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbZB1Mmp
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 07:42:45 -0500
Received: from ti-out-0910.google.com ([209.85.142.190]:9593 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZB1Mmo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 07:42:44 -0500
Received: by ti-out-0910.google.com with SMTP id d10so2071411tib.23
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 04:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=kkQmuEXPbfWY/6EBIMcO+pnf6RTyQVjtThE1yDTh3+8=;
        b=ABO8K4CUwC3wixwDcB3f0r5wpaXEc8UkXy/vFJPEytf88neQjMYdJJx6hkVsM4l13s
         wEvBYzuViSsd6EB5jzAlclnyuEsqBwEsJ4+PShCGcO8eVqTK+OnKYfpSHBqZbw0goCzG
         nR5dDpt0CrQpxaDtQquSn8V6mTvg/en+eydRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=cvO9BhaY+IXWQELQ/LonmoaEeockQEXm0oWRtS0UoeMtc7oFq2q9L+Z3IJh2mahADP
         fV54ZWFYRZDjClXGZJ4gSfGrBW1yWRx8ueHRZf/8S58VLOkDKrZCxDBxzrNb/eGUKme0
         3JCaPPo7peiFt7tj/NCVbCVRCYLLFmOu5S/n8=
Received: by 10.110.90.9 with SMTP id n9mr5481220tib.6.1235824961663;
        Sat, 28 Feb 2009 04:42:41 -0800 (PST)
Received: from localhost.localdomain ([118.229.143.3])
        by mx.google.com with ESMTPS id b7sm4904155tic.35.2009.02.28.04.42.39
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Feb 2009 04:42:40 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111765>

If there are multiple --cc=<email> arguments, git format-patch will generate
patches with cc lines like:
  Cc: <email>,
      <email>
which git send-email fails to parse.
git send-email only accept formats like:
  Cc: <email>
  Cc: <email>
So change git format-patch to generate patches in a proper format.

Signed-off-by: Peng Tao <bergwolf@gmail.com>
---
 builtin-log.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 60f8dd8..22bb6b6 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -907,13 +907,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (extra_cc_nr)
-		strbuf_addstr(&buf, "Cc: ");
 	for (i = 0; i < extra_cc_nr; i++) {
-		if (i)
-			strbuf_addstr(&buf, "    ");
+		strbuf_addstr(&buf, "Cc: ");
 		strbuf_addstr(&buf, extra_cc[i]);
-		if (i + 1 < extra_cc_nr)
-			strbuf_addch(&buf, ',');
 		strbuf_addch(&buf, '\n');
 	}
 
