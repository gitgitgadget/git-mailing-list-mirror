From: Johan Herland <johan@herland.net>
Subject: [PATCH] Fix submodule sync with relative submodule URLs
Date: Wed, 24 Sep 2008 11:31:16 +0200
Message-ID: <200809241131.16327.johan@herland.net>
References: <200809221808.31730.johan@herland.net>
 <402731c90809240029l308726aeme14c0e7fe2d54a3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 11:33:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiQjz-0002dv-1W
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 11:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbYIXJbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 05:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbYIXJbu
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 05:31:50 -0400
Received: from smtp.getmail.no ([84.208.20.33]:54358 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbYIXJbt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 05:31:49 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K7P0092514PFY00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 24 Sep 2008 11:31:37 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7P00L2I144EW10@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 24 Sep 2008 11:31:16 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7P004YV144UO70@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 24 Sep 2008 11:31:16 +0200 (CEST)
In-reply-to: <402731c90809240029l308726aeme14c0e7fe2d54a3c@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96625>

Signed-off-by: Johan Herland <johan@herland.net>
---

On Wednesday 24 September 2008, David Aguilar wrote:
> Instead of just doing an "|| exit" shouldn't it report an explanation
> of the error?
> Other than that, it looks good to me.

Fixed. Thanks.

...Johan


 git-submodule.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1c39b59..f89bdbe 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -634,6 +634,15 @@ cmd_sync()
 	do
 		name=$(module_name "$path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
+
+		# Possibly a url relative to parent
+		case "$url" in
+		./*|../*)
+			url=$(resolve_relative_url "$url") ||
+				die "failed to resolve relative submodule url for '$name'"
+			;;
+		esac
+
 		if test -e "$path"/.git
 		then
 		(
-- 
1.6.0.2.463.g7f0eb
