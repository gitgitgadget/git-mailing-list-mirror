From: Cody A Taylor <cody.taylor@maternityneighborhood.com>
Subject: [PATCH] git prompt: Use toplevel to find untracked files.
Date: Thu, 12 Mar 2015 18:45:12 -0700 (PDT)
Message-ID: <20150313014332.11094.18357@catuvm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: szeder@ira.uka.de, felipe.contreras@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 02:45:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWEf9-0007My-66
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 02:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbbCMBpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 21:45:14 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:44770 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbbCMBpN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 21:45:13 -0400
Received: by qcwr17 with SMTP id r17so23295844qcw.11
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 18:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:content-type:mime-version
         :content-transfer-encoding:to:cc:subject:message-id;
        bh=nSDCHRDvTpejxsbTx/0gAnY8QHBR8PdLz9jZPLGs6hA=;
        b=maJH6DDWLPkXXHrVtaM2OG2vhaB8oQFHh0kLB1W0vvqZcXwWKIjdKEsjDGYQi1KEVx
         7Tz47nW6FNf0HG7eesf1YkWzwI3fxdhq8zX6XsidMWjamhCUkTvMzx70BIkQVhIry6UF
         DOOU1kO4u92YRKHOqLRFGNIu5lhtSV8xWpUGEZkTAe6eX5xkV6IVBDND0vcJm1O5oCYl
         UF5WbmnVjOaN1yIlKlZlCS20xRJn3HTNnRECpkFL2u2rLA2F933rJnFmLwzClTMyDezo
         Fwf1yxhd8Intsz5sUIIYKqazo97WujhWgQJo/xFAAQQIqePMZXlkJxLi8HgCUKXyK61Q
         eWuA==
X-Gm-Message-State: ALoCoQmCaiOGFX8F0ps0CuPNXAX1jAG14ciIBZr2c9Ik2eZ+RSsAk2HbXUN9tcxvMtx3SeI++PcP
X-Received: by 10.140.51.107 with SMTP id t98mr55266165qga.63.1426211112524;
        Thu, 12 Mar 2015 18:45:12 -0700 (PDT)
Received: from [127.0.1.1] ([216.197.66.13])
        by mx.google.com with ESMTPSA id 17sm456672qhq.23.2015.03.12.18.45.11
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2015 18:45:12 -0700 (PDT)
X-Google-Original-From: Cody A Taylor <codemister99@yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265387>

>From 3e4e22e93bf07355b40ba0abcb3a15c4941cfee7 Mon Sep 17 00:00:00 2001
From: Cody A Taylor <codemister99@yahoo.com>
Date: Thu, 12 Mar 2015 20:36:44 -0400
Subject: [PATCH] git prompt: Use toplevel to find untracked files.

The __git_ps1() prompt function would not show an untracked
state when the current working directory was not a parent of
the untracked file.

Signed-off-by: Cody A Taylor <codemister99@yahoo.com>
---
 contrib/completion/git-prompt.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 214e859f99e7..f0d8a2669236 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -487,7 +487,8 @@ __git_ps1 ()
 
 		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
 		   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
-		   git ls-files --others --exclude-standard --error-unmatch -- '*' >/dev/null 2>/dev/null
+		   git ls-files --others --exclude-standard --error-unmatch -- \
+		     "$(git rev-parse --show-toplevel)/*" >/dev/null 2>/dev/null
 		then
 			u="%${ZSH_VERSION+%}"
 		fi
-- 
2.3.2
