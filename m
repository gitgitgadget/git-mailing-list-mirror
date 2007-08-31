From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 11/14] gitweb: git_is_head_detached() function
Date: Fri, 31 Aug 2007 13:19:11 +0200
Message-ID: <11885591601143-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
 <11885591542097-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 13:21:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4Ys-0002jD-Kz
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 13:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbXHaLVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 07:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbXHaLVH
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 07:21:07 -0400
Received: from hu-out-0506.google.com ([72.14.214.230]:32010 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964856AbXHaLVE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 07:21:04 -0400
Received: by hu-out-0506.google.com with SMTP id 19so593548hue
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 04:21:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QmzzF8hzKgSQ1Z5S9m1d/kNKhNkphmnB2jD+YctqYleWJ3q69VjgUZtLIuptsb1uLlKunTVRPbg/nIaaI/wcw0g6knfXVbUzGJKypXYBdgKEnqtbe424Gm7nCnzvkafyWOCHJ7VQAapc+lJgfNcNhP8FFqjvfxKOmaAh3UygQ0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NxvHtgBE6YtR1qn/f54QZdQTZR76swjMsl9uLmkoAnvjvldOGuwkpkKpnziWxU08EGiHWugIz34Bi17dY2ZjNOGS/WotfimeG1ugqdv6gWqZnVybuFCHi5EdQcBCfSYW1U+35/4MTxVnvd8jKm1rLqGORhg0rSNW1Qm5Alroosk=
Received: by 10.82.186.5 with SMTP id j5mr393758buf.1188559263876;
        Fri, 31 Aug 2007 04:21:03 -0700 (PDT)
Received: from localhost ( [84.221.55.162])
        by mx.google.com with ESMTPS id k10sm1274580nfh.2007.08.31.04.21.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2007 04:21:02 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <11885591542097-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57159>

The function checks if the HEAD for the current project is detached by checking if 'git branch' returns "* (no branch)"

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e743c3d..a745434 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1416,6 +1416,13 @@ sub git_get_head_hash {
 	return $retval;
 }
 
+# check if current HEAD is detached
+sub git_is_head_detached {
+	my @x = (git_cmd(), 'branch');
+	my @ret = split("\n", qx(@x));
+	return 0 + grep { /^* \(no branch\)$/ } @ret;
+}
+
 # get type of given object
 sub git_get_type {
 	my $hash = shift;
@@ -2091,11 +2098,9 @@ sub git_get_heads_list {
 	my @headslist;
 
 	if (grep { $_ eq 'heads' } @class) {
-		my @x = (git_cmd(), 'branch');
-		my @ret = split("\n", qx(@x));
-		if (grep { /^* \(no branch\)$/ } @ret) { ;
+		if (git_is_head_detached()) { ;
 			my %ref_item;
-			@x = (git_cmd(), 'log', '-1', '--pretty=format:%H%n%ct%n%s');
+			my @x = (git_cmd(), 'log', '-1', '--pretty=format:%H%n%ct%n%s');
 			my ($hash, $epoch, $title) = split("\n", qx(@x), 3);
 
 			$ref_item{'class'} = 'head';
-- 
1.5.2.5
