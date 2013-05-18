From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 02/15] contrib: related: add option parsing
Date: Sat, 18 May 2013 06:46:42 -0500
Message-ID: <1368877615-9563-3-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:48:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udfcv-0006ti-Af
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170Ab3ERLsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:48:35 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:40735 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab3ERLsd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:48:33 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so5609726obb.17
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=tdXChkvmcPRCAyAb5rRtvHwzspA6fmPy7ob7svIZVCA=;
        b=y3XslTbYQ8ATHv/0nrXJE4uImoRqrNVSAVxkYF+Q70P9T79hbm/ZLom62p8IZFRAXN
         /FvzA4EfpE/1/GugmZl7W2eQ0VIg0z7TqZlqID7vP1Y4UKSyqZFe5Zr46gx/EwvuRCdv
         iGGcIC8CsvA+WXBzyKyALUe0Zu2fzp+8v0GXZexZur6ZFlyGSfNp2iNNBgqlsJnr3ydT
         1zxDt5eDqBZXDJ5FeJYFg5NqnmTFjs4vfTGamNkobq4EYenUMFHtlpa1Xa5K4AnnQXzd
         MHX0CgPTPcM3/oeLxrY8zH3A+xrDT7m1QMfnsAZHR2kCEgPIvXe3F1fhnRtqrbtyMksx
         axTg==
X-Received: by 10.60.115.73 with SMTP id jm9mr17601259oeb.126.1368877713456;
        Sat, 18 May 2013 04:48:33 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n5sm11235268obi.8.2013.05.18.04.48.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:48:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224775>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 4f31482..6f18cc8 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -3,6 +3,8 @@
 # This script finds people that might be interested in a patch
 # usage: git related <file>
 
+require 'optparse'
+
 $since = '5-years-ago'
 $min_percent = 10
 
@@ -10,6 +12,21 @@ def fmt_person(name, email)
   name ? '%s <%s>' % [name, email] : email
 end
 
+begin
+  OptionParser.new do |opts|
+    opts.program_name = 'git related'
+    opts.banner = 'usage: git related [options] <file>'
+
+    opts.on('-p', '--min-percent N', Integer, 'Minium percentage of role participation') do |v|
+      $min_percent = v
+    end
+    opts.on('-d', '--since DATE', 'How far back to search for relevant commits') do |v|
+      $since = v
+    end
+  end.parse!
+rescue OptionParser::InvalidOption
+end
+
 class Commit
 
   attr_reader :persons
-- 
1.8.3.rc2.542.g24820ba
