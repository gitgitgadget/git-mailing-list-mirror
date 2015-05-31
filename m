From: Jim Hill <gjthill@gmail.com>
Subject: [PATCH 0/2] don't add duplicate paths to info/alternates
Date: Sun, 31 May 2015 11:15:21 -0700
Message-ID: <1433096123-14420-1-git-send-email-gjthill@gmail.com>
Cc: git@vger.kernel.org
To: Junio Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 31 20:15:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz7lp-0007Pa-Nn
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 20:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758407AbbEaSPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 14:15:34 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36768 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbbEaSPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 14:15:32 -0400
Received: by pdjm12 with SMTP id m12so8195655pdj.3
        for <git@vger.kernel.org>; Sun, 31 May 2015 11:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ubYeR1BpeQrCWOONtNrNF/YZvHSekS9fayrR0h4tYyc=;
        b=QCHIgnWH6toll0f7BVmGEglSZ8veOPBVO53+CNoQ46MamDNlvCPqD6wqPhYexxdbFU
         zXx8nn0C08lvaO1cB2mIVQTbeWNIEdtQpMXDQiUSzQEPbip5OfIsQkXhD1t7dLV3N7Bo
         GaxqjazSQpgNgQ6NQyxhNNQETQs6nOYDUUslwuDl+kClAOH2Sy4pJHjPo9Qk11sc85Bn
         XwH+gMJtR/rbQWaRNQjnd8j8qjQca96yNZ3QPbcQZpXJ+LDvb/q1ZuW6yC+L2XJkpVa+
         KKgBVoVamghixkEu/Wp/5mUdM8WxPv3V4oZX32IRbARqSZb29SxjtjOZC3hQSFbz9ZaT
         eU1w==
X-Received: by 10.68.57.209 with SMTP id k17mr34064652pbq.118.1433096132289;
        Sun, 31 May 2015 11:15:32 -0700 (PDT)
Received: from gadabout.domain.actdsltmp (pool-71-119-14-52.lsanca.dsl-w.verizon.net. [71.119.14.52])
        by mx.google.com with ESMTPSA id l10sm11826347pbq.87.2015.05.31.11.15.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 11:15:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.4.gfc728c2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270341>

These patches address
http://thread.gmane.org/gmane.comp.version-control.git/269050/focus=269415
linked from the git blame page, avoiding adding duplicates to info/alternates
and removing hold_lock_file_for_append which is too heavyweight for logging and
too limited for anything else.

There's an argument to be made that since a-t-a-f is only used by clone, it
shouldn't even bother taking a lock -- but then it should be moved to
builtin/clone.c and reduced to a single write of the pre-deduped list, followed
by a single read_info_alternates call. One thing at a time.  Taking out the
locking in the incremental version here doesn't really simplify the code much
anyway.
