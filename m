From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 0/4] setenv/putenv errors
Date: Wed, 14 Dec 2011 15:07:07 +0100
Message-ID: <1323871631-2872-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, gitster@pobox.com, schwab@linux-m68k.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 15:07:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RapUW-0001cC-D4
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309Ab1LNOHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 09:07:22 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:65260 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754893Ab1LNOHU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 09:07:20 -0500
Received: by lagp5 with SMTP id p5so326737lag.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 06:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=6Sq7jJ57MrzZWFxK+LJR5tu1yV5oDug2tKH4mga7tSc=;
        b=P5fVMiqDnTP7bc9PfxjSsoZwsHcTyAEidvYX1KyysftCfY6TyGOatepv+n84dqk/Kb
         kMr6EM/tsHTiyguM30TM3P2v/eVmEMdWYF/9x4AjLUYI7JXGHdMgktD/aV0yByfqnvyo
         tjWpF7OIJkK20cpdc07lRD/nxS3Llkk9fvsA4=
Received: by 10.152.132.39 with SMTP id or7mr2456540lab.14.1323871635537;
        Wed, 14 Dec 2011 06:07:15 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id ng10sm2311696lab.13.2011.12.14.06.07.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 06:07:13 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.msysgit.0.272.g9e47e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187112>

Here's v2 of this series. It grew a bit since the last round, as
I figured fixing the error-paths in compat/setenv.c made sense to
do while I was at it, considering how Windows (which is one of
the few likely platforms to be able to actually trigger this
issue) use it.

Erik Faye-Lund (4):
  compat/setenv.c: update errno when erroring out
  compat/setenv.c: error if name contains '='
  wrapper: supply xsetenv and xputenv
  use wrapper for unchecked setenv/putenv calls

 builtin/clone.c      |    2 +-
 builtin/commit.c     |    6 +++---
 builtin/help.c       |    4 ++--
 builtin/init-db.c    |    2 +-
 builtin/merge.c      |    4 ++--
 builtin/notes.c      |    2 +-
 builtin/remote-ext.c |    4 ++--
 builtin/revert.c     |    2 +-
 compat/setenv.c      |   10 ++++++++--
 config.c             |    2 +-
 exec_cmd.c           |    4 ++--
 git-compat-util.h    |    2 ++
 git.c                |   18 +++++++++---------
 pager.c              |    2 +-
 run-command.c        |    2 +-
 setup.c              |    6 +++---
 wrapper.c            |   14 ++++++++++++++
 17 files changed, 54 insertions(+), 32 deletions(-)

-- 
1.7.7.1.msysgit.0.272.g9e47e
