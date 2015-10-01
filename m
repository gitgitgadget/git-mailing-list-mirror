From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 5/8] sigchain: add command to pop all common signals
Date: Wed, 30 Sep 2015 18:54:13 -0700
Message-ID: <1443664456-1307-6-git-send-email-sbeller@google.com>
References: <1443664456-1307-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 03:55:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhT5Y-0000PF-Nr
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 03:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbbJABzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 21:55:08 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34326 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbbJABye (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 21:54:34 -0400
Received: by padhy16 with SMTP id hy16so57628245pad.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 18:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZzS4c4sVl8RwkSlP9coWjCyDVhEfqpfhhTP7xw+BL4o=;
        b=Bei9E4OObIPtQ5sI1/iqog6djtciNOeUEjFqeELbkgIbqG79iJcqvLMxIwK/sDP1Yz
         jQmkvrPj0iXYNXr6IZgt89ek41f6iWRNJKCWm6k0mMCCworB13WUJ1DCW/8WbG8hqx74
         SHGnlaUVgvhLpo56kTB5fimPp5Cj/lEvqZ49gOj9XHHM11w/SjJl+EP2sIS0mcx/jdg8
         RP/zmgjU3ERLYpm4JxzckAe8UdzzZobXHhsbxOI6ek0aJS373kiOpE4KUo1Msd8nS8m0
         VpTomeUBu0nb+NiQufJxXKuFPnMQsZx48YTlszdoWF8nWE2J/j70Z1AjyhpI/9PjGR55
         Sz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZzS4c4sVl8RwkSlP9coWjCyDVhEfqpfhhTP7xw+BL4o=;
        b=iNONR1hEyUyvCxlLRwpUbAAGEdLMU1zV104AjH2zqkyIipnfkRX995RP6QGSrjV7xh
         eS3qEVuRoqMnfPeTOs/MQnXtsh6TtIL7oXC2Jh4SKni/zkvgzlOw7Ley72kbhj0uFFvP
         ctmXZpt7HG5Wvztw+VrDwfZkVCP+NdID/CKKzajVwvghzHuciRHW4tJyi/c3ttRcC0ah
         6ynLI2iYkXEsBZ5pgxH7UgNTvm+dkH6Rb95iDWdcvNZnp6ScCvhUcCFLGN46pwach5Rb
         BH4AJA+9WiOuGyNXRrYMW/kjbdHSVnY/gSr/klEEL7rs5TeNb2I89thHxQxC2gCObNEc
         qZQw==
X-Gm-Message-State: ALoCoQkNjLcln9mQvqMZkQ4kO3ecCFuJ/jEDPH4bD63voo9qwcfYXVoYHoEki2DNOQp8+DZmbnZs
X-Received: by 10.68.183.5 with SMTP id ei5mr8847675pbc.124.1443664474387;
        Wed, 30 Sep 2015 18:54:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8d91:1679:adb7:b916])
        by smtp.gmail.com with ESMTPSA id te7sm3055197pbc.87.2015.09.30.18.54.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 18:54:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gf20166c.dirty
In-Reply-To: <1443664456-1307-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278875>

The new method removes all common signal handlers that were installed
by sigchain_push.

CC: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.5.0.275.gf20166c.dirty
