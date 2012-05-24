From: David Barr <davidbarr@google.com>
Subject: [PATCH 6/7] vcs-svn: fix clang-analyzer error
Date: Fri, 25 May 2012 00:04:18 +1000
Message-ID: <1337868259-45626-7-git-send-email-davidbarr@google.com>
References: <1337868259-45626-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 24 16:05:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXYfm-0004SF-DG
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 16:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345Ab2EXOFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 10:05:42 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50024 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239Ab2EXOFj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 10:05:39 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so11360466dad.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NFMpqT0X6Ahbp3keW9sBvqcpvG7+iCqDG+bP2/NnjSo=;
        b=PUYvByhUy0tHCDKNtwHYMObX7UkDrQR5Tzf2//Ztb9h72l1rTVtmNn6Pf5QQG67pYr
         Ov6f1QWh4HBLLtbnA8BkLEPm/rNFKtl7ctZvzWC2nzQhi2KxJq94mDbrAO227++ugZSs
         xrk0NVW7QabPRCV0o+0icCwkTG+mV+FIDhMTH0wK2Wv4c/N0Hg9YN5fTlQ+kLcfyQ+51
         GdNYEGHIYydKf7nZiFmRfDjzEkfj6IMd2aLb2Yz3E+C3Vlnkt11reJ+4OwNgyB/hs9ar
         Igue56bvWXqSNtHBx5krA/F6ZZVQg+h36APB2Pus5OjrMh/UsuiPkiy5vy3YfYRCsnSD
         jzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=NFMpqT0X6Ahbp3keW9sBvqcpvG7+iCqDG+bP2/NnjSo=;
        b=mSApf2q7re/HCCUm+zw9fWExTVjRRcrfssJZZsS1ujfwFSEThK5wDkzF5zTmn/0Cm6
         9dpSYFoE5LWtybstEr1ku3fY08jsSv8ghx6YSfT/uUkfAc5a0MIBVcb/+UYLUJg6Zn8x
         CqBYr03NHLagFkCZn9CgyUEnM++CR3fOxaXe+bhWoUZynGgwGS7dEj7NUjMx0Szcpd6H
         YQKIzjUXwcXM5xodHDeOgMknHUkhgIKtPVvB9qDSFbum3/uXHbgrhWDoQPm6h30ZVTMz
         f2f2eex96c2pm9FoGk4/Ez2t0CPQvWsVXz6DXJrj4i9INPgdRioDLXaDteWybAuwkVQy
         5tMg==
Received: by 10.68.134.1 with SMTP id pg1mr11092433pbb.1.1337868339463;
        Thu, 24 May 2012 07:05:39 -0700 (PDT)
Received: by 10.68.134.1 with SMTP id pg1mr11092408pbb.1.1337868339306;
        Thu, 24 May 2012 07:05:39 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id rv8sm5565332pbc.64.2012.05.24.07.05.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 May 2012 07:05:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1337868259-45626-1-git-send-email-davidbarr@google.com>
X-Gm-Message-State: ALoCoQkwpS+JJdcl1cRn4RezvRHsZc08qOl91tSKu+5r6oH3unFJG+bf+VeGM4BvS4WYBtFQZ38gxOatvfKo73RTXhjTTkm33MAB3tDRyJM7/dwP9aBCst82UVxcPMGls0tABZjdKRtMB0OGNe7qN6Rxa72vYLBbtVUVq7jpKurAbcDryQn4G6A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198381>

vcs-svn/svndiff.c:298:3: warning: Assigned value is garbage or undefined
                off_t pre_off = pre_off; /* stupid GCC... */
                ^               ~~~~~~~

Signed-off-by: David Barr <davidbarr@google.com>
---
 vcs-svn/svndiff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 97d6967..7a71833 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -295,7 +295,7 @@ int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 	if (read_magic(delta, &delta_len))
 		return -1;
 	while (delta_len) {	/* For each window: */
-		off_t pre_off = pre_off; /* stupid GCC... */
+		off_t pre_off = 0; /* stupid GCC and clang-analyzer... */
 		size_t pre_len;
 
 		if (read_offset(delta, &pre_off, &delta_len) ||
-- 
1.7.10.2
