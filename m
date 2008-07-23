From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 12/12] git-status: print sparse checkout status
Date: Wed, 23 Jul 2008 21:58:10 +0700
Message-ID: <20080723145810.GA29177@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 17:00:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfow-0003lQ-9B
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 17:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbYGWO6b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYGWO6b
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:58:31 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142AbYGWO6a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:58:30 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1202339tic.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=96TXYaqUiCyfkvl7GaOVlXU1aUhP+pJA5v8JrryETZ4=;
        b=yAp8MwuWZXyD3KijkYYeAwUK7Sq7+PUIeRoHNqKHVFSc8cif2vJSG6MsnOKQHZmw6p
         cRDrl6H8hKNe4qCO5k6wiYELJzLMYScOD5ZMSOhuxlIwTYVCaunfYFdM/5yFIRjqBvOj
         z4a7Ri3LtoMteW7wVEfVWjsgy0vhPWzzOSgmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=r/y5cdZ9xjNr9ZT3/LKkj5FZeaWggmSExOVhfvp6fZ4MyrEUJOHH5OAnnEN4ln9jHB
         5yV6RJby2r2O20gP/sFvS9xotyFTekt53b5d9uBEhMJl23ZqbUBBX3hiLteG6WEbALB1
         LEWl1ovjNUPmaS1IkABD556jtmAb3Jd8YJyMk=
Received: by 10.110.41.17 with SMTP id o17mr126407tio.18.1216825109341;
        Wed, 23 Jul 2008 07:58:29 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.5.7])
        by mx.google.com with ESMTPS id y5sm14817843tia.8.2008.07.23.07.58.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:58:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Jul 2008 21:58:10 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89683>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 889e50f..28add31 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -361,12 +361,18 @@ void wt_status_print(struct wt_status *s)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "# Initial commit")=
;
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
-		wt_status_print_initial(s);
 	}
-	else {
-		wt_status_print_updated(s);
+
+	if (get_sparse_prefix()) {
+		color_fprintf(s->fp, color(WT_STATUS_HEADER), "# Sparse checkout: ")=
;
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), get_sparse_prefix_s=
tr());
 	}
=20
+	if (s->is_initial)
+		wt_status_print_initial(s);
+	else
+		wt_status_print_updated(s);
+
 	wt_status_print_changed(s);
 	if (wt_status_submodule_summary)
 		wt_status_print_submodule_summary(s);
--=20
1.5.5.GIT
