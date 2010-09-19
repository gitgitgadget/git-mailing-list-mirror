From: Clemens Buchacher <drizzd@aon.at>
Subject: Patch id tests and diff performance optimization
Date: Sun, 19 Sep 2010 11:59:26 +0200
Message-ID: <1284890369-4136-1-git-send-email-drizzd@aon.at>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 19 11:59:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxGg3-0005KY-5h
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 11:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab0ISJ7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 05:59:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44960 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0ISJ7N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 05:59:13 -0400
Received: by bwz11 with SMTP id 11so3701062bwz.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer;
        bh=fSaDfWyH9e0oAaw1zJz6aecp1qrO45hrGJ4dKDm/OQk=;
        b=AKbmAJ4RuDkBGjHpZNg4mCSg8p6+w5ftVRcEr7MAV4V4E79oD78UR2/af4cco4bA0R
         BG5iGoL2bseeMXnmf7jnfkOTKgO8/Dzg6QxhzEYItLHhvrB1UhMTfwgCd0R70Dh+wtFK
         VNKfxwDh0P38XFzAn9F6M1KvmHma6kCSpkcIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=AQm61ISXwgAhfWvRsN1riVVH/VgtByw7ifsrJrLpa3XBtr0SDDG7IZy7Ahro9mliJc
         mV4mZPXT9KDfF34r4V2dYMGkmh48pndZTiXMvggqqiVM5Apren/pBsZv8LrybGAuSFGn
         DnW0Y6ekI7iJYmhLIknGuj5IZsxgekq2voKic=
Received: by 10.204.126.205 with SMTP id d13mr5587275bks.126.1284890351675;
        Sun, 19 Sep 2010 02:59:11 -0700 (PDT)
Received: from darc.lan (p549A467A.dip.t-dialin.net [84.154.70.122])
        by mx.google.com with ESMTPS id y19sm5435667bkw.18.2010.09.19.02.59.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 02:59:10 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OxGgf-00015Q-30; Sun, 19 Sep 2010 11:59:57 +0200
X-Mailer: git-send-email 1.7.1.571.gba4d01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156489>

Hi,

I finally came around to de-bashify my patch ID test script. Here we go.

[PATCH 1/3] add rebase patch id tests
[PATCH 2/3] do not search functions for patch ID
[PATCH 3/3] use cache for function names in hunk headers

The first patch adds correctness and (optional) performance tests for the patch
"hash binary sha1 into patch id"
http://thread.gmane.org/gmane.comp.version-control.git/153468/focus=155919 .

The test reveals a performance problem with the search for function names for
the hunk headers. This is fixed for patch ID computation by the second patch
and for diff in general by the third patch.

Clemens
---

 diff.c                     |    2 +-
 t/t3419-rebase-patch-id.sh |  109 ++++++++++++++++++++++++++++++++++++++++++++
 xdiff/xemit.c              |   44 +++++++++++++-----
 3 files changed, 142 insertions(+), 13 deletions(-)
