From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/2] submodule::module_clone(): silence die() message from module_name()
Date: Fri,  7 Oct 2011 17:04:55 +0800
Message-ID: <1317978295-4796-2-git-send-email-rctay89@gmail.com>
References: <1317978295-4796-1-git-send-email-rctay89@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 11:05:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC6Mw-0007JI-BH
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 11:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935643Ab1JGJFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 05:05:11 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47276 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759633Ab1JGJFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 05:05:09 -0400
Received: by mail-iy0-f174.google.com with SMTP id k32so3980735iak.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 02:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DZph2edfD2WtHA9twtQcy/aGqhDKCtkwie/XTSE1J4E=;
        b=qJ5sJYgt17SnpVSmbjFx/9kaGybPdlst2aSSJDajsQBMP6qW5efoXuVb6ZtnpJYeWy
         04YGb0N9k6NRDeLN7HZeJx0lPwFrIXIqW1Pfh5wOuqanyDF4SNB7ZsVqbXlkFh1XeB2m
         cc5rWyoG28wVLzetixWHf18IFA2wpu82kTEWc=
Received: by 10.231.42.74 with SMTP id r10mr2851016ibe.72.1317978309520;
        Fri, 07 Oct 2011 02:05:09 -0700 (PDT)
Received: from localhost (nusnet-198-15.dynip.nus.edu.sg. [137.132.198.15])
        by mx.google.com with ESMTPS id ee29sm18397440ibb.9.2011.10.07.02.05.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 02:05:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.msysgit.0.584.g2cbf
In-Reply-To: <1317978295-4796-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183069>

The die() message that may occur in module_name() is not really relevant
to the user when called from module_clone(); the latter handles the
"failure" (no submodule mapping) anyway.

Leave other callers of module_name() unchanged, as the die() message
shown is either relevant for user consumption (such as those that exit()
when the call fails), or will not occur at all (when called with paths
returned by module_list()).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ebea35b..3adab93 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -130,7 +130,7 @@ module_clone()
 
 	gitdir=
 	gitdir_base=
-	name=$(module_name "$path")
+	name=$(module_name "$path" 2>/dev/null)
 	base_path=$(dirname "$path")
 
 	gitdir=$(git rev-parse --git-dir)
-- 
1.7.7.584.g16d0ea
