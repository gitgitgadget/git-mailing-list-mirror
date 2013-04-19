From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/8] contrib: cc-cmd: parse committish like format-patch
Date: Fri, 19 Apr 2013 00:14:16 -0500
Message-ID: <1366348458-7706-7-git-send-email-felipe.contreras@gmail.com>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 07:16:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT3g0-00087I-GE
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 07:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188Ab3DSFPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 01:15:49 -0400
Received: from mail-gh0-f179.google.com ([209.85.160.179]:35941 "EHLO
	mail-gh0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab3DSFPr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 01:15:47 -0400
Received: by mail-gh0-f179.google.com with SMTP id z12so450015ghb.10
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 22:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=k3xdskykT+VIFl5sW38Vmdt9d3fq4U8IdhbGVV2ojl8=;
        b=tAj3X/g/Pdl2P8ntiLOo3mBMI9/tuzgGAVA8jUG2gI8ZyLOaz7LMhAFtpAI303ee6H
         vV/y/gE5kmn+b8lLPeF2eqsjugeCUY4482O4wm8BzZjRngvx2AU+YebRB2deJ36CBQ5i
         tFKXmrQo11rsUFA+vlrll3CF1nFKW79pivqksxsmuuRZZrf8iFuSGMUmYDUM89izyhXL
         UW291YBHq9zeT9G9oXIUXEfxN3Li2SkzeqeWa8FU/rFdo12OSUTj9TMR+fYiM6A3ErJY
         LRBhOhfXBolbpU0cr5ZPrcybOscKCcksDhb8/89bDn+PpkeksGHQmEPKCfsR6sodI97I
         zE9g==
X-Received: by 10.236.143.105 with SMTP id k69mr7127628yhj.176.1366348546815;
        Thu, 18 Apr 2013 22:15:46 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id x33sm22320424yhn.18.2013.04.18.22.15.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 22:15:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221732>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index 462f22c..02e1a99 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -138,6 +138,20 @@ class Commits
 
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
1.8.2.1.790.g4588561
