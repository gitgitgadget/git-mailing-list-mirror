X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] Documentation: Two more git-rebase --onto examples
Date: Sat, 4 Nov 2006 22:05:57 +0100
Message-ID: <200611042205.58212.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 4 Nov 2006 21:05:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=emRlOMcRN8QviLsEKP8iIM7Yj84V03kKOZuulqDC6tC1BsOdctnyiA81quT8YnlOYDIgqQbHcngBfuS6xoQWqsLf+mUtR8tPhrMuF/dLC4P5iHUnF67otZWUJemx7EgBsUsBCxgIooDJas6401r7kvcW9FjHG24siAat+wLJYUE=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30939>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgSi3-0001yR-G8 for gcvg-git@gmane.org; Sat, 04 Nov
 2006 22:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965689AbWKDVFo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 16:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965693AbWKDVFo
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 16:05:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:8909 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965689AbWKDVFn
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 16:05:43 -0500
Received: by ug-out-1314.google.com with SMTP id m3so631041ugc for
 <git@vger.kernel.org>; Sat, 04 Nov 2006 13:05:42 -0800 (PST)
Received: by 10.67.91.6 with SMTP id t6mr4836573ugl.1162674341960; Sat, 04
 Nov 2006 13:05:41 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 13sm2531034ugb.2006.11.04.13.05.41; Sat, 04 Nov
 2006 13:05:41 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Added example of transplantig feature branch from one development
branch (for example "next") into the other development branch (for
example "master").

Added example of rebasing part of branch, or transplanting feature
branch from the tip of other feature branch to the development branch
the second feature branch started from.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I asked for comments because I'm not native English speaker and I'm not
sure about correctness of descriptions of added examples.

P.S. Perhaps we should separate the part dealing with CONFLICT(contents)
into separate documentation file, and include it as needed (for example
alsop in git-push(1)).

 Documentation/git-rebase.txt |   55 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 10f2924..1308d2f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -65,6 +65,61 @@ would be:
     D---E---F---G master
 ------------
 
+More useful example of --onto option usage include transplanting feature
+branch from one development branch to other, for example change to branch
+based off "next" branch:
+
+------------
+    o---o---o---o---o  master
+         \
+          o---o---o---o---o  next
+                           \
+                            o---o---o  topic
+------------
+
+to being a branch based off "master" branch as shown below:
+
+------------
+    o---o---o---o---o  master
+        |            \
+        |             o'--o'--o'  topic
+         \
+          o---o---o---o---o  next
+------------
+
+We can get this using the following command:
+
+    git-rebase --onto master next topic
+
+
+Yet another example of use for --onto option is to rebase part of
+branch. If we have the following situation:
+
+------------
+                            H---I---J topicB
+                           /
+                  E---F---G  topicA
+                 /
+    A---B---C---D  master
+------------
+
+then the command
+
+    git-rebase --onto master topicA topicB
+
+would give us the following situation:
+
+------------
+                 H'--I'--J'  topicB
+                /
+                | E---F---G  topicA
+                |/
+    A---B---C---D  master
+------------
+
+with "topicB" branch based off "master".
+
+
 In case of conflict, git-rebase will stop at the first problematic commit
 and leave conflict markers in the tree.  You can use git diff to locate
 the markers (<<<<<<) and make edits to resolve the conflict.  For each
-- 
1.4.3.3
