From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] receive-pack: enable protocol v2
Date: Mon, 23 Feb 2015 19:12:42 -0800
Message-ID: <1424747562-5446-4-git-send-email-sbeller@google.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 04:14:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQ5x7-0002Kl-DW
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 04:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbbBXDOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 22:14:20 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34907 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbbBXDOS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 22:14:18 -0500
Received: by mail-ig0-f172.google.com with SMTP id l13so23524575iga.5
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 19:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=moroI5tSaeKAsjWJcj7vCkmNxYOkfXb5mKIUhEUCsOY=;
        b=phYneSZKvPNhGu85p+fr2mT7w1Oi3rejKonw10+M808i++zcCMb/MkUgv8WF2OZ7XX
         fqqGWPBbekD0a86cGESZgDJ/ThOrKMeUPD5GwkJkhaKGWW+qCATe98/LTD1wCDVl5Jdr
         dLJpFEkHTABj52X70p31WmUVsvBA7zeFjxPuFW7qplwb/k516KQPm5aVI2z7u98dlCvJ
         IUGpC/AJXyHKrhqfNj8yxtcbFdglrrjBCTChklnYfOPAo1ePC887wZfnxxsnWojOAy4N
         J+UEVH2YMBXT5DpY84Cl+0B0/xXZZRy1eT9sVPsERScqOvQb0GCLzYEhQk0vpTrDVfyJ
         QtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=moroI5tSaeKAsjWJcj7vCkmNxYOkfXb5mKIUhEUCsOY=;
        b=EvdjJuoUjTdxfMHNtgAVW4ufvQMj82EY8H59s52GtQkCoSbbjXH218eLUArdk1dbIC
         Wl6/PmWlLhioNX3l775keIYRRuCjbEuqtm0KYT1wm1lafvw8pDpWsOU+qo7H58I2NXOI
         /v8TsqmFQ1o0PCVhziSyV4milorQnRh6N+1qRTRcsKuTf55wbuIOSBroc91Z4BpF6mGh
         8tBJ8TaWqZfl99w429C+g+v0AXkslG2cwQQ7Fk1DU9b775AP13hs+3phVI7DZaGb25O0
         r4n2YTI4CKdvDcssBxn79/9hYvH82mkHjL0AvuaI+WVM4woPXlXimwF4KSeQvNKv1vtG
         7qIg==
X-Gm-Message-State: ALoCoQkMBUwMn+ShKS+N3SZAv3fO6II+Jfjm1W8/aUWQj2hTqtNDHAHv3r/TcNoeWxtl/I0ibh9L
X-Received: by 10.50.138.76 with SMTP id qo12mr17609557igb.36.1424747657225;
        Mon, 23 Feb 2015 19:14:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:acce:8652:941a:5856])
        by mx.google.com with ESMTPSA id y142sm1722609iod.25.2015.02.23.19.14.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Feb 2015 19:14:16 -0800 (PST)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1424747562-5446-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264306>

This string would tell the client that git-receive-packv2 as well as
git-receive-pack would be supported.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a077b1d..dcb231b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -71,7 +71,7 @@ static long nonce_stamp_slop;
 static unsigned long nonce_stamp_slop_limit;
 static struct ref_transaction *transaction;
 
-static const char *advertised_versions = NULL;
+static const char *advertised_versions =  "v2,";
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
-- 
2.3.0.81.gc37f363
