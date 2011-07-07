From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC 2/3] mingw: fix compilation of poll-emulation
Date: Thu,  7 Jul 2011 13:43:08 +0200
Message-ID: <1310038989-5724-3-git-send-email-kusmabite@gmail.com>
References: <1310038989-5724-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 13:43:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QemzS-000089-Rz
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 13:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050Ab1GGLnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 07:43:23 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55032 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755975Ab1GGLnW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 07:43:22 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so280265eyx.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jM4L5hEhph05yvPb00yZaFWmouvOOH7aWdd4AaRzsK0=;
        b=NJj/QZWvY8ogP3TqlMHdkvAly7lkJOSCE/ZZGHNyR/oPOpEq5UwuDpo9bOHcnlK6F0
         djMy2I9VrVjaxPkPrOZBg+aTOam2vRoy91OIUjSp+ceClEYED8TZtJSg5t4+/h/6uKaN
         u+WYwRMC/Xh8XRo800RUnBQtwNPhJW5sVLZg8=
Received: by 10.14.10.74 with SMTP id 50mr216587eeu.57.1310039001503;
        Thu, 07 Jul 2011 04:43:21 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id f6sm6942715eef.14.2011.07.07.04.43.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jul 2011 04:43:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.4055.gbf1a7
In-Reply-To: <1310038989-5724-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176757>

gnulib has changed the inclusion of poll.h from double quotes
to single-quotes. But because compat/win32/sys/ isn't in our
include-path, this breaks compilation. Change it back the way
it was.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Ugh, I don't like this so much; this means that 1/3 is left in a
broken state, which is a bit nasty for bisection. But this is the
only way I can think of to show what are upstream-changes and what
are git-specific.

An alternative is to move Windows' poll emulation out of the 'sys'
folder, and enable the NO_SYS_POLL_H-switch for MinGW and MSVC
builds.

I'm sure what best approach is. Input, anyone? :)

 compat/win32/sys/poll.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/win32/sys/poll.c b/compat/win32/sys/poll.c
index 403eaa7..225ddce 100644
--- a/compat/win32/sys/poll.c
+++ b/compat/win32/sys/poll.c
@@ -29,7 +29,7 @@
 #include <sys/types.h>
 
 /* Specification.  */
-#include <poll.h>
+#include "poll.h"
 
 #include <errno.h>
 #include <limits.h>
-- 
1.7.6.135.ge14e3f
