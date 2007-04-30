From: Dana How <danahow@gmail.com>
Subject: [PATCH 1/8] git-repack --max-pack-size: add new file statics
Date: Mon, 30 Apr 2007 16:17:32 -0700
Message-ID: <4636790C.5060908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 01:17:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hif7m-00011W-1M
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423392AbXD3XRi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423400AbXD3XRi
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:17:38 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:39430 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423392AbXD3XRh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:17:37 -0400
Received: by py-out-1112.google.com with SMTP id a29so1462502pyi
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 16:17:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=qJmKHuD/6FYdaZnQ7CuwS/AazsD8v6evI/ICnNb6/fQJ//boGnTRtLKgAeaAc405xBv7jFCYIrr9gmtstC8UigHhBf4fVHoLEzqOBTygJQdFKLrooi3Yv7e7NGjtl3GacjSFTYMH4a3Bfsx9XmD5sgWj4DUT60Je9NBK7A4vclA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=knDWa0NgMV6xxJRR1R8Dt2H1KUHeNcdaHuTZ8zQnwlgj9gpx4sLuRqIkdcSgSnFCzJKHbbbjcff0GhvpdFE+AFYvx3xNZmJweC1Tmn+ZojtN9ge2oYJm0cTa7zYlwd0ZOGGsc1Oea7+glG3rr7GMBfD5wZtelrUp9XS9FSWMNL4=
Received: by 10.35.69.11 with SMTP id w11mr12142189pyk.1177975056075;
        Mon, 30 Apr 2007 16:17:36 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 38sm23151463nzk.2007.04.30.16.17.33;
        Mon, 30 Apr 2007 16:17:34 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45890>


This adds "pack_size_limit", which will contain the limit
specified by --max-pack-size, "written_list", the actual
list of objects written to the current pack, and "nr_written",
the number of objects in written_list.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b827627..ac2c15e 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -52,7 +52,8 @@ struct object_entry {
  * nice "minimum seek" order.
  */
 static struct object_entry *objects;
-static uint32_t nr_objects, nr_alloc, nr_result;
+static struct object_entry **written_list;
+static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
 
 static int non_empty;
 static int no_reuse_delta;
@@ -64,6 +65,7 @@ static char tmpname[PATH_MAX];
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
 static int window = 10;
+static uint32_t pack_size_limit;
 static int pack_to_stdout;
 static int num_preferred_base;
 static struct progress progress_state;
-- 
1.5.2.rc0.766.gba60-dirty
