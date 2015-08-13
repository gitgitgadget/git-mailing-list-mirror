From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 5/7] transport: Remove git_transport_options.push_cert
Date: Thu, 13 Aug 2015 15:00:49 -0400
Message-ID: <1439492451-11233-6-git-send-email-dborowitz@google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 21:01:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxkc-0003I7-W7
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbbHMTBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:01:06 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37025 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbbHMTBA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:01:00 -0400
Received: by igui7 with SMTP id i7so5792014igu.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UByGPUEKWQ5gzsF5XlX57xh2xOx38nyrOsFL34wuALk=;
        b=BUDLY0/7RhlzGloaMCPPvkSclowmbDzg9dQn0rm+NGPemN3rRVt7tHXaJEN/ku9s55
         hGqBW+LzRtrPW79meU5mPt1qgGzEhH0GZaJNSAQUrumT5XkEU4Pe/oz7KurvOrcVl0p9
         34QegZIhREFp0HfDNm2rPeDsvYDiRCzumstmnr8Bzfu9i5DHoAJCv6RcknNU9hGBXFsL
         hQtEdkFYWPztl1xlRuI39Ar2gNhr+PZ3osyFLOY/uZcGVoMbEQdNwQNPfivAaWNW8kLX
         m751vVnlv4Yi1xdHYsOuQTLP7yrX878LkuPDA40bJkHBZu1F9X++bfKsOyWDPwvCSEGc
         eGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UByGPUEKWQ5gzsF5XlX57xh2xOx38nyrOsFL34wuALk=;
        b=mzbeSWvEp7Mv7iLjkRsYZcgHRTN0yziaV/KK7owpKn4JO/4Wrkn/f725QeHlBSzlqF
         TD90uETUB4yket7pof784lNnypQEh2HIAlJYMFew8DkB8pUUPYi5clcT1bGSHqZszAsN
         ip/u6kN2pPqRc/Yo2hjqCb08Hr7zv1lf85Dqo+OOAkoQR7OOAANfxTBiiOL7HFlTX1WM
         IxcBIdcvYzLiAkjsTuESmNhDQoIX26bdQdywomTAYtQYGx1wP9Xt6ajE1f6Yszqy7wok
         nFIJ0Fsgywwh29SSGIavBpa97gR+VSqkQlowCKX5whvmrjlaKCr22+hLg3HbWeJOH95U
         c6Ug==
X-Gm-Message-State: ALoCoQlG0pQUAnFnsYEg6F7thk/WlGeUvN/x8wUfaUy2dlmuKSDM4hMFNqO6O96kLNvzdAjiKWO+
X-Received: by 10.50.50.69 with SMTP id a5mr19597372igo.68.1439492459805;
        Thu, 13 Aug 2015 12:00:59 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id c91sm2078646ioj.43.2015.08.13.12.00.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2015 12:00:59 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275880>

This field was set in transport_set_option, but never read in the push
code. The push code basically ignores the smart_options field
entirely, and derives its options from the flags arguments to the
push* callbacks. Note that in git_transport_push there are already
several args set from flags that have no corresponding field in
git_transport_options; after this change, push_cert is just like
those.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 transport.c | 3 ---
 transport.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/transport.c b/transport.c
index 40692f8..3dd6e30 100644
--- a/transport.c
+++ b/transport.c
@@ -476,9 +476,6 @@ static int set_git_option(struct git_transport_options *opts,
 				die("transport: invalid depth option '%s'", value);
 		}
 		return 0;
-	} else if (!strcmp(name, TRANS_OPT_PUSH_CERT)) {
-		opts->push_cert = !!value;
-		return 0;
 	}
 	return 1;
 }
diff --git a/transport.h b/transport.h
index 18d2cf8..79190df 100644
--- a/transport.h
+++ b/transport.h
@@ -12,7 +12,6 @@ struct git_transport_options {
 	unsigned check_self_contained_and_connected : 1;
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
-	unsigned push_cert : 1;
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
-- 
2.5.0.276.gf5e568e
