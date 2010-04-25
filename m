From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v2 0/3] pretty: format aliases
Date: Sun, 25 Apr 2010 22:56:16 +0100
Message-ID: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 25 23:57:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O69pb-00025t-34
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 23:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab0DYV5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 17:57:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59529 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab0DYV5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 17:57:22 -0400
Received: by wyg36 with SMTP id 36so881071wyg.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 14:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=56QYVDY0LbtueXaLkjzNSQ0CGOsPof9ZeN2ru1Bk2B0=;
        b=aWGPe/8Yjxdt1wCt/vi7BqvDpx2QL86L9achD5Yl6RsoI1+bwUgb3ddT6zIWbZo1Ob
         VotHC+iPOQVc3GOgJ0+aKSUupNrrJaWt/4jgz7IBTrAOcpUmuiV6MZSqBv3KFNPzkhm5
         ZrpgnN9J1CQUJ8hPfPOabMh9zRkZoGWmxELa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uEAPsiLlHkcDRUaI/ZN3fuyYRxd+ZO3dFjbzIq+jXPcOrMJgDDhCASnqeiev57l/Nu
         a7Hnqcepl4Ok6cGSb8ZsgfJzR1cZVFLVASGY5bph2Loyl6pyOJDty3d+aD9ByhOfR8D2
         0c6aZVN27725sWnwSgI1A5dm4LGWWfHTymnIw=
Received: by 10.216.88.134 with SMTP id a6mr4222418wef.66.1272232640410;
        Sun, 25 Apr 2010 14:57:20 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id r29sm16328252wbv.9.2010.04.25.14.57.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 14:57:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145769>

The following patch series adds the ability to configure aliases for
user-defined formats. The first two patches define new placeholders and
modify the output of existing placeholders to allow aliases to be more
consistent with the way builtin formats are handled. The final patch
adds support for the aliases themselves.

There were a couple of places where I wasn't entirely sure about which
color setting I should be following, but I've tried to be consistent
throughout. It may be that I could have simply followed diffopt's color
option in all cases, in which case various modifications to show_log()
were entirely unnecessary. I'll await judgement at the hands of one who
groks those sections more than I do, but I think what I've done feels
correct.

My original goal was to make it possible to define all of the builtin
formats as builtin aliases to format strings, but complications
regarding how --parents and --decorate would be handled require further
thought and discussion. For example, we could simply make
"--format=%H --decorate" synonymous with "--format=%H%d", but I'm not
sure if that feels clean enough.

For now, I think this is at a point where its good-enough to submit, if
only as a starting point for some discussion as to where to head next.

This is the second version of the patch. Following feedback from Jeff
King <peff@peff.net>, I realized that the modification to the arguments
of show_log() were unnecessary, as they only made a difference within
show-branch.c, which does not accept a --format option in any case.

Will Palmer (3):
  pretty: add conditional %C?colorname placeholders
  pretty: make %H/%h dependent on --abbrev[-commit]
  pretty: add aliases for pretty formats

 Documentation/config.txt         |    8 ++
 Documentation/pretty-formats.txt |    1 +
 builtin/log.c                    |    2 +-
 builtin/rev-list.c               |    2 +
 builtin/shortlog.c               |    7 +-
 commit.h                         |    2 +
 log-tree.c                       |    3 +
 pretty.c                         |  248 ++++++++++++++++++++++++++++++--------
 shortlog.h                       |    2 +-
 t/t4205-log-pretty-formats.sh    |   87 +++++++++++++
 10 files changed, 307 insertions(+), 55 deletions(-)
 create mode 100755 t/t4205-log-pretty-formats.sh
