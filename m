From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 05/31] "guilt new": Accept more than 4 arguments.
Date: Fri, 16 May 2014 16:45:52 +0200
Message-ID: <1400251578-17221-6-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:47:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJQN-0006of-2B
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371AbaEPOrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:47:48 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:53283 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806AbaEPOrq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:47:46 -0400
Received: by mail-la0-f42.google.com with SMTP id el20so2049181lab.29
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/UBtkyS4x5yp+uLdAKyYSdwdgNBIs1qtCfLGd2nzws=;
        b=cmHDeKyH7ibgvzBfJwqS9WiLZ1I/o6YXT8mDM/JLk35LWxamZGaH6CbdxC0oddqjZ9
         0Pki6Z0lRd/NWFKIzXufS6w+NTOcT2xzO0B7jvAOz9HP/AFpzQKfNP8frSCllholkKXd
         HIhpCvbaqj28NBfz78bqAVBZ8oesNvmT84Z4b2RByIg5G7Kx2p1aXfbEOoXsD4vqYln7
         aCF7yVqLRjzhMPvNZ8AG7hns/amCTTzLO+J/kevWS5PyadsLVYagJUyy77Gl2nk4CGzJ
         urbKPMFE0v60yfiEAOH1mVMlAOTE2AJ2x4vJ01jsv1Ka8vWPoxZstlz19IVm/TBkzFyo
         9ebA==
X-Gm-Message-State: ALoCoQn6eyn7pTswBZ4uk/oSjOSTXeyiRQ/I2I4c/VyoWobP8JwTD0vxPBjWPzfFmIYcPFiLrZGh
X-Received: by 10.152.6.131 with SMTP id b3mr12620895laa.9.1400251665180;
        Fri, 16 May 2014 07:47:45 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.47.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:47:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249311>

The argument parser arbitrarily refused to accept more than 4
arguments.  That made it impossible to run "guilt new -f -s -m msg
patch".  Removed the checks for the number of arguments from the
"guilt new" parser -- the other checks that are already there are
enough to catch all errors.

Give a better error message if "-m" isn't followed by a message
argument.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt-new | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/guilt-new b/guilt-new
index bb68924..9528438 100755
--- a/guilt-new
+++ b/guilt-new
@@ -11,10 +11,6 @@ fi
 
 _main() {
 
-if [ $# -lt 1 ] || [ $# -gt 4 ]; then
-	usage
-fi
-
 while [ $# -gt 0 ] ; do
 	case "$1" in
 		-f)
@@ -31,6 +27,9 @@ while [ $# -gt 0 ] ; do
 			fi
 			;;
 		-m)
+			if [ $# -eq 1 ]; then
+				usage
+			fi
 			msg="$2"
 			shift
 
-- 
1.8.3.1
