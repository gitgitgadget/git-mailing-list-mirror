From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3] enter_repo(): fix docs to match code
Date: Wed,  1 Apr 2015 02:10:20 +0800
Message-ID: <1427825420-406-1-git-send-email-pyokagan@gmail.com>
References: <xmqq4mp1rrwj.fsf@gitster.dls.corp.google.com>
Cc: Git List <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 20:10:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd0co-00070V-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 20:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbbCaSKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 14:10:45 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33776 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbbCaSKo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 14:10:44 -0400
Received: by pdrw1 with SMTP id w1so19968992pdr.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fkS5ZuW4pbxLdKyrvE9B51MgmpMorSpghpc3RY4eq2g=;
        b=oNjHG8INoR30Nn1mq+2t+LUYSbJgUP2bzqHS+dv9iK21NrEiMuZ4LBcjh4OBODjuN4
         7SHhAqIJZTInzt5QdVsXGkURaBxGeQSSipIRSIti0aMkV34w4l1d5ywE7vYEc820xdz9
         IR2BNkLftBAaQ1IHiXVO2yXqdihquO6fHL7ltHieEK6EaoULmaYe9BdryY2f0uvwqor6
         TjlHKA29O0dcuBfinmX5WZUVFEPAxmbQcSN/XFqw+E4F4IL90hOmKvTa8jVGyCharRW9
         sBQTptaapMIclFIfCWO0usOU1cBTUnpQROfmwbf26t1PKpWbzONTChQ4YepVQgnf2dUt
         hzbw==
X-Received: by 10.70.28.5 with SMTP id x5mr71116343pdg.13.1427825444320;
        Tue, 31 Mar 2015 11:10:44 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.172.217])
        by mx.google.com with ESMTPSA id x3sm14635584pdo.0.2015.03.31.11.10.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2015 11:10:42 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1Yd0cZ-00008s-S5; Wed, 01 Apr 2015 02:10:39 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <xmqq4mp1rrwj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266543>

Hi,

On Wed, Apr 1, 2015 at 1:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> It appears to me that Peff's "squash" is nullifying everything you
> did, so a more truthful attribution might be
>
>         From: Jeff King <peff@peff.net>
>
>         commit log message
>
>         S-o-b: Jeff
>         S-o-b: Paul Tan

Thanks, didn't know that could be done. Fixed patch (and fixed scissors line) below,

-- >8 --
From: Jeff King <peff@peff.net>

In b3256eb (standardize and improve lookup rules for external local
repos), enter_repo() was modified to use a different precedence ordering
of suffixes for DWIM of the repository path, and to ensure that the
repository path is actually valid instead of just testing for existence.
However, the documentation was not modified to reflect these changes.
As such, fix the documentation to match the code.

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
