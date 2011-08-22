From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 0/2] fast-import: tag any object by sha1
Date: Mon, 22 Aug 2011 18:10:17 +0600
Message-ID: <1314015019-6636-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 14:08:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvTIo-000141-Sh
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 14:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764Ab1HVMIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 08:08:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45035 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab1HVMIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 08:08:21 -0400
Received: by bke11 with SMTP id 11so3606489bke.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Oe6tMaHZ7Zj4jD8vnya6w/gDv0yI1J+95nVS8muYuUc=;
        b=lnAUPfS5HqWFjn0XjnRB0bXokEJcpKhPT+tOzGc0+9RyoqNbbZu8HZZcAo19EKlLcV
         2ex6ls4YPumkWAVTLrr5Xpyndk8wyYL5hcimHaQPqUwwS0ZLw4CD6MDr5/uGwip+uEtA
         1Vhk2Svm7iyDuNjJSaUdCEHm84inc+Nihjes8=
Received: by 10.204.156.144 with SMTP id x16mr910061bkw.320.1314014899428;
        Mon, 22 Aug 2011 05:08:19 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zy5sm1908953bkb.64.2011.08.22.05.08.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Aug 2011 05:08:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179856>

fast-export can export annotated tags that annotate any type of object.
It specifies objects via mark references and fast-import accepts this.

fast-import also allows to specify objects via sha1, and to query sha1
for a object being imported. So it should allow to tag a pre-existing
or being-imported objects by their sha1. And it currently does not:
- for pre-existing it kind of assumes it is a OBJ_COMMIT, read_sha1_file()s
  and checks only for (size >= 46), weird
- for being-imported objects it calls read_sha1_file too and fails

Just make it produce expected tags in these cases. Add a test for this.

Dmitry Ivankov (2):
  fast-import: add tests for tagging blobs
  fast-import: allow to tag newly created objects

 fast-import.c          |   14 +++++-----
 t/t9300-fast-import.sh |   67 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 7 deletions(-)

-- 
1.7.3.4
