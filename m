From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] imap-send.c: support GIT_CURL_VERBOSE
Date: Tue,  6 Jan 2015 03:00:55 -0800
Message-ID: <ce80e4296739f2fce0d70ddf4a710fb@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Tue Jan 06 12:02:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Rsr-0003y4-2o
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 12:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbbAFLBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 06:01:03 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:50260 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbbAFLBC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 06:01:02 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so30899167pad.29
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 03:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nQDurtMnUPdx8lyCBhbquP+Z6y8UBvry4d9ZujptlcY=;
        b=OuTLoA/QXr+KyS5qZGFsGJkRO5iZdC/s2WxdAwgiuzPyIDPoS4FVkvDy2q0J2M6zd+
         58e0NYynnoA294dOd7E16me2K/8MbRSF2feMTQO7F4xg4OAr2qz/51aG9ZgmQfB/0G5g
         jxvQtTl2pNTpaQbytqPRfGvXxkAIXr2LVkjEEACpBHF4Muhn4PIvwLHZtKz5cQbt9yBR
         azbg8ujwCnn5VbrccuTP53J/DxPEyV87Ue9OhXc/1yr2dwUl66RsP/sKRpYeyD3D62z+
         aD5ws4/fq3BPogmwJv+SZ+fHmJwhmgRAqjl2O3QD44DKWD3oPTjE+yX1LDcuJlE6Etre
         4TfQ==
X-Received: by 10.68.224.6 with SMTP id qy6mr129617393pbc.155.1420542061749;
        Tue, 06 Jan 2015 03:01:01 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id vb4sm57058092pab.19.2015.01.06.03.01.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 03:01:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262057>

When using git-imap-send to send via cURL, support setting
the GIT_CURL_VERBOSE environment variable to enable cURL's
verbose mode.

The existing http.c code already supports this and does
it by simply checking to see whether or not the environment
variable exists -- it does not examine the value at all.

For consistency, enable CURLOPT_VERBOSE when GIT_CURL_VERBOSE
is set by using the exact same test that http.c does.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

*** PATCH IS AGAINST NEXT ***

In particular, this patch requires br/imap-send-via-libcurl


 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 4dfe4c25..060df834 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1431,7 +1431,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
 
 	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
 
-	if (0 < verbosity)
+	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
 
 	return curl;
-- 
2.1.4
