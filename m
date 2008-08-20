From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: diff --check is stupid about blank lines
Date: Wed, 20 Aug 2008 16:05:17 +0200
Message-ID: <20080820140517.GA1304@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 16:07:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVoKs-00062D-Bo
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 16:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbYHTOFX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2008 10:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbYHTOFW
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 10:05:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:42484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751064AbYHTOFV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 10:05:21 -0400
Received: (qmail invoked by alias); 20 Aug 2008 14:05:18 -0000
Received: from i577B97AF.versanet.de (EHLO atjola.local) [87.123.151.175]
  by mail.gmx.net (mp020) with SMTP; 20 Aug 2008 16:05:18 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/E6HFKlRPEVNin5M+yHk7xtPzcacZVjI51ySOGVH
	Yq8S29dNEXrNJa
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92989>

Hi,

diff --check triggers not only for blank lines at the end of the file,
but also at the end of the changes. That seems broken to me, unless you
really dislike empty lines.

=46or example:
git (master) $ git diff
diff --git a/git.c b/git.c
index 37b1d76..3fa1aeb 100644
--- a/git.c
+++ b/git.c
@@ -9,6 +9,8 @@ const char git_usage_string[] =3D
 const char git_more_info_string[] =3D
        "See 'git help COMMAND' for more information on a specific comm=
and.";
=20
+int new_var =3D 0;
+
 static int use_pager =3D -1;
 struct pager_config {
        const char *cmd;

git (master) $ git diff --check
git.c:13: ends with blank lines.

But that blank line was of course intentional.

I'm not quite sure why that happens though. The code in
checkdiff_consume seems to reset the flag when it sees context lines,
but apparently that does not work for some reason.

git version 1.6.0.36.g3814c

Bj=F6rn
