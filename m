From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: Rename 'tagcontents' to 'cached_tagcontent'
Date: Sat,  8 Sep 2012 12:53:16 -0700
Message-ID: <1347133996-70908-1-git-send-email-davvid@gmail.com>
References: <1347130993-69863-1-git-send-email-davvid@gmail.com>
Cc: Tim McCormack <cortex@brainonfire.net>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 21:53:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAR5q-00068j-8d
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 21:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574Ab2IHTxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 15:53:18 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56174 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab2IHTxR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 15:53:17 -0400
Received: by pbbrr13 with SMTP id rr13so1149716pbb.19
        for <git@vger.kernel.org>; Sat, 08 Sep 2012 12:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TVzt/PwmAugHQlsBaQCNGQC6kcG6gyWw2MUv8BnQNEM=;
        b=MWyKFnTI1h1uzOI0t+GoMudD3M0X3LNPPqfYn4etiFNRg8zx/CXtd79PIQt/iA79yQ
         HGjWkV8X2jlXmzoVXIUr1kVha+drhotNb9EniLPnUtmtx87ckS+4SoBcICovt/5hFoRR
         V5EQ9RcAoXNh0AZqQWDvl8Ays6y7IbSj3rXZhr2/aUvM0icg4ejTBv1TgnZ6/PTW2neZ
         aeGlp7az705h2EEj2Wm1q5IyrpkYmUQz3rAN9DCfry7K5AVWmV44xYdM6tMglmDumO9I
         Lf1Gxy0oYAeC3muri1m1st5XXA/jqNmFk+svRQ9+FFLhPM4WytZIgyxXOUhairTgKCjk
         JLCw==
Received: by 10.68.141.46 with SMTP id rl14mr17233320pbb.2.1347133997392;
        Sat, 08 Sep 2012 12:53:17 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id gh7sm5831336pbc.29.2012.09.08.12.53.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Sep 2012 12:53:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.2.448.gee6df
In-Reply-To: <1347130993-69863-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205032>

Name the 'tagcontents' variable similarly to the rest of the
variables cleared in the changedrefs() function.

This makes the naming consistent and provides a hint that it
should be cleared when reloading gitk's cache.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---

Follow-up to 'gitk: Teach "Reread references" to reload tags'

 gitk |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/gitk b/gitk
index a124822..6f24f53 100755
--- a/gitk
+++ b/gitk
@@ -10599,7 +10599,7 @@ proc movedhead {hid head} {
 }
 
 proc changedrefs {} {
-    global cached_dheads cached_dtags cached_atags tagcontents
+    global cached_dheads cached_dtags cached_atags cached_tagcontent
     global arctags archeads arcnos arcout idheads idtags
 
     foreach id [concat [array names idheads] [array names idtags]] {
@@ -10611,7 +10611,7 @@ proc changedrefs {} {
 	    }
 	}
     }
-    catch {unset tagcontents}
+    catch {unset cached_tagcontent}
     catch {unset cached_dtags}
     catch {unset cached_atags}
     catch {unset cached_dheads}
@@ -10664,7 +10664,7 @@ proc listrefs {id} {
 }
 
 proc showtag {tag isnew} {
-    global ctext tagcontents tagids linknum tagobjid
+    global ctext cached_tagcontent tagids linknum tagobjid
 
     if {$isnew} {
 	addtohistory [list showtag $tag 0] savectextpos
@@ -10673,13 +10673,13 @@ proc showtag {tag isnew} {
     clear_ctext
     settabs 0
     set linknum 0
-    if {![info exists tagcontents($tag)]} {
+    if {![info exists cached_tagcontent($tag)]} {
 	catch {
-           set tagcontents($tag) [exec git cat-file tag $tag]
+           set cached_tagcontent($tag) [exec git cat-file tag $tag]
 	}
     }
-    if {[info exists tagcontents($tag)]} {
-	set text $tagcontents($tag)
+    if {[info exists cached_tagcontent($tag)]} {
+	set text $cached_tagcontent($tag)
     } else {
 	set text "[mc "Tag"]: $tag\n[mc "Id"]:  $tagids($tag)"
     }
-- 
1.7.7.2.448.gee6df
