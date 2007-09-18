From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 2/7] Enable wt-status to run against non-standard index file.
Date: Mon, 17 Sep 2007 20:06:43 -0400
Message-ID: <1190074014548-git-send-email-krh@redhat.com>
References: <1190074008617-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 02:07:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXQcm-0002Qo-HJ
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 02:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974AbXIRAG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 20:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756920AbXIRAG5
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 20:06:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56215 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756884AbXIRAG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 20:06:56 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06tXa012089
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 20:06:55 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06sTm022174;
	Mon, 17 Sep 2007 20:06:54 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06scv021539;
	Mon, 17 Sep 2007 20:06:54 -0400
X-Mailer: git-send-email 1.5.3.1.993.gbf388-dirty
In-Reply-To: <1190074008617-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58503>

We still default to get_index_file(), but this can be overridden
by setting wt_status.index_file after calling wt_status_prepare().

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 wt-status.c |    3 ++-
 wt-status.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index eeb1691..03b5ec4 100644
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
1.5.3.1.993.gbf388-dirty
