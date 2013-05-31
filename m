From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 2/6] contrib: related: add option parsing
Date: Fri, 31 May 2013 02:37:40 -0500
Message-ID: <1369985864-31922-3-git-send-email-felipe.contreras@gmail.com>
References: <1369985864-31922-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 09:39:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJw2-0008Ec-Ln
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 09:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543Ab3EaHjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 03:39:36 -0400
Received: from mail-ye0-f174.google.com ([209.85.213.174]:53244 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3EaHje (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 03:39:34 -0400
Received: by mail-ye0-f174.google.com with SMTP id r9so294209yen.19
        for <git@vger.kernel.org>; Fri, 31 May 2013 00:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IIE5CiRlMIwLajWwPKBnc4V2Wf4AhJagRF10QlCs7Xw=;
        b=EGnLyV+aCCAU1maKdtVcn7ZdveI25/+g6MAzIca2xlOHIZFecgb38WJUw7mMCBqrEN
         sf/X+UzcxhLEE0OrWkRH4gW5CjggA115yv/qMm8KgwLpWSlfoztNDUIKuNnHzexAXevz
         p8NDkgkHprVpJ/AayiqaOmjnhnlm2Igdt5LnCuvnjM28v1IGZZ8E/8CprGpHEOMOWC+6
         NHTv+S50mmRk/bJ3l7gA/DZmL+CUxNq84Xf0pf3WdOdEYUX4uXZ3wiQEwqUy8a8eDKxa
         HK5zDb5gNA05c/aHE19bn/7CgoHnVvG0ZH1g6l580fjArklM0/MTjQAz1WylM1EvF392
         5QDw==
X-Received: by 10.236.109.169 with SMTP id s29mr5888000yhg.195.1369985974012;
        Fri, 31 May 2013 00:39:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id s45sm66024577yhk.22.2013.05.31.00.39.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 May 2013 00:39:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.358.g5a91d05
In-Reply-To: <1369985864-31922-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226060>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 1b9b1e7..bde5b99 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -3,9 +3,25 @@
 # This script finds people that might be interested in a patch
 # usage: git related <file>
 
+require 'optparse'
+
 $since = '5-years-ago'
 $min_percent = 10
 
+OptionParser.new do |opts|
+  opts.program_name = 'git related'
+  opts.banner = 'usage: git related [options] <file>'
+
+  opts.on('-p', '--min-percent N', Integer,
+          'Minium percentage of role participation') do |v|
+    $min_percent = v
+  end
+  opts.on('-d', '--since DATE',
+          'How far back to search for relevant commits') do |v|
+    $since = v
+  end
+end.parse!
+
 class Commit
 
   attr_reader :persons
-- 
1.8.3.358.g5a91d05
