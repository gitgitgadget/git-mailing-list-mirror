From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/RFC 0/2] fast-import: commit from null_sha1
Date: Mon, 19 Sep 2011 03:20:44 +0600
Message-ID: <1316380846-15845-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 23:14:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5OhO-0007FT-Bw
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517Ab1IRVOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 17:14:34 -0400
Received: from mail-wy0-f170.google.com ([74.125.82.170]:38777 "EHLO
	mail-wy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932366Ab1IRVOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 17:14:33 -0400
Received: by wyg8 with SMTP id 8so8299412wyg.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=JtKlCOFuA/LvjccvjPbcuOalMAbXLV+4N9tqCeHkdA8=;
        b=bG/esftw68GJs8Lv2YM268MPonocDUPEETd/yeruBni77O9SMf1UdICAB9VsDvpyas
         DXXBssweAqcVJ6R5a271JksVmoUnlv6+uTVukeXFWHxQ6Axk1d4xPJRWrcnpVHEU8rrX
         xX4PvBVC6jeGiaLpoLkFyF9uZoso1YI/7QRTI=
Received: by 10.227.201.133 with SMTP id fa5mr856596wbb.91.1316380472152;
        Sun, 18 Sep 2011 14:14:32 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id gd6sm22990486wbb.1.2011.09.18.14.14.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 14:14:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181639>

Not so sure how null_sha1 parent should be treated in fast-import.
Absent parent is represented as null_sha1 to the user in reflog,
but isn't allowed as an argument for porcelain nor shows in most
plumbing commands afaik.

These patches make fast-import treat
    commit refs/heads/master
    ...
    from `null_sha1`
like any other missing parent sha1 - reject such input.

Note: if we'll want this input to be valid, some other adjustments
to fast-import logic may be needed for consistency.

Dmitry Ivankov (2):
  fast-import: add 'commit from 0{40}' failing test
  fast-import: fix 'from 0{40}' test

 fast-import.c          |   17 ++++++-----------
 t/t9300-fast-import.sh |   12 ++++++++++++
 2 files changed, 18 insertions(+), 11 deletions(-)

-- 
1.7.3.4
