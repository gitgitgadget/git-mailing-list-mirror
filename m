From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 0/2] Improve diffcore-pickaxe documentation
Date: Fri, 31 May 2013 17:42:13 +0530
Message-ID: <1370002335-6596-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 31 14:10:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiOAE-0001K2-F7
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 14:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839Ab3EaMKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 08:10:30 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:57312 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934Ab3EaMK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 08:10:29 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so2097332pde.37
        for <git@vger.kernel.org>; Fri, 31 May 2013 05:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=S+eOjD+tFd9fCpHm5KeIGEbNa5aS00QnWjMbg0hHIIg=;
        b=JbKO2lpA/wB1IZGbJ08udpwfS9X4x2dTtVZ/kaDw52/APTbNGOsvYhE89kq04Ix4Pk
         okQhvsnfZdjq4tUo/iXMM71npXjczcrfgLuq9PXDq6tGxWhoR7tcPMOCG32xRtP5Hpgq
         UcLE6MXu/TdmmVYrTrFbKyc9b+J8JbV9aQUNfwCKrza3ypT/p3rbK4DNw6ozVLfeBizu
         DgDLMzAQc8GeXn3zJkibXURIMNeiUoFgyL2DCX3akWgDxq/odZxCn6FWkbmaqpI3wHfR
         wZXlaFc1Jj/rwUjv7PIwhSaXRbWJR6ZWEod6WioBLnnB3nTCPDRvVQfj88VP+RT4JhcC
         sDOA==
X-Received: by 10.66.26.52 with SMTP id i20mr12986615pag.209.1370002228818;
        Fri, 31 May 2013 05:10:28 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id cp1sm46430663pbc.42.2013.05.31.05.10.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 May 2013 05:10:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.114.gcd03571
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226089>

Junio had some suggestions in the previous round.  The inter-diff
follows.

Yeah, word-diff is a bit messy.  Which brings me to: is it possible to
turn on word-diff only where heuristically appropriate?  word-diff
applied on the rewrite of the first paragraph of gitdiffcore.txt is a
disaster, but okay everywhere else.

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index efb5dfe..a85288f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -387,11 +387,11 @@ ifndef::git-format-patch[]
	the specified string (i.e. addition/deletion) in a file.
	Intended for the scripter's use.
+
It is[-especially-] useful when you're looking for an exact block of code (like a
struct), and want to know the history of that block since it first
came into being: use the feature iteratively to feed the interesting
block in the preimage back into `-S`, and keep going until you get the
very first version of the block.

-G<regex>::
	Look for differences whose patch text contains added/removed
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index ef4c04a..c8b3e51 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -222,25 +222,27 @@ version prefixed with '+'.
diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
---------------------------------------------------------------------

[-There are two kinds of pickaxe:-]{+This transformation limits+} the [-S kind (corresponding-]{+set of filepairs+} to [-'git log-]
[--S')-]{+those that change+}
{+specified strings between the preimage+} and the [-G kind (mnemonic: grep; corresponding-]{+postimage in a certain+}
{+way.  -S<block of text> and -G<regular expression> options are used+} to
[-'git log -G').-]{+specify different ways these strings are sought.+}

"-S<block of text>" detects filepairs whose preimage and postimage
have different number of occurrences of the specified block of text.
By definition, it will not detect in-file moves.  Also, when a
changeset moves a file wholesale without affecting the interesting
string, [-rename detection-]{+diffcore-rename+} kicks in as usual, and `-S` omits the filepair
(since the number of occurrences of that string didn't change in that
rename-detected filepair).[-The implementation essentially-]
[-runs a count, and is significantly cheaper than the G kind.-]  When used with `--pickaxe-regex`, treat
the <block of text> as an extended POSIX regular expression to match,
instead of a literal string.

"-G<regular expression>" {+(mnemonic: grep)+} detects filepairs whose
textual diff has an added or a deleted line that matches the given
regular expression.  This means that it [-can-]{+will+} detect in-file (or what
rename-detection considers the same file) [-moves.-]{+moves, which is noise.+}  The
implementation runs diff twice and greps, and this can be quite
expensive.

When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
that match their respective criterion are kept in the output.  When


Ramkumar Ramachandra (2):
  diffcore-pickaxe: make error messages more consistent
  diffcore-pickaxe doc: document -S and -G properly

 Documentation/diff-options.txt | 38 +++++++++++++++++++++++++++--------
 Documentation/gitdiffcore.txt  | 45 +++++++++++++++++++++++++-----------------
 diffcore-pickaxe.c             |  4 ++--
 3 files changed, 59 insertions(+), 28 deletions(-)

-- 
1.8.3.114.gcd03571
