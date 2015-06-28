From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 36/44] builtin-am: invoke post-applypatch hook
Date: Sun, 28 Jun 2015 22:05:58 +0800
Message-ID: <1435500366-31700-37-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:09:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DGl-00032O-29
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbbF1OJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:09:08 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33570 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbbF1OIg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:36 -0400
Received: by padev16 with SMTP id ev16so91892924pad.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5HOFSzMCk7hUOSR8cD6W8eEsS4PikYx5j2CapE48MvY=;
        b=b8br4kr1gHoMMFR0oIRXXZHZ0dzBooUNOSdA6pZlbOrPbrKqJgY42NYcMsis2loxXr
         xH20y7DupOb4kDh/pg8awRx+WmgaJoygAnUxAWA+Oegu7oE+Khtx7i1ifgYN4j+zwiPV
         Ko9twuMbYjzpptifouxyXC2E94Wv9/4/OjGreQ5uCDvkKN/G22FLOc5BTAjlbiZZegLX
         AEtd4IEVdKhjTOnMFV/SvaZF+WGRbUkoRwrazejfoAPHZaFp74FbWqCRzTM6UXr8vecG
         FcLyYnzmaxGpiXvNekhYPKCT+3ttVUq4ZPGWNvLi8RlT+PW6IXhYlRn0IVvYB1cFi6FJ
         2okw==
X-Received: by 10.66.250.12 with SMTP id yy12mr22324257pac.43.1435500515151;
        Sun, 28 Jun 2015 07:08:35 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272912>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh will invoke the post-applypatch hook after the patch is
applied and a commit is made. The exit code of the hook is ignored.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    No tests in master.

 builtin/am.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index a2b0d63..be85b97 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1423,6 +1423,8 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
+	run_hook_le(NULL, "post-applypatch", NULL);
+
 	strbuf_release(&sb);
 }
 
-- 
2.5.0.rc0.76.gb2c6e93
