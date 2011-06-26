From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [RFC 0/2] push checks for unpushed remotes in submodules
Date: Sun, 26 Jun 2011 20:29:45 +0200
Message-ID: <1309112987-3185-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, iveqy@iveqy.com, hvoigt@hvoigt.net,
	jens.lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 26 20:32:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qau83-0000xI-08
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 20:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab1FZSbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 14:31:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59911 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658Ab1FZS3f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 14:29:35 -0400
Received: by bwd5 with SMTP id 5so775660bwd.19
        for <git@vger.kernel.org>; Sun, 26 Jun 2011 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer;
        bh=6Aan/kzyGMl9ekdlqsTJrLJ867efD7SGPUA0Dt0kWpU=;
        b=w+2ZNy9abqyk7ypozSGN2kimKtBALH2N38QLGVcvaDl1jF6+bbZO4AR9eTEs1XCJ+Y
         agaZVB0SPmhsIsSo6+Bk5MWhplyBDogo371cn2GMEmtlyHaOUjExOX2IjFfbPkt5acuk
         CUGdh5oRVqrfgqpgjOUl4DKP0tVh0szbsAPXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=m0P+tMrsBIYX3jcnFjnpnXI8JE7PfOuanaR0w3XckF0TVfFtzjzSlPBI+xzVpFplxa
         oqqRNzQdiFXNg2enL1ZwhuFcS88N0NexwxuIRs0jyI7bHESRt7lawAaV+GByVNh/lASI
         YzSYC42bPwTHZlLY3FFoQhIkYfQcDrRjRVhX8=
Received: by 10.205.35.1 with SMTP id su1mr3626950bkb.129.1309112974098;
        Sun, 26 Jun 2011 11:29:34 -0700 (PDT)
Received: from kolya (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id v6sm3473845bkf.11.2011.06.26.11.29.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Jun 2011 11:29:33 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1Qau5h-0000q3-AM; Sun, 26 Jun 2011 20:29:53 +0200
X-Mailer: git-send-email 1.7.6.rc3.2.g0185a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176328>

When working with submodules it is easy to end up in a state when submodule
commits required by the super-project only is present locally. This is most
often a human error (although technical errors such as connection failure
can be a reason).

This patch-series tries to prevent pushing a super-project if not all (by
the super-project used) submodules are pushed first. This will prevent the
human error of forgetting to push submodules before pushing the
super-project.

This is a RFC-series, please consider:
* Is this going into the right direction?
* Should we use a new flag similar to REF_STATUS_REJECT_NONFASTFORWARD?

Future improvements could be:
* Make git status aware of unpushed submodules.
* Show a list of unpushed submodules when a push is denied.

Fredrik Gustafsson (1):
  Don't push a repository with unpushed submodules

Heiko Voigt (1):
  test whether push checks for unpushed remotes in submodules

 submodule.c                    |   79 ++++++++++++++++++++++++++++++++++++++++
 submodule.h                    |    1 +
 t/t5531-deep-submodule-push.sh |   68 ++++++++++++++++++++++++++++++++++
 transport.c                    |    8 ++++
 4 files changed, 156 insertions(+), 0 deletions(-)

-- 
1.7.6.rc3.2.g0185a
