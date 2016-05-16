From: Vasily Titskiy <qehgt0@gmail.com>
Subject: [PATCH] Ignore dirty submodule states during stash
Date: Mon, 16 May 2016 02:07:35 +0000
Message-ID: <20160516020735.GA7884@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 04:08:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b27xF-0008Oj-L3
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 04:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbcEPCHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 22:07:38 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:32947 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcEPCHi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 22:07:38 -0400
Received: by mail-yw0-f194.google.com with SMTP id y6so17701918ywe.0
        for <git@vger.kernel.org>; Sun, 15 May 2016 19:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vZKurpP1fRI0OaMQKCas7v5sKjbuGSXrtyOyTijsqdQ=;
        b=Oi/uJwtlaeXKcPhEyLBrgp/mBnjZ0LyksqFWLWsSfhiPbEQp2KihEsMA01F0/XZJAT
         N2OzrdiAioHtbdapOnrwZdjbZSWJw8+FKyDfgl+U33oaeX6a4+FZP3PlKjwbma/mNKTx
         BU5FNRZQLYVkbB17waNiW36CcfqcrtQrBabdrjNDoVtoWsuYyj0lJWfhyEIeVCIHO2Wp
         2LhJdR2701B/w91eI/gPIt4qx1cB9kXwlxddMKjewJsTAsAn9zNVEBGviPk0x1qAJ1QM
         KhaRUVDklqwQr+px0NA6sqwClN50Mm/IYX9CJtGIsJ8Nv237VaPF3sn3Xt2Fut56tl6r
         /p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vZKurpP1fRI0OaMQKCas7v5sKjbuGSXrtyOyTijsqdQ=;
        b=Xg+P4A3n9/8leAVp2LcsvTI3XwBXy0h+BLL1BJ6y+S96RZ1zp62je+D1tASwNKFp81
         663yx+AIiPK7RcCYbEdPQc7iELSnkEFTIbr65r86LOroPHWG4ker9qqLB8953qcQ1Yjc
         zsjjNrunhO68MaLvhoap3Ca1KltUnk1WMoMEJzQMPohGqbnULcBXKGwD6n23LUQeN+om
         74nPTmTzKl52XQk8w32/sTtNz5a6X6C75VdZw7n9WPPfRBFNd7OgYVj0z3F6K7saJaHK
         wDOhk8zQFW6610owQcB7XeMgPpQ4lM1hCctTw3GPo0ujPuPA24IUG1w0FqD9gKbt0FZk
         /xMQ==
X-Gm-Message-State: AOPr4FWt+97DTNs49selZW2By/a6c7h16bqOV2qXvtOjNolr8bFxH31we4pGDKHkEyDS6w==
X-Received: by 10.37.13.197 with SMTP id 188mr12293969ybn.163.1463364457010;
        Sun, 15 May 2016 19:07:37 -0700 (PDT)
Received: from gmail.com ([2600:3c02::f03c:91ff:fe96:da77])
        by smtp.gmail.com with ESMTPSA id h15sm18095712ywc.9.2016.05.15.19.07.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 May 2016 19:07:36 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294715>

Do not save states of submodules as stash should ignore it.

Signed-off-by: Vasily Titskiy <qehgt0@gmail.com>
---
 git-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index c7c65e2..b500c44 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -116,7 +116,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
+			git diff --name-only --ignore-submodules -z HEAD -- >"$TMP-stagenames" &&
 			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
-- 
2.1.4
