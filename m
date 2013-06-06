From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/9] sequencer: trivial fix
Date: Thu,  6 Jun 2013 03:58:57 -0500
Message-ID: <1370509144-31974-3-git-send-email-felipe.contreras@gmail.com>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 11:01:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkW4G-000672-8A
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 11:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406Ab3FFJBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 05:01:04 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:41212 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326Ab3FFJBA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 05:01:00 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so419262oag.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DliE0Omkdf/PYUsnA/jNUoCuK05jVXnHdoe2PWuDKJs=;
        b=HUd8attMt7co1VhJWWHm4d1Fv4CCMp2cmGu/2B6oHrj3JyzozjdLsupRPnnK8WW/bD
         2VRCWqu6vKUb5rEtuM9s6v0/a4e7nbQLLZmZ8vt3AQXy1AUIe9SaIgtkeHcuGdzXjTu9
         U+LBw2GfYo3C/jgpvLSuhqRnv/DSvWFANm9y8hmeO6WTun7NqvlPNY6T9+EVVU5NEyma
         YAu8Jn+A+Y7uc8Zjt6DjDkg7cdIMlcUUu+/irVJncwcMa3ruxQvFanY8G4X4zM75dxTd
         adhcOvcnK1AbNSSTZ2Mow7zQ9OzXJyMA/b9Xm7UbEKFJiGQuPG7KZUJBWauWeSmrUp+N
         +zGA==
X-Received: by 10.60.79.165 with SMTP id k5mr16993124oex.108.1370509260518;
        Thu, 06 Jun 2013 02:01:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id l4sm11778318obh.7.2013.06.06.02.00.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Jun 2013 02:00:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226489>

We should free objects before leaving.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b4989ba..f7be7d8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -628,8 +628,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	}
 
 	allow = allow_empty(opts, commit);
-	if (allow < 0)
-		return allow;
+	if (allow < 0) {
+		res = allow;
+		goto leave;
+	}
 	if (!opts->no_commit)
 		res = run_git_commit(defmsg, opts, allow);
 
-- 
1.8.3.698.g079b096
