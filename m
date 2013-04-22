From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/16] remote-hg: add custom local tag write code
Date: Mon, 22 Apr 2013 16:55:17 -0500
Message-ID: <1366667724-567-10-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 23:59:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOla-0003k2-3s
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059Ab3DVV7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:59:14 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:45762 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab3DVV7N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:59:13 -0400
Received: by mail-ob0-f176.google.com with SMTP id wd20so5819846obb.7
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=DgFwSjCY6pINUygbAzL4kiAJ9FKznhx4E7G8K3HNa9Q=;
        b=Sb84vG8XRwuV0wCzCRdDPpulPSaUSk5ytJmmOQ4Pf625bDrzIYQPRu0/NJV++XF46A
         /Kh7/8SSlvhA+kH6GrMrEs7K8yWpCax2syJsUTXB9/J5M5i+b6FisBVd1Y7V/6X+hdw9
         Hp3+qBOhYxuOdbJ3SNu6mGSfqCQOyCdHfy/YYSsDwbj9hE21aL1RtaBDxkj5a6BC0MH7
         CS9tXwSReATyIqDrri7RrtALgHvB+qVg8VF1KSuGGIsH7d4DkZjWlbJ5DHANBsLuVT3H
         CoawjxinJYIGKAz7Gs4nmsxV0TOyINSEMMAcAMhMIlQel44/T1vY7o22XokQvEGEe5vj
         u/uQ==
X-Received: by 10.182.38.201 with SMTP id i9mr4450412obk.55.1366667952864;
        Mon, 22 Apr 2013 14:59:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id it9sm20065365obb.6.2013.04.22.14.59.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 14:59:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222106>

There's no point in calling the tag method for such simple action. Not
that we care much about the hg-git compat mode, it's mostly just for
comparison testing purposes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index f685990..3c6eeb7 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -797,7 +797,9 @@ def do_export(parser):
                     msg = 'Added tag %s for changeset %s' % (tag, hghex(node[:6]));
                 write_tag(parser.repo, tag, node, msg, author)
             else:
-                parser.repo.tag([tag], node, None, True, None, {})
+                fp = parser.repo.opener('localtags', 'a')
+                fp.write('%s %s\n' % (hghex(node), tag))
+                fp.close()
             print "ok %s" % ref
         else:
             # transport-helper/fast-export bugs
-- 
1.8.2.1.790.g4588561
