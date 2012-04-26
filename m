From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t5541: warning message is given even with --quiet
Date: Wed, 25 Apr 2012 22:44:38 -0700
Message-ID: <xmqqpqav9hdl.fsf_-_@junio.mtv.corp.google.com>
References: <vpqaa27bgon.fsf@bauges.imag.fr>
	<1334876234-20077-1-git-send-email-Matthieu.Moy@imag.fr>
	<1334876234-20077-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Apr 26 07:44:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNHVX-0006aX-Hr
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 07:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab2DZFom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 01:44:42 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:61795 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab2DZFol (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 01:44:41 -0400
Received: by lbbge1 with SMTP id ge1so34584lbb.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 22:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=zU2QjQ7ERbB5p9N6q8bkXjCQ08BdMOpGm6vKLG8yn0g=;
        b=fs/5u9ZpIoEXQm7+zBUMRc13QqTfwRDW/8IXEecb0e7SU9GCxCGr3WLJkK1sZCO27i
         Hn6Ylu7ESJLROF0uP0BWp9RncUxhlzHknGOjIGBcFC2hkVTJbaW8oqOf4c5b0M+IFyL2
         MgBqQj0iCPG+RMBSA7VD6jjGqTuuCyz+zKe6Eecpd+F76gMKcCT+A/vXqqSKEwnYdUUt
         /2K06jJkur7TEmwyzPycfTOphC4cFM2lyKmq0ZTlORif1KqzMTVs5GI6NT9mPC9+PNxg
         nYFNpcWOS0e6WO6oZrnF9dy2pVmj1pqWvH3M4F22pwujN5UXHLbws4vMZBL+F7cRboe8
         J7yA==
Received: by 10.14.47.80 with SMTP id s56mr1371897eeb.6.1335419079952;
        Wed, 25 Apr 2012 22:44:39 -0700 (PDT)
Received: by 10.14.47.80 with SMTP id s56mr1371884eeb.6.1335419079803;
        Wed, 25 Apr 2012 22:44:39 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si1889567een.0.2012.04.25.22.44.39
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 22:44:39 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 96B4F20004E;
	Wed, 25 Apr 2012 22:44:39 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id E14E3E125C; Wed, 25 Apr 2012 22:44:38 -0700 (PDT)
In-Reply-To: <1334876234-20077-4-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Fri, 20 Apr 2012 00:57:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQm8oVjw+llyGNQtPbD02Dyq8+gy+FGOUwrkXmwkxt0IsaSwP90d7l0BNEmy4pSUy2+zp+Fwl/1QZ3ncAXbdDTaJZK4DNh2bKP1Wu4ojILy1Igjlpt8RQg/J0qq2zdwQVaXyyVFSY3izpKOmEh+zWkPcuhyJymnDRzsCr/Mx9/gMl44lmKo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196352>

Explicitly set push.default to matching to avoid the warning message;
the test wants to verify there is no post-push report when --quiet is
given, and this message interferes with it.

This change is *iffy*, not in the sense that it breaks the test it
touches, but because it is unclear if the output should be given when
the user explicitly asked --quiet.

On one hand, --quiet is a request to be "quiet", but on the other hand,
this warning is meant to be shown in the face in large flashing red
letters no matter what the user says, so...

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5541-http-push.sh |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 5b170be..07fa199 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -64,7 +64,10 @@ test_expect_success 'no empty path components' '
 
 test_expect_success 'clone remote repository' '
 	rm -rf test_repo_clone &&
-	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone
+	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone &&
+	(
+		cd test_repo_clone && git config push.default matching
+	)
 '
 
 test_expect_success 'push to remote repository (standard)' '
-- 
1.7.10.475.g8b959
