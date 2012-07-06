From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/9] vcs-svn: use constcmp instead of prefixcmp
Date: Fri, 6 Jul 2012 12:18:38 -0500
Message-ID: <20120706171838.GE31001@burratino>
References: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
 <CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
 <20120607003904.GB4065@burratino>
 <7vtxynk81p.fsf@alter.siamese.dyndns.org>
 <20120706171040.GA31001@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 19:18:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnCB7-0006Nc-GB
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 19:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757958Ab2GFRSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 13:18:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50174 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757920Ab2GFRSn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 13:18:43 -0400
Received: by yhmm54 with SMTP id m54so9627103yhm.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bcWDZkoy1VFf+2UvV3Fdf/FcHxVC1/yNVpaWViZxhF8=;
        b=yG0kCIqPJllWXTQVoYB94lkcdvSynNPpopQpiEiJ9RK/F19ijXw8rYH4U74fkj/v4W
         R9ifMEZi2wKeTmPqJzMXEyTCaVnfUzsRhOJSJSTdPwTLwriTK/UDEahCLksNhZbHSW8L
         mBKCaVWlZMOwgkUFZRxfyVTMJiEXsuhP8lz245I8uxfdwduFEaX0KMXIM2Kc/VSY7Amw
         ZFlF9nB8HlzycLu2JECri9e02xEwp5F33IDaFeyfMhRq+KQtQD/PtiCIKx+OLwtjnixW
         L9CjxIXY8ZCrAOS7q+HJm0sl4R3ehSyhD1IaG1tVtgqOxFjNbDG3TPkYGqiPupOJXNin
         VT0A==
Received: by 10.50.94.133 with SMTP id dc5mr3115784igb.16.1341595122130;
        Fri, 06 Jul 2012 10:18:42 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wp10sm5973034igb.6.2012.07.06.10.18.41
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 10:18:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120706171040.GA31001@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201128>

From: David Barr <davidbarr@google.com>
Date: Fri, 1 Jun 2012 00:41:27 +1000

Since the length of t is already known, we can simplify a little by
using memcmp() instead of strncmp() to carry out a prefix comparison.
All nearby code already does this.

Noticed in the standalone svn-dump-fast-export project which has not
needed to implement prefixcmp() yet.

Signed-off-by: David Barr <davidbarr@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Description clarified.  No other change.

 vcs-svn/svndump.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index f6c0d4c8..c5d07a66 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -361,7 +361,7 @@ void svndump_read(const char *url)
 			reset_rev_ctx(atoi(val));
 			break;
 		case sizeof("Node-path"):
-			if (prefixcmp(t, "Node-"))
+			if (constcmp(t, "Node-"))
 				continue;
 			if (!constcmp(t + strlen("Node-"), "path")) {
 				if (active_ctx == NODE_CTX)
-- 
1.7.10.4
