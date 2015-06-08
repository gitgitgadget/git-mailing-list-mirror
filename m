From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2] git-rebase--interactive.sh: add config option for custom instruction format
Date: Mon,  8 Jun 2015 17:00:02 -0400
Message-ID: <1433797202-97425-2-git-send-email-rappazzo@gmail.com>
References: <1433797202-97425-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 08 23:00:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z249e-0007jo-9Q
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 23:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbbFHVAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 17:00:15 -0400
Received: from mail-vn0-f44.google.com ([209.85.216.44]:34943 "EHLO
	mail-vn0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbbFHVAL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 17:00:11 -0400
Received: by vnbf129 with SMTP id f129so9434505vnb.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 14:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P8ZkCqDoxUeZkxmskS1il1JjIr5HLrXflnnXQbU//3M=;
        b=xCFnhOoza5XktQ4WfHj4/jW8c/riflrCFE03kRcXfLUgQRaH5RW8YCr2Iwn8+8YXtq
         J9nnntHqAF6kXFeYVnW+05AlYGMVYVx9Ny7AGaP/DdWdDXm/7jH6eMTsDUyeEAogWZFZ
         T0wk0SbftrlCUt5xHpr1k69aWQe+PyrPeP1aYKmIwUNjranToHZwrP5yiTN6Yj5eUGr2
         QvCwcOUgC3xCcfsI0sWTw7K53m5bUJ5LNZS6FRwiDru7PmLtXaV5vm9r7Q3b7eqw4qNS
         7iGL2PTtRtgQmT+i2ZXmofj7DOmxEiwpegsJRzEvOOgT+KIxo/XNPCnqQa8/Lt9BR4x1
         OJAw==
X-Received: by 10.52.69.178 with SMTP id f18mr27016167vdu.83.1433797211136;
        Mon, 08 Jun 2015 14:00:11 -0700 (PDT)
Received: from MRappazzo-2.local.info (ool-4572900c.dyn.optonline.net. [69.114.144.12])
        by mx.google.com with ESMTPSA id st8sm4320277vdb.4.2015.06.08.14.00.09
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jun 2015 14:00:10 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433797202-97425-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271132>

A config option 'rebase.instructionFormat' can override the
default 'oneline' format of the rebase instruction list.

Since the list is parsed using the left, right or boundary mark plus
the sha1, they are prepended to the instruction format.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 git-rebase--interactive.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index dc3133f..b92375e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -977,7 +977,9 @@ else
 	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
-git rev-list $merges_option --pretty=oneline --reverse --left-right --topo-order \
+format=$(git config --get rebase.instructionFormat)
+# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
+git rev-list $merges_option --format="%m%H ${format-%s}" --reverse --left-right --topo-order \
 	$revisions ${restrict_revision+^$restrict_revision} | \
 	sed -n "s/^>//p" |
 while read -r sha1 rest
-- 
2.4.2
