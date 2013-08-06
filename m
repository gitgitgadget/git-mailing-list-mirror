From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 06/16] t8001/t8002: blame: add tests of multiple -L options
Date: Tue,  6 Aug 2013 09:59:39 -0400
Message-ID: <1375797589-65308-7-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:01:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hpA-0003t2-VP
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034Ab3HFOAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:00:39 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:38794 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309Ab3HFOAh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:37 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so919295obc.12
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+aA+oBlmqYWltF2odXfx0StVc1ldHl/efni/MxamLRI=;
        b=WmLsY6JmSzILE8K195HOZG9c+NqqzoVC923wfOCAWyMNCsPUpc8JavJzXf7fB6d5yC
         wNSuwZQ2ZvRmsfWmeXmH0c55IszBdVOw8Mvvt98oaBMInakkG8JRTecqqL2mrDjRgref
         27csdbUoopc/5pM/usCDG1qB7f7JpfrvbmWgwF6zF8qDTR9io0ANFuapscYGn3+k7bZ9
         70d/6NOHYt3ygAQVvcEfloMx0vd1DoaLvetBf/jqSoF4GtyFyIiemPu1bdgAdgYjo+kU
         ZygpUnWKpP48525hH9nL9/fDvQ74rDb4+0yhn9+H4VSzQG6Fd9Wi8YPvmg5njUt/iqPq
         lM6g==
X-Received: by 10.60.144.8 with SMTP id si8mr1037958oeb.97.1375797637154;
        Tue, 06 Aug 2013 07:00:37 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231752>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/annotate-tests.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index ce5b8ed..77083d9 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -271,6 +271,38 @@ test_expect_success 'blame -L ,Y (Y > nlines)' '
 	test_must_fail $PROG -L,12345 file
 '
 
+test_expect_success 'blame -L multiple (disjoint)' '
+	check_count -L2,3 -L6,7 A 1 B1 1 B2 1 "A U Thor" 1
+'
+
+test_expect_success 'blame -L multiple (disjoint: unordered)' '
+	check_count -L6,7 -L2,3 A 1 B1 1 B2 1 "A U Thor" 1
+'
+
+test_expect_success 'blame -L multiple (adjacent)' '
+	check_count -L2,3 -L4,5 A 1 B 1 B2 1 D 1
+'
+
+test_expect_success 'blame -L multiple (adjacent: unordered)' '
+	check_count -L4,5 -L2,3 A 1 B 1 B2 1 D 1
+'
+
+test_expect_success 'blame -L multiple (overlapping)' '
+	check_count -L2,4 -L3,5 A 1 B 1 B2 1 D 1
+'
+
+test_expect_success 'blame -L multiple (overlapping: unordered)' '
+	check_count -L3,5 -L2,4 A 1 B 1 B2 1 D 1
+'
+
+test_expect_success 'blame -L multiple (superset/subset)' '
+	check_count -L2,8 -L3,5 A 1 B 1 B1 1 B2 1 C 1 D 1 "A U Thor" 1
+'
+
+test_expect_success 'blame -L multiple (superset/subset: unordered)' '
+	check_count -L3,5 -L2,8 A 1 B 1 B1 1 B2 1 C 1 D 1 "A U Thor" 1
+'
+
 test_expect_success 'setup -L :regex' '
 	tr Q "\\t" >hello.c <<-\EOF &&
 	int main(int argc, const char *argv[])
-- 
1.8.4.rc1.409.gbd48715
