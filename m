From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 20/42] fetch.c: clear errno before calling functions that might set it
Date: Wed, 14 May 2014 14:16:54 -0700
Message-ID: <1400102236-30082-21-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgbf-0000M0-3D
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbaENVUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:20:46 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:42686 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbaENVR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:27 -0400
Received: by mail-oa0-f73.google.com with SMTP id i4so40925oah.0
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QmSd7TSlk3rI2PPkPRIrAdB70Kb6XC9aimdnu8Npvts=;
        b=GwZytA3llG3hwRY/kwWMrxCmvNf+HGGGJrd2ZbLeZvq02n8YRTUgPNRU9EDzEStT0J
         PnAFfteAnj8KsNZvNrJHu886uHmP658h20ZC+XBeyB9cvsSu+7HrEc/S/BCQ0JNkxE8v
         17Wc6nTlYJKPDcFlKTLSv6EohDbHlFDo1w5ctLXjcEbbIczHhRjhDma4Ew9HTLd8LdrW
         aAZGUXUG1cPRD6EB57cYa1O0hHcIHxTFm5j0SVsyWsPAnR+Ivx2U6//Pcz7/54bg0KE+
         Ml+dA8quWZcFiw2nTIrI+QuF3cxySixhGtyG6eGuyCWDYevbK+n1jeXKg+idvTyy4grT
         aUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QmSd7TSlk3rI2PPkPRIrAdB70Kb6XC9aimdnu8Npvts=;
        b=GBYnJUp12/srIQTOGYhuRTVh1uDN9CUF/TYnXOgKptIMx5yIXECqMEK5IKQjpy4Va3
         PtS1e1T8gM4QZuFvgw4SgNDD0IlmbS3gjdqiE5jCIw/jc4YVpjSm2L6pBE4fzQN7/uLN
         uuw1SymuCohwcZpRkbAh2zUUq/JYoJFbBRasRfGNsmmt5ERZ1CFJh5KdNYk6+dloFJ/9
         R6aHCx6iMikS78LnpyqO+f+C6hn2hTG+iCJ85mdWlfTLeZWUL3LxqL8y/+Du65vp/8zY
         HER+j/2XGspmjh5LhxInp8/dO3QAMdxjsnz25evX5t++TXSeOnr43eoEEyq0WZ2jGE1q
         aw1g==
X-Gm-Message-State: ALoCoQlpk0OUm0pnXPBYEgFDgfli+QverhwW/EIfWdxcmPEo8AkXbB6IrhgF8jzqYovaPhKbv7Qi
X-Received: by 10.50.115.104 with SMTP id jn8mr10505800igb.1.1400102246796;
        Wed, 14 May 2014 14:17:26 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si144567yhb.6.2014.05.14.14.17.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:26 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9A1E531C1F8;
	Wed, 14 May 2014 14:17:26 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5E5E6E0973; Wed, 14 May 2014 14:17:26 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248982>

In s_update_ref there are two calls that when they fail we return an error
based on the errno value. In particular we want to return a specific error
if ENOTDIR happened. Both these functions do have failure modes where they
may return an error without updating errno, in which case a previous and
unrelated ENOTDIR may cause us to return the wrong error. Clear errno before
calling any functions if we check errno afterwards.

Also skip initializing a static variable to 0. Statics live in .bss and
are all automatically initialized to 0.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55f457c..a93c893 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -44,7 +44,7 @@ static struct transport *gtransport;
 static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
-static int shown_url = 0;
+static int shown_url;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -382,6 +382,8 @@ static int s_update_ref(const char *action,
 	if (!rla)
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
+
+	errno = 0;
 	lock = lock_any_ref_for_update(ref->name,
 				       check_old ? ref->old_sha1 : NULL,
 				       0, NULL);
-- 
2.0.0.rc3.471.g2055d11.dirty
