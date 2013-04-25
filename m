From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 09/11] contrib: related: sort by participation
Date: Thu, 25 Apr 2013 14:59:41 -0500
Message-ID: <1366919983-27521-10-git-send-email-felipe.contreras@gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 22:01:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSMR-0004FC-0U
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512Ab3DYUBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:01:35 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:39545 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245Ab3DYUBc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:01:32 -0400
Received: by mail-oa0-f47.google.com with SMTP id n9so3219539oag.20
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=WO1KFpIOY2S6eVD6V2QPG2fMts/yV846jyaIh9gLyOM=;
        b=rky47thL498Z7Gx6I91uzaQJ92Hh7hIUyQJADz5lt4McLL/SGHE/dmn/3vT2y4YQuQ
         bShNpn1754b00qxbBdBIyH+fTW6KKIaLMtNeQ78Ceu9hbIhqtiS+XAEpuRbbhDik5FNZ
         7K22F6ST4C2b6cfErwELi5RmtYOotc+j2TbHS6GuTyYL65M/g1CLjKh1MLm8LNFl7qIA
         ZmaVbH5bG720nlAytaqoifI9UPmH2kEBHjnPN1/5mVm7Hf8RfdLfNdra+77TK9gF3I79
         ww1HMzT+IBa+O4ay3YAzdPDcD33sweKG9/8KvXmsFwgQpFfC0jru+62l4anu5P/uPDOx
         NKIg==
X-Received: by 10.182.231.197 with SMTP id ti5mr16432791obc.64.1366920091675;
        Thu, 25 Apr 2013 13:01:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id pq6sm1859588obc.11.2013.04.25.13.01.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 13:01:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222437>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index cf6818e..4e9b916 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -212,7 +212,12 @@ commits.items.values.each do |commit|
   end
 end
 
-persons.each do |person, roles|
+# sort by number of participations
+count_sort = lambda do |a, b|
+  b[1].values.reduce(:+) <=> a[1].values.reduce(:+)
+end
+
+persons.sort(&count_sort).each do |person, roles|
   roles = roles.map do |role, count|
     percent = count.to_f * 100 / commits.size
     next if percent < $min_percent
-- 
1.8.2.1
