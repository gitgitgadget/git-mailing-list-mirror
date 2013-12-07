From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] remote-hg: fix 'shared path' path
Date: Sat,  7 Dec 2013 07:09:42 -0600
Message-ID: <1386421783-27781-4-git-send-email-felipe.contreras@gmail.com>
References: <1386421783-27781-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 14:17:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpHl9-0003G3-BL
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 14:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757144Ab3LGNRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 08:17:21 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:53250 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582Ab3LGNRU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 08:17:20 -0500
Received: by mail-ob0-f180.google.com with SMTP id wo20so1939108obc.25
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 05:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OERE7SB0vNVEhTpSzJWRI3yw6xmOAuKkP1aoKQh6qHc=;
        b=Hu5V67Uxk98j90fpBJEOL+bOU0ufvrtgDBU+sAqBKwjKLe88L3G4Av86igNWsrgyC8
         G1uzjYBofX12basPEqGigxkAt+MMPWqNCWoDHVXluMRaUZOdOLPXdYgWJkSdaCjE/Zwo
         OZq5KxCN3igdRWQ46bwWeHCcHlAxFWW8SWutrB+ltM/2rPLprJchvxEgbBXaD+/gx7mn
         iUwmi/olsTpy8+55d9aQp6477IthnGI8miwIielAXqlXpyLpEQyT8FTTIulDZgW1xdUf
         ZgXNFaMR3ZO9Ny16hx2lLPaLlC2GybciP/PjdKw6jTh/KfE4KVr2d+KUXTezEBl3JQqy
         sllQ==
X-Received: by 10.182.28.134 with SMTP id b6mr6479600obh.27.1386422239497;
        Sat, 07 Dec 2013 05:17:19 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u9sm5254339oey.0.2013.12.07.05.17.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 05:17:18 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1386421783-27781-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238982>

If the repository is moved, the absolute path of the shared repository
would fail.

Make sure it's always up-to-date.

Reported-by: Michael Davis <mjmdavis@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index aa1d230..718ef95 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -416,6 +416,9 @@ def get_repo(url, alias):
         local_path = os.path.join(dirname, 'clone')
         if not os.path.exists(local_path):
             hg.share(myui, shared_path, local_path, update=False)
+        else:
+            # make sure the shared path is always up-to-date
+            util.writefile(os.path.join(local_path, '.hg', 'sharedpath'), hg_path)
 
         repo = hg.repository(myui, local_path)
         try:
-- 
1.8.4.2+fc1
