From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 2/2] pull: parse pull.ff as a bool or string
Date: Mon, 18 May 2015 21:45:42 +0800
Message-ID: <1431956742-25992-3-git-send-email-pyokagan@gmail.com>
References: <1431956742-25992-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:46:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLN2-0006os-SX
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbbERNqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:46:09 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36436 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbbERNqG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:46:06 -0400
Received: by pabts4 with SMTP id ts4so153101557pab.3
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9hD8oSQOoHjo9YerjSWPJU2pj8sekaxU2PcC0tGEeeM=;
        b=dTsRbKn4oR4BSX1P9x2aSpDxQE6pIfCFdHVTmQ6JXRt6VdVhG5DAkf/b+OHqQQWS4H
         +uVWf8bzVzxC97pZMslZZ+JMyTq1BDwMIfgiV/YjSYIV8Mcnf734nehbW59+nQLdTVL3
         Te9d0+mgFWSaCFUAMyqVtMHSxFZT/HQ2Iuy9nig0Sw3CpIFJiU7eW3uw077qUbujbJZI
         DIDwnWaSQdipRLJGBZcbSQc7/T3faDdP9fHL5Z+DVoNbx6vUGypJakQdTlV9GShgcls0
         1fpLCuukrQlxPnNybsudTaR77+D9uQqUvK0ezEcIot7lYKIcQZC4TdRVJwiW84Ktvw7Q
         AN/Q==
X-Received: by 10.70.54.164 with SMTP id k4mr44754651pdp.61.1431956765958;
        Mon, 18 May 2015 06:46:05 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id x4sm10175713pdl.55.2015.05.18.06.46.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:46:04 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431956742-25992-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269248>

Since b814da8 (pull: add pull.ff configuration, 2014-01-15) git-pull
supported setting --(no-)ff via the pull.ff configuration value.
However, as it only matches the string values of "true" and "false", it
does not support other boolean aliases such as "on", "off", "1", "0".
This is inconsistent with the merge.ff setting, which supports these
aliases.

Fix this by using the bool_or_string_config function to retrieve the
value of pull.ff.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

 git-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index e51dd37..09bc678 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -54,7 +54,7 @@ then
 fi
 
 # Setup default fast-forward options via `pull.ff`
-pull_ff=$(git config pull.ff)
+pull_ff=$(bool_or_string_config pull.ff)
 case "$pull_ff" in
 true)
 	no_ff=--ff
-- 
2.1.4
