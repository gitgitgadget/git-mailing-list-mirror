From: sdaoden@googlemail.com
Subject: [PATCH 0/2 RFC] Add update_progress(), divert checkout messages
Date: Mon, 29 Aug 2011 22:14:59 +0200
Message-ID: <cover.1314647163.git.sdaoden@gmail.com>
References: <7vaaau9hso.fsf@alter.siamese.dyndns.org>
Cc: Steffen Daode Nurpmeso <sdaoden@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 22:16:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy8Ft-0007uE-GZ
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015Ab1H2UQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:16:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58599 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969Ab1H2UQU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:16:20 -0400
Received: by fxh19 with SMTP id 19so4797127fxh.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 13:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to;
        bh=6lNjSqOF80g36tvcZH9g1cEBjNFxjBPDsNk8fCUvL/g=;
        b=Of9ckY5M8MsCBZwLIbBDMoUxS3NAcnrJBBQUHEGQDUM6MBFHOG4YSoXCFcqJWiK4z4
         Mx8Wlo/xes9Pk8dqqK5STLoTtw5lr7lqzAjlM+jMLg8sloZsZbnfgPFWea9BSSwvOMJh
         y1dcuIJO/Hh8eUWsxh7kZgD7W0pwb8DkCmRyM=
Received: by 10.223.22.131 with SMTP id n3mr7770816fab.4.1314648979112;
        Mon, 29 Aug 2011 13:16:19 -0700 (PDT)
Received: from localhost.localdomain ([89.204.137.171])
        by mx.google.com with ESMTPS id b14sm4037549fak.5.2011.08.29.13.16.16
        (version=SSLv3 cipher=OTHER);
        Mon, 29 Aug 2011 13:16:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.dirty
In-Reply-To: <7vaaau9hso.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180343>

From: Steffen Daode Nurpmeso <sdaoden@gmail.com>

Whereas only syntactic sugar, i think it's a bit odd that during
a checkout which mostly removes files the git-checkout progress
displays "Checking out files" all of the time.

There are two solutions to this: either simply change that string
to "Updating working tree", which is acceptable to anybody at
anytime.  Or divert what progress reports to the actual action
which is currently performed.  This series tries to achieve the
latter.

But maybe progress should instead be extended that it could handle
a situation like the following directly.  I.e., offer an
additional start_parted_progress() series, or extend the current
one with an additional "signed parted" argument.  That
update_progress() could then instead be named
progress_change_part() or whatever.  ?

    Updating work tree: removing files (x/y [xy%]) total%
       Main-Title        Action-title  Action-cnt 

Steffen Daode Nurpmeso (2):
  progress: add update_progress()
  unpack-trees: divert check_updates() output via update_progress()

 progress.c     |   15 +++++++++++++++
 progress.h     |    2 ++
 unpack-trees.c |   30 +++++++++++++++++++++++-------
 3 files changed, 40 insertions(+), 7 deletions(-)

-- 
1.7.7.rc0.dirty
