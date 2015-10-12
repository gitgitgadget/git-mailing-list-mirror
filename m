From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 5/8] sigchain: add command to pop all common signals
Date: Mon, 12 Oct 2015 11:47:18 -0700
Message-ID: <1444675641-14866-6-git-send-email-sbeller@google.com>
References: <1444675641-14866-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Jeff King <peff@peff.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 12 20:47:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zli8W-0006Ox-9z
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 20:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbbJLSrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 14:47:35 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34955 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbbJLSrc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 14:47:32 -0400
Received: by pabve7 with SMTP id ve7so102883983pab.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 11:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7sYUg+9ga1pib6bUvPNFHMHF3Tu2lbkxnG74YCGAFHk=;
        b=kDNObbuiVsO19xnDY9Ac4N4ON03ZAnj5CJAStJAudQAETJx1JDGrBW4HPQTXNwrstv
         EbjogYOo2uuSdHwYeXTNrFSs8nKom99IFV0+Oljz32ilzcPKIYU3UEBceYcNvFja4FuM
         qs53IB3cbQ3294cVz2MVJYNI2WPGN987RvaCnN/A3TJsMr7FOIW4JC2W0bmt8TCfkYCT
         gb+NvMRJfy4QHO1MO3c29uTz12CqxDG54ptEPAzqM9tZ7ZtPOCn+lheBu68WJe9CBA4m
         W48gGNb9R06NtWVIvGtyIr2E8Et9fNHsmmFHCBpaF3rNOsTLq3R6ObHL0q1UZ6JoL/mg
         N4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7sYUg+9ga1pib6bUvPNFHMHF3Tu2lbkxnG74YCGAFHk=;
        b=m6iNNVP3F9kFbu0h3mMQVHUcY0B/qXglNmSR2wu2zyVtuzrypJHr4FHt9MU/9huTNV
         7LtgPabEgAmDvz6fCDl6Asgw3IETPxfEWTmbAMN7VaZFhn3WFBZLTa+g3SfRg2+ufX2f
         1boF90K/gdG8/1Kka9CxGFAysvPizMC4JtWJpICjods+1LMTe3PjQdcDQcr5Rk26Y8ga
         Lvl3P68WTTSDNF9UOz7Y+HwoniMN3BQ76soCodKkcbZWlb3Sd3L4NU/As4U1tdlcLUE/
         64RsKdJ+Muu8Zg1JLIbJRlt/fAjkRnfDIpC4vN7mG1iafDWdzptCewdJZj8rkXKXlg2z
         L1BQ==
X-Gm-Message-State: ALoCoQnJQ4zemMz3pqVQwh6E5Id0oEm8tmwAPiA1KlO0C1z2Fgeb3NVdNVEHoJaj/zmq37iOMGlk
X-Received: by 10.68.88.130 with SMTP id bg2mr28969248pbb.38.1444675652133;
        Mon, 12 Oct 2015 11:47:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5950:8bdc:8939:e460])
        by smtp.gmail.com with ESMTPSA id xm4sm19785583pab.27.2015.10.12.11.47.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 11:47:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.268.g453a26a
In-Reply-To: <1444675641-14866-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279396>

The new method removes all common signal handlers that were installed
by sigchain_push.

CC: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sigchain.c | 9 +++++++++
 sigchain.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/sigchain.c b/sigchain.c
index faa375d..2ac43bb 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -50,3 +50,12 @@ void sigchain_push_common(sigchain_fun f)
 	sigchain_push(SIGQUIT, f);
 	sigchain_push(SIGPIPE, f);
 }
+
+void sigchain_pop_common(void)
+{
+	sigchain_pop(SIGPIPE);
+	sigchain_pop(SIGQUIT);
+	sigchain_pop(SIGTERM);
+	sigchain_pop(SIGHUP);
+	sigchain_pop(SIGINT);
+}
diff --git a/sigchain.h b/sigchain.h
index 618083b..138b20f 100644
--- a/sigchain.h
+++ b/sigchain.h
@@ -7,5 +7,6 @@ int sigchain_push(int sig, sigchain_fun f);
 int sigchain_pop(int sig);
 
 void sigchain_push_common(sigchain_fun f);
+void sigchain_pop_common(void);
 
 #endif /* SIGCHAIN_H */
-- 
2.5.0.268.g453a26a
