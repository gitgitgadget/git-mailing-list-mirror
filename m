From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH/RFC 0/3] teach fetch --prune
Date: Fri,  6 Nov 2009 00:10:38 -0500
Message-ID: <1257484241-27219-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 06:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6H6L-0006dc-Gu
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 06:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbZKFFK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 00:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbZKFFK5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 00:10:57 -0500
Received: from mail-qy0-f174.google.com ([209.85.221.174]:57600 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbZKFFK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 00:10:57 -0500
Received: by qyk4 with SMTP id 4so333511qyk.33
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 21:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vosuu3GJcPbEXxBwq1zxVBw8XWIjHlE65RkAtTes0/E=;
        b=nCrsV8Sdc0jq6QBSPdz9VMjpq5GA5tbm7HwiTa2PmhzVhheBGkFWoCD2UwXSuKqyVx
         j+8IdL6tkmvVdiUyP6V1nWkuhGyIyZp2Hswa5rdWBJJP0BLmHtyPVxIx4chPcHf9XFgo
         Jzlm8W6SVbsjU17HoFDozD7F5s37hJR3Be9kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=S544udORSGT/aQDMzItfRGXiCpHCYvWL4UwUXTSsuqQbfDnGCHdZl7mC3fY/U+cjL1
         pvrSTHpppfNvqepaBnq9nLOQLVyWOz9x6JG1cWNN4BAyR4dLYrDMukRkVHeAcF7girNB
         adx0dniYLp/4mCTmCg+0KPI0pVpuIXJx5tPZI=
Received: by 10.224.116.212 with SMTP id n20mr2115484qaq.172.1257484262623;
        Thu, 05 Nov 2009 21:11:02 -0800 (PST)
Received: from localhost (cpe-069-134-096-008.nc.res.rr.com [69.134.96.8])
        by mx.google.com with ESMTPS id 21sm1047445qyk.8.2009.11.05.21.11.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 21:11:02 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132271>

This is just a start so I can get some feedback. Some things still missing:

1) "git remote prune <remote>" calls warn_dangling_symref(), but 
"git fetch --prune" does not. I ran out of time tonight to refactor 
warn_dangling_symref() to do something more intelligent than just spew to
stdout (which doesn't get along with fetch, which spews to stderr...).

2) Perhaps "git remote update --prune" should be refactored to call 
"git fetch --prune". If so, then fetch should gain a "--prune-only" option
so that "git remote prune" can just call "got fetch --prune-only".

3) Perhaps add a config option for users who wish to prune by default.

Thoughts, comments, flames?

Jay Soffian (3):
  remote: refactor some logic into get_stale_heads()
  builtin-fetch: add --dry-run option
  builtin-fetch: add --prune option

 builtin-fetch.c  |   30 +++++++++++++++++++++++++++---
 builtin-remote.c |   32 ++++++++------------------------
 remote.c         |   40 ++++++++++++++++++++++++++++++++++++++++
 remote.h         |    3 +++
 4 files changed, 78 insertions(+), 27 deletions(-)
