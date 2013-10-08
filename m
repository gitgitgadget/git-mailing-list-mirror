From: Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH] git-credential-netrc: fix uninitialized warning
Date: Tue, 08 Oct 2013 10:34:03 -0400
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87zjqjx25g.fsf@flea.lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 08 16:34:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTYMU-0006i6-Fb
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 16:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317Ab3JHOeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 10:34:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:37779 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab3JHOeE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 10:34:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VTYML-0006dv-OF
	for git@vger.kernel.org; Tue, 08 Oct 2013 16:34:01 +0200
Received: from c-98-229-61-72.hsd1.ma.comcast.net ([98.229.61.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 16:34:01 +0200
Received: from tzz by c-98-229-61-72.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 16:34:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-98-229-61-72.hsd1.ma.comcast.net
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:g5/YCTxnVhMSnwxj2KphGwmxAiA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235776>

Simple patch to avoid unitialized warning and log what we'll do.

---
 contrib/credential/netrc/git-credential-netrc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
index 6c51c43..13e537b 100755
--- a/contrib/credential/netrc/git-credential-netrc
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -369,7 +369,10 @@ sub find_netrc_entry {
 	{
 		my $entry_text = join ', ', map { "$_=$entry->{$_}" } keys %$entry;
 		foreach my $check (sort keys %$query) {
-			if (defined $query->{$check}) {
+			if (!defined $entry->{$check}) {
+			       log_debug("OK: entry has no $check token, so any value satisfies check $check");
+			}
+			elsif (defined $query->{$check}) {
 				log_debug("compare %s [%s] to [%s] (entry: %s)",
 					  $check,
 					  $entry->{$check},
-- 
1.8.1.5
