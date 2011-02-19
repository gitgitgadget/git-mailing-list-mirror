From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 1/3] t/gitweb-lib.sh: print to stderr when gitweb_run has errors
Date: Sat, 19 Feb 2011 15:27:40 +0000
Message-ID: <1298129262-10468-2-git-send-email-avarab@gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 16:28:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqojD-0006EQ-KJ
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 16:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589Ab1BSP2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 10:28:01 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34998 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577Ab1BSP17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 10:27:59 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1925810ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references;
        bh=SCGq6LUZ6ErduEVD2q5zZm9ABWAuYvac+g3F/3KAEO8=;
        b=nsD+n7o61hXjR3kV/WaLro0fU0i5XEht8zqUjIo3suTjHKkwcmRGH2Z1Na1AMqWHKk
         XhBY9aBtprfx+ml9dIGI6/f+F3Mrj7DXAUEhJoJeuikTTp/GdBxXbS8QMX/Et4rNaTb3
         C/ORlbS899NTbAXW+SvK2TGLWkdkIU6HePzD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ed+8f9mcQf86rjLZKIKCiXbmyb12RfNLz5TzwoGF0Z2L5Vq/pQlsiRVnt3N5FloZap
         f9WWjuMfY6ShT+hJtlFiGfXsEZxJDjw3T5kaV1uQ9oimiL7OuXJM8AcJGhktTaW1v00V
         qOBwFEJmR3LU5R3/SfNplodwC1VDJR2fQt7bw=
Received: by 10.213.4.67 with SMTP id 3mr2372178ebq.46.1298129278473;
        Sat, 19 Feb 2011 07:27:58 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id q52sm3006362eei.15.2011.02.19.07.27.57
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 07:27:57 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298124654-12051-1-git-send-email-avarab@gmail.com>
In-Reply-To: <1298124654-12051-1-git-send-email-avarab@gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167287>

Change the gitweb_run test subroutine to spew errors to stderr if
there are any, previously it would just silently fail, which made
tests very hard to debug.

Before you'd get this output, when running tests under `--verbose
--immediate --debug`:

    expecting success: git rm renamed_file &&
             rm -f renamed_file &&
             git commit -a -m "File removed." &&
             gitweb_run "p=.git;a=commitdiff"
    rm 'renamed_file'
    [master 8d80741] File removed.
     Author: A U Thor <author@example.com>
     1 files changed, 0 insertions(+), 1 deletions(-)
     delete mode 120000 renamed_file
    not ok - 32 commitdiff(0): file deleted
    #       git rm renamed_file &&
    #                rm -f renamed_file &&
    #                git commit -a -m "File removed." &&
    #                gitweb_run "p=.git;a=commitdiff"

Now you'll get the much more useful:

    expecting success: git rm renamed_file &&
             rm -f renamed_file &&
             git commit -a -m "File removed." &&
             gitweb_run "p=.git;a=commitdiff"
    rm 'renamed_file'
    [master 2a4214e] File removed.
     Author: A U Thor <author@example.com>
     1 files changed, 0 insertions(+), 1 deletions(-)
     delete mode 120000 renamed_file
    [Sat Feb 19 14:32:54 2011] gitweb.perl: Use of uninitialized value in subroutine entry at /home/avar/g/git/t/../gitweb/gitweb.perl line 4415.
    not ok - 32 commitdiff(0): file deleted
    #       git rm renamed_file &&
    #                rm -f renamed_file &&
    #                git commit -a -m "File removed." &&
    #                gitweb_run "p=.git;a=commitdiff"
---
 t/gitweb-lib.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index b9bb95f..2388b0f 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -82,7 +82,12 @@ gitweb_run () {
 		}
 		close O;
 	' gitweb.output &&
-	if grep '^[[]' gitweb.log >/dev/null 2>&1; then false; else true; fi
+	if grep '^[[]' gitweb.log >/dev/null 2>&1; then
+		cat gitweb.log >&2
+		false
+	else
+		true
+	fi
 
 	# gitweb.log is left for debugging
 	# gitweb.output is used to parse HTTP output
-- 
1.7.2.3
