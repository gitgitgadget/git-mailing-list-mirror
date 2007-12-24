From: Bernt Hansen <bernt@alumni.uwaterloo.ca>
Subject: [PATCH] Force new line at end of commit message
Date: Mon, 24 Dec 2007 09:31:07 -0500
Message-ID: <8763yof9lg.fsf@gollum.intra.norang.ca>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 15:31:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6oLR-0005pq-Iy
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 15:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbXLXObR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 09:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbXLXObR
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 09:31:17 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55828 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbXLXObQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 09:31:16 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1J6oKo-0008zt-Ji; Mon, 24 Dec 2007 14:31:14 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/q+Rf25I8RmpDWL7Bl3HSt
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id lBOEV8V0027741
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 24 Dec 2007 09:31:09 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.2/8.14.2/Debian-1) with ESMTP id lBOEV76n001981;
	Mon, 24 Dec 2007 09:31:07 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.2/8.14.2/Submit) id lBOEV7Fu001980;
	Mon, 24 Dec 2007 09:31:07 -0500
In-Reply-To: <87ve6ub3u7.fsf@gollum.intra.norang.ca> (Bernt Hansen's message of "Wed\, 19 Dec 2007 19\:35\:28 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69216>

git rebase --interactive formats the combined commit log message
incorrectly when squashing 3 or more commits which have no newline on
the last line of the commit message.

Signed-off-by: Bernt Hansen <bernt@alumni.uwaterloo.ca>
---

This may well be the wrong fix for this problem but my attempts to make
git-rebase--interactive.sh append a newline breaks too many tests in the
test suite.

I tried something like this in git-rebase--interactive.sh:

-               git cat-file commit HEAD | sed -e '1,/^$/d'
+               git cat-file commit HEAD | sed -e '1,/^$/d' -e '$a\'

Sorry I don't have an automated test for git-gui.  Are there any?

 git-gui/lib/commit.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index b2d2d53..1c0586c 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -303,7 +303,7 @@ A rescan will be automatically started now.
 		puts stderr [mc "warning: Tcl does not support encoding '%s'." $enc]
 		fconfigure $msg_wt -encoding utf-8
 	}
-	puts -nonewline $msg_wt $msg
+	puts $msg_wt $msg
 	close $msg_wt
 
 	# -- Create the commit.
-- 
1.5.4.rc1.22.g88b9
