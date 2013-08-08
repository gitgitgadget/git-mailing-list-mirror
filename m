From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] diff: fix a possible null pointer dereference
Date: Fri,  9 Aug 2013 00:11:53 +0200
Message-ID: <1375999913-4912-1-git-send-email-stefanbeller@googlemail.com>
References: <7v8v0b96xe.fsf@alter.siamese.dyndns.org>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: gitster@pobox.com, Jens.Lehmann@web.de, Johannes.Schindelin@gmx.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 00:11:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7YR4-0005tp-61
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 00:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758176Ab3HHWLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 18:11:54 -0400
Received: from mail-ea0-f175.google.com ([209.85.215.175]:53722 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758112Ab3HHWLx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 18:11:53 -0400
Received: by mail-ea0-f175.google.com with SMTP id m14so1686708eaj.6
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 15:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ryvIh5jitcJ3IF/jz9wA824NCZYPCpwjb5JjhMcodx0=;
        b=luNQbNk5xqC0bYzvdnSosjuTsS+4FYDrQS+mdCy6T+eyi3GKvWu7MdDt5hmHP+2nu0
         210pIlbkWy3ISlMYlOrmM5mA5y6sT5IU3RY9o5/u765SEtpiKWesMMkmPfSYH2Pu65Jm
         s2J+J/YT0dTNDyKrrgZ7pDYnwdW7TkzIIGUsB+JlzQmZ3CXDVSNMdwWxQAgVO1xQNj2N
         kzLTvbDuLjiwuJsCAKZs9cI2fJWh2FTzJwYCSL7FZXe+4s0ioMa9suG0JeZSZ9fqrjy6
         xqUIek3kS2vtZNKQO9WQy0Lw4ekajgRKhCgOVjfjJDsfFYT/Yodrg+TY69AkEoC7FfD5
         rx0w==
X-Received: by 10.14.182.131 with SMTP id o3mr10161362eem.119.1375999912306;
        Thu, 08 Aug 2013 15:11:52 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id bq1sm23070057eeb.9.2013.08.08.15.11.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 15:11:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.25.gd121ba2
In-Reply-To: <7v8v0b96xe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231944>

The condition in the ternary operator was wrong, hence the wrong char
pointer could be used as the parameter for show_submodule_summary.
one->path may be null, but we definitely need a non null path given
to the function.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
Acked-By: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 80f8439..061694b 100644
--- a/diff.c
+++ b/diff.c
@@ -2252,7 +2252,7 @@ static void builtin_diff(const char *name_a,
 			(!two->mode || S_ISGITLINK(two->mode))) {
 		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_summary(o->file, one ? one->path : two->path,
+		show_submodule_summary(o->file, one->path ? one->path : two->path,
 				line_prefix,
 				one->sha1, two->sha1, two->dirty_submodule,
 				meta, del, add, reset);
-- 
1.8.4.rc1.25.gd121ba2
