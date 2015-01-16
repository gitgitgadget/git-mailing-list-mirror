From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] contacts: introduce --since and --min-percent
Date: Fri, 16 Jan 2015 15:58:53 -0500
Message-ID: <1421441933-54183-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 21:59:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCDz5-0004sH-FW
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 21:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbbAPU7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 15:59:04 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:55595 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbbAPU7C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 15:59:02 -0500
Received: by mail-qc0-f177.google.com with SMTP id x3so18946578qcv.8
        for <git@vger.kernel.org>; Fri, 16 Jan 2015 12:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=plE/ogBzB+kxv+cZTtCzrAUX4FAOD9Clab+xRxlYjyk=;
        b=r9IlfaoUvMclWy9wuESvYOF6Gorg3FcdI0dCrczL+Qkg9o4qYjqtoTWiiVCHLsqi4G
         PeIw2LLTqiTbl4HH0RRLtNI5EmTdif/V332Pyt2ZdUBlk/PLo9wyfbEB+vHqnfoUQOW+
         kYX9OhOeaNZlmzoDG01gS61XqiKxyfhWUpimnoTg64Cc9wG/7tzII1tpGsxU+7wnYtX8
         GDyV3d93uIUxWHbE1x7iKS07q0nNyxRqmL74Ps15cEU5Hmxw1+gF0/gfi+Z1toLLTzow
         PIvco2JNSrObadNOdeg8OcsV8AvL7k4pGHNDCM/ytXkRECv8p5TOSSm41IyQ43BiG2Lz
         zTKA==
X-Received: by 10.140.91.201 with SMTP id z67mr18185915qgd.27.1421441941420;
        Fri, 16 Jan 2015 12:59:01 -0800 (PST)
Received: from localhost.localdomain (cpe-66-65-144-82.nyc.res.rr.com. [66.65.144.82])
        by mx.google.com with ESMTPSA id u1sm5166231qap.11.2015.01.16.12.59.00
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Jan 2015 12:59:00 -0800 (PST)
X-Mailer: git-send-email 2.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262574>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/contacts/git-contacts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index dbe2abf..b06f2e1 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -8,12 +8,16 @@
 use strict;
 use warnings;
 use IPC::Open2;
+use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 
 my $since = '5-years-ago';
 my $min_percent = 10;
 my $labels_rx = qr/Signed-off-by|Reviewed-by|Acked-by|Cc/i;
 my %seen;
 
+my $rv = GetOptions('since=s' => \$since, 'min-percent=i' => \$min_percent);
+exit 1 if (!$rv);
+
 sub format_contact {
 	my ($name, $email) = @_;
 	return "$name <$email>";
-- 
2.2.1
