From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 6/7] --name-only, --name-status, --check and -s are mutually
 exclusive
Date: Sat, 24 Jun 2006 20:26:49 +0300
Message-ID: <20060624202649.b2ed7f57.tihirvon@gmail.com>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 19:30:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuBxq-0001XZ-17
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 19:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWFXRab (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 13:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWFXRab
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 13:30:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:12043 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750959AbWFXRa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 13:30:29 -0400
Received: by nf-out-0910.google.com with SMTP id m19so402611nfc
        for <git@vger.kernel.org>; Sat, 24 Jun 2006 10:30:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=aKLSrNgsEjz0nZmHOoz523iWkB6waZXZRP6UTKT5uOg4iazpt1W4HW74KQHeyangnJ/hgaQnQSfPCcPUaosFmUnR+Wbx4pDAj9XVgjZpCx+sO82SFwd/qCHTOA8Zb4Wr3zMIn2biCDt6rQjkmnWHN0WfcGK1LqQXKHVb0dGplMc=
Received: by 10.48.43.11 with SMTP id q11mr3528963nfq;
        Sat, 24 Jun 2006 10:30:29 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id y24sm4234851nfb.2006.06.24.10.30.28;
        Sat, 24 Jun 2006 10:30:29 -0700 (PDT)
To: junkio@cox.net
In-Reply-To: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22528>


Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 diff.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 6be31e7..4b1b4eb 100644
--- a/diff.c
+++ b/diff.c
@@ -1366,6 +1366,19 @@ void diff_setup(struct diff_options *opt
 
 int diff_setup_done(struct diff_options *options)
 {
+	int count = 0;
+
+	if (options->output_format & DIFF_FORMAT_NAME)
+		count++;
+	if (options->output_format & DIFF_FORMAT_NAME_STATUS)
+		count++;
+	if (options->output_format & DIFF_FORMAT_CHECKDIFF)
+		count++;
+	if (options->output_format & DIFF_FORMAT_NO_OUTPUT)
+		count++;
+	if (count > 1)
+		die("--name-only, --name-status, --check and -s are mutually exclusive");
+
 	if ((options->find_copies_harder &&
 	     options->detect_rename != DIFF_DETECT_COPY) ||
 	    (0 <= options->rename_limit && !options->detect_rename))
-- 
1.4.1.rc1.g8637
