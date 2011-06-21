From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/13] revert: Don't check lone argument in get_encoding
Date: Tue, 21 Jun 2011 13:04:39 +0000
Message-ID: <1308661489-20080-4-git-send-email-artagnon@gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 15:05:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ0e5-00065X-R5
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 15:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756556Ab1FUNFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 09:05:04 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51876 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab1FUNE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 09:04:59 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so1679724vxb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=SHdyOzzNPdUlyst7KyQTaCyz9b3YjD579dDKv+6z+RY=;
        b=oH5QudQVHZ3AUH1NJ2t80i9fNPAEY1Y1kvhARC6vGk+/+q1FSBW0fi5/B0Le5U7Tmf
         +K9jUQm1V1+okSPH8cwQ6ZuXmi0wR10Jd6RmUSLQ0b6/8g7JWrfBkADL48JtqH6t+Ddo
         aOIvWBh7ILx+JP8tWSkX+fP1/3lmaoBE4CZDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QTTOcuTNJI08XN4RbSpceDBf5+M4nxdLZSrdr4nl8m4RJ4fpQLvxWmZgu1GKElMwcH
         du3H1TCePLoVlvtukL52iZXeRDElvW+tQdDEtVNM1jBe/AC1CNrpMicVq0ODp6fxyxIq
         +NiRdbrYUMR3LFa7NfurUv5whTHOmDMmYFd+8=
Received: by 10.52.175.132 with SMTP id ca4mr4964374vdc.98.1308661498725;
        Tue, 21 Jun 2011 06:04:58 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id k9sm1575853vbn.0.2011.06.21.06.04.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 06:04:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176142>

The get_encoding function has only one callsite, and its caller makes
sure that a NULL argument isn't passed.  Don't unnecessarily double
check the same argument in get_encoding.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index d6d2356..2de2e75 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -167,9 +167,6 @@ static char *get_encoding(const char *message)
 {
 	const char *p = message, *eol;
 
-	if (!p)
-		die (_("Could not read commit message of %s"),
-				sha1_to_hex(commit->object.sha1));
 	while (*p && *p != '\n') {
 		for (eol = p + 1; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
-- 
1.7.5.GIT
