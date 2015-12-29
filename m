From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 01/10] dir: free untracked cache when removing it
Date: Tue, 29 Dec 2015 08:09:25 +0100
Message-ID: <1451372974-16266-2-git-send-email-chriscool@tuxfamily.org>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:12:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoSa-0008Ky-Sx
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbbL2HMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:12:12 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34190 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbbL2HMC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:12:02 -0500
Received: by mail-wm0-f42.google.com with SMTP id u188so2204387wmu.1
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 23:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HCORKqI2AqDHdyMUtAF/j+AmkybKNr9pFi/vOjb0QSY=;
        b=tTHgIu/3Bvsam8IN+CtEARKP+alxWp9rmZtJMloQ6RakEMe6Sn1BTNcNLskZVbLe4t
         TVtNvPtuDOUG3BhZ7W6r8WOP8Plw99cIhnwmyQkknyF0yNy/eS70LfE/jeWECXPh3ySC
         dkn8r+sgGHcebnIQePAKlyMWGI/pYeLF7c5CWNvPuBeW8q+eYDyeJN6rBlvEhTGORUQf
         amyxyBGkHFECmsheheWMqrt+z/4mdIQKIWg3H89/aPgmfvtXPLD9z1hLLcQXpN5Jjztw
         R82gkgSMDd+F6t8+QzhV8Q0cdMvSSlF3UY0aRIeM9vsd2HC1RCzFn3vGiGNMSyIZaMrs
         ZB7w==
X-Received: by 10.194.103.198 with SMTP id fy6mr51176534wjb.48.1451373120978;
        Mon, 28 Dec 2015 23:12:00 -0800 (PST)
Received: from localhost.localdomain (243.40.126.78.rev.sfr.net. [78.126.40.243])
        by smtp.gmail.com with ESMTPSA id uw6sm59795661wjc.42.2015.12.28.23.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2015 23:11:59 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.10.g544ad6b
In-Reply-To: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283081>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..a6fff87 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1123,6 +1123,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 	} else if (!untracked_cache && the_index.untracked) {
+		free_untracked_cache(the_index.untracked);
 		the_index.untracked = NULL;
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 	}
-- 
2.7.0.rc2.10.g544ad6b
