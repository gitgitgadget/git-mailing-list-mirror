From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/8] sigchain: add command to pop all common signals
Date: Mon, 14 Dec 2015 11:37:15 -0800
Message-ID: <1450121838-7069-6-git-send-email-sbeller@google.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 20:37:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8YwT-0003jc-PB
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbbLNThl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:37:41 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34938 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbbLNThg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:37:36 -0500
Received: by pff63 with SMTP id 63so16211337pff.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 11:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UjC/KLz2TAyaA4RMgzNQ3FMPYT4zbYmshniyT2Z8B4g=;
        b=AcMk4S0qMFZMZlB0gS7IuGM/dYbADb1q4R6Y2EqDGpnWqUgb7yxmkfV8RoDsbYH4AD
         g/j73mB1KZGE8MI6FarBilRHYXOq/uZs9YMmKs+cskirEWdTZT8mo+FqW3EX1mbX0X+k
         OkHpzLUhZfjPswKKr5Nq7UzHSN5LZ2K1l3WxiHgA8KiUmFwbnhko7aJpeOG8WmM0hZkm
         41NvbjGQJU4Bmyh76QCnqCFGyxxtWGtGas+VpPmOMuUGEtVo2UfbLDeouJfFWTb5RfJ6
         y3Gvpx4mWetQoPzKxrtrusHr1jkZa027cHBO/KW/ugB9qd0bakj9sz/P7K9JYZNy94Di
         stYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UjC/KLz2TAyaA4RMgzNQ3FMPYT4zbYmshniyT2Z8B4g=;
        b=jPMuTJWp2j8TLNjzaxMjP3A70CHC8RuSx8K0q9Y+7lMR8ae3Avu/AmMC7EOWTXxAYG
         ldBfnzvDIvFQG8Q60Hl5t4l0pLpxTP3KhVgemr9/GRZA1l7gpNQhsmo2BLiZjrK7Is7p
         o2UFIFv1PDFNGf8reC6l53ISMyU1GkqjQD4/Nol0GO4Oq2rqVlQ97KzKQRY+hWZaEgR4
         Xd6+1EaMOPI8fEQwNOpvlEoGDuFva76HjCa73MgZwfvYJvRJKGUVmukio9yqvNOHU3rn
         g/WhZ2N8xb2LU0/6VACiix51W+ZW0O+hc0ECuVWxVxlkha92kyntDhUkd1T7dzwiB8Hg
         BtNA==
X-Gm-Message-State: ALoCoQm/O5gPupIP6slvnmGkWUZSBQ1a5q3QOEIEfjQj2hFLoCwRh3rgKMACr3DT4hv/+n/Xsb8ALDMw2q7ze1o4b1A349HfuQ==
X-Received: by 10.98.69.216 with SMTP id n85mr21687549pfi.21.1450121855413;
        Mon, 14 Dec 2015 11:37:35 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a894:af1d:9081:95fb])
        by smtp.gmail.com with ESMTPSA id l20sm44130239pfi.10.2015.12.14.11.37.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 11:37:34 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450121838-7069-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282392>

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
2.6.4.443.ge094245.dirty
