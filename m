From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] remote.c: simplify a bit of code using git_config_string()
Date: Tue,  2 Apr 2013 13:10:29 +0530
Message-ID: <1364888434-30388-2-git-send-email-artagnon@gmail.com>
References: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 02 09:39:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMvov-0007It-Ox
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 09:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760390Ab3DBHjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 03:39:22 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:63609 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759834Ab3DBHjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 03:39:21 -0400
Received: by mail-pa0-f41.google.com with SMTP id kx1so149379pab.28
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=GsEY+TyJCjWMDsg2Fm0VdtMFYvhMsuk/fUl1pZWir0A=;
        b=MJggE3EdUrJKAesfakwn/gRa3VsrD578Y1L8mkBOYioeonPnhN0gh+OR0o8buCo5O+
         1Ch4vi93Kio2ciNfdEJBf5bi1RG96jXvotFCrN4a96FjOj2zYIAmIS5Cl7y4t4o6x1+s
         001jMwoKkTYoo5bPJEZOOTT0b5h54MBoT6+jaAgF9RLk+0ueeQygqC9dhk47KzU5Tpge
         YxX77cOWw4ocfsnHHfZwl4a8tZEh1vls01veTl8rFf3DNYk5LuAQtmiHmUtI7k52bheh
         6B/tO+VPxvlP9IAMHHSteHsjMHm3UTzrA0qCLMWr772bCsMtrazZD7Cuib+qT0pvhiZV
         19IA==
X-Received: by 10.68.253.137 with SMTP id aa9mr11267626pbd.26.1364888360721;
        Tue, 02 Apr 2013 00:39:20 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id oq3sm1259341pac.16.2013.04.02.00.39.18
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 00:39:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.363.g901f5bc
In-Reply-To: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219744>

A small segment where handle_config() parses the branch.remote
configuration variable can be simplified using git_config_string().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index ca1edd9..34ddc5b 100644
--- a/remote.c
+++ b/remote.c
@@ -357,9 +357,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 			return 0;
 		branch = make_branch(name, subkey - name);
 		if (!strcmp(subkey, ".remote")) {
-			if (!value)
-				return config_error_nonbool(key);
-			branch->remote_name = xstrdup(value);
+			if (git_config_string(&branch->remote_name, key, value))
+				return -1;
 			if (branch == current_branch) {
 				default_remote_name = branch->remote_name;
 				explicit_default_remote_name = 1;
-- 
1.8.2.363.g901f5bc
