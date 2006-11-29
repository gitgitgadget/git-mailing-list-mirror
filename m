X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: gitk with arguments fails on OSX
Date: 29 Nov 2006 07:28:41 -0800
Message-ID: <86vekyw9ue.fsf@blue.stonehenge.com>
References: <864psixpj6.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0611291609370.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 15:29:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.6; tzolkin = 13 Cimi; haab = 19 Ceh
In-Reply-To: <Pine.LNX.4.63.0611291609370.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Original-Lines: 63
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32645>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpRMc-0001S3-So for gcvg-git@gmane.org; Wed, 29 Nov
 2006 16:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967420AbWK2P2n (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 10:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967424AbWK2P2n
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 10:28:43 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:37274 "EHLO
 blue.stonehenge.com") by vger.kernel.org with ESMTP id S967420AbWK2P2n (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 10:28:43 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 785128FBAA; Wed, 29 Nov 2006 07:28:42 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 29472-01-97; Wed, 29 Nov 2006 07:28:41 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id DA4318FBB7;
 Wed, 29 Nov 2006 07:28:41 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> Hi,
Johannes> On Wed, 29 Nov 2006, Randal L. Schwartz wrote:

>> 
>> Using the native "wish", gitk fails on OSX 10.4 if given any arguments.
>> For example, the failure for "gitk --all" is:
>> 
>> localhost.local:~/MIRROR/git-GIT % gitk --all
>> Error in startup script: unknown option "-state"
>> while executing

Johannes> Known problem:

Johannes> http://thread.gmane.org/gmane.comp.version-control.git/31266/focus=31266

The fix works for me.  How about mainlining it?

From: Randal L. Schwartz <merlyn@localhost.local>
Date: Wed, 29 Nov 2006 07:20:04 -0800
Subject: [PATCH] patch from mailing list

---
 gitk |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index ab383b3..d9df0a3 100755
--- a/gitk
+++ b/gitk
@@ -1632,8 +1632,8 @@ proc showview {n} {
 
     set curview $n
     set selectedview $n
-    .bar.view entryconf 2 -state [expr {$n == 0? "disabled": "normal"}]
-    .bar.view entryconf 3 -state [expr {$n == 0? "disabled": "normal"}]
+    .bar.view entryconf "Edit*" -state [expr {$n == 0? "disabled": "normal"}]
+    .bar.view entryconf "Delete*" -state [expr {$n == 0? "disabled": "normal"}]
 
     if {![info exists viewdata($n)]} {
        set pending_select $selid
@@ -6305,8 +6305,8 @@ if {$cmdline_files ne {} || $revtreeargs ne {}} {
     set viewargs(1) $revtreeargs
     set viewperm(1) 0
     addviewmenu 1
-    .bar.view entryconf 2 -state normal
-    .bar.view entryconf 3 -state normal
+    .bar.view entryconf "Edit*" -state normal
+    .bar.view entryconf "Delete*" -state normal
 }
 
 if {[info exists permviews]} {
-- 
1.4.4.1.gf927



-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
