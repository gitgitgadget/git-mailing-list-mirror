From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/23] expire_reflog(): pass flags through to expire_reflog_ent()
Date: Fri,  5 Dec 2014 00:08:27 +0100
Message-ID: <1417734515-11812-16-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWq-0003Hk-8L
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933368AbaLDXJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:09:39 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:65152 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933333AbaLDXJD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:09:03 -0500
X-AuditID: 1207440d-f79976d000005643-7e-5480e98ea88b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 12.16.22083.E89E0845; Thu,  4 Dec 2014 18:09:02 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8deC027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:09:01 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqNv3siHE4GC7okXXlW4mi4beK8wW
	b28uYbS4vWI+s0Vv3ydWi82b21kc2Dz+vv/A5LFz1l12jwWbSj0uXlL2+LxJLoA1itsmKbGk
	LDgzPU/fLoE7Y+f0U6wFJ9gqNvW8Z29gXM7axcjBISFgIvHvY1UXIyeQKSZx4d56ti5GLg4h
	gcuMEt3zu6CcY0wSPxZPYQGpYhPQlVjU08wEYosIqEnMXDUbrIhZ4ASjxK/J3YwgCWGBQImj
	Lzewg9gsAqoS15a+YwWxeQVcJW6tnMAGsVlOYus6b5AwJ1B46sxWsFYhAReJZ5sWsk9g5F3A
	yLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdILzezRC81pXQTIyS0eHcw/l8nc4hRgINRiYe3
	YHd9iBBrYllxZe4hRkkOJiVR3rNPG0KE+JLyUyozEosz4otKc1KLDzFKcDArifAaHwHK8aYk
	VlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeLleADUKFqWmp1akZeaUIKSZ
	ODhBhnNJiRSn5qWkFiWWlmTEgyIjvhgYGyApHqC9ZSDtvMUFiblAUYjWU4y6HC1Nb3uZhFjy
	8vNSpcR5rUGKBECKMkrz4FbAEskrRnGgj4V5S0GqeIBJCG7SK6AlTEBLzjbUgiwpSURISTUw
	ai3Zo3TJZZpz0KltJXMUHOpyXfi8W6UumKwwTQ6Tt5PWynvw7kbEwhu/lsjdXjT7TKi9aAdb
	xJzZecnrrLyMbctfzJ/zZu4i7Uu63qXlK5kbp9UcjnaU+LOnpl0r0vb4lfrUpsap 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260827>

Add a flags field to "struct expire_reflog_cb", and pass the flags
argument through to expire_reflog_ent(). In a moment we will start
using it to pass through flags that expire_reflog_ent() needs.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 5dfa53a..1512b67 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -46,6 +46,7 @@ struct expire_reflog_policy_cb {
 };
 
 struct expire_reflog_cb {
+	unsigned int flags;
 	void *policy_cb;
 };
 
@@ -437,6 +438,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 
 	memset(&cb, 0, sizeof(cb));
 	memset(&policy_cb, 0, sizeof(policy_cb));
+	cb.flags = flags;
 	cb.policy_cb = &policy_cb;
 
 	/*
-- 
2.1.3
