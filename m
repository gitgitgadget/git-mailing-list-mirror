From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 10/18] remote-bzr: fix branch names
Date: Tue, 30 Apr 2013 20:10:02 -0500
Message-ID: <1367370610-14250-11-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLay-0007cG-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934127Ab3EABMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:12:25 -0400
Received: from mail-ye0-f179.google.com ([209.85.213.179]:39087 "EHLO
	mail-ye0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934111Ab3EABMW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:12:22 -0400
Received: by mail-ye0-f179.google.com with SMTP id l2so197119yen.10
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dt50McV7wyn/Whu+ll/NbnsSGxn7NXQ2BjUHfnNCc+I=;
        b=T1k9dVm8463U885WNmlvoyCpEfvLMNrdNetxzpOzY8DG/IPG9KwRG2rNHQPzffZWxE
         KWb1n6iSye69uzEMhnivil3WGNQrQwZRjlD/BluxnE3hnuZfaJPnWJrMQ/aXieOB/dhQ
         6bELra3MUSBYyr21li6jzd6y6bw/pAEhNjCDsCKsiUxU/eEzpqP137I/hL1iUxdLm++m
         xQF9Zo0l3NhJ+tuV8iBBnRKNTRW2NeWHfjyO8NCUQp/BHaXcW+XYQsHJ1AJthHdGEYVx
         rUrdALEzi16Vswvv3iBE6T/VZWoZycNX3Mtg//J4E+eL7ucjat0X9QOA9jAIJSSix27w
         N5xA==
X-Received: by 10.236.124.200 with SMTP id x48mr551871yhh.180.1367370741737;
        Tue, 30 Apr 2013 18:12:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id v48sm1502471yhi.26.2013.04.30.18.12.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:12:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223054>

When branches have '/' in their name (aka. sub-branches), bazaar seems
to choke while creating the new directory.

Also, git cannot have both 'foo' and 'foo/bar'.

So let's replace slashes with a plus sign.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 3b33061..38cec07 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -781,6 +781,7 @@ def get_repo(url, alias):
 
             name = repo.user_transport.relpath(branch.base)
             name = name if name != '' else 'master'
+            name = name.replace('/', '+')
 
             if not is_local:
                 peers[name] = branch
-- 
1.8.3.rc0.399.gc96a135
