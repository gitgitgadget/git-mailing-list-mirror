From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/47] remote-hg: update bookmarks when pulling
Date: Mon, 13 May 2013 23:36:31 -0500
Message-ID: <1368506230-19614-9-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:39:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc717-0003uB-Cc
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085Ab3ENEjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:06 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:48580 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3ENEjF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:05 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so103792oag.2
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=SrIhD/ZpPRFfuy31IvlDXqg1HRqjYQ9PT8EhMm/09uA=;
        b=wi3XrETz6gQdtiF0Jwxk31WVtXgkGTwUIGjhXw1VuFQdtmEC9mMUVI4R/ut4P+qfyM
         UhkJ/m9nnNZXutljFW+ReJ3zMVQ+O7yNQpiS7tNvklWbAFo7MVK6GeRqAq6vNS4wL2y0
         4t9nTBnu9ObIxp5m4rU9ppNvyyaRgZ+3xJ5wrsrFhPru8i5O54jpFWIQ1R0SflRSpP27
         0XMzCoY61iXqk3vAlJVXdLdTRl2z7viWmKsF5SvETWEgmK/9YyEcflwLmjNeH4qx3vTo
         ke12K+JS9UMjv+vLRFvIdgzPsUOXmhOOjmfDZp0Xc0KQIR5lm4d/zaBKJ8yA5J5upVyF
         WIGg==
X-Received: by 10.60.16.69 with SMTP id e5mr15390254oed.46.1368506344912;
        Mon, 13 May 2013 21:39:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n6sm20469002oel.8.2013.05.13.21.39.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224243>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index beb864b..dc276af 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -363,6 +363,9 @@ def get_repo(url, alias):
                 die('Repository error')
             repo.pull(peer, heads=None, force=True)
 
+        rb = peer.listkeys('bookmarks')
+        bookmarks.updatefromremote(myui, repo, rb, url)
+
     return repo
 
 def rev_to_mark(rev):
-- 
1.8.3.rc1.579.g184e698
