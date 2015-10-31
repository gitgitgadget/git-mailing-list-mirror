From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 2/3] run-command: export child_process_clear()
Date: Sat, 31 Oct 2015 10:20:06 +0100
Message-ID: <563487C6.4050504@web.de>
References: <56348709.9080207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 10:20:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsSKm-0006FL-MM
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 10:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbbJaJUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 05:20:20 -0400
Received: from mout.web.de ([212.227.17.11]:51786 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbbJaJUS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 05:20:18 -0400
Received: from [192.168.178.36] ([79.253.163.201]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MCZtW-1ZkErt2m1q-009NAz; Sat, 31 Oct 2015 10:20:07
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <56348709.9080207@web.de>
X-Provags-ID: V03:K0:YohSIVKFRMkBEZ/IWo0tEqQtKhI7mHi5AMCWKu3v3AdySM1OuXg
 swbPnc/48cGRhc3pC0lVWirZHaH+SzvKFzCytho++GrcbcrRgloksnTdJQPxbBII+83LlkK
 iZwoq8p5zWQ4G8haiujN0RAeqD70QI5X/YaFbKexxWAoU7ioEGSvcleIhQxX6w6QEWVUULN
 yrGBWSuUQN1j6Y+EbqmLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7wBYffhX26E=:6sLmvmYDTS1Htj5DaRGIwu
 83ReoaoXv+sKmK9NKQyIeX/yauTX1AYW8Ph/qU6XIkNpEaDcxrDHvlZwfSK1BDGOXA0T8iiLZ
 Bo4Ry3BfN2BXcbQTXq8Tb4TI7bc0nNyxFHfWJxM5jaXQFggG2Z7gFSjP7RC45WhLK3gHtWhHC
 BicN0vl15ypJLio31nBjQOIFcKFE8Yvph5fqxO8DEa4VWxtUrtCl5iA4d8tkmtAP00iMRIFLn
 ptKEFSjcNwqXI5KpnIDpDHRwtKh2WtrTKeEtIgdnqE+gVVnCiyByUHumE7mO8ARPdNAhiu2lk
 6Tc+9ctWz6bo8ThpsGVaQeGX/WEbnSQXFTyB0Bw3HalcYYJH5y8QmcJJIdrXme+JVsrjSUBvc
 l5/aAhEXNpLtZecXDJ31XV8jpjlQTe0M7syJ+69RujDmSd0V/V5ixLVUQhQxMf5l/hSFgpz8I
 Aq4aA1Il+OViKaijk8qDfVrta60P9fui2HEw+1/TlXMWIOYyZyB+2rqv7tBMBGCAxZrKGbyoA
 Lc2BFLfnLbhkulRO+zrCGgNHqZhXu6tdRvKl8L/8jwMd6Yweb2olZtkVaXV4iwPNM3tOUsdsT
 77yd0GArTo/bCgA84cwEnvVSsAkeZppou7XNSsacqBd6shp/FuSu5zMY0RMEhgu7tHm5R9rK2
 C/ufZw6Qx4Jhxtox6P89uw5aFh8JvDjmCrlhSfufaZTL8bQaXaqlAeEXqB8dXDJB/sOGbygUJ
 RN6J6p/u01hpUba1miXuqFt4HA0i0iNPDKBcdZRT36uEr7CWKtzJwx3XAxU1KpKPY/FeSOzw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280573>

Make the API symmetric by including a cleanup function as a counterpart
to child_process_init().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/technical/api-run-command.txt | 7 +++++++
 run-command.c                               | 2 +-
 run-command.h                               | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index a9fdb45..8bf3e37 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -46,6 +46,13 @@ Functions
 	The argument dir corresponds the member .dir. The argument env
 	corresponds to the member .env.
 
+`child_process_clear`::
+
+	Release the memory associated with the struct child_process.
+	Most users of the run-command API don't need to call this
+	function explicitly because `start_command` invokes it on
+	failure and `finish_command` calls it automatically already.
+
 The functions above do the following:
 
 . If a system call failed, errno is set and -1 is returned. A diagnostic
diff --git a/run-command.c b/run-command.c
index b10ec75..0a3c24e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -13,7 +13,7 @@ void child_process_init(struct child_process *child)
 	argv_array_init(&child->env_array);
 }
 
-static void child_process_clear(struct child_process *child)
+void child_process_clear(struct child_process *child)
 {
 	argv_array_clear(&child->args);
 	argv_array_clear(&child->env_array);
diff --git a/run-command.h b/run-command.h
index 9fe37ee..e296bd2 100644
--- a/run-command.h
+++ b/run-command.h
@@ -47,6 +47,7 @@ struct child_process {
 
 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
 void child_process_init(struct child_process *);
+void child_process_clear(struct child_process *);
 
 int start_command(struct child_process *);
 int finish_command(struct child_process *);
-- 
2.6.2
