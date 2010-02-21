From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 6/7] remote-curl: use http_fetch_ref() instead of walker wrapper
Date: Sun, 21 Feb 2010 11:08:27 +0800
Message-ID: <1266721708-1060-7-git-send-email-rctay89@gmail.com>
References: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Cc: "Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 21 04:59:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj2Bt-0004jO-Lj
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 04:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168Ab0BUDI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 22:08:59 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:49688 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757157Ab0BUDI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 22:08:57 -0500
Received: by qw-out-2122.google.com with SMTP id 8so262931qwh.37
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 19:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wzLci8NQEZck/GbSjZ+jCGF8fegwdPKOQTUc7c1OpBo=;
        b=Q4ID84uYkqu4EgU5lwLvatwk65Gnz5wbrhJi9ZxEv5bL7FvbL3iMYwLJG0UG0WXNB8
         +RAYySP8jbXkx49qrUbe4vXK54xOE4fwVggYaIJou8zbZScfaATquO1llR1w9/ZYjxfV
         wC6PlS4sOKiF/Kq6LywBZB+YKOHWDG3x/t9YM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lYnqn/bn9j97lU3VqsIbXeZEB2/yptJfcihTkH5LyW1IQOjzBA2DH6sTwEGzFo2amO
         boXzz0nGU2HX+/ubRCqL0RLxb1L5ML8CBc94WL+FdGqgapPNJWhMsEGNljLfl6cQBxKa
         nxxgb53aIbm0u1uG6soEBZ4AcMVefcJExk/1s=
Received: by 10.224.59.28 with SMTP id j28mr4717149qah.109.1266721736292;
        Sat, 20 Feb 2010 19:08:56 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 22sm1412717qyk.14.2010.02.20.19.08.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 19:08:55 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140591>

The http-walker implementation of walker->fetch_ref() doesn't do
anything special compared to http_fetch_ref() anyway.

Remove init_walker() invocation before fetching the ref, since we aren't
using the walker wrapper and don't need a walker instance anymore.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 remote-curl.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 1e13fb5..5ace99e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -250,9 +250,8 @@ static struct ref *parse_info_refs(struct discovery *heads)
 		i++;
 	}
 
-	init_walker();
 	ref = alloc_ref("HEAD");
-	if (!walker->fetch_ref(walker, ref) &&
+	if (!http_fetch_ref(url, ref) &&
 	    !resolve_remote_symref(ref, refs)) {
 		ref->next = refs;
 		refs = ref;
-- 
1.7.0.26.gbfa16
