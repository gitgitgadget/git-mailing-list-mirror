From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/9] Suppress warnings from "git var -l"
Date: Wed, 11 Nov 2009 17:57:36 -0600
Message-ID: <20091111235735.GD1140@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091111235100.GA1140@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:47:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8MuQ-0006iz-P0
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 00:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759232AbZKKXrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 18:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757531AbZKKXrR
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 18:47:17 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:46282 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757528AbZKKXrR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 18:47:17 -0500
Received: by gxk26 with SMTP id 26so1567355gxk.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 15:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SSIbdh0WXxpxcSKPJE9IMyWkNXPm5nCK6FnA/YSJVCw=;
        b=WtJLQpNm3lvOAg6pEEJg+rzvOl88+zmmWfLA/IRUoxp2WKzTB76ZWquhBG2eg9bGBi
         8Dh4Eag98sN5yc2WDdMcklfzWLBNEzZ6acno12eeXyVixvy0UQi5cAyQ4t4E2fr63ht9
         flvq2VjRvysatmn0jYRPurDW3n1hAPDBvl0Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sW7SO+eKs3GYhVuAoiZH2K4UzUe7GM3QDvCZR5F/XBbG4E+R51AQYT5Vg8voIpRJVz
         0zg0PNU8Vbtu4T6n+pSriu4QGpg5HA572yRyu9kWMa0XClG1AI2FvAF/LneuJeKjw/Rv
         47I75GVWmCtpK/uHIeZMLUZfw+yieiLUEM/1Q=
Received: by 10.91.54.22 with SMTP id g22mr3296813agk.80.1257983242599;
        Wed, 11 Nov 2009 15:47:22 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1027438yxe.39.2009.11.11.15.47.21
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 15:47:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091111235100.GA1140@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132724>

=46or scripts using "git var -l" to read all logical variables at
once, not all per-variable warnings will be relevant.  So suppress
them.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is a separate issue that might even deserve to be ejected
from the series.

Changes from jn/editor-pager: unsquashed from the next patch, added
back comment-changing hunk.  Of course, there=E2=80=99s no harm in omit=
ting
the comment change, but it describes a change in reality: before this
patch, that code gets run multiple times by "git var -l"; afterwards,
by no one (except possible out-of-tree users).

 ident.c |    2 +-
 var.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index 99f1c85..26409b2 100644
--- a/ident.c
+++ b/ident.c
@@ -205,7 +205,7 @@ const char *fmt_ident(const char *name, const char =
*email,
 		if ((warn_on_no_name || error_on_no_name) &&
 		    name =3D=3D git_default_name && env_hint) {
 			fprintf(stderr, env_hint, au_env, co_env);
-			env_hint =3D NULL; /* warn only once, for "git var -l" */
+			env_hint =3D NULL; /* warn only once */
 		}
 		if (error_on_no_name)
 			die("empty ident %s <%s> not allowed", name, email);
diff --git a/var.c b/var.c
index 125c0d1..dacbaab 100644
--- a/var.c
+++ b/var.c
@@ -22,7 +22,7 @@ static void list_vars(void)
 {
 	struct git_var *ptr;
 	for (ptr =3D git_vars; ptr->read; ptr++)
-		printf("%s=3D%s\n", ptr->name, ptr->read(IDENT_WARN_ON_NO_NAME));
+		printf("%s=3D%s\n", ptr->name, ptr->read(0));
 }
=20
 static const char *read_var(const char *var)
--=20
1.6.5.2
