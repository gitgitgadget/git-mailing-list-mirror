From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/7] refs: add a "for_each_replace_ref" function
Date: Fri, 23 Jan 2009 10:06:38 +0100
Message-ID: <20090123100638.29039543.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 10:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQI0y-0007cf-Cb
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 10:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbZAWJGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 04:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753873AbZAWJGX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 04:06:23 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:33274 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbZAWJGV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 04:06:21 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id AC0A594019A;
	Fri, 23 Jan 2009 10:06:13 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id AE6759401AC;
	Fri, 23 Jan 2009 10:06:10 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106860>

This is some preparation work for the following patches that are using
the "refs/replace/" ref namespace.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 refs.c |    5 +++++
 refs.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

	Here is a new patch series. I only fixed what Junio reported
	as bugs (thanks) and added a global switch to forbid the
	replacement for connectivity walkers. I added a few test
	cases for the latter, but I may be missing a lot of things.

diff --git a/refs.c b/refs.c
index 33ced65..042106d 100644
--- a/refs.c
+++ b/refs.c
@@ -632,6 +632,11 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/remotes/", fn, 13, cb_data);
 }
 
+int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref("refs/replace/", fn, 13, cb_data);
+}
+
 /*
  * Make sure "ref" is something reasonable to have under ".git/refs/";
  * We do not like it if:
diff --git a/refs.h b/refs.h
index 06ad260..8d2ee5a 100644
--- a/refs.h
+++ b/refs.h
@@ -23,6 +23,7 @@ extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_tag_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
+extern int for_each_replace_ref(each_ref_fn, void *);
 
 /*
  * Extra refs will be listed by for_each_ref() before any actual refs
-- 
1.6.1.231.g9c286
