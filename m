From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/6] gitweb: Mark matched 'ctag' / contents tag (?by_tag=foo)
Date: Fri, 29 Apr 2011 19:51:58 +0200
Message-ID: <1304099521-27617-4-git-send-email-jnareb@gmail.com>
References: <1304099521-27617-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Sebastien Cevey <seb@cine7.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 19:52:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFrs3-0001Q3-TM
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 19:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760764Ab1D2Rwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 13:52:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35897 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760753Ab1D2Rw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 13:52:28 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so2635553fxm.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=9yxTzaI2La6X3SyIitbU8f0+XtTzwDWBK2aWAwlk/SE=;
        b=hXvUKJxJAt6GHbXPrjdlFc2v0LTzrxu6TKPdMBghF8n6XD45682qrzg1MYd1auLGWB
         9YsDTmD8vV0FIMFiE7s+WUAyjnqmwm0cuxGviiiL66b50Ui8Ukgwrxy/wwO8LZQHLbYK
         647cI9S6gmhFXGbPkpSCL/Kxw1fdrSyEOAjcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=q4i8JYOXCgVErKpLY1HMlbnp2aYbFDbAmpxHLmOiyq6nJM4g7s4ORIVOzQYXHyaHtI
         rldvFrk6juRWtfqvqOZQyW344Hj+o0zM9OSGvgIEOjz90W8njhSSNZtO1iBt75W+52+5
         Mzx2bDCeDt+BFyyG8wZC70iekWvKnku5yph6U=
Received: by 10.223.77.92 with SMTP id f28mr2823954fak.37.1304099548096;
        Fri, 29 Apr 2011 10:52:28 -0700 (PDT)
Received: from localhost.localdomain (abvr62.neoplus.adsl.tpnet.pl [83.8.215.62])
        by mx.google.com with ESMTPS id n26sm962346fam.37.2011.04.29.10.52.26
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Apr 2011 10:52:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304099521-27617-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172483>

It might have been hard to discover that current view is limited to
projects with given content tag (ctag), as it was distinquished only
in gitweb URL.  Mark matched contents tag in the tag cloud using
"match" class, for easier discovery.

This commit introduces a bit of further code duplication in
git_populate_project_tagcloud().

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Acked-by: Petr Baudis <pasky@suse.cz>
---
This patch was originally sent to git mailing list as

  [PATCH 2/1] gitweb: Mark matched 'ctag' / contents tag (?by_tag=foo)
  http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/802865/focus=168731

(yes, it was crossposted).

 gitweb/gitweb.perl |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 60cb772..e81c27d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2653,6 +2653,7 @@ sub git_populate_project_tagcloud {
 	}
 
 	my $cloud;
+	my $matched = $cgi->param('by_tag');
 	if (eval { require HTML::TagCloud; 1; }) {
 		$cloud = HTML::TagCloud->new;
 		foreach my $ctag (sort keys %ctags_lc) {
@@ -2662,17 +2663,22 @@ sub git_populate_project_tagcloud {
 			$title =~ s/ /&nbsp;/g;
 			$title =~ s/^/&nbsp;/g;
 			$title =~ s/$/&nbsp;/g;
+			if (defined $matched && $matched eq $ctag) {
+				$title = qq(<span class="match">$title</span>);
+			}
 			$cloud->add($title, href(project=>undef, ctag=>$ctag),
 			            $ctags_lc{$ctag}->{count});
 		}
 	} else {
 		$cloud = {};
 		foreach my $ctag (keys %ctags_lc) {
-			my $title = $ctags_lc{$ctag}->{topname};
+			my $title = esc_html($ctags_lc{$ctag}->{topname}, -nbsp=>1);
+			if (defined $matched && $matched eq $ctag) {
+				$title = qq(<span class="match">$title</span>);
+			}
 			$cloud->{$ctag}{count} = $ctags_lc{$ctag}->{count};
 			$cloud->{$ctag}{ctag} =
-				$cgi->a({-href=>href(project=>undef, ctag=>$ctag)},
-			          esc_html($title, -nbsp=>1));
+				$cgi->a({-href=>href(project=>undef, ctag=>$ctag)}, $title);
 		}
 	}
 	return $cloud;
-- 
1.7.3
