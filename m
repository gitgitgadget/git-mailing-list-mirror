From: Abbaad Haider <abbaad@gmail.com>
Subject: [PATCH] http-push.c: make CURLOPT_IOCTLDATA a usable pointer
Date: Sat, 5 Jul 2014 20:43:48 -0400
Message-ID: <53b89d7a.030d320a.0760.206f@mx.google.com>
References: <53b8918c.ca6d320a.7df8.18ac@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 02:51:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3afh-000623-2A
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 02:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbaGFAvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2014 20:51:09 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:51114 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbaGFAvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2014 20:51:08 -0400
Received: by mail-ig0-f180.google.com with SMTP id h18so3286455igc.1
        for <git@vger.kernel.org>; Sat, 05 Jul 2014 17:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:in-reply-to:references:date:subject;
        bh=vGg7EgjybYdpw5MKlF34uy8k+NsG4bt1zgUCDCCjI0M=;
        b=rB1+rmtdyPXmJ7Iu441pa3iOKPLmezBVdNKBQvEeIgD1hs2+XVroUcLCrnTcrN1t0b
         X+PsyPvvWZKF3tlKvqe4aHTSMWyz7lr1v97FzhCij0wJCZ+ksr0RqI76UuwY7s8Dw3/h
         8m/fsMBXmNwkk+4/nUnyJlIA+0Gy/Pi9KfIzxIliL+QBJriSrBUXDN2KQPnksfJ6ezTe
         uVNOhIeaBSMOg0MLetspDL3eBnT5zWvUbfEDP/1g5thNctAd6mY3gX4yPCTANeslyrl5
         n86A2DnOOQx6LJC/j1S69bEgwAlzUzUOAUxNvWu9d20UiQXGDwQnSgILJWU2vBUWBhp/
         KFhQ==
X-Received: by 10.50.30.228 with SMTP id v4mr27166224igh.26.1404607867339;
        Sat, 05 Jul 2014 17:51:07 -0700 (PDT)
Received: from localhost (cpe-71-74-112-172.neo.res.rr.com. [71.74.112.172])
        by mx.google.com with ESMTPSA id d3sm76209450igc.17.2014.07.05.17.51.06
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jul 2014 17:51:06 -0700 (PDT)
In-Reply-To: <53b8918c.ca6d320a.7df8.18ac@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252922>

Fixes a small bug affecting push to remotes which use some sort of
multi-pass authentication. In particular the bug affected SabreDAV as
configured by Box.com [1].

It must be a weird server configuration for the bug to have survived
this long. Someone should write a test for it.

[1] http://marc.info/?l=git&m=140460482604482

Signed-off-by: Abbaad Haider <abbaad@gmail.com>
---
 http-push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index f2c56c8..bd42895 100644
--- a/http-push.c
+++ b/http-push.c
@@ -199,7 +199,7 @@ static void curl_setup_http(CURL *curl, const char *url,
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
 #ifndef NO_CURL_IOCTL
 	curl_easy_setopt(curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
-	curl_easy_setopt(curl, CURLOPT_IOCTLDATA, &buffer);
+	curl_easy_setopt(curl, CURLOPT_IOCTLDATA, buffer);
 #endif
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
 	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
-- 
2.0.1
