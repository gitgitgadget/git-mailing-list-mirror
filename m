From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH] commit.c:record_author_date() use skip_prefix() instead of starts_with()
Date: Sat,  1 Mar 2014 11:48:19 -0800
Message-ID: <1393703299-7977-1-git-send-email-tanayabh@gmail.com>
To: git@vger.kernel.org, tanayabh@gmail.com
X-From: git-owner@vger.kernel.org Sat Mar 01 20:49:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJpuM-0007u3-N0
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 20:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbaCATtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 14:49:01 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:51240 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbaCATtA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 14:49:00 -0500
Received: by mail-pb0-f47.google.com with SMTP id up15so2153269pbc.6
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 11:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=ofC+RRjh58zG3NptOMHoVXZ5u7fG+0Tax7mSqrKuizs=;
        b=DPintYmhcqShnDQmyELsFP03TtO1+Wqs4ZUnLxeGUISTYCeMRQ/k0aSKcNXAdsA40S
         mQYea+BoH4OzjFtZo+HKKoGXWFmgxUr0IT31OyfWDwDLNZ4tnvciQqDbpXbbGhh7A/PH
         pSlbcDdSGuKUtSpRMKTRETFu4CwLLWmN5fzkcfypOxJDszYdyiZMLfPI0Q4gpPi3DqTK
         A4biqxVmikwDjNeD7TyGzpq607BeBKvDMh2uanUrjlLyoS3WLra8MsC5GOCiXX1xN/dR
         gO0lP1ZQPh5gnfc1Gn9OKdf/Ny6uko4w6avDLvawvSDMwVibh1Ru0k2Hh/uHc5yNDwMi
         oKzw==
X-Received: by 10.68.131.100 with SMTP id ol4mr10878848pbb.134.1393703339948;
        Sat, 01 Mar 2014 11:48:59 -0800 (PST)
Received: from localhost.localdomain ([59.178.139.18])
        by mx.google.com with ESMTPSA id sy2sm19025502pbc.28.2014.03.01.11.48.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 11:48:59 -0800 (PST)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243109>


Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 commit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..c954ecb 100644
--- a/commit.c
+++ b/commit.c
@@ -566,7 +566,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	     buf;
 	     buf = line_end + 1) {
 		line_end = strchrnul(buf, '\n');
-		if (!starts_with(buf, "author ")) {
+		if (!skip_prefix(buf, "author ")) {
 			if (!line_end[0] || line_end[1] == '\n')
 				return; /* end of header */
 			continue;
-- 
1.7.9.5

Hello,

This is my patch for the GSoC microproject #10:

Rewrite commit.c:record_author_date() to use skip_prefix(). 
Are there other places in this file where skip_prefix() would be more 
readable than starts_with()?

Since skip_prefix() and starts_with() implement the same functionality with different
return values, they can be interchanged easily.

Other usage of starts_with() in the same file can be found with

$ grep -n starts_with commit.c

1116:		else if (starts_with(line, gpg_sig_header) &&
1196:		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {

I have a query,should I tackle a bug from the mailing lists or research about the proposal 
and present a rough draft?

Cheers,
Tanay Abhra.
