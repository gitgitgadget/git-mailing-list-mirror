From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/6] add: make warn_pathless_add() a no-op after first call
Date: Tue, 19 Mar 2013 15:45:52 -0700
Message-ID: <20130319224552.GD19014@google.com>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
 <20130319224400.GA19014@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 23:46:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI5IW-0000ep-Ip
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 23:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934447Ab3CSWp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 18:45:57 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:55942 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933289Ab3CSWp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 18:45:57 -0400
Received: by mail-pd0-f171.google.com with SMTP id 10so348338pdc.30
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=8pIg1eUX+LEBpw6Dcok/NuvKWbCxoyiP2zyiyGkiLQM=;
        b=QBZL7n5B1GxKa+QQDzZv+/DJtIrH2dv2upR1UuvJvnmUY6WWsmFL7uIt3yBkYmx0Ge
         EKoppFUjB6PWMOF892dWQqMfMTzHK4jhndGZOkk/IdEmZBFN46OCeU44pStnC6+bJW88
         4yKZxBVAg4UjAj1CMfwNiDolcke+YZCssx4kt9Uxy/H1cacrGEj4PXhNw1qn/wYvGhoQ
         Obm8a1TJJIy5Jh8+6uwSmXlIWCb4FGYKcfJmeKem1kh1ebLJvTpblLibwmUJRG0d5xLm
         CaBhSvIOVo6eXz7yXjlj4DLAWR1JcePpkw97n5Mps+RmdFUiPY81xt9MVIMcXB91EL2F
         re5A==
X-Received: by 10.68.129.9 with SMTP id ns9mr5861544pbb.16.1363733156561;
        Tue, 19 Mar 2013 15:45:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id xr3sm25767785pbc.46.2013.03.19.15.45.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Mar 2013 15:45:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130319224400.GA19014@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218563>

Make warn_pathless_add() print its warning the first time it is called
and do nothing if called again.  This will make it easier to show the
warning on the fly when a relevant condition is detected without
risking showing it multiple times when multiple such conditions hold.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As before.

 builtin/add.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index a4028ee..a424e69 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -33,8 +33,13 @@ static const char *short_option_with_implicit_dot;
 
 static void warn_pathless_add(void)
 {
+	static int shown;
 	assert(option_with_implicit_dot && short_option_with_implicit_dot);
 
+	if (shown)
+		return;
+	shown = 1;
+
 	/*
 	 * To be consistent with "git add -p" and most Git
 	 * commands, we should default to being tree-wide, but
-- 
1.8.2.rc3
