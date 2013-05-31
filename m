From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v9 4/4] contrib: related: parse committish like format-patch
Date: Fri, 31 May 2013 02:46:20 -0500
Message-ID: <1369986380-412-5-git-send-email-felipe.contreras@gmail.com>
References: <1369986380-412-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 09:48:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiK4Z-0004O1-Pb
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 09:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736Ab3EaHsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 03:48:20 -0400
Received: from mail-gg0-f180.google.com ([209.85.161.180]:33066 "EHLO
	mail-gg0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab3EaHsR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 03:48:17 -0400
Received: by mail-gg0-f180.google.com with SMTP id q4so284528ggn.39
        for <git@vger.kernel.org>; Fri, 31 May 2013 00:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8TXMWwE2kt1r4BYqPR8IAC24svZxi8AFjxmKM/BiLJg=;
        b=xwxdDQD8i4QG/VDsqWtr6Gw9NZwB0Jxb4Q4Z8v0EoT7R3T/KYfN1uRSc6wXptZNSr/
         3MSFI8HVqhJ9LKm4Dhskkh0TTRQ0zh8keReOL+45ZRH6vYN+FmE4mwZkQZ6BJfdpWUen
         XijUQcqhwzr+fNlughqw6xzPNoiJuwh/dyl8r1F4uKBJMqoK1Xz57x8/UQSHlEpFTLE0
         dd7mCC+anX7Y9If+qmNnOjha8hqPc8tWyCYOh3gbEniCQbK13eic0PKNrtcXJkit8sc+
         YvbJBtLaPcLahsciab7FTXNc0KWaXSVRpPB4yfYFc5KJkWnTYz3gqYnO5bq2wd0R6gEH
         Y60Q==
X-Received: by 10.236.133.97 with SMTP id p61mr6178102yhi.0.1369986496220;
        Fri, 31 May 2013 00:48:16 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id s45sm66060612yhk.22.2013.05.31.00.48.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 May 2013 00:48:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.358.g5a91d05
In-Reply-To: <1369986380-412-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226069>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 20eb456..bded6f6 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -105,6 +105,21 @@ class Commits
   end
 
   def from_rev_args(args)
+    revs = []
+
+    File.popen(%w[git rev-parse --revs-only --default HEAD --symbolic] + args).each do |rev|
+      revs << rev.chomp
+    end
+
+    case revs.size
+    when 1
+      r = revs[0]
+      r = '^' + r if r[0] != '-'
+      args = [ r, 'HEAD' ]
+    else
+      args = revs
+    end
+
     source = nil
     File.popen(%w[git rev-list --reverse] + args) do |p|
       p.each do |e|
-- 
1.8.3.358.g5a91d05
