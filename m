From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH 0/3] pretty: format aliases
Date: Sun, 25 Apr 2010 16:42:52 +0100
Message-ID: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 25 17:44:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O640I-0000ZE-H4
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 17:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab0DYPn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 11:43:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37866 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab0DYPn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 11:43:56 -0400
Received: by wyg36 with SMTP id 36so752496wyg.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=4BIE9WSjEOjigCa35pSp2JjuKh6QbDtGj685e5m5KMQ=;
        b=WmCwh4oPTzzJZ/xIXmFktjfFhVbdZNJIUcEyUv/PnhBLDt454QXdGFMOMG1K5QvjVw
         ufkfDnMCNoji4nk3nArPePqB9ofmda2mX94A2VsgNJ7/MXH0S49+HP+xHDHymchyHaAh
         J/7t/X3X4dVzki+Pt5z4ir7w0L462ooh261YA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=flpDKW+hrx4mPVj2TiFpqBOeL3rL4MgIQA/uZs93ykM2PU0SwVCw11b0R0BEjlazv7
         edb9wRQHM3iHTUy3fnrbKiQn1hFO57DFeKBO77vhZs9+8G/IyPQp4pRsPcmC0a3G64VI
         q7sH4wOHb5C8LBL65GSAXeSTU6JaQ4n//ztF8=
Received: by 10.216.87.16 with SMTP id x16mr267728wee.27.1272210234865;
        Sun, 25 Apr 2010 08:43:54 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id x1sm16755457wbx.19.2010.04.25.08.43.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 08:43:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145741>

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

Will Palmer (3):
  pretty: add conditional %C?colorname placeholders
  pretty: make %H/%h dependent on --abbrev[-commit]
  pretty: add aliases for pretty formats

 Documentation/config.txt         |    8 ++
 Documentation/pretty-formats.txt |    1 +
 builtin/log.c                    |    2 +-
 builtin/rev-list.c               |    2 +
 builtin/shortlog.c               |    7 +-
 builtin/show-branch.c            |    1 +
 combine-diff.c                   |   11 +-
 commit.h                         |    2 +
 log-tree.c                       |   11 ++-
 log-tree.h                       |    2 +-
 pretty.c                         |  248 ++++++++++++++++++++++++++++++--------
 shortlog.h                       |    2 +-
 t/t4205-log-pretty-formats.sh    |   87 +++++++++++++
 13 files changed, 321 insertions(+), 63 deletions(-)
 create mode 100755 t/t4205-log-pretty-formats.sh
