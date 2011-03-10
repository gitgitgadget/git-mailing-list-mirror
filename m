From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 0/5] support --exclude for diff/log commands
Date: Thu, 10 Mar 2011 10:13:34 +0700
Message-ID: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 04:14:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxWKx-0008J2-8y
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 04:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab1CJDOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2011 22:14:46 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:65111 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab1CJDOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 22:14:45 -0500
Received: by gwaa18 with SMTP id a18so255825gwa.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 19:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=ry7aRQeDU231GP+gEbN+YCncOnkg3t6WTqm1su1ZBQY=;
        b=xrURqLjTYgiowt04iAzN4cjFVp27mYOb1Z3tqBSQsy9g/+48/3Lsy/Ln67zzI4kbhS
         5gTfoLfZhw1UMCEGLq6iriL8EYYd2zYCWjs7sGm8kZAbpVSCUJG7EGcDDIMFDuiWMCSG
         FZ4UbmmyJyxYL4Dn3QsgmEwNWCOLs5jEab8Po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=dXnfsjgzw5fjve1lAWwb9jxW5fb0BIRdOH2SIeDs9O9hL1wadwqdQGPWP/ONLwIpCo
         VpLe24Q+tj9Nr3OZ30QQ6e8pG4zqJW44mHmwyZNtH3UO8+BnKXNe7txnzQAeyKzvfXjC
         Vj+wwOVfTZGOLPM+Kwofq1cHRthk4Vci6QWZg=
Received: by 10.150.199.6 with SMTP id w6mr326647ybf.94.1299726884471;
        Wed, 09 Mar 2011 19:14:44 -0800 (PST)
Received: from pclouds@gmail.com ([118.69.34.31])
        by mx.google.com with ESMTPS id w19sm2639995ybe.22.2011.03.09.19.14.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 19:14:43 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 Mar 2011 10:13:40 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168780>

This is not really ready for review or use, but I'd like to have
feedback if any, where this series is heading because it requires some
code refactor in diff/rev machinery. It does not feel absolutely right
to me.

On the other hand, if we go with ':' as a mark of special pathspecs, th=
en

 - ":/" mark pathspecs relative to worktree root
 - ":!" may mark negative pathspecs

Less changes in diff/rev this way.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  tree-walk: support negative pathspec
  match_pathspec_depth: support negative pathspec

match_pathspec_depth needs work. tree_entry_interesting() can use some
optimization, but leave it for now.

  revision.c: get rid of struct rev_info.prune_data
  diff: refactor init/release API

These two facilitate post pathspec manipulation to transform --exclude
to pathspecs with to_exclude =3D 1.

  diff: support --exclude

 Documentation/technical/api-diff.txt |    2 +-
 builtin/add.c                        |    3 +-
 builtin/blame.c                      |   22 +++++----------
 builtin/diff.c                       |    6 ++--
 builtin/fast-export.c                |    2 +-
 builtin/merge.c                      |    2 +-
 builtin/reset.c                      |    4 +-
 cache.h                              |    1 +
 diff-lib.c                           |    6 ++--
 diff-no-index.c                      |    6 ++--
 diff.c                               |   49 ++++++++++++++++++++++++++=
++++++-
 diff.h                               |    6 ++--
 dir.c                                |    5 +++
 merge-recursive.c                    |    2 +-
 notes-merge.c                        |    8 +++---
 patch-ids.c                          |    2 +-
 revision.c                           |   22 ++++++++-------
 revision.h                           |    1 -
 tree-diff.c                          |   21 +++------------
 tree-walk.c                          |   37 +++++++++++++++++++------
 wt-status.c                          |    6 +---
 21 files changed, 130 insertions(+), 83 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
