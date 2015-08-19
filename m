From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v2 5/9] transport: Remove git_transport_options.push_cert
Date: Wed, 19 Aug 2015 11:26:43 -0400
Message-ID: <1439998007-28719-6-git-send-email-dborowitz@google.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:27:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5HB-0005AP-On
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbbHSP1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:27:20 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35882 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbHSP1S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:27:18 -0400
Received: by igxp17 with SMTP id p17so108040847igx.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UByGPUEKWQ5gzsF5XlX57xh2xOx38nyrOsFL34wuALk=;
        b=dD/AMZwJ6OuHW1srXmuILo9Q+4Qsan+MghXhFDvae9uPT+vaFxiBsgYzzBWyQ+w+65
         FMoT+YqzRPbV+MJC7uiZCeQasC0lVpbPC9zIcQtFJRMUMSCbT1PQL/nRkJyX6hi0vAs6
         vOCykj2uIxYlJnlZxGOJYJCWaRhTWQXODskPkilHqrddwUO8/ysHutGHXp6gwiPPPiUI
         NH3lB2WvpAOekbuXC+l71Y42/Fchnz3priyfic0nyFFxG3SgCtmwhvBPO/LEoRGC86MI
         gcu1h/8KqOmd05Q4jNT5VP+ELc6uHUgf6CGVT63zzthBNzISDtDWHWgh5KCgtI0SlG6o
         Cq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UByGPUEKWQ5gzsF5XlX57xh2xOx38nyrOsFL34wuALk=;
        b=PMBVUcYhaTVklCHQPfQEANwap55UAP/GFUDmp0+NXP8HOAGYCiEv4/rWWZf1Za7tzt
         z8WywwRFgA6AsSNUR+qKGr4S2eRqH2nxH34U4jQhquC2wjPUzmNk0NAXiuYwULV8kk4v
         XvhA1f9J/Mwh/nIl0lVFR0/Pjjuz0JfuHzhQjJob8FEDt/WsX4e1HV6F9/KKK68m7dLc
         WacyejaHDLP7fyCV2hPAEGycS5ERJZxtxy/5Pn+e5M3HtivZRqNFb6O/HUkfJWeZVHW8
         2gRFoOQwV+4a28wfKjSSNa1aaY44OeJz8lWK2K+tB2InICRDACBXUFG0YecSCBQDfHK7
         MxGQ==
X-Gm-Message-State: ALoCoQk3hX1WieNaIS5nUuI56ySoji1MgFf+HNhUeZRrGxMiKbXscUzBR3ayM3kRlqsm7q9nbrXf
X-Received: by 10.50.141.193 with SMTP id rq1mr2377148igb.4.1439998036680;
        Wed, 19 Aug 2015 08:27:16 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id o19sm2347819igs.18.2015.08.19.08.27.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Aug 2015 08:27:16 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276194>

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
