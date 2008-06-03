From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] cat-file --batch: flush stdout also when objects are missing
Date: Tue,  3 Jun 2008 20:34:17 +0200
Message-ID: <1212518057-9137-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 20:35:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3bLf-0008OE-Dd
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 20:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbYFCSdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 14:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755339AbYFCSdy
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 14:33:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:27426 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260AbYFCSdx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 14:33:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1105169fgg.17
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=EYACLl17z0Eq4kCirVDw8PoS17DmjJSjtYl9hsjGgOE=;
        b=ArfYO0wiOyWfohsMA+vuzxZasGIYSPiPZfhkDckMcLhGLX5sIt97ctuFA+/ZHXHK0t/BAVRzbfY4M/qhvC0ml7AF15z0dcnP8iOvJsyGzIIIwYtW6I3o7Kcic+jw4+MJQdMvuUzZeNaTKaAbVVx5/jSgxB+Ucf1qZAa0GhJQLTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=I7R+9LaDSaHaDlNLnfabXZsjupl3F7xxjpmZJuLcPthYP5Xgmmi0tSgGzMYK0kq/86iRk/xaFIkr9CmJ+AGPRB1IaluUljMbvmU2xgm0NNQx3v1zmYb4gXX9/FogrPccOdNNI+FM5ctP+WvSmC0L3FblSPGb4obhlhRQof9x3tg=
Received: by 10.86.71.1 with SMTP id t1mr5313751fga.36.1212518031853;
        Tue, 03 Jun 2008 11:33:51 -0700 (PDT)
Received: from fly ( [91.33.209.222])
        by mx.google.com with ESMTPS id 12sm443740fgg.0.2008.06.03.11.33.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 11:33:50 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K3bKr-0002Nj-7V; Tue, 03 Jun 2008 20:34:17 +0200
X-Mailer: git-send-email 1.5.6.rc0.92.g27fd.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83688>

cat-file --batch/--batch-check only flushes stdout when the object
exists, but not when it doesn't ("<object> missing").  This makes
bidirectional pipes hang.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
 builtin-cat-file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 200345e..f8b3160 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -159,6 +159,7 @@ static int batch_one_object(const char *obj_name, int print_contents)
 
 	if (get_sha1(obj_name, sha1)) {
 		printf("%s missing\n", obj_name);
+		fflush(stdout);
 		return 0;
 	}
 
-- 
1.5.6.rc0.92.g27fd.dirty
