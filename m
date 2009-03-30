From: David Aguilar <davvid@gmail.com>
Subject: [POC PATCH] difftool: add support for the --interactive flag
Date: Mon, 30 Mar 2009 01:48:31 -0700
Message-ID: <1238402911-19064-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 30 10:49:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoDBd-0003b5-Dm
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 10:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899AbZC3IsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 04:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754482AbZC3IsJ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 04:48:09 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:49332 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbZC3IsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 04:48:08 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2401826qwh.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 01:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=u1yh0RDYsDI/KCHsShiAi2WM6To1sKlBR+LCDDZ9QU8=;
        b=TnuyAou61i2d/hsFOymkJ6ox6yx0cDOqnj9XTw6voJS9TxZmHUgFtY0wW4x8v/uPZN
         sWevLYYw6YUcSWLZiGpJ3JL16GNLemukPNo3UidaYji4c+dbjOMbgEfbmJdnOzsplLSJ
         WI/Z/QaflRVujju/FvJt57knJ3aTzSz8AZ6+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=A69Fb1+2JHoEQSysU9fFqxXA3b0oZiwDrShdJeRQYXXEc1sVXtNJb305j/sp1ftXAv
         y0bYKhbeN7mywrnrnfjePZj0/TTLRlU2aE3h0Qhh6gGrpkUGGdhz3WFflZD3A8eo9tQi
         JsYx7egYgQ7IRRAIx2WVS+YYiirhWkHlfVOn8=
Received: by 10.224.37.2 with SMTP id v2mr3585793qad.133.1238402886043;
        Mon, 30 Mar 2009 01:48:06 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 4sm5548560qwe.25.2009.03.30.01.48.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 01:48:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.303.g63699
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115108>

'git diff --interactive' already provides a prompt so
we should inhibit the difftool-helper prompt by default.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Based on top of [PATCH v2] difftool.prompt
and Ping's 'git diff --interactive' patch.

This is just an example of what we'd need to change
in git-difftool if git-diff grew --interactive.

 git-difftool.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 985dfe0..0e1efe6 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -53,6 +53,11 @@ sub generate_command
 			$skip_next = 0;
 			next;
 		}
+		if ($arg eq '--interactive') {
+			$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+			delete $ENV{GIT_DIFFTOOL_PROMPT};
+			# pass-through
+		}
 		if ($arg eq '-t' || $arg eq '--tool') {
 			usage() if $#ARGV <= $idx;
 			$ENV{GIT_DIFF_TOOL} = $ARGV[$idx + 1];
-- 
1.6.2.1.303.g63699
