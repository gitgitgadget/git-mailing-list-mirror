From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 02/11] contrib: related: add option parsing
Date: Thu, 25 Apr 2013 14:59:34 -0500
Message-ID: <1366919983-27521-3-git-send-email-felipe.contreras@gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 22:01:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSM2-0003mg-G0
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758289Ab3DYUBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:01:12 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:58475 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab3DYUBK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:01:10 -0400
Received: by mail-oa0-f52.google.com with SMTP id n12so3299808oag.11
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=eR2AmTBbRx3FJJi2NvD6v4XvSF/aiKW0ifm4a0+ENwg=;
        b=l+vFgkFUtgBxcfpoEzoeKh/gKnKww8egmwVDJmgI4jHxtYHwWLiKuZAfbvW5PMUTgM
         H90AIa5KOEGAtkskmMJzh2uQyCjck9snfdb3wyKRJR/7tI+sdaD4wRYnavIWb400g+t6
         f8OFvNNdfPBm1Wk/88rsYGquAXVZ8Fm4j6g4YfBzz0eUdHPk7G4o0Q+IPyyLiXDK41kz
         wGd0TcRcwZ829pNAioZ8uLI+VPoWQ8zaQKIhHhAVVJG3ibjPXxUbIFIk64tlehlbsZ/C
         dUNTb880QRev+LQqqSvz2R9oxvvLACbPHl6uqelIgugcz0AM1YR9rDGaU2Err3A+Oofa
         3VhQ==
X-Received: by 10.182.237.77 with SMTP id va13mr10204826obc.65.1366920070128;
        Thu, 25 Apr 2013 13:01:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ru4sm4729133obb.4.2013.04.25.13.01.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 13:01:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222430>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 2d47efa..702836a 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -1,8 +1,25 @@
 #!/usr/bin/env ruby
 
+require 'optparse'
+
 $since = '3-years-ago'
 $min_percent = 5
 
+begin
+  OptionParser.new do |opts|
+    opts.program_name = 'git cc-cmd'
+    opts.banner = 'usage: git cc-cmd [options] <file>'
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
 
   attr_reader :id, :roles
-- 
1.8.2.1
