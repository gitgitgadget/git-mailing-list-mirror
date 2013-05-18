From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 14/15] contrib: related: parse committish like format-patch
Date: Sat, 18 May 2013 06:46:54 -0500
Message-ID: <1368877615-9563-15-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:49:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udfda-0007Sn-3n
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab3ERLtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:49:17 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:38131 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab3ERLtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:49:13 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so5498142obc.40
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9dbXn+bfwarnI6oJe2V7r3IBcMGHHDsvgzR3SQhkPbA=;
        b=FgGQTQKqY4TtHezbYj4zEFUAC/f+OP5qT9rKKZyyj+/opP70r4bZeZmXOBWHpx4wMY
         jb/IQ9dUxDF+k90ukz6/pQcqPsnrsUNVoafYNWJrBJmjztRmFRkqgYSI83oGCAipjjiT
         ZGgq3iMGpjYl4HSDJr124ALUlql6ncmtRhURA9FYhIjruONsf6ZfnmoTv14C6x9TW6CN
         F6wsaxK7j385hk33DgaJhbxASzVTLHIl7v1H284Tal3AQpr+oEM32EDYMd0G9hyfH2Vm
         P+3wSMDZfIgw3Lu0Aq6IOCtTHw19pg2BOXhXF8JEy/wqx8b7Dv/RqAQYDa2Tu1nY9Db4
         ttqA==
X-Received: by 10.182.102.234 with SMTP id fr10mr8890599obb.85.1368877753104;
        Sat, 18 May 2013 04:49:13 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id yx4sm11207488obb.11.2013.05.18.04.49.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:49:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224787>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 8394cdc..62c9b56 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -232,6 +232,20 @@ class Commits
 
   def from_rev_args(args)
     return if args.empty?
+
+    revs = []
+
+    File.popen(%w[git rev-parse --revs-only --default=HEAD --symbolic] + args).each do |rev|
+      revs << rev.chomp
+    end
+
+    case revs.size
+    when 1
+      committish = [ '%s..HEAD' % revs[0] ]
+    else
+      committish = revs
+    end
+
     source = nil
     File.popen(%w[git rev-list --reverse] + args) do |p|
       p.each do |e|
-- 
1.8.3.rc2.542.g24820ba
