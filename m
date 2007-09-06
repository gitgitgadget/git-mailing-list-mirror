From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 2/9] Enable wt-status to run against non-standard index file.
Date: Wed,  5 Sep 2007 20:23:31 -0400
Message-ID: <11890382242333-git-send-email-krh@redhat.com>
References: <11890382183913-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 02:36:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT5Le-0001k6-J3
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 02:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757199AbXIFAfs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Sep 2007 20:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757188AbXIFAfr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 20:35:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43760 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756896AbXIFAfp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 20:35:45 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l860Zikq005413
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 20:35:44 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860Ziec032583;
	Wed, 5 Sep 2007 20:35:44 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860ZhbW016503;
	Wed, 5 Sep 2007 20:35:43 -0400
X-Mailer: git-send-email 1.5.3.rc5.852.gc119
In-Reply-To: <11890382183913-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57783>

We still default to get_index_file(), but this can be overridden
by setting wt_status.index_file after calling wt_status_prepare().

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 wt-status.c |    3 ++-
 wt-status.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 65a7259..0cf9b81 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -53,6 +53,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->branch =3D head ? xstrdup(head) : NULL;
 	s->reference =3D "HEAD";
 	s->fp =3D stdout;
+	s->index_file =3D get_index_file();
 }
=20
 static void wt_status_print_cached_header(struct wt_status *s)
@@ -198,7 +199,7 @@ static void wt_status_print_changed_cb(struct diff_=
queue_struct *q,
 static void wt_read_cache(struct wt_status *s)
 {
 	discard_cache();
-	read_cache();
+	read_cache_from(s->index_file);
 }
=20
 static void wt_status_print_initial(struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index 4f3a615..7744932 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -21,6 +21,7 @@ struct wt_status {
 	int commitable;
 	int workdir_dirty;
 	int workdir_untracked;
+	const char *index_file;
 	FILE *fp;
 };
=20
--=20
1.5.2.GIT
