From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] branch_annihilated: don't use _name as temporary variable
Date: Sat,  9 Oct 2010 09:50:20 +0200
Message-ID: <efdb8c3889e39a36efc328acb1a5e5f55c24be5a.1286610589.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 09:50:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4UCi-0007CY-7k
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 09:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab0JIHue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 03:50:34 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61538 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab0JIHud (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 03:50:33 -0400
Received: by ewy23 with SMTP id 23so1004526ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ox4xVNPdgoiuzKKhRSAMM1wiztdcrxZGtz+r0MXuQ00=;
        b=PSHpF64H2jfrPEU/+SdCv2Nb6mRGyM7vjk/jcUH6KWL+4XNhJCp9s2qYoE65XGyen4
         oVW+XeCj5qHTUU64wyBlpZhmA1uEvU6wideiW4bthuKFhAdIkrlcguFLMtnL4hu7dK6f
         MQcglVBiM/ntQNaSlt2fzbJr+6gsEKkrgGkQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xhnqNgyWj4vjsH2Eg+yy3C5X063WLae4tS1yGS0kJNIdvXBNz8urNfRUbRF1x3HLsi
         GTJTsmQndSMhjA/9fB+17m+D7W85ItfRU2DErYsE3FMtRkvaOHNeSTxvhOQgQ4LQiR0U
         d8EzXACNeoJdHt5g7zmxx/6cKWNjKbFn7XaS0=
Received: by 10.213.20.17 with SMTP id d17mr564514ebb.21.1286610631399;
        Sat, 09 Oct 2010 00:50:31 -0700 (PDT)
Received: from localhost ([46.115.222.9])
        by mx.google.com with ESMTPS id u9sm6835774eeh.11.2010.10.09.00.50.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 00:50:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158574>

_name is used in recurse_deps as an external global. Be on the safe side
and don't use a local variable in branch_annihilated.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg.sh |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tg.sh b/tg.sh
index 3718702..b3c5004 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -120,12 +120,10 @@ has_remote()
 
 branch_annihilated()
 {
-	_name="$1";
-
 	# use the merge base in case the base is ahead.
-	mb="$(git merge-base "refs/top-bases/$_name" "$_name")";
+	mb="$(git merge-base "refs/top-bases/$1" "$1")";
 
-	test "$(git rev-parse "$mb^{tree}")" = "$(git rev-parse "$_name^{tree}")";
+	test "$(git rev-parse "$mb^{tree}")" = "$(git rev-parse "$1^{tree}")";
 }
 
 # is_sha1 REF
-- 
1.7.1.1067.g5aeb7
