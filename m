From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v2] completion: Add '--edit-todo' to rebase
Date: Mon, 27 Jul 2015 19:54:09 +0200 (CEST)
Message-ID: <1064256694.3063.1438019649384.JavaMail.open-xchange@app07.ox.hosteurope.de>
References: <1436786876.6619.0.camel@virtuell-zuhause.de> <20150713131107.GC1451@serenity.lan>
Reply-To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jul 27 19:54:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJmbR-0002Hu-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 19:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbbG0RyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 13:54:13 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:32847 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753199AbbG0RyM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jul 2015 13:54:12 -0400
Received: from app07.ox.hosteurope.de ([92.51.170.14]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	id 1ZJmbJ-00035R-CU; Mon, 27 Jul 2015 19:54:09 +0200
In-Reply-To: <20150713131107.GC1451@serenity.lan>
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.6.2-Rev25
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1438019652;e3d24d7e;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274694>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
> John Keeping <john@keeping.me.uk> hat am 13. Juli 2015 um 15:11 geschrieben:
> git-rebase.sh contains:
> 
> 	if test "$action" = "edit-todo" && test "$type" != "interactive"
> 	then
> 		die "$(gettext "The --edit-todo action can only be used during interactive
> rebase.")"
> 	fi
> 
> I wonder if it's worth doing a similar check here, which presumably
> means testing if "$dir"/interactive exists.

Good point. Thanks for the hint.

 contrib/completion/git-completion.bash | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index c97c648..b03050e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1668,7 +1668,11 @@ _git_rebase ()
 {
 	local dir="$(__gitdir)"
 	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
-		__gitcomp "--continue --skip --abort"
+		if [ -d "$dir"/interactive ]; then
+			__gitcomp "--continue --skip --abort --edit-todo"
+		else
+			__gitcomp "--continue --skip --abort"
+		fi
 		return
 	fi
 	__git_complete_strategy && return
-- 
2.4.5.windows.1
