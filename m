From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v2 09/11] gitweb: git_is_head_detached() function
Date: Thu, 13 Nov 2008 23:49:15 +0100
Message-ID: <1226616555-24503-10-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-7-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-8-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-9-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 23:50:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0l1X-0004iw-NG
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYKMWt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbYKMWtY
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:49:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:31154 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbYKMWtU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:49:20 -0500
Received: by fg-out-1718.google.com with SMTP id 19so912881fgg.17
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 14:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WkuVtTpgxq0LaummoiDZt82BOUn2FSGvoxUwyjlu7xQ=;
        b=bhaUhIhis3hSsWFcKD2Lgr+pKHzFsjCKdhRaianH173ikP1hnW1xYDXj3tIhs5+x35
         XVasX6MoQvdVK9IZJhDnWD6h/u3DDwzfPdWbywzh96qZQ4cxFdGXyvx399Uk8Ye0l34X
         rx5x46M8NMsknbrbeTf9F9scM5EeSNGMoYe9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=feB96jwBwu1od6zcqSLIPQSHY35EwSgmxs68Hz/uJ5Sj93YNyvw7cupjvWki8UAVRE
         d3tNdkQKtwxk5sGlMUPR3QSlMnJxsnToNOJ+KCghLZ33e+kNLjimUGqqy4NgDzr7IoLY
         xZoYSniY1FFEVzlIzv2NAWme8BVmuqUHT9Z9A=
Received: by 10.180.222.1 with SMTP id u1mr72412bkg.62.1226616559583;
        Thu, 13 Nov 2008 14:49:19 -0800 (PST)
Received: from localhost ([78.15.2.247])
        by mx.google.com with ESMTPS id y15sm5455564fkd.17.2008.11.13.14.49.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 14:49:19 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226616555-24503-9-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function checks if the HEAD for the current project is detached by
checking if 'git branch' returns "* (no branch)"

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a168f6f..ceb0271 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1844,6 +1844,13 @@ sub git_get_head_hash {
 	return $retval;
 }
 
+# check if current HEAD is detached
+sub git_is_head_detached {
+	my @x = (git_cmd(), 'branch');
+	my @ret = split("\n", qx(@x));
+	return 0 + grep { /^\* \(no branch\)$/ } @ret;
+}
+
 # get type of given object
 sub git_get_type {
 	my $hash = shift;
@@ -2673,11 +2680,9 @@ sub git_get_heads_list {
 	my @headslist;
 
 	if (grep { $_ eq 'heads' } @class) {
-		my @x = (git_cmd(), 'branch');
-		my @ret = split("\n", qx(@x));
-		if (grep { /^\* \(no branch\)$/ } @ret) { ;
+		if (git_is_head_detached()) {
 			my %ref_item;
-			@x = (git_cmd(), 'log', '-1', '--pretty=format:%H%n%ct%n%s');
+			my @x = (git_cmd(), 'log', '-1', '--pretty=format:%H%n%ct%n%s');
 			my ($hash, $epoch, $title) = split("\n", qx(@x), 3);
 
 			$ref_item{'class'} = 'head';
-- 
1.5.6.5
