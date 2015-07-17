From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 06/22] checkout: check_linked_checkout: improve "already checked out" aesthetic
Date: Fri, 17 Jul 2015 19:00:01 -0400
Message-ID: <1437174017-81687-7-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdE-0002J0-CM
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbbGQXBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:22 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35902 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbbGQXBS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:18 -0400
Received: by igbij6 with SMTP id ij6so47744097igb.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vy8vzvocncwIkhIkCoAt4dMWLrLI38nnzb3nLODOf4k=;
        b=URDMso8r44nzw0+w/5/utyKqwSeeA+dNgUJa4WZDVE3pt84sZAuIvb7xOTfZ1u1LeE
         ouF/Dc+N7/z4uMH18UjlDG9IhVP06uW+3hEecU2/p/0U7uETa4sqAusbtNhyVyPBLVRB
         PB28Z9JNxmuZCep6YKI+Mfe9CGJLCNNS76hXAA8QK1IhRsJdFcPo/Vwh6Mi1Julo4wBH
         n02CzgObia3ceBNmeZGqDfQYrqLXxFqFNOrU4ag40wpLpcc098DRVbBmZzmN01qHGvmi
         86E6qUwW/Zqu3XkWIu8AiJDZqJS4NBQaAq9LCJfC/2kAa+r/N0JrEfA6Y5bHJ9VSEJv0
         ikrw==
X-Received: by 10.107.129.230 with SMTP id l99mr23834804ioi.32.1437174078020;
        Fri, 17 Jul 2015 16:01:18 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.16
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:17 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274133>

When check_linked_checkout() discovers that the branch is already
checked out elsewhere, it emits the diagnostic:

    'blorp' is already checked out at '/some/path/.git'

which is misleading since "checked out at" implies the working tree, but
".git" is the location of the repository administrative files. Fix by
dropping ".git" from the message.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Changes since v2: strip only trailing ".git" rather than "/.git" from
"already checked" diagnostic[1]; reword commit message to better
emphasize that trailing ".git" is more than a mere cosmetic issue[1]

[1]: http://article.gmane.org/gmane.comp.version-control.git/274035

 builtin/checkout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 177ad6a..de6619f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -909,6 +909,7 @@ static void check_linked_checkout(const char *branch, const char *id)
 	} else
 		strbuf_addstr(&gitdir, get_git_common_dir());
 	skip_prefix(branch, "refs/heads/", &branch);
+	strbuf_strip_suffix(&gitdir, ".git");
 	die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
 done:
 	strbuf_release(&path);
-- 
2.5.0.rc2.378.g0af52e8
