From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v9 0/6] transport-helper: fixes
Date: Sat, 12 Apr 2014 15:12:49 -0500
Message-ID: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:23:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4Sl-0007Oi-RB
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbaDLUW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:22:59 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58504 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798AbaDLUW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:22:58 -0400
Received: by mail-oa0-f46.google.com with SMTP id i7so7690315oag.33
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ajdKz2yqmg6GEYLgGG5AKx5Smd/SlqKosYXHupK6u4A=;
        b=Dyg/xkmf4d84gu/HUvtMWpyC2PROFKoK/qaYYvGNhT1i5VJfmjVkZy5Cb2Lyc2HVx/
         OdmvuMtgO3FmPGljYsO/ojW/rZdHs2xPOIsOaEmP7PN1Zn140Hfl9ORS/sMGpqAgAC0Z
         8vK1xmBIWkVM115UoMi+M24hHDriaZ/uhicft8xb/4YcoZcH8KbxHzxLGj35bkrfDkWg
         wlgzc0/SmTQY5cTuV98KLmeGuEk1MIrmAKFzU5XzILw3A81Uprk1ix2vAUJCs+u6k1xz
         LFpqu+WwibhvM1x+i92KcDh2ZaY6z0Ipr5yKba7oIVp/gaSQqYYgeZdBBfgcSwRdM/Rs
         glOA==
X-Received: by 10.60.59.196 with SMTP id b4mr3538959oer.48.1397334178079;
        Sat, 12 Apr 2014 13:22:58 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 10sm19162531obq.18.2014.04.12.13.22.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:22:57 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246179>

Hi,

These patches add support for remote helpers --force, --dry-run, and reporting
forced update.

Changes since v8:

--- a/transport-helper.c
+++ b/transport-helper.c
@@ -734,7 +734,7 @@ static int push_update_ref_status(struct strbuf *buf,
        }
 
        (*ref)->status = status;
-       (*ref)->forced_update = forced;
+       (*ref)->forced_update |= forced;
        (*ref)->remote_status = msg;
        return !(status == REF_STATUS_OK);
 }

Felipe Contreras (4):
  transport-helper: mismerge fix
  transport-helper: don't update refs in dry-run
  transport-helper: add 'force' to 'export' helpers
  transport-helper: check for 'forced update' message

Richard Hansen (2):
  test-hg.sh: tests are now expected to pass
  remote-bzr: support the new 'force' option

 Documentation/gitremote-helpers.txt   |  4 ++++
 contrib/remote-helpers/git-remote-bzr | 31 ++++++++++++++++++++++++++++++-
 contrib/remote-helpers/test-bzr.sh    | 22 +++++++++++++++++++++-
 contrib/remote-helpers/test-hg.sh     |  4 ++--
 git-remote-testgit.sh                 | 18 ++++++++++++++++++
 t/t5801-remote-helpers.sh             | 13 +++++++++++++
 transport-helper.c                    | 25 +++++++++++++++++--------
 7 files changed, 105 insertions(+), 12 deletions(-)

-- 
1.9.1+fc3.9.gc73078e
