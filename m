From: David Barr <davidbarr@google.com>
Subject: [PATCH v2 2/6] vcs-svn: simplify cleanup in apply_one_window()
Date: Fri,  1 Jun 2012 00:41:26 +1000
Message-ID: <1338475290-22644-3-git-send-email-davidbarr@google.com>
References: <1338475290-22644-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 31 16:42:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa6a9-0003gL-7D
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380Ab2EaOmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 10:42:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50238 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326Ab2EaOmW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 10:42:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1551829pbb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Sb1I2l0oSEQVgBVThtoOHTVCklpxPUZbQEmXPX1nd2Q=;
        b=OCw/GY4rHu1dYK/nn8FUM1GWiLi1BTY2t2CqYNckIS0+zyHqA1mZRXVa0C/O6JUQmD
         ea2l9s8nwIRSilVE9cYISidCo4YKrZj7npELU63TMjsVAqYbju+7DZpar9avsNaz0jDE
         wN8pxO1x8AEffcvWJcisjMVDDFC8fu84xC5ycWvfWRIgrUtAhezbpZUHQ5hyB6/KbBAg
         8ONK4GB0TGIr+/yxajpqVR8DCG4Z+ZeQxNuLmAaGmVooMjSeGivMtO1WRqwKbAULrV1f
         F0h0D5ll/tCsfcqzcmK9r2YMvoFi227LZwIiG4crUeJOG5TF+pRcy5cWYKStpP3GzQAu
         W0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=Sb1I2l0oSEQVgBVThtoOHTVCklpxPUZbQEmXPX1nd2Q=;
        b=Uld5/3slhZJz03uJsmVUa7BU71sKjxSlf1IKhgNUWlROLl8gTa8IkN+Yvn6T6w9aW0
         Zbu8npiNgR3oSCOA0nVIxYu2IvB9iD+eE80fkY1XqPnVtYOmEVTy0qpILntxpdXTDOK0
         9dqgpnyHsHF0TLemEHYyzorqsP9++pdU6iWGlTVaNJ8vxBRLtUNIRouyWG1+1VN5KKmO
         MxtYiQ7nEHz4GvI7ZrlgGVYsyiu/QjOA0UIgCaqQinPzyLCcGmJP0+EcUPxwT55tg8Rv
         1BiEIywGroVtWnz5H6mbdAR3NAG3Yq91/U4AhT1LO56hQJ4QHRmj5T85EmxwBRVwKchN
         ZD6w==
Received: by 10.68.237.166 with SMTP id vd6mr319069pbc.139.1338475342529;
        Thu, 31 May 2012 07:42:22 -0700 (PDT)
Received: by 10.68.237.166 with SMTP id vd6mr319044pbc.139.1338475342288;
        Thu, 31 May 2012 07:42:22 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id og6sm4376720pbb.42.2012.05.31.07.42.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 07:42:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1338475290-22644-1-git-send-email-davidbarr@google.com>
X-Gm-Message-State: ALoCoQldATNWQRZtLF5MLpRZs8tKPplQxKvoSn13FNbYpkJdPNqA2kQchI6u4qHFeFSJdmVGJi+cWb+rpsfreSYHRldGW1QIFTxWeNwbjZ0l3+cHCVRtkoDovhk2v482Xk94hx1k7KqsFTT8TdYQ4gm/wj0efyemgStJj7SFupAJ8FdNhAaAX6U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198911>

As a side-effect, fix clang-analyzer warning:

vcs-svn/svndiff.c:278:3: warning: expression result unused [-Wunused-value]
                error("invalid delta: incorrect postimage length");
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This warning caused by an insanely concise error() upstream.

Signed-off-by: David Barr <davidbarr@google.com>
---
 vcs-svn/svndiff.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 57d647d..11a0e38 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -258,6 +258,7 @@ static int apply_window_in_core(struct window *ctx)
 static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
 			    struct sliding_view *preimage, FILE *out)
 {
+	int rv = -1;
 	struct window ctx = WINDOW_INIT(preimage);
 	size_t out_len;
 	size_t instructions_len;
@@ -275,16 +276,15 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
 	if (apply_window_in_core(&ctx))
 		goto error_out;
 	if (ctx.out.len != out_len) {
-		error("invalid delta: incorrect postimage length");
+		rv = error("invalid delta: incorrect postimage length");
 		goto error_out;
 	}
 	if (write_strbuf(&ctx.out, out))
 		goto error_out;
-	window_release(&ctx);
-	return 0;
+	rv = 0;
 error_out:
 	window_release(&ctx);
-	return -1;
+	return rv;
 }
 
 int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-- 
1.7.10.2
