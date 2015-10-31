From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 2/5] wt-status: exit early using goto in
 wt_shortstatus_print_tracking()
Date: Sat, 31 Oct 2015 18:36:01 +0100
Message-ID: <5634FC01.8050601@web.de>
References: <5634FB59.1000506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:36:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsa4a-0002sF-FM
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbbJaRgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:36:09 -0400
Received: from mout.web.de ([212.227.17.11]:50744 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039AbbJaRgG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:36:06 -0400
Received: from [192.168.178.36] ([79.253.163.201]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MVLWc-1ZyV3M2aCM-00YjqB; Sat, 31 Oct 2015 18:36:02
 +0100
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5634FB59.1000506@web.de>
X-Provags-ID: V03:K0:UdEJdkwob21f6DhqvFbvtfVracD6FkNQCJ5tnnHt8TP3RGeoR8f
 zhwJW7A7FbTYEakAGfd6LSJlO0gTYwHb+mipe8Py1Umpz4Ala2Ki1vACfa4YErOJZSjAUhO
 oeOWv3Q7HEXY7qBwYVnSJGcOtgoKP525GniCgxUSHMMrSHwVenuYivwIv2pMbtO0VvJaOQ6
 P9tozoxhAo3coWV7sMKbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3maxC3fU5KM=:arKea9eXaKaZQ5GUWZNRcQ
 /nucvz0vbY2hQsv67Q87tg7Nq7cV8OyRhT20l5sxlNtAEeVM/sCjl7MfmxLHkC45hHW29eWDW
 dbnw4gSFWt3mh+A8M/8jcrdasOhxLtZb1J5eWh1jkSUbEY+8vtrqJ/qexrhw5EL9kZJrKXbv+
 QZyRQa7Af6QIz3MCYWQc0R4p9p9BpXEn0ftSfNg7wH5NtI8z8uNhl23tmJDgp4ZlViq+j4o9w
 pQA8EVcJbYl+7u1taU6+f7hTkR1woannURw98f1NLbdmnRq+8tW6mLC4t+H8siI/AOV1a5s0m
 YoRJ7mO6V1migPYwE4NpGk11EBT2y/wzwvyCMXKd+fqeshcXt5WZRw8bvKFLwvYdhZ5y7BpNk
 XT23CvcIv+s4JKN1SpkCqvJfMC97q9FmjODp2fLTfcrzuPQaCuUp1HhLSu3WEUkUrOdmZv5ZH
 XkHSfaWLzZA2/KJxiZAQF7nnhPIFXlY0dJVI4KXbzJ6TeqqSAHM9oR+7XNhTU22z8NXZ/30yI
 qq5HQ10dVslZIfCB0x7XnehzbYebnZI5ZGhV3GSRD9j2WvtsTyHe5ZsbOXhzaqyKOP2MYCBNZ
 9ThjAaeHAkhnH10YtvLoiOZBDKsxiKH0nRGQ+cIWjfHjkOZ5GA8v3447RuWNBfSSMjBtKwC/S
 4XSdsv8MbcBmXlRBMROoMYlCrIa0ecYrFItAZPkBZwU9IhN4Sfr9yNH4bDNcb781v2CPlIemx
 XSV5eAWPwJuOeeHtOX/Z7WoTRxT5wVozimXzXlEEbqsNhjZh8i8vFPi2oa+uUm+rb/LuatQD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280588>

Deduplicate printing the line terminator by jumping to the end of the
function.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 wt-status.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 3e3b8c0..083328f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1658,10 +1658,8 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
 	if (stat_tracking_info(branch, &num_ours, &num_theirs, &base) < 0) {
-		if (!base) {
-			fputc(s->null_termination ? '\0' : '\n', s->fp);
-			return;
-		}
+		if (!base)
+			goto conclude;
 
 		upstream_is_gone = 1;
 	}
@@ -1671,10 +1669,8 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	color_fprintf(s->fp, branch_color_remote, "%s", base);
 	free((char *)base);
 
-	if (!upstream_is_gone && !num_ours && !num_theirs) {
-		fputc(s->null_termination ? '\0' : '\n', s->fp);
-		return;
-	}
+	if (!upstream_is_gone && !num_ours && !num_theirs)
+		goto conclude;
 
 #define LABEL(string) (s->no_gettext ? (string) : _(string))
 
@@ -1695,6 +1691,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	}
 
 	color_fprintf(s->fp, header_color, "]");
+ conclude:
 	fputc(s->null_termination ? '\0' : '\n', s->fp);
 }
 
-- 
2.6.2
