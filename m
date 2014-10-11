From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] remote.c - Make remote definition require a url
Date: Sat, 11 Oct 2014 11:20:49 -0400
Message-ID: <1413040849-20056-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 11 17:21:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcyTu-0005nC-Er
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 17:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbaJKPVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 11:21:00 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:55068 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbaJKPVA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2014 11:21:00 -0400
Received: by mail-qa0-f50.google.com with SMTP id w8so2804965qac.37
        for <git@vger.kernel.org>; Sat, 11 Oct 2014 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=95XeCZcIZjLcUoy7MQFnk7UZLZAJRHOglQCnxNW/b4g=;
        b=mesd9cYkv8M9QCC9SiJ0z8nYQ1YrGN8EmeTPS+idG4+rOIKSveh8OFB5dldcMgFWu0
         1qPQAepTw6j8ZNoeIobd8BkQSD2YMGHSLgZpsEokQe1O+sKHNugQ3j/jYkxe4m76fKQn
         CffO4EsH5PFiCAItLFG0IHDSOkJK6P2a1XsV8+N0bX+nI9zIxnd8OPT6KxhnFQZZF966
         Uq58CsnPGSBxzu7PAoWrb/C+Ge6yOo52c+qAJju0G3H6b1Rfpz7YM3tLe+u7UPe3qaFV
         dKTxycg8rRIV/gSX7D3zgBJUaArSpS9iQbYBkf4DSSooGjs6Hp9QjJslAbAtF6o3JqO1
         rIiw==
X-Received: by 10.224.4.5 with SMTP id 5mr21089269qap.83.1413040859364;
        Sat, 11 Oct 2014 08:20:59 -0700 (PDT)
Received: from marklaptop.lan (pool-173-73-114-83.washdc.fios.verizon.net. [173.73.114.83])
        by mx.google.com with ESMTPSA id z32sm7684565qgd.40.2014.10.11.08.20.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Oct 2014 08:20:57 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.2.0.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some options may be configured globally for a remote (e.g, tagopt).
The presence of such options in a global config should not cause
git remote or get fetch to believe that remote is configured
for every repository. Change to require definition of remote.<foo>.url
for the remote to be included in "git fetch --all" or "git remote
update."

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index ce785f8..1b08924 100644
--- a/remote.c
+++ b/remote.c
@@ -761,7 +761,7 @@ int for_each_remote(each_remote_fn fn, void *priv)
 	read_config();
 	for (i = 0; i < remotes_nr && !result; i++) {
 		struct remote *r = remotes[i];
-		if (!r)
+		if (!r || !r->url)
 			continue;
 		if (!r->fetch)
 			r->fetch = parse_fetch_refspec(r->fetch_refspec_nr,
-- 
2.1.2.2.0.14
