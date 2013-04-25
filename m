From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 06/11] contrib: related: parse committish like format-patch
Date: Thu, 25 Apr 2013 14:59:38 -0500
Message-ID: <1366919983-27521-7-git-send-email-felipe.contreras@gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 22:01:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSMC-0003yE-Fz
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152Ab3DYUBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:01:25 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:40345 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758397Ab3DYUBW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:01:22 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so3275587oag.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wwjCOK59qIzxIiYm97Eu0eGtVibIdqaeW74sPSSAEAY=;
        b=zzD7MKucmnAOyr6PZDNO60VWOJdZomNjztFHx8CZTeotEDxhrfugJUgfqd4D6DYJb3
         TkvaANDY0bF5uzff9tx2UYG4v2Iqyc3hp4gZ8k58rJWRFsjtJTOo8ZVzHEdmVqjNULKV
         u9sAhmvJ+FjJKFXNjs+8DOf4tc96tfSDRPWE3UN6jRBmB3yycrvXZ42a9cJ6Z7sfbUXW
         TlurLFElYn08N9IOtrFnmUtpopRlr4bnC4ex01RjRK3bc6PrEbWxjkWyIAD/0a8thGGG
         c05vwU70bu4znyw+8LI7Dzk/1AFint3LJsW+5bKAuSP9uHnI6nxPpViIpQPAEWysh7JT
         nfxw==
X-Received: by 10.60.121.70 with SMTP id li6mr17473944oeb.16.1366920082174;
        Thu, 25 Apr 2013 13:01:22 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id xz9sm4950003oeb.5.2013.04.25.13.01.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 13:01:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222434>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 0015b3c..2f38ee1 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -126,6 +126,20 @@ class Commits
 
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
1.8.2.1
