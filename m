From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 15/20] t/t5000-tar-tree.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:58 -0700
Message-ID: <1402066563-28519-16-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZM-0001vC-84
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbaFFO4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:25 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:49069 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbaFFO4W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:22 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so2586439pbc.30
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gsoAHCxGHKWAtVfqIKoO8JSfqx/VcXmwH6IKZYQW4lc=;
        b=M1od7fiqw4fyve46BpvuD3OC0yW5Tf+JMvzahBlC2VJIuzWKMjFR201+MByIWSZy8f
         K4JH9kjLcEfGk8AZOKPWxSnuuLXEPBRZF0UDqbbvM5Lu5X3QPrYDj6l8vlZtHHnAHXj2
         MmLo+W7VAIgCa1MUXvW7FWIr27TMHJZAqU7OltYJz5/sOhKzXEfM9CEwjVmZYcC1TgSs
         c8A8JeC9DboQqTM+RN/bfau/WzJfeCVty1YiKIj+iYJfB4FUXiQBbU9yJKi7qK3+oQUb
         mIsQgggdJ7tCZoNXer+CXperADbvn8God3QbkJvZiZ/sU4prIgPTnbZ2RD+rkc5scV8+
         qHBA==
X-Received: by 10.68.143.231 with SMTP id sh7mr1928965pbb.7.1402066581840;
        Fri, 06 Jun 2014 07:56:21 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250926>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5000-tar-tree.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 74fc5a8..ad6fa0d 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -72,7 +72,7 @@ check_tar() {
 			for header in *.paxheader
 			do
 				data=${header%.paxheader}.data &&
-				if test -h $data -o -e $data
+				if test -h $data || test -e $data
 				then
 					path=$(get_pax_header $header path) &&
 					if test -n "$path"
-- 
1.7.10.4
