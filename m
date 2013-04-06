From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] remote-helpers: remove --graph in hg_log()
Date: Sat,  6 Apr 2013 18:00:55 +0200
Message-ID: <1365264055-30507-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:30:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWWt-0001D7-G0
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423257Ab3DFQBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 12:01:34 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:42646 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423233Ab3DFQBb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 12:01:31 -0400
Received: by mail-wg0-f53.google.com with SMTP id c11so4772273wgh.32
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=tgO6fj/GGN1K6u1wKZYyKc57GuAOQnSgMmsaVbnoDDs=;
        b=uDIZKBKKiSlTDeuEy8byx2fdKTAzLviy+aFLlO8WocWCHzj/ITBTsiRiA4OenLcaUX
         U5N9UD96NyGE9WSzZbwzRklyjxr7AvE8TX23YOF+Of7sNkDUEK0E4yc4citE+nmGjfMn
         MLnXde8Y1fin3y3R19mwXcvJp5ACEBfAaRO3uJtYVAgCGrop0Yv6zceKiMAWs3pkx2jF
         1QgtEV/SYhCutRzW/Iz7gg3kDCBxz16MIgPbQGNv86KIQPRsLB3cLvFd4GoBN4OJnk90
         9a17793E4u8ob54QJixTnH6/K1QftrHk3VVWyKQ8VU1RG0yJy4MQBJgR+KVVH1ghkb8F
         iM9w==
X-Received: by 10.180.149.227 with SMTP id ud3mr9822910wib.0.1365264090339;
        Sat, 06 Apr 2013 09:01:30 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id o5sm11023488wix.3.2013.04.06.09.01.28
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 06 Apr 2013 09:01:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220213>

The hg_log() test helper uses the "--graph" parameter that is
implemented by the GraphLog extension. If the extension is not activated
by the user, the parameter is not available. Do not use the option that
is unnecessary.

Also changes the way we grep the output in hg_log(). The pipe operator
can hide the return code of hg command. As a matter of fact, if log
fails because it doesn't know about "--graph", it doesn't report any
failure and let's you think everything worked.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
Hey Felipe,
I'm not so confident that --graph is useless to the test. If it's really
necessary, it would be nice either to activate it in setup() or to use
it just for the command through: "--config extensions.graphlog=".

Cheers,

 contrib/remote-helpers/test-hg-bidi.sh |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index 1d61982..96cd5a7 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -50,7 +50,8 @@ hg_push () {
 }

 hg_log () {
-	hg -R $1 log --graph --debug | grep -v 'tag: *default/'
+	hg -R $1 log --debug >log &&
+	grep -v 'tag: *default/' log
 }

 setup () {
--
1.7.9.5
