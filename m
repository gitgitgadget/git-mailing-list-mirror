From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 37/45] builtin-am: invoke post-applypatch hook
Date: Tue,  4 Aug 2015 21:51:58 +0800
Message-ID: <1438696326-19590-38-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfz-0002r5-FM
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbbHDNyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:40 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35413 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964949AbbHDNyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:37 -0400
Received: by pasy3 with SMTP id y3so9212854pas.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S/y2pSZeXqn1i4aDJrdw6mR5qY4KNIByUfzOfjmMhWo=;
        b=jnSllK+50ZxwKjHEuq+ckwhO1bg+n2Dc6He6p3FmH/tQvCtRfF9sBJsOA9QvlK9Ibo
         Esu6ygpRxO7Qx6lzNt4osPPLkqf3n94oCATAjFtLz1/hi5eGOxLKmQK/WRxJv+8oa/kS
         c80wYlka+6g1Vpu3x10l4GJn5UnNMJ4XOlfqWP4R50J9lsA/LTuzOfn89TjaqzwP/3rc
         vd900PNEGY5G64ZbE9R8WC3gzyyHsq42yTgNGxy78UARKOVZFmOjnyBjFeNC3CGpvbwY
         vRpNkuWQLhhRqKjsaAAmxPIulAgvk7uXNZn3PsogkC6dgFXE8gqmbuSSNAB8xjLE7cyi
         bdVw==
X-Received: by 10.66.102.71 with SMTP id fm7mr8012241pab.5.1438696476995;
        Tue, 04 Aug 2015 06:54:36 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275301>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh will invoke the post-applypatch hook after the patch is
applied and a commit is made. The exit code of the hook is ignored.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 7a7da94..c313e58 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1378,6 +1378,8 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
+	run_hook_le(NULL, "post-applypatch", NULL);
+
 	strbuf_release(&sb);
 }
 
-- 
2.5.0.280.gd88bd6e
