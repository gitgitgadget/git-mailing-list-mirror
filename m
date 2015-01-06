From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed notes refs
Date: Mon,  5 Jan 2015 22:03:53 -1000
Message-ID: <e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
Cc: Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:05:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8P7g-00035D-7H
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 09:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbbAFIEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 03:04:10 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:56415 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062AbbAFIEH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 03:04:07 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so30261025pac.25
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 00:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5fm3cRqSNIddE2CFkxfmB6J3QIlfLX5NEmMGyYtF7M=;
        b=jT8n9kB6yaqV7TBD2fIH7Fwb5R1K1lHOu5nM0SbSjX9eeCcLNBQkHarnhNnayK2kiJ
         1H3uIwWbMu+6csvVzO5p5acyioE+k2RT7ECIqJN5voX7ie979LlptiTgChibmNfHD7bZ
         NWS///9BG0oaMxXij2c5Z47D2wULkAFrv9VhRgbguaNZr46A0czIjx6PszBDvJwKKm5g
         caS513tLIPOdoq15UHy/39TM2i/YbVkDp+dQ5yIxqjzcT95KRO6wLs1OjFN/2J5ujIMh
         9rtMMYIY+xLdgP7TpCZyjiYTCAYlq4d1U3+918+OGGLcv5zjrpIs8GTP043wcYs2QQXS
         8kfw==
X-Received: by 10.70.35.109 with SMTP id g13mr90693864pdj.17.1420531446992;
        Tue, 06 Jan 2015 00:04:06 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ug6sm56550745pab.7.2015.01.06.00.04.05
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 00:04:06 -0800 (PST)
In-Reply-To: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262047>

With the recent change to allow notes refs to be located in
the refs hierarchy in locations other than refs/notes/ the
'git notes merge refs/heads/master' test started succeeding.

Previously refs/heads/master would have been expanded to
a non-existing, ref refs/notes/refs/heads/master, and the
merge would have failed (as expected).

Now, however, since refs/heads/master exists and the new,
more relaxed notes refs rules leave it unchanged, the merge
succeeds.  This has a follow-on effect which makes the
next two tests fail as well.

The refs/heads/master ref could just be replaced with
another ref name that does not exist such as refs/heads/xmaster,
but there are already several tests using non-existant refs
so instead just remove the refs/heads/master line.

Suggested-by: Johan Herland <johan@herland.net>
Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 t/t3308-notes-merge.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index 24d82b49..f0feb64b 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -90,7 +90,6 @@ test_expect_success 'fail to merge various non-note-trees' '
 	test_must_fail git notes merge refs/notes/ &&
 	test_must_fail git notes merge refs/notes/dir &&
 	test_must_fail git notes merge refs/notes/dir/ &&
-	test_must_fail git notes merge refs/heads/master &&
 	test_must_fail git notes merge x: &&
 	test_must_fail git notes merge x:foo &&
 	test_must_fail git notes merge foo^{bar
-- 
2.1.4
