From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 01/14] gitweb: get remotes too when getting heads list
Date: Fri, 31 Aug 2007 12:54:58 +0200
Message-ID: <1188557698793-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 12:56:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4BA-0005EJ-At
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 12:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbXHaK4k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 06:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbXHaK4k
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 06:56:40 -0400
Received: from jack.tiscali.it ([213.205.33.53]:37503 "EHLO jack.tiscali.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932433AbXHaK4j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 06:56:39 -0400
Received: from localhost.localdomain (84.221.55.162) by jack.tiscali.it (7.3.122)
        id 46A8A7D10038FB97; Fri, 31 Aug 2007 12:56:37 +0200
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57149>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b2bae1b..65953db 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2063,7 +2063,7 @@ sub git_get_heads_list {
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
 		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-		'refs/heads'
+		'refs/heads', 'refs/remotes'
 		or return;
 	while (my $line = <$fd>) {
 		my %ref_item;
@@ -2073,8 +2073,9 @@ sub git_get_heads_list {
 		my ($hash, $name, $title) = split(' ', $refinfo, 3);
 		my ($committer, $epoch, $tz) =
 			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
-		$name =~ s!^refs/heads/!!;
+		$name =~ s!^refs/(head|remote)s/!!;
 
+		$ref_item{'class'} = $1;
 		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;
 		$ref_item{'title'} = $title || '(no commit message)';
-- 
1.5.2.5
