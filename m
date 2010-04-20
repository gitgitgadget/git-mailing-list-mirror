From: Michael Olson <mwolson@gnu.org>
Subject: [PATCH/RFC 2/2] git-svn: Don't allow missing commit parent to stop 
	git-svn
Date: Tue, 20 Apr 2010 14:30:19 -0700
Message-ID: <j2wc8b3bef91004201430ie371be83kee0e3e4c35ab9c9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 20 23:30:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4L1z-0000Fv-C0
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 23:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428Ab0DTVau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 17:30:50 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:45242 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab0DTVas (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 17:30:48 -0400
Received: by pzk42 with SMTP id 42so4528249pzk.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 14:30:48 -0700 (PDT)
Received: by 10.220.81.20 with HTTP; Tue, 20 Apr 2010 14:30:19 -0700 (PDT)
X-Originating-IP: [209.104.55.5]
X-Google-Sender-Auth: 66147c93571498c6
Received: by 10.115.28.1 with SMTP id f1mr1629880waj.181.1271799048007; Tue, 
	20 Apr 2010 14:30:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145400>

Instead, fall back to assuming that the incoming merge is a bunch of
cherry-picks and ignore it.

Signed-off-by: Michael W. Olson <mwolson@gnu.org>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0e1feb3..1a53709 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3110,7 +3110,7 @@ sub check_cherry_pick {
 	my %commits = map { $_ => 1 }
 		_rev_list("--no-merges", $tip, "--not", $base);
 	for my $range ( @ranges ) {
-		delete @commits{_rev_list($range)};
+		eval { delete @commits{_rev_list($range)} };
 	}
 	for my $commit (keys %commits) {
 		if (has_no_changes($commit)) {
-- 
1.7.1.rc0
