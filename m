From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] fast-import: Document author/committer/tagger name is
	optional
Date: Wed, 30 Dec 2009 07:03:48 -0800
Message-ID: <20091230150348.GF6914@spearce.org>
References: <4B304987.7030201@facebook.com> <20091222150649.GI10687@spearce.org> <4B3AED66.3030803@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Reiss <dreiss@facebook.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 16:03:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ05c-00040y-JE
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 16:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbZL3PDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 10:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753019AbZL3PDw
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 10:03:52 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:50862 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbZL3PDw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 10:03:52 -0500
Received: by yxe17 with SMTP id 17so10862951yxe.33
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 07:03:51 -0800 (PST)
Received: by 10.101.187.18 with SMTP id o18mr17263183anp.8.1262185430710;
        Wed, 30 Dec 2009 07:03:50 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm12839840iwn.10.2009.12.30.07.03.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Dec 2009 07:03:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B3AED66.3030803@facebook.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135905>

The fast-import parser does not validate that the author, committer
or tagger name component contains both a name and an email address.
Therefore the name component has always been optional.  Correct the
documentation to match the implementation.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
   David Reiss <dreiss@facebook.com> wrote:
   > >> author <somename> 1261454209 +0000
   > >> committer <somename> 1261454209 +0000
   > > a foreign system where the data might not reasonably exist.
   > But shouldn't there still be an extra space?  One to separate "author"
   > from the empty name, and one to separate the empty name from the email?
   > If not, then I think this change should be made.  (I couldn't find any
   > authoritative documentation on what constitutes a valid commit object.)
   
   Yes, we should do this.
    
 Documentation/git-fast-import.txt |    6 +++---
 fast-import.c                     |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 288032c..e6d364f 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -311,8 +311,8 @@ change to the project.
 ....
 	'commit' SP <ref> LF
 	mark?
-	('author' SP <name> SP LT <email> GT SP <when> LF)?
-	'committer' SP <name> SP LT <email> GT SP <when> LF
+	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
+	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
 	data
 	('from' SP <committish> LF)?
 	('merge' SP <committish> LF)?
@@ -657,7 +657,7 @@ lightweight (non-annotated) tags see the `reset` command below.
 ....
 	'tag' SP <name> LF
 	'from' SP <committish> LF
-	'tagger' SP <name> SP LT <email> GT SP <when> LF
+	'tagger' (SP <name>)? SP LT <email> GT SP <when> LF
 	data
 ....
 
diff --git a/fast-import.c b/fast-import.c
index dd3c99d..cd87049 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -19,8 +19,8 @@ Format of STDIN stream:
 
   new_commit ::= 'commit' sp ref_str lf
     mark?
-    ('author' sp name sp '<' email '>' sp when lf)?
-    'committer' sp name sp '<' email '>' sp when lf
+    ('author' (sp name)? sp '<' email '>' sp when lf)?
+    'committer' (sp name)? sp '<' email '>' sp when lf
     commit_msg
     ('from' sp committish lf)?
     ('merge' sp committish lf)*
@@ -47,7 +47,7 @@ Format of STDIN stream:
 
   new_tag ::= 'tag' sp tag_str lf
     'from' sp committish lf
-    ('tagger' sp name sp '<' email '>' sp when lf)?
+    ('tagger' (sp name)? sp '<' email '>' sp when lf)?
     tag_msg;
   tag_msg ::= data;
 
-- 
1.6.6.307.gba67

-- 
Shawn.
