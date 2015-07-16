From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 06/20] checkout: check_linked_checkout: improve "already checked out" aesthetic
Date: Thu, 16 Jul 2015 04:20:11 -0400
Message-ID: <1437034825-32054-7-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:22:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeRC-0000WH-21
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbbGPIWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:22:20 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37625 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbbGPIUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:53 -0400
Received: by igbpg9 with SMTP id pg9so8106821igb.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oRLKeka825KxEvJV7Iy0RzFlYkquj6uA+EI4HMedU9c=;
        b=anLbYGAO3dLfgfMeLu9aGHwJZm7mLBfm5gwfTLVlT/K2rsArRJXta58B2sfVyCJdHR
         vjoA+tCUITpIaylYnTPPa73Eemt0D1QVOfd2EtT71pNLM4FjZs/oG6VDNC6TVmhRSZMz
         pT9UqUsVTYIEYxKpuFwp83yYnnpDj50RMizlysVjv09zh6hy5IMUjyh7RY/CxnhzfsDp
         zxVdJAYj8a2dwvPP38b2l9I7uRxedPfsT/gMXXxfA+Dqk/GQQnWQpjwBr0xfnwy5wOIU
         KhiaKhxJvUGG1sDtq37wVWS+R3JcfxUDbPp+hqpb4KeEQnq4vuD9ulnZBpEdKq1DIwQp
         2TsQ==
X-Received: by 10.107.46.159 with SMTP id u31mr9026345iou.69.1437034852934;
        Thu, 16 Jul 2015 01:20:52 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.52
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:52 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274025>

When check_linked_checkout() discovers that the branch is already
checked out elsewhere, it emits the diagnostic:

    'blorp' is already checked out at '/some/path/.git'

which is mildly misleading and a bit unsightly due to the trailing
"/.git". For the user, "/some/path" is significant, whereas "/.git" is
mere noise, so drop it.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

New in v2.

 builtin/checkout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 177ad6a..a331345 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -909,6 +909,7 @@ static void check_linked_checkout(const char *branch, const char *id)
 	} else
 		strbuf_addstr(&gitdir, get_git_common_dir());
 	skip_prefix(branch, "refs/heads/", &branch);
+	strbuf_strip_suffix(&gitdir, "/.git");
 	die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
 done:
 	strbuf_release(&path);
-- 
2.5.0.rc2.378.g0af52e8
