From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI)] git-gui: Support more git version notations.
Date: Sat, 7 Feb 2009 19:43:57 +0300
Organization: HOME
Message-ID: <200902071943.58106.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 17:44:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVqHz-0001Qh-J3
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 17:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbZBGQmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 11:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbZBGQmf
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 11:42:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:17114 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbZBGQme (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 11:42:34 -0500
Received: by fg-out-1718.google.com with SMTP id 16so763765fgg.17
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 08:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bk/f6Zlw+torhbVmye3wgSIQNyoYM0sOUJodtKrLBIQ=;
        b=xy+DCZ5N8jysZ2jdNOAlcjAxLrPpJ9Sb8zAgOyl3TvhTx98HPDEeDQlJGgSmP4WXEA
         A6TD/9z93plAYogDMFDjEh0b+cVSad5ZU+Th0SidlKDUi/vDqhWox1DefOQ4wxgPrwCj
         j9QsV2UgE3/9IxKTwPvGn0V/LsR/czZcB5SS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=BcjGrH66nbiChLz7Cq3NUbWXxbL8csTjauWtGsEGcIdw8J62BgHB4IQlxzsjQQqGVU
         mF60+ihFZ3D/+dmNLEKoaqITi/l1D0zzS/NMqov6pVJeVIrWomUSYTQ1ey6BssOvhLKM
         /8Njs/QVVADpl9+JlP43GEPF0LaY28JzGAQqg=
Received: by 10.86.60.14 with SMTP id i14mr1701927fga.21.1234024951769;
        Sat, 07 Feb 2009 08:42:31 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id l19sm5465967fgb.47.2009.02.07.08.42.30
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 08:42:31 -0800 (PST)
User-Agent: KMail/1.10.4 (Linux/2.6.27.12-170.2.5.fc10.i686; KDE/4.1.4; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108866>

Recently the msysgit repository has got a '1.6.1-msysgit1'
tag, which, when used to build the git version, is not
handled gracefully by the git-gui version code.

This patch changes the regular expressions to fix it, and
removes the hardcoded 'rc' string. Now git-gui can accept
a version tail like '.foo123.GIT.bar.456.7.g89ab'

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index e018e07..2f1f305 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -769,9 +769,9 @@ if {![regsub {^git version } $_git_version {} _git_version]} {
 set _real_git_version $_git_version
 regsub -- {[\-\.]dirty$} $_git_version {} _git_version
 regsub {\.[0-9]+\.g[0-9a-f]+$} $_git_version {} _git_version
-regsub {\.rc[0-9]+$} $_git_version {} _git_version
+regsub {\.[a-zA-Z]+\.?[0-9]+$} $_git_version {} _git_version
 regsub {\.GIT$} $_git_version {} _git_version
-regsub {\.[a-zA-Z]+\.[0-9]+$} $_git_version {} _git_version
+regsub {\.[a-zA-Z]+\.?[0-9]+$} $_git_version {} _git_version
 
 if {![regexp {^[1-9]+(\.[0-9]+)+$} $_git_version]} {
 	catch {wm withdraw .}
-- 
1.6.1.2.35.g919ab
