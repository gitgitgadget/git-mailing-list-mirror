From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 26/28] rebase: cherry-pick: add merge options
Date: Fri, 30 Aug 2013 00:56:20 -0500
Message-ID: <1377842182-18724-27-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:02:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmf-0007iQ-J5
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab3H3GCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:02:08 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:63418 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3H3GCH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:02:07 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so1758172oag.24
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ef6D2hxxqfpJgNIq1bJ9Pq/Eb4e1wC61dNRXwhzFh60=;
        b=n5jOi4rugxb2bglIjlXaMJyBXUjeajNX69zEkKu2fOI9u4bYCbXPsjxPzZS7m3QjDW
         ebQIe89tBBWFzDb4qMlQGZdGQObBkdLaik7BeGDbIc+2WK2K5HSBXwG5MSk0tL+iNeN1
         uGFumakMYqzopwUhwOcWoGQz07dOK7+OY76BBSRkNK0afsXe9HklW88w5akKrSfXfTfT
         g7TJfMPf1GpVTOt/rslycnDXB4AAoObuZcCv7FNe+nXtO9omNYgInLfOItr8WsLzlAsW
         HSLtPPJKsVVSilrS2mk2TNNFYuRqdorjh8Dw9At1uhakCfV5YKzwCOmiVzS9M0H59P/y
         r8+A==
X-Received: by 10.182.130.131 with SMTP id oe3mr5537701obb.34.1377842526871;
        Thu, 29 Aug 2013 23:02:06 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm35726977obc.10.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:02:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233417>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index d36b0dc..bda7cfc 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -45,6 +45,15 @@ else
 fi
 test -n "$GIT_QUIET" && extra="$extra -q"
 test -z "$force_rebase" && extra="$extra --ff"
+test -n "$strategy" && extra="$extra --strategy=$strategy"
+for x in "$strategy_opts"
+do
+	test -z "$x" && continue
+	x=$(eval "echo $x")
+	extra="$extra -X${x#--}"
+done
+test -n "$allow_rerere_autoupdate" && extra="$extra $allow_rerere_autoupdate"
+
 git cherry-pick --no-merges --right-only --topo-order --do-walk --action-name rebase $extra "$revisions"
 ret=$?
 
-- 
1.8.4-fc
