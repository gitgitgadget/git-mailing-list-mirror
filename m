From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] diff: remove another ternary expression always evaluating to true
Date: Thu,  8 Aug 2013 20:55:03 +0200
Message-ID: <1375988103-29947-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: Jens.Lehmann@web.de, johannes.schindelin@gmx.de, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 20:55:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7VMd-0003UB-HA
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 20:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966146Ab3HHSzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 14:55:05 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:37383 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966099Ab3HHSzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 14:55:04 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so1621845eak.32
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4Zm9ZImpvwI39nExUxyHXA+mGen9vdwvZZxO6RkxkwA=;
        b=rOXOlbklVgBlqF0hpAVCHo8mX9HDhaPFEcj1Fd902NU5VKL4fzBs2HPQ8LzlyEW6nM
         evVWt1SKDfUQq2zPrp1nMKV6ewdnEuIKfUAgBaMKIumsrxktNYHPybwgOcTm3j86M9oz
         Auqfo+p6T3u0QP/UIo4bjcjqAcEm0qqjO529snbZ6yOki5IjvLO/28bkiE5fqihVL7S3
         3hedJ47MYMsyXNZYoGy87vJ9j9vnjrSGYdh2s/g9uWslUFFiItSY53WU+YME1FgEpigN
         HvUFF3haOwrm/ewO4hjV1w3eDAYB12jozod78hk9xc6C9Jd8GmMtn+5nv0ab2E0GrZHH
         c/FA==
X-Received: by 10.14.100.141 with SMTP id z13mr9644957eef.81.1375988102535;
        Thu, 08 Aug 2013 11:55:02 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k3sm21574694een.16.2013.08.08.11.55.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 11:55:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.25.gd121ba2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231920>

The condition before the changed line dereferences 'one' to query the mode,
so if the condition evaluates to true, the variable one must not be null.
Therefore we do not need the ternary operator depending on one, giving
either one->path or two->path. This always evaluates to one->path, so
we can remove the ternary operator.

The condition and the usage of the ternary operator have been introduced
by the same commit (752c0c24, 2009-10-19, Add the --submodule option to
the diff option family). As that commit message refers to a GitTogether
I'd assume that patch was crafted in a hurry, so maybe overlooking the
need for a ternary operator there.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 diff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 80f8439..f30b7e4 100644
--- a/diff.c
+++ b/diff.c
@@ -2252,8 +2252,7 @@ static void builtin_diff(const char *name_a,
 			(!two->mode || S_ISGITLINK(two->mode))) {
 		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_summary(o->file, one ? one->path : two->path,
-				line_prefix,
+		show_submodule_summary(o->file, one->path, line_prefix,
 				one->sha1, two->sha1, two->dirty_submodule,
 				meta, del, add, reset);
 		return;
-- 
1.8.4.rc1.25.gd121ba2
