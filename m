From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v3 0/4] Enhance encoding support.
Date: Mon, 13 Oct 2008 12:12:30 +0400
Message-ID: <1223885554-27718-1-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 10:15:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpIaS-0003Qq-Im
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 10:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593AbYJMIOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 04:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756584AbYJMIOW
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 04:14:22 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:21158 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572AbYJMIOU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 04:14:20 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1550920fkq.5
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 01:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KVKGglnPtYTAv7VH1mcD/bp2cIPUH5ygwoU1xGLSpgE=;
        b=GdbloxRKHdpKfX7iPXSXCnQd601InuMyWF+ILKFi6BUh4VMwVrb65la72/ravhot2P
         YCGbGKtmTGUV2LwUJAReqnEX4oG5NtFiGcPM4RQoyZprRg5GVwKPYR/I670AE7g7g84I
         iB6kywR2tRM6SzqD20xF7tJHSk6pMY8dXez5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mAx6WjOQiUuM9fem4nSuk7MbYn62jCT/CqKhkzodlbS1VK71h8JdQJe3xvpXtmijB9
         H5vwbYbr/CeuCT+wK8NzGdctUZ+OeeP79WCWRQGXnr1gObpUkjaZBTsLmuvOFIIi7Tbe
         8VtwLap17B0y/x5HxLPe3oum98x1IMA49qFy0=
Received: by 10.181.134.12 with SMTP id l12mr4206036bkn.80.1223885656236;
        Mon, 13 Oct 2008 01:14:16 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm6128723fks.6.2008.10.13.01.14.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 01:14:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98090>

Currently GUI tools don't provide enough support for
viewing files that contain non-ASCII characters. This set of
patches addresses this issue. The git-gui part of the series
is based on patches that were in the 'pu' branch of the
git-gui repository.

UPDATE: the git-gui part of the series is in master.

File encoding can be specified in the following ways:

1) It defaults to the current locale encoding.
2) It can be overridden by setting the gui.encoding option.
3) It can be further set on per-file basis by specifying
   the 'encoding' attribute in gitattributes.
4) Finally, git-gui allows directly selecting encodings
   through a popup menu.

Since git apparently cannot work with filenames in non-locale
encodings anyway, I did not try to do anything about it apart
from fixing some obvious bugs.


CHANGES v2:

- Wrote better comments for the first three patches.
- Added a patch to speed up loading of very large diffs.

CHANGES v3:

- Killed get_cached_encoding, replacing it with get_path_encoding.
- Squashed file name and content patches into one.
- Added the tcl_encoding reimplementation patch. I should
  say that without the second cache this really makes a
  difference with thousand-file diffs.

GITK:
	gitk: Port new encoding logic from git-gui.
	---
	 gitk |   39 ++++++++++++++++++++++++++++++++++++---
	 1 files changed, 36 insertions(+), 3 deletions(-)

	gitk: Enhance file encoding support.
	---
	 gitk |   35 +++++++++++++++++++++++++++--------
	 1 files changed, 27 insertions(+), 8 deletions(-)

	gitk: Implement batch lookup and caching of encoding attrs.
	---
	 gitk |   35 ++++++++++++++++++++++++++++++++++-
	 1 files changed, 34 insertions(+), 1 deletions(-)

	gitk: Optimize encoding name resolution using a lookup table.
	---
	 gitk |   84 ++++++++++++++++++++++++++++++++++++++++++-----------------------
	 1 files changed, 54 insertions(+), 30 deletions(-)
