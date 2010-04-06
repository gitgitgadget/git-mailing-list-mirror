From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v4 3/8] status: Added missing calls to diff_unmodified_pair() in format_callbacks.
Date: Tue,  6 Apr 2010 14:46:39 +0200
Message-ID: <5962221bef558d15183c9937863b38bc7ca41339.1270554878.git.grubba@grubba.org>
References: <cover.1270554878.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 14:47:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz8Bi-0004uy-Hf
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 14:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261Ab0DFMqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 08:46:54 -0400
Received: from mail.roxen.com ([212.247.29.220]:60236 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426Ab0DFMqw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 08:46:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id E767D628187
	for <git@vger.kernel.org>; Tue,  6 Apr 2010 14:46:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7sHZjYU3oAB4; Tue,  6 Apr 2010 14:46:49 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id C99DF628173;
	Tue,  6 Apr 2010 14:46:49 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o36Cknkt028650;
	Tue, 6 Apr 2010 14:46:49 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o36Cknjt028649;
	Tue, 6 Apr 2010 14:46:49 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.3.316.g33b5e
In-Reply-To: <cover.1270554878.git.grubba@grubba.org>
In-Reply-To: <cover.1270554878.git.grubba@grubba.org>
References: <cover.1270554878.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144132>

The diff_queue_struct provided by diff_flush() is raw, and needs to be
filtered through diff_unmodified_pair() before being used.
This is already done by most of the other functions operating on
diff_queue_struct called by diff_flush().

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
=46or diff_modified_pair() to be able to do its job, it needs
to be called...

 wt-status.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..e661225 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -229,6 +229,8 @@ static void wt_status_collect_changed_cb(struct dif=
f_queue_struct *q,
 		struct wt_status_change_data *d;
=20
 		p =3D q->queue[i];
+		if (diff_unmodified_pair(p))
+			continue;
 		it =3D string_list_insert(p->one->path, &s->change);
 		d =3D it->util;
 		if (!d) {
@@ -276,6 +278,8 @@ static void wt_status_collect_updated_cb(struct dif=
f_queue_struct *q,
 		struct wt_status_change_data *d;
=20
 		p =3D q->queue[i];
+		if (diff_unmodified_pair(p))
+			continue;
 		it =3D string_list_insert(p->two->path, &s->change);
 		d =3D it->util;
 		if (!d) {
--=20
1.7.0.3.316.g33b5e
