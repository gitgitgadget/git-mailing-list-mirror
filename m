From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] pre-commit hook: complain about conflict markers.
Date: Wed, 19 Apr 2006 14:59:51 -0700
Message-ID: <7vpsjd5iqw.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vu08p72sn.fsf@assigned-by-dhcp.cox.net>
	<87acah6zk6.wl%cworth@cworth.org>
	<7v8xq16y31.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 20 00:00:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWKiJ-0005Sx-Qd
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 23:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWDSV7x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 17:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWDSV7x
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 17:59:53 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:20658 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751270AbWDSV7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 17:59:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419215951.ZXPV24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 17:59:51 -0400
To: git@vger.kernel.org
In-Reply-To: <7v8xq16y31.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 19 Apr 2006 14:43:14 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18946>

Several <<< or === or >>> characters at the beginning of a line
is very likely to be leftover conflict markers from a failed
automerge the user resolved incorrectly, so detect them.

As usual, this can be defeated with "git commit --no-verify" if
you really do want to have those files, just like changes that
introduce trailing whitespaces.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 templates/hooks--pre-commit |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

6be63d37efc766756922a9b96ed8fe7a332f133a
diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 43d3b6e..723a9ef 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -61,6 +61,9 @@ perl -e '
 	    if (/^\s* 	/) {
 		bad_line("indent SP followed by a TAB", $_);
 	    }
+	    if (/^(?:[<>=]){7}/) {
+		bad_line("unresolved merge conflict", $_);
+	    }
 	}
     }
     exit($found_bad);
-- 
1.3.0.g2c4a
