From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCH 1/2] git-svn: Fix the commit-url config to be the base url, just like the url config
Date: Mon,  4 Apr 2011 15:09:07 -0400
Message-ID: <1301944148-7950-2-git-send-email-asedeno@mit.edu>
References: <1301944148-7950-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James Y Knight <jknight@itasoftware.com>,
	=?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 04 21:09:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6p9Q-00035Q-M3
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 21:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab1DDTJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 15:09:19 -0400
Received: from mx1.itasoftware.com ([63.115.78.20]:35814 "EHLO
	mx1.itasoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755135Ab1DDTJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 15:09:18 -0400
Received: from ita4mta2.internal.itasoftware.com (ita4mta2.internal.itasoftware.com [10.4.52.168])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.itasoftware.com (Postfix) with ESMTP id 20323256D42;
	Mon,  4 Apr 2011 15:09:11 -0400 (EDT)
Received: from asedeno.corp.itasoftware.com (lb1.dc4nat150.dc4.internal.itasoftware.com [10.4.199.150])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ita4mta2.internal.itasoftware.com (Postfix) with ESMTPS id E8B5F19D8039;
	Mon,  4 Apr 2011 15:09:10 -0400 (EDT)
Received: from asedeno by asedeno.corp.itasoftware.com with local (Exim 4.74)
	(envelope-from <asedeno@asedeno.corp.itasoftware.com>)
	id 1Q6p9C-0004C7-SR; Mon, 04 Apr 2011 15:09:10 -0400
X-Mailer: git-send-email 1.7.4.2.1.gd6f1f
In-Reply-To: <1301944148-7950-1-git-send-email-asedeno@mit.edu>
X-ITASoftware-MailScanner: Found to be clean
X-ITASoftware-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 3, ALL_TRUSTED -1.00)
X-ITASoftware-MailScanner-From: asedeno@itasoftware.com
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170835>

=46rom: James Y Knight <jknight@itasoftware.com>

This is necessary if you want to be able to commit to multiple branches=
=2E

Signed-off-by: James Y Knight <jknight@itasoftware.com>
Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
---
 git-svn.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a5857c1..aa41896 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -523,12 +523,14 @@ sub cmd_dcommit {
 	}
=20
 	if (defined $_commit_url) {
-		$url =3D $_commit_url;
+		$url =3D $_commit_url . (length $gs->{path} ? '/' . $gs->{path} : ''=
);
 	} else {
 		$url =3D eval { command_oneline('config', '--get',
 			      "svn-remote.$gs->{repo_id}.commiturl") };
 		if (!$url) {
 			$url =3D $gs->full_url
+		} else {
+			$url =3D $url . (length $gs->{path} ? '/' . $gs->{path} : '');
 		}
 	}
=20
--=20
1.7.4.2.1.gd6f1f
