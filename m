From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] rebase -i: Fix left-behind CHERRY_PICK_HEAD
Date: Thu, 18 Jun 2015 12:45:58 -0700
Message-ID: <xmqqwpz0er61.fsf@gitster.dls.corp.google.com>
References: <cover.1434627492.git.johannes.schindelin@gmx.de>
	<cover.1434645436.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 21:46:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5flG-0007Bb-66
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 21:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbbFRTqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 15:46:02 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33141 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbbFRTqA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 15:46:00 -0400
Received: by igbqq3 with SMTP id qq3so23818268igb.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 12:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JYf+Hemd3KAKcaU/SQdtSDC5kDOtXWDbw4vw71jgQtQ=;
        b=Sy/1CzpyFhrxGJOK6x5xAIrYg6UMR2lzJfwRQgWNTAAumieQZGBYXO2Kc5CkdP2wNP
         J2mVWwGLMwUhc0W2UC+MQDPP+SOslQFboEhtjltLLbQyCLHT1Jc8PdGtOxZDxoaAgoLi
         NazRWvFSXULjthoeluQLuIW9pTLSIcvB1GoARRm756XDLVnV1+4UcePxFv6wzfn3e93L
         Byx63G5v4T1pNgYI0qR23mXz0hRbbey0mid+tKdZ4j7myyGO4MuadP2p3+y/1YYu0/a1
         wx1D2gJnKIXVy2seVSnQO16w9Wb+tsw1NExczkGzf0Bb4AK6m7d2JR2CXi6qw6/a0itY
         Qukw==
X-Received: by 10.42.113.133 with SMTP id c5mr7782317icq.67.1434656759706;
        Thu, 18 Jun 2015 12:45:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id b74sm5553692ioe.6.2015.06.18.12.45.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 12:45:59 -0700 (PDT)
In-Reply-To: <cover.1434645436.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Thu, 18 Jun 2015 18:38:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272037>

Thanks.

This round looks good, except one trivial nit (below), which I'll
locally squash-in a fix for.

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index fb1b571..6938e5e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1052,7 +1052,7 @@ test_expect_failure 'rebase --continue removes CHERRY_PICK_HEAD' '
 	git reset --hard HEAD~2 &&
 	git cherry-pick seq-onto &&
 	set_fake_editor &&
-	FAKE_LINES= test_must_fail git rebase -i seq-onto &&
+	test_must_fail env FAKE_LINES= git rebase -i seq-onto &&
 	test -d .git/rebase-merge &&
 	git rebase --continue &&
 	git diff --exit-code seq-onto &&
-- 
2.4.4-569-gdcc90bb
