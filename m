From: "Kevin Leung" <kevinlsk@gmail.com>
Subject: [PATCH] git-stash: Display help message if git-stash is run without sub-commands
Date: Fri, 30 Nov 2007 16:16:34 +0800
Message-ID: <e66701d40711300016v15700deft3d262d75a9055aca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git ML" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nanako Shiraishi" <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 09:17:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy13T-0004eb-Bi
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 09:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934325AbXK3IQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 03:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934279AbXK3IQi
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 03:16:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:50434 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934140AbXK3IQg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 03:16:36 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2166747nfb
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 00:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=icpDFb0YtjcFB+pigN4otXGEYp6MiMR1LxHPPL7xi/4=;
        b=XGETTp5kHTEPYF4OsAJO3bAFbqPrcZXcUCGyz01LrJSUB8ZESfJWlsix39dA32l9cFyQpSc9kZjoVmCo7CG5sTCAZafLjiiG1a96hpwRak+4cOtSmW/arkJIa0W9SintCYTKct9vEuJXd4XjRRhzWzIpWGdwin6HeN8kUsHCTfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qEPa9ZX/jdA2iGVKc2KFyDqu1zjGlDLO3cdtNlJvDR26XI6rB6zfDAZxjXYKCYDVf+CUK0kEAtoWpV6o0qvY2hC1H5EFNIY9FgncTOxj7ST5elFthnEZSIiGe8rcWP/PTgNMwuzks4mu/+j1K4hEWvqu2fyAnYRwoSqCB+6yjUA=
Received: by 10.78.134.2 with SMTP id h2mr8345528hud.1196410594942;
        Fri, 30 Nov 2007 00:16:34 -0800 (PST)
Received: by 10.78.57.2 with HTTP; Fri, 30 Nov 2007 00:16:34 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66624>

The current git-stash behaviour is very error prone to typos. For example,
if you typed "git-stash llist", git-stash would thought that you wanted to
save to a stash named "llist", but in fact, you meant "git-stash list".

Signed-off-by: Kevin Leung <kevinlsk@gmail.com>
---
 git-stash.sh |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 77c9421..dbb8894 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2007, Nanako Shiraishi

-USAGE='[ | list | show | apply | clear]'
+USAGE='[ save | list | show | apply | clear ]'

 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -195,6 +195,10 @@ show)
        shift
        show_stash "$@"
        ;;
+save)
+       shift
+       save_stash "$@" && git-reset --hard
+       ;;
 apply)
        shift
        apply_stash "$@"
@@ -202,14 +206,7 @@ apply)
 clear)
        clear_stash
        ;;
-help | usage)
-       usage
-       ;;
 *)
-       if test $# -gt 0 && test "$1" = save
-       then
-               shift
-       fi
-       save_stash "$*" && git-reset --hard
+       usage
        ;;
 esac
-- 
1.5.3.6.36.g38762
