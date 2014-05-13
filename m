From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 06/29] Fix the do_get_patch function.
Date: Tue, 13 May 2014 22:30:42 +0200
Message-ID: <1400013065-27919-7-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:33:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJO8-0000pl-5J
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbaEMUdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:33:01 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:42023 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbaEMUcz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:32:55 -0400
Received: by mail-lb0-f177.google.com with SMTP id s7so699036lbd.8
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h2zJApO5fmvPsIlEUnpI/OLmIWBX705r4OWqPTDiCe0=;
        b=D5f2RqyYyzPBB+ckUPpisV6DYLXmJQVVDdm8cM8DrLTWXxutHkxvo+O7IcU1qoUgAq
         SWVvUGUI1D3MNJmdUjRQgfis2YvZEvd5pXyLdeF7TXqmibegaSrDvVtN8U7dNneWkeaH
         W7BBFx97elxjXLT3BJbVNo+/VJ/haDJkVxM09tQcpvpQMQyvHwpWhfbLR2T+yr7SCT0y
         0Txvuri3xoVrI9yuJcJ1c2WMY0WCSvvGXGZyUijWLuQN1qSglEWmnnXuOp2BLR6K8lbl
         ZIyPb9MX4YdyQTj/6YuBv0Xfuu95SmT2E5jn31lJOVeeyVS1m9h0jAhIrmJR2vntgUbw
         4nHA==
X-Gm-Message-State: ALoCoQkMOMRqZLAg/6HlS9nPTbJoLDg2KkylS6t1fHuCtqMHY7nIWszXoLp1DWOZvy/8Kl6Y+Cee
X-Received: by 10.112.52.167 with SMTP id u7mr30068626lbo.28.1400013174179;
        Tue, 13 May 2014 13:32:54 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.32.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:32:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248821>

A patch file consists of:

(1) the description
(2) optional diffstat
(3) the patches

When extracting the patch, we only want part 3.  The do_get_patch used
to give us part 2 and part 3.  That made for instance this series of
operations fail if guilt.diffstat is true:

    guilt push empty-1
    guilt push empty-2
    guilt pop
    guilt fold empty-2
    guilt pop
    guilt push

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt b/guilt
index 8701481..3fc524e 100755
--- a/guilt
+++ b/guilt
@@ -334,7 +334,7 @@ do_get_patch()
 {
 	awk '
 BEGIN{}
-/^(diff |---$|--- )/ {patch = 1}
+/^(diff |--- )/ {patch = 1}
 patch == 1 {print $0}
 END{}
 ' < "$1"
-- 
1.8.3.1
