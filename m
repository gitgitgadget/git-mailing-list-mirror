From: Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCHv2] git-credential-netrc: fix uninitialized warning
Date: Tue, 08 Oct 2013 16:02:02 -0400
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87hacrv8ed.fsf@flea.lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 08 22:02:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTdTs-0002s0-Ug
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 22:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628Ab3JHUCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 16:02:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:46084 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753469Ab3JHUCD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 16:02:03 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VTdTm-0002oh-6J
	for git@vger.kernel.org; Tue, 08 Oct 2013 22:02:02 +0200
Received: from c-98-229-61-72.hsd1.ma.comcast.net ([98.229.61.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 22:02:02 +0200
Received: from tzz by c-98-229-61-72.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 22:02:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-98-229-61-72.hsd1.ma.comcast.net
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:Z4p/j+lO1BsqHykDhW1tscHw268=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235788>

Simple patch to avoid unitialized warning and log what we'll do.

Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>
---
 contrib/credential/netrc/git-credential-netrc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
index 6c51c43..1571a7b 100755
--- a/contrib/credential/netrc/git-credential-netrc
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -369,7 +369,9 @@ sub find_netrc_entry {
 	{
 		my $entry_text = join ', ', map { "$_=$entry->{$_}" } keys %$entry;
 		foreach my $check (sort keys %$query) {
-			if (defined $query->{$check}) {
+			if (!defined $entry->{$check}) {
+			        log_debug("OK: entry has no $check token, so any value satisfies check $check");
+			} elsif (defined $query->{$check}) {
 				log_debug("compare %s [%s] to [%s] (entry: %s)",
 					  $check,
 					  $entry->{$check},
-- 
1.8.1.5
