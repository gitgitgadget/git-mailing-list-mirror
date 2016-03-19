From: "Jose Ivan B. Vilarouca Filho" <joseivan@lavid.ufpb.br>
Subject: [PATCH] Fixing segmentation fault when merging FETCH_HEAD
Date: Sat, 19 Mar 2016 14:17:40 -0400
Message-ID: <1458411460-26146-1-git-send-email-joseivan@lavid.ufpb.br>
Cc: "Jose Ivan B. Vilarouca Filho" <joseivan@lavid.ufpb.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 19:18:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahLRw-0007OM-Mx
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 19:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbcCSSSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 14:18:00 -0400
Received: from mail-qg0-f65.google.com ([209.85.192.65]:32836 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809AbcCSSR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 14:17:58 -0400
Received: by mail-qg0-f65.google.com with SMTP id y89so9945713qge.0
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lavid-ufpb-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+c3CmukHOdq3hk5tE5Zu7x2c+FFUkiMhkBo6924EfSg=;
        b=iQUgMPSlZYz8tBGQnk2pbSwOEDFQvvfC28OvB9ddM+tPU/kSqKh49E0MyYGPYItxFT
         UanHbw0QO6OHWxei+v/wF1PjGXweiRYdwGLeWQqMvMnW6oon6G9902pI0T2c1enxJQ5E
         eWmQOEtecmXTQYmj1rpm3XKF80z0rkNjMtUGOYeCOJ8eYmmzk7I7QV12dzzVJ8oNqTmd
         rzjaPBkjLPSUzCMMf0Fy6bEOYeQ3CxyIeKwI3Gp0hGGCNwg0LlfKy4Bv3qZZcdNVxH6c
         Do9aCrnk0ljExoipqYffDU14k11nOdneaysGq9RWiWMeyGM4OJ3fcRmvKFd40ktQs0/K
         ZXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+c3CmukHOdq3hk5tE5Zu7x2c+FFUkiMhkBo6924EfSg=;
        b=XGgyrOLxadzfbGndPiOykEVzGVIM2ASQeyuwdyGnTYYLilmdE5jo6+7+HBU7/Ae+Zi
         rLBA39VZKixe2zeX6Ee6xJ0BdN7pARs07cgbPbk/YFYdICytZ8A9wMYvgtnzB/xgzeHV
         orPgDZJqFOvFD7S6qgJI/wgJwKsjROqV7Szu7geFDQInp755rqxk2PnYr2YncpNO/dKJ
         GlAfo5RwzZqBkbs2vroji2To7VTuvLt1Y6g4dIXEsUIXzb42/jbR45hgaoha3eAQWU42
         bC8GPk5NfevjwhdMqvadbQE5j5nnMNPZFA3eY3c2rmq+1CZhooIwoLx7jQChw0z9F8oe
         Nq1g==
X-Gm-Message-State: AD7BkJKEql5CGamB+p5FGFAQDU5yuv8nmQMwt6UfiLNECcuPfZltLqZCsxwEH7Y2mP0ihw==
X-Received: by 10.140.98.163 with SMTP id o32mr31468165qge.46.1458411478095;
        Sat, 19 Mar 2016 11:17:58 -0700 (PDT)
Received: from cinema-lenovo1.pet.ci.ufpb.br ([186.207.136.144])
        by smtp.gmail.com with ESMTPSA id c66sm8574506qha.27.2016.03.19.11.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Mar 2016 11:17:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289321>

From: "Jose Ivan B. Vilarouca Filho" <joseivan@lavid.ufpb.br>

A segmentaion fault is raised when trying to merge FETCH_HEAD
formed only by "not-for-merge" refs.

Ex:
    git init .
    git remote add origin ...
    git fetch origin
    git merge FETCH_HEAD

Signed-off-by: Jose Ivan B. Vilarouca Filho <joseivan@lavid.ufpb.br>
---
 builtin/merge.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 101ffef..7e419dc 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1270,9 +1270,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			    "an empty head"));
 		remoteheads = collect_parents(head_commit, &head_subsumed,
 					      argc, argv, NULL);
-		remote_head = remoteheads->item;
-		if (!remote_head)
+		if ((!remoteheads) || (!remoteheads->item))
 			die(_("%s - not something we can merge"), argv[0]);
+		remote_head = remoteheads->item;
 		if (remoteheads->next)
 			die(_("Can merge only exactly one commit into empty head"));
 		read_empty(remote_head->object.oid.hash, 0);
-- 
1.7.10.4
