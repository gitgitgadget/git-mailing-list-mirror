From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20clone=3A=20fix=20refspec=20on=20=22--single-branch=22=20option?=
Date: Fri, 14 Sep 2012 07:09:17 +0200
Message-ID: <1347599357-15533-1-git-send-email-ralf.thielow@gmail.com>
References: <CAN0XMOKszADpeaCG7VhL-AZ3m7_hSWV3NhEmPuH6FETzs=eDNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 14 07:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCO9l-00015F-1o
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 07:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab2INFJZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2012 01:09:25 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:56930 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2INFJY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 01:09:24 -0400
Received: by weyx8 with SMTP id x8so2139592wey.19
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 22:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OLYInALHYuVDbakUIUfCaDEv0uWHLAhR8Y71dJ/g4nA=;
        b=hQNIDwtnyIuX4CjXGq6KIWbEGTNGSA6PCTzPIwTHvOBr6yZFqB3U3ONJ9Zn+yJa6kC
         azM/xhJS/UI/+vVvYnWdDneQ1juBzvyYGBWu7m3plMTuPHqCxUHPr53Vb3QozkteFym4
         geujx+vxM1RzD5b7jjkxAYWljwQVFcEKeCJ0h/Q7ZDWh1z9Qvf2XXO4Gf2TcF6iqkANv
         Ig5+0S7DKVwKRq+2VVJjrLxZ+VdL00lgcBb9xUvzfcElihZRXqw+sWM5cTVGZNyg6x2n
         wsmRSAmRg4qcsCc380jdr9HoIWdbati+pjGU748kfcsvQHBaVkKGD1KaiNnaLDbUVu5x
         LRdQ==
Received: by 10.180.97.106 with SMTP id dz10mr3187664wib.21.1347599362609;
        Thu, 13 Sep 2012 22:09:22 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id q4sm16996797wix.9.2012.09.13.22.09.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Sep 2012 22:09:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.395.g6b149ce.dirty
In-Reply-To: <CAN0XMOKszADpeaCG7VhL-AZ3m7_hSWV3NhEmPuH6FETzs=eDNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205453>

After using "git clone" with the "--single-branch"
option, the configured refspec for this repo was
"+refs/heads/*:refs/remotes/origin/*".
After fetching changes from this repo again, it'll
receive all refs instead of the single ref which
was used in "--single-branch". Fixing the refspec
that it just contains the ref of the branch which
was cloned.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/clone.c | 5 ++++-
 1 Datei ge=C3=A4ndert, 4 Zeilen hinzugef=C3=BCgt(+), 1 Zeile entfernt(=
-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5e8f3ba..3e74d55 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -754,7 +754,10 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
=20
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
+	if (option_single_branch)
+		strbuf_addf(&value, "+%s%s:%s%s", src_ref_prefix, option_branch, bra=
nch_top.buf, option_branch);
+	else
+		strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
=20
 	if (option_mirror || !option_bare) {
 		/* Configure the remote */
--=20
1.7.12.395.g6b149ce.dirty
