From: "Simon A. Eugster" <simon.eu@gmail.com>
Subject: [PATCH 2/2] Documentation on git-checkout --ours/--theirs improved
Date: Mon, 15 Jun 2015 14:47:27 +0200
Message-ID: <1434372447-51230-3-git-send-email-simon.eu@gmail.com>
References: <xmqqwpzafe88.fsf@gitster.dls.corp.google.com>
 <1434372447-51230-1-git-send-email-simon.eu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Simon A. Eugster" <simon.eu@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 15 14:48:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4ToC-000228-Uw
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 14:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024AbbFOMsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2015 08:48:08 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33293 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbbFOMsG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 08:48:06 -0400
Received: by wgez8 with SMTP id z8so67969657wge.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NZLk67NDYxYlML6LydW7PgmkO+IhWcFqOCl7mzoDsDs=;
        b=RQf2aDCy0AmHtwR7naSx+18mT74Lc6m0ABkh/DevUeTEPIEsv5155DiKPjnGaHCCCQ
         IcN8EmSgt4RHmCdm2IpjZ/DrrGwCl1AZgqaf8LOEbMw3zzuO5p0UdewPcMUtCB7OOGWo
         7440GQytVxmZNEvUZNes9XFHvgEFe+w+tdgJCwOryFCnrWHhKGGsdAgN73pjtvBrT2o/
         5hjP8E/sMsC35QzTxZgS7kwPtVbmPJz3KYNZCAFFdO/NbCpfbXXb+GDft/xjMNOw32W7
         IJ4BIDAY58451W6XSBYN87e/q8dDEGZ5ekCJsYuUG/svS+/1L38bCYK6JJVotvONIkjm
         ZKlQ==
X-Received: by 10.194.82.38 with SMTP id f6mr49572074wjy.16.1434372485801;
        Mon, 15 Jun 2015 05:48:05 -0700 (PDT)
Received: from sie-matemint.localdomain ([194.9.120.21])
        by mx.google.com with ESMTPSA id js3sm18780287wjc.5.2015.06.15.05.48.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2015 05:48:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1434372447-51230-1-git-send-email-simon.eu@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271682>

---
 Documentation/git-checkout.txt | 39 ++++++++++++++++++++++++++++++++++=
+----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 5c3ef86..ec0be28 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -116,10 +116,41 @@ entries; instead, unmerged entries are ignored.
 --theirs::
 	When checking out paths from the index, check out stage #2
 	('ours', HEAD) or #3 ('theirs', MERGE_HEAD) for unmerged paths.
-+
-After a `git pull --rebase`, for example, 'ours' points to the remote
-version and 'theirs' points to the local version. See linkgit:git-merg=
e[1]
-for details about stages #2 and #3.
+	See linkgit:git-merge[1] for details about stages #2 and #3.
++
+Note that during `git rebase` and `git pull --rebase`, 'theirs' checks=
 out
+the local version, and 'ours' the remote version or the history that i=
s rebased
+against.
++
+The reason ours/theirs appear to be swapped during a rebase is that we
+define the remote history as the canonical history, on top of which ou=
r
+private commits are applied on, as opposed to normal merging where the
+local history is the canonical one.
+During merging, we assume the role of the canonical history=E2=80=99s =
keeper,
+which, in case of a rebase, is the remote history, and our private com=
mits
+look to the keeper as =E2=80=9Ctheir=E2=80=9D commits which need to be=
 integrated on top
+of =E2=80=9Cour=E2=80=9D work.
++
+Normal merging:
+------------
+local ---------abC                  <-- canonical history
+                 | git checkout --ours
+                 v
+MERGE ---------abC
+                 ^
+                 | git checkout --theirs
+origin/master ---Xyz
+------------
+Rebasing:
+------------
+local -----------Abc
+                 | git checkout --theirs
+                 v
+REBASE --------xyZ
+                 ^
+                 | git checkout --ours
+origin/master -xyZ                    <-- canonical history
+------------
=20
 -b <new_branch>::
 	Create a new branch named <new_branch> and start it at
--=20
1.8.5.1
