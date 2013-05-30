From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] cherry-pick: don't barf when there's nothing to do
Date: Thu, 30 May 2013 08:49:41 -0500
Message-ID: <1369921781-30667-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 15:52:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui3H1-0002MN-Mj
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618Ab3E3Nvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:51:37 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:61855 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932601Ab3E3NvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:51:24 -0400
Received: by mail-yh0-f53.google.com with SMTP id f64so56752yha.12
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=QAPlWs4DkZqHpXMSXI3ItTjYjkaEUFyKWXWf6y6Mk7w=;
        b=XjLgQlVq/i8JBeuG1G5+3L0Npwp33FU+5dDg5tF4b5sbD5gGGPd4kOjs7Z5+lnLG8W
         u4MEMUjV8RfGWwOw6XeP/dS3Le5hgEsTCKG3ES6E/FDhFCmaHi1uIrfSGcBzG7nSN+/x
         DksTFuqZW1zY4VSXugts+I8HtM5y62cYD8uVty29xCjx48dFJVyYXUfuC8Ov0zp/QFe7
         9YvI9PMyrAE8eaSSLLANA19A3I/9+8Mp7Mc6/+RdqFL+HEWFMN2ReTuGN2gIGnrnNg0X
         9kqZ1YHAMCGu/qyWBDRBRJLunt07JS+6Rm/Sn6rHcrcvDqgI7KVPsDhuUY95FRGCAP2n
         VYEQ==
X-Received: by 10.236.201.70 with SMTP id a46mr3757315yho.75.1369921883988;
        Thu, 30 May 2013 06:51:23 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w62sm60029509yhd.27.2013.05.30.06.51.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:51:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225994>

If the user set --ff, it's expected that if theres's nothing to do we
fast-forward our current HEAD, which is a no-op.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d8f9d30..b9d4b48 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -749,7 +749,7 @@ static void prepare_revs(struct replay_opts *opts)
 	if (prepare_revision_walk(opts->revs))
 		die(_("revision walk setup failed"));
 
-	if (!opts->revs->commits)
+	if (!opts->revs->commits && !opts->allow_ff)
 		die(_("empty commit set passed"));
 }
 
-- 
1.8.3.rc3.312.g47657de
