From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] send-email: add proper default sender
Date: Sun, 11 Nov 2012 18:06:50 +0100
Message-ID: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 18:07:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXb0C-0008Ug-EF
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408Ab2KKRHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:07:04 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33446 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab2KKRHC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:07:02 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2085215bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 09:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=4cr58xenIQCdYvnGz/4WmQ5flbdsm+uYwHJY4gugrl8=;
        b=FOABwf96DONaAWzDyO9l69otZfvgn9Wfil2P0XxljJ5nTpeR7sizS2tTg1XBoJvoW6
         u9xjQWRhpsFQoT2g9K+Jeajrh33mldjmqYYel3kU1sYplc1XlayoirwsFNYl02EC+EFi
         SSEvK7Co5Rww3f30hUjnv6I7fC+NzD2uRqmmZcN4jALiHJC/Ist2KOSTtpAK6z1vbMuN
         A8yg1HxFIZh3Tkfw+yXKHXIPoTqa9cDjObYd8ptM/eiMgdHT6ekOciScJsbxLeHeIv7H
         ojgHkI7Pkm21H7QFLx39EwMf70Zt8sBBwayUjUNvHn+cBDcCy/Vx5N8wMEKwWALgwG0l
         4eYA==
Received: by 10.204.136.197 with SMTP id s5mr6291956bkt.88.1352653621200;
        Sun, 11 Nov 2012 09:07:01 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id g8sm1645225bkv.6.2012.11.11.09.06.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 09:07:00 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209418>

There's no point in asking this over and over if the user already
properly configured his/her name and email.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

I got really tired of 'git send-email' always asking me from which address to send mails... that's already configured.

 git-send-email.perl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index aea66a0..65b8328 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -748,6 +748,17 @@ if (!$force) {
 	}
 }
 
+my $name = Git::config('user.name');
+my $email = Git::config('user.email');
+
+if (defined $email) {
+	if (defined $name) {
+		$sender = sprintf("%s <%s>", $name, $email);
+	} else {
+		$sender = $email;
+	}
+}
+
 my $prompting = 0;
 if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter || '';
-- 
1.8.0
