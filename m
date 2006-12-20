X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ron Parker <ron.parker@mobot.org>
Subject: Patch: Support slashes in branches in git-cvsserver
Date: Wed, 20 Dec 2006 14:55:40 -0600
Message-ID: <1166648140.5380.40.camel@s2ua6340pxk.mobot.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 20:55:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Evolution 2.0.2 (2.0.2-27.rhel4.6) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34960>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx8Ta-0001du-Dz for gcvg-git@gmane.org; Wed, 20 Dec
 2006 21:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965012AbWLTUzn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 15:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWLTUzn
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 15:55:43 -0500
Received: from mbgmail01.mobot.org ([4.36.133.74]:1359 "EHLO
 mbgmail01.mobot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965012AbWLTUzn (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 15:55:43 -0500
Received: from 172.16.17.95 ([172.16.17.95]) by MBGMail01.mobot.org
 ([172.16.19.244]) via Exchange Front-End Server mbgowa01.mobot.org
 ([172.16.18.246]) with Microsoft Exchange Server HTTP-DAV ; Wed, 20 Dec 2006
 20:55:40 +0000
Received: from s2ua6340pxk.mobot.org by mbgowa01.mobot.org; 20 Dec 2006
 14:55:40 -0600
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Here is a little patch to allow git-cvsserver to support fetching from
branches with slashes in their names like:

	topic/convert-to-xhtml

>From 1d22e18f46a82eab3fe6d467b2b87fe8203ebacc Mon Sep 17 00:00:00 2001
From: Ron Parker <ron.parker@mobot.org>
Date: Wed, 20 Dec 2006 14:48:31 -0600
Subject: [PATCH] Support slashes in branches in git-cvsserver

---
 git-cvsserver.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 2a8447e..418c821 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2087,7 +2087,9 @@ sub new
     die "Database dir '$self->{dbdir}' isn't a directory" unless
( defined($self->{dbdir}) and -d $self->{dbdir} );
 
     $self->{module} = $module;
-    $self->{file} = $self->{dbdir} . "/gitcvs.$module.sqlite";
+    my $mod = $module;
+    $mod =~ s/\//./g;
+    $self->{file} = $self->{dbdir} . "/gitcvs.$mod.sqlite";
 
     $self->{git_path} = $config . "/";
 
-- 
1.4.4.2.g8336

