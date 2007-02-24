From: Nix <nix@esperi.org.uk>
Subject: [COGITO] fix git-tag-ls in the presence of all-packed tags
Date: Sat, 24 Feb 2007 00:07:13 +0000
Message-ID: <87abz4e7v2.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Feb 24 01:25:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKkir-0002yE-2p
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 01:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933288AbXBXAZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 19:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933287AbXBXAZE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 19:25:04 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:3640 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933288AbXBXAZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 19:25:03 -0500
X-Greylist: delayed 1064 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Feb 2007 19:25:03 EST
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l1O07DO5022448;
	Sat, 24 Feb 2007 00:07:13 GMT
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l1O07DZ9012859;
	Sat, 24 Feb 2007 00:07:13 GMT
Emacs: because extension languages should come with the editor built in.
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40474>

(I don't know if cogito is dead (no changes for two months), but on the
off-chance that it isn't here's a tiny patch.)


Rely on the ref walker to determine if there are any tags.
(Just consulting refs/tags fails wrongly if all tags are packed.)

Signed-off-by: Nick Alcock <nix@esperi.org.uk>

diff --git a/cg-tag-ls b/cg-tag-ls
index f4c776c..724f428 100755
--- a/cg-tag-ls
+++ b/cg-tag-ls
@@ -28,10 +28,7 @@ _git_wc_unneeded=1
 
 msg_no_tags="no tags present, please see cg-tag(1)"
 
-[ -d "$_git/refs/tags" ] || die "$msg_no_tags"
-
-[ "$(find "$_git/refs/tags" -follow -type f)" ] \
-       || die "$msg_no_tags"
+[ "x$(git-for-each-ref --count=1 --format=present refs/tags)" = "xpresent" ] || die "$msg_no_tags"
 
 maxlen="$(git-for-each-ref --format="%(refname)" refs/tags | column_width "refs/tags/")"
 

-- 
`In the future, company names will be a 32-character hex string.'
  --- Bruce Schneier on the shortage of company names
