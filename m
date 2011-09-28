From: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
Subject: [GUILT 2/6] guilt-header: fix patch corruption
Date: Wed, 28 Sep 2011 15:15:20 +0100
Message-ID: <1317219324-10319-2-git-send-email-alan.christopher.jenkins@googlemail.com>
References: <1317219324-10319-1-git-send-email-alan.christopher.jenkins@googlemail.com>
Cc: git@vger.kernel.org,
	Alan Jenkins <alan.christopher.jenkins@googlemail.com>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Wed Sep 28 16:16:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8uwS-0007Ie-Do
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab1I1OQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 10:16:51 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57348 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab1I1OQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 10:16:51 -0400
Received: by wyg34 with SMTP id 34so31170wyg.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CktiH6/xZUtNv9i+aGYkHxjdIyhcnqbWqLVga1QEmA4=;
        b=V+Y7ZTz9DSeCZUDaWNxNIS7vniJULHldQXPzM0Zlxs9D2qWSX8BZvKE2XyM7NcK3C3
         l0xt3h7KxPuzrDD5AUBA2V2bU4eltOlxweZhK1mKNeVC6pDYA5eR/TWInAJxHlDL+V9N
         k8LUeBXG+Do1D5B+cdOyRoNW4M1Iv/Qf+Q4Vk=
Received: by 10.227.157.206 with SMTP id c14mr10269177wbx.47.1317219410017;
        Wed, 28 Sep 2011 07:16:50 -0700 (PDT)
Received: from localhost.localdomain ([86.53.68.233])
        by mx.google.com with ESMTPS id n21sm40795936wbp.2.2011.09.28.07.16.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Sep 2011 07:16:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1317219324-10319-1-git-send-email-alan.christopher.jenkins@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182320>

Hunks containing the string "END{}" were being corrupted.

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
---
 guilt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/guilt b/guilt
index 51532f9..5d79e0f 100755
--- a/guilt
+++ b/guilt
@@ -341,7 +341,9 @@ do_get_patch()
 {
 	cat "$1" | awk '
 BEGIN{}
-/^(diff |---$|--- )/,/END{}/
+/^(diff |---$|--- )/ {patch = 1}
+patch == 1 {print $0}
+END{}
 '
 }
 
-- 
1.7.4.1
