From: Nicolas Viennot and Sid Nair <nicolas@viennot.com>
Subject: [PATCH] git-submodule.sh: Always initialize $url variable
Date: Mon, 28 May 2012 05:41:54 -0400
Message-ID: <1338198114-20480-1-git-send-email-nviennot+sidnair@viennot.biz>
Cc: Nicolas Viennot and Sid Nair <nviennot+sidnair@viennot.biz>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Nicolas Viennot <nicolas@viennot.biz>,
	Sid Nair <sidnair09@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 28 11:43:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYwTh-0006Dy-R2
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 11:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab2E1Jmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 05:42:44 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:32806 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab2E1JmT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 05:42:19 -0400
Received: by vcbf11 with SMTP id f11so1368345vcb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 02:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=vMwcmGQ4qy7laPGQzNykTJt/ltJpq9plC9OrDQdxtg8=;
        b=YQswsLcOvs4MhBpl7QgKg9CZ81ipHlAYS/h+mLH9r0u1YQjZgh9cZI3rbymEJQHwyE
         ijJek5o8rGWy7rSB9tIUNXXM9KWfpSiw2oG1NFm6qFXI4NQkgYJryj8WMQKes8W1LdhT
         0or0LJUzog79VIHsHECZ7BkzMN3gs07ZeV4PD/+1ZJWdshTyyV0QrPPFg9gTRdwB53q2
         RPXDmseaTQfVYp6GwGT6jqPKipJuoHhBaSiGdotD6z6JQ7ZwlJcirXqWwdu5aHnEayNr
         EytYo/n22Af9xLL8XCjcAxi2FigJGJRZg8bCkfniM+FMevgJ3jbziD+Z0sEBqVR8VaNa
         y4Yg==
Received: by 10.52.73.42 with SMTP id i10mr6548299vdv.116.1338198138422;
        Mon, 28 May 2012 02:42:18 -0700 (PDT)
Received: from smtp.gmail.com:587 (cpe-72-229-241-198.nyc.res.rr.com. [72.229.241.198])
        by mx.google.com with ESMTPS id o15sm18140005vdi.15.2012.05.28.02.42.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 02:42:17 -0700 (PDT)
Received: by smtp.gmail.com:587 (sSMTP sendmail emulation); Mon, 28 May 2012 05:42:15 -0400
X-Mailer: git-send-email 1.7.8.6
X-Gm-Message-State: ALoCoQkRYIA8Ao+xge5DByAP8JrYHRh8u06itp5icRcpbbLV3rlp4sVhhX4qSAupwAkQScP+beKE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198638>

When git submodule init was called, the $url variable was not initialized
properly for submodules which have already been initialized. This led
to two problems.

First, when all of the submodules were initialized, each showed an empty url
instead of the actual url.

Second, when previously initialized submodules were printed after newly
added submodules, the displayed urls were incorrect.

Cc: Jens Lehmann <Jens.Lehmann@web.de>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Nicolas Viennot <nicolas@viennot.biz>
Signed-off-by: Sid Nair <sidnair09@gmail.com>
---
 git-submodule.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 64a70d6..92fd6e2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -396,11 +396,11 @@ cmd_init()
 	module_list "$@" |
 	while read mode sha1 stage sm_path
 	do
-		# Skip already registered paths
 		name=$(module_name "$sm_path") || exit
+		url=$(git config -f .gitmodules submodule."$name".url)
+		# Skip already registered paths
 		if test -z "$(git config "submodule.$name.url")"
 		then
-			url=$(git config -f .gitmodules submodule."$name".url)
 			test -z "$url" &&
 			die "$(eval_gettext "No url found for submodule path '\$sm_path' in .gitmodules")"
 
-- 
1.7.8.6
