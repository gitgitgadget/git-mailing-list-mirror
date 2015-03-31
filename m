From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2] enter_repo(): fix docs to match code
Date: Tue, 31 Mar 2015 21:39:27 +0800
Message-ID: <1427809167-21711-1-git-send-email-pyokagan@gmail.com>
References: <vpqk2xykaiu.fsf@anie.imag.fr>
Cc: Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 15:40:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcwOm-0003IH-EH
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 15:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbbCaNkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 09:40:03 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34190 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbCaNkC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 09:40:02 -0400
Received: by pdbni2 with SMTP id ni2so21233286pdb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZRXdCPcacFIvfY7Bnvv5PpjGVJVMoVUWnLwGAHL3z3c=;
        b=kpW7aq0YRsAaFXff9gctiofyOB4upoopp5lmA3RegQt4DPnF7fOoM70ps/5T+j2QuC
         7HlqcBWcIKJPamdHJiQ61rx1Eom0nvJwiXKYaM1sIKJGabTOCtLDfoKp3WcW3aj4yyhs
         hh9xTNbPXMXHWk1xmetRx5fwCtzhJYQ0zvAcZYR5Jd4YORuMknC+wGqiDn/rDTmtg3+Z
         k4/oKqGRzJuRf2wROuHlos8TnjPbHaTIJil9KySzEYIP1n2+dR7AeVmu5MqX1ytZMK/E
         Orw7QHmgzWRD3w8gMYfjXHvikKIYdi/FfgQIajXQMDaclaOxhH62jng5F+n/NDJxbPQt
         L4vQ==
X-Received: by 10.70.47.102 with SMTP id c6mr10630300pdn.24.1427809201806;
        Tue, 31 Mar 2015 06:40:01 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.172.217])
        by mx.google.com with ESMTPSA id fk4sm13428872pab.48.2015.03.31.06.39.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2015 06:40:00 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YcwOb-0005hB-Dz; Tue, 31 Mar 2015 21:39:57 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <vpqk2xykaiu.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266525>

On Mon, Mar 30, 2015 at 07:44:08AM -0400, Jeff King wrote:
> Yes, this was adjusted in b3256eb (standardize and improve lookup rules
> for external local repos, 2012-02-02), but I failed to update the
> comment.
> 
> Your patch is certainly an improvement, but I think there are more
> inaccuracies in the comment caused by that commit. Maybe squash this on
> top:

Thanks for catching.

I've squashed the patches and rewrote the commit message.

-->8--

In b3256eb (standardize and improve lookup rules for external local
repos), enter_repo() was modified to use a different precedence ordering
of suffixes for DWIM of the repository path, and to ensure that the
repository path is actually valid instead of just testing for existence.
However, the documentation was not modified to reflect these changes.
As such, fix the documentation to match the code.

Documentation contributed by Jeff King.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 path.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/path.c b/path.c
index e608993..595da81 100644
--- a/path.c
+++ b/path.c
@@ -303,14 +303,9 @@ return_null:
  * (3) "relative/path" to mean cwd relative directory; or
  * (4) "/absolute/path" to mean absolute directory.
  *
- * Unless "strict" is given, we try access() for existence of "%s.git/.git",
- * "%s/.git", "%s.git", "%s" in this order.  The first one that exists is
- * what we try.
- *
- * Second, we try chdir() to that.  Upon failure, we return NULL.
- *
- * Then, we try if the current directory is a valid git repository.
- * Upon failure, we return NULL.
+ * Unless "strict" is given, we check "%s/.git", "%s", "%s.git/.git", "%s.git"
+ * in this order. We select the first one that is a valid git repository, and
+ * chdir() to it. If none match, or we fail to chdir, we return NULL.
  *
  * If all goes well, we return the directory we used to chdir() (but
  * before ~user is expanded), avoiding getcwd() resolving symbolic
-- 
2.1.4
