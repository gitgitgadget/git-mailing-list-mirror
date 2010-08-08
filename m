From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 5/9] stash: teach git stash drop to fail early if the specified revision is not a stash reference
Date: Sun,  8 Aug 2010 14:46:07 +1000
Message-ID: <1281242771-24764-6-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, nanako3@bluebottle.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 06:47:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohxnf-0007rb-6F
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 06:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993Ab0HHErw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 00:47:52 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37021 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab0HHErv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 00:47:51 -0400
Received: by mail-px0-f174.google.com with SMTP id 14so3342990pxi.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 21:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=K+RGnrwfDX2UccKykg7GyeNmhIV4viVTUHtu1OHnegE=;
        b=Y5J6+U3ijxSzRT2H9+DoW5Hi2UlDkpdBj/TVOO51kGrqbSfsa68Qa6pPFGs/sVWszA
         iQL4MW6Ie7vH+TZaAubGkv33qZkKM9OZ+Hmj4SwMtHFwNJNkbKYL4kELsp3pGr/X5hYW
         lWu505VaeDBmVGwPdFagoc5xWynRVRGImgdw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VSpsURnjlk4gho7i/uRt6gJLNE1METgAvXQ6rfDJNysictK6laQqINEkOLIZjxCNjc
         4ApKsV95NbfFld1S2+gOHW8CbEHZtXNV7JziuFQHRNrB/dqphCIGio9I9EySfXc56geh
         Xtl0NzFWHh54vB2eVeCb5+XxqUw/LrXTJWXx4=
Received: by 10.142.132.18 with SMTP id f18mr12074831wfd.263.1281242871033;
        Sat, 07 Aug 2010 21:47:51 -0700 (PDT)
Received: from localhost.localdomain ([120.16.216.92])
        by mx.google.com with ESMTPS id n2sm4295884wfl.13.2010.08.07.21.47.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 21:47:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.47.gc532
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152888>

Previously, git stash drop would fail noisily while executing git reflog
delete if the specified revision argument was not a stash reference.

Now, git stash drop fails with an error message which more precisely
indicates the reason for failure.


Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4f28c09..86cd446 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -379,6 +379,7 @@ drop_stash () {
 		shift
 	fi
 
+	assert_stash_ref "$@"
 	assert_stash_like "$@"
 
 	git reflog delete --updateref --rewrite "$@" &&
-- 
1.7.2.1.51.g82c0c0
