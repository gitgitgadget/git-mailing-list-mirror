From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 15/16] t8001/t8002: blame: add tests of -L line numbers less than 1
Date: Tue,  6 Aug 2013 09:59:48 -0400
Message-ID: <1375797589-65308-16-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:01:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hpB-0003t2-Ft
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab3HFOBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:01:07 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:39541 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100Ab3HFOA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:57 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so750846oag.31
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f2H4nKD0j9L8MkwrryJtBVlFvanKoMpDzd3k7e3yBXM=;
        b=SDvj13mnHd56leYEnd2mVHsLSUFJmGD0uZ+IQOUGZ07lMc5JGsJTAaQhcbjYHq7hk1
         v8JpbIfMQYN8wjXgAXvOl6b7PaOWBq3LZ63G9ezoi+vzvq6bdGwZYYJbGUfFAETJBeZK
         t+FIC6kY3772wAEbY0/SvDYompljSFH4MCmRfA4aZ2DE6ep9M3htkOvAJaJ3m6VRVhAL
         6hamwkPJECzpJSAAcph8jhbYnQfokx1A4D3dp4+mrZVibemqf10AmWfOryy9SHZO6x3s
         43p4tZ/TvI3Ac70W8jRhFNndRKq3QsAQ7PL3yTrva26zDvywmo77CoKiF6spqgtl58sz
         51Nw==
X-Received: by 10.182.56.232 with SMTP id d8mr1051151obq.96.1375797657047;
        Tue, 06 Aug 2013 07:00:57 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231753>

git-blame -L is documented as accepting 1-based line numbers. When
handed a line number less than 1, -L's behavior is undocumented and
undefined; it's also nonsensical and should be rejected but is
nevertheless accepted. Demonstrate this shortcoming.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/annotate-tests.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index dabe89d..376b042 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -185,6 +185,18 @@ test_expect_success 'blame -L Y,X (undocumented)' '
 	check_count -L6,3 B 1 B1 1 B2 1 D 1
 '
 
+test_expect_failure 'blame -L -X' '
+	test_must_fail $PROG -L-1 file
+'
+
+test_expect_failure 'blame -L 0' '
+	test_must_fail $PROG -L0 file
+'
+
+test_expect_failure 'blame -L ,0' '
+	test_must_fail $PROG -L,0 file
+'
+
 test_expect_success 'blame -L ,+0' '
 	test_must_fail $PROG -L,+0 file
 '
-- 
1.8.4.rc1.409.gbd48715
