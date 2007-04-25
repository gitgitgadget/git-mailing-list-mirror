From: Adam Roben <aroben@apple.com>
Subject: [PATCH] Remove usernames from all commit messages, not just when using svmprops
Date: Tue, 24 Apr 2007 18:02:07 -0700
Message-ID: <9F361BEA-54A1-479F-9552-1E2170A83DAF@apple.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 03:38:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgWSa-0002Eq-Fb
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 03:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161561AbXDYBiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 21:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161581AbXDYBiP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 21:38:15 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:52862 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161561AbXDYBiP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 21:38:15 -0400
X-Greylist: delayed 2147 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Apr 2007 21:38:15 EDT
Received: from relay6.apple.com (a17-128-113-36.apple.com [17.128.113.36])
	by mail-out3.apple.com (8.13.8/8.13.8) with ESMTP id l3P12HZ9021754;
	Tue, 24 Apr 2007 18:02:17 -0700 (PDT)
Received: from relay6.apple.com (unknown [127.0.0.1])
	by relay6.apple.com (Symantec Mail Security) with ESMTP id BC89910B3B;
	Tue, 24 Apr 2007 18:02:17 -0700 (PDT)
X-AuditID: 11807124-a2ca1bb000000872-bd-462ea899a334 
Received: from [17.219.196.236] (unknown [17.219.196.236])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by relay6.apple.com (Apple SCV relay) with ESMTP id A028D100EB;
	Tue, 24 Apr 2007 18:02:17 -0700 (PDT)
X-Mailer: Apple Mail (2.752.3)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45496>

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
Signed-off-by: Adam Roben <aroben@apple.com>
---
  git-svn.perl |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index efc4c88..077d6b3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1866,11 +1866,14 @@ sub make_log_entry {
  	} elsif ($self->use_svnsync_props) {
  		my $full_url = $self->svnsync->{url};
  		$full_url .= "/$self->{path}" if length $self->{path};
+		remove_username($full_url);
  		my $uuid = $self->svnsync->{uuid};
  		$log_entry{metadata} = "$full_url\@$rev $uuid";
  		$email ||= "$author\@$uuid"
  	} else {
-		$log_entry{metadata} = $self->metadata_url. "\@$rev " .
+		my $url = $self->metadata_url;
+		remove_username($url);
+		$log_entry{metadata} = "$url\@$rev " .
  		                       $self->ra->get_uuid;
  		$email ||= "$author\@" . $self->ra->get_uuid;
  	}
-- 
1.5.2.rc0.14.g520d-dirty
