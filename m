From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 0/7] correctly calculate patches to rebase
Date: Wed, 18 Jul 2012 00:27:28 -0700
Message-ID: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 09:28:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOgC-0000Ii-GP
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800Ab2GRH2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:28:07 -0400
Received: from mail-wg0-f74.google.com ([74.125.82.74]:51181 "EHLO
	mail-wg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab2GRH1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:27:51 -0400
Received: by wgbdt11 with SMTP id dt11so58225wgb.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=oIyBi4oerOTsoA9GYvd1AXT4HWsE6L3+OdW1LTebn8w=;
        b=jtCqrNCQOIyOiTYkXpOwFpNTHCdCHClkX0t9/CgN25aEjt9XCXRYt0uEFTmR84ecxV
         5BoS3VwAsB3mgUHWej/uZ2/m8JJYb/AxiIZqfwKjiB2kkXyndWXvb5PEmsNsXyItlPpi
         23a7NDjUE6yHb8jldrBTclTcaLE9S0DPNw6mgs54Q2p5GsWqkxewCx0FiZ0fP1+cGHtx
         lV96Q0DZ7YdUqlylzUf+EFVq4BceTzeu2YcZTk6CiN4i+vCOzx/L01GYqH9gA6/7iw/N
         qG03XXj1nJJ8lm/X+HOkp5Sn3rPt2HHiFp8YInV/7AXb8M7idsV7fsidclOPOanW9jIF
         r8pw==
Received: by 10.14.179.72 with SMTP id g48mr1723174eem.2.1342596469867;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by 10.14.179.72 with SMTP id g48mr1723168eem.2.1342596469723;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s44si15275428eeo.0.2012.07.18.00.27.49
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 844EA200057;
	Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 966ECC15C8; Wed, 18 Jul 2012 00:27:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
X-Gm-Message-State: ALoCoQn/z/euYmh0x/B2TMXxpnzeYlKv62Sh5wJx5x8ksAzqOMt8dKZhwSpeAYuGp68IPTJp1TsuUYxKNgy0z0ImxQKT2IGHKbwuKIz/BOfjavqwptV9/xkeHg4c7ijh2fKZNapNjUbHpr6Gw3dlqs3Rpn8XXmxgMrkP6qEbVeMZ5kVd1Tl+kS1Hzptxw02XmvATa00e3rhl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201663>

These seven patches replace the broken one I sent in
http://thread.gmane.org/gmane.comp.version-control.git/200644/focus=200648. I
hope I got the handling of empty commits right this time.

Martin von Zweigbergk (7):
  git-rebase--am.sh: avoid special-casing --keep-empty
  git-rebase--interactive.sh: extract function for adding "pick" line
  git-rebase--interactive: group all $preserve_merges code
  git-rebase--interactive.sh: look up subject in add_pick_line
  rebase -p: use --cherry-mark for todo file
  rebase -p: don't request --left-right only to ignore left side
  rebase (without -p): correctly calculate patches to rebase

 git-am.sh                  | 10 +++++-
 git-rebase--am.sh          | 20 +++--------
 git-rebase--interactive.sh | 87 ++++++++++++++++++++--------------------------
 git-rebase--merge.sh       |  2 +-
 git-rebase.sh              | 11 +++---
 t/t3401-rebase-partial.sh  | 17 +++++++++
 t/t3406-rebase-message.sh  | 14 ++++----
 7 files changed, 81 insertions(+), 80 deletions(-)

-- 
1.7.11.1.104.ge7b44f1
