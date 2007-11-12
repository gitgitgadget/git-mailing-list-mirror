From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Call refresh_cache() when updating the user index for --only commits.
Date: Mon, 12 Nov 2007 15:48:22 -0500
Message-ID: <1194900502-8987-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 12 21:50:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrgEf-0006V4-Jz
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 21:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbXKLUuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2007 15:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbXKLUuF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 15:50:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49276 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbXKLUuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 15:50:04 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lACKmeDh010548;
	Mon, 12 Nov 2007 15:48:40 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lACKmdiS020700;
	Mon, 12 Nov 2007 15:48:40 -0500
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lACKmRap021166;
	Mon, 12 Nov 2007 15:48:31 -0500
X-Mailer: git-send-email 1.5.3.5.1762.g9a09d-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64705>

We're guaranteeing the user that the index will be stat-clean after
git commit. Thus, we need to call refresh_cache() for the user index to=
o,
in the 'git commit <paths>' case.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-commit.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 5011b8b..35205ef 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -109,6 +109,7 @@ static char *prepare_index(const char **files, cons=
t char *prefix)
=20
 	/* update the user index file */
 	add_files_to_cache(verbose, prefix, files);
+	refresh_cache(REFRESH_QUIET);
 	if (write_cache(fd, active_cache, active_nr) || close(fd))
 		die("unable to write new_index file");
=20
--=20
1.5.3.5.1762.g9a09d-dirty
