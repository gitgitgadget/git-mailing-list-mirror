From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v4 00/11] Resend sp/maint-dumb-http-pack-reidx
Date: Mon, 19 Apr 2010 07:23:04 -0700
Message-ID: <1271686990-16363-1-git-send-email-spearce@spearce.org>
References: <20100418115744.0000238b@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 16:23:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3rsh-0000bW-VC
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 16:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789Ab0DSOXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 10:23:18 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:48685 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab0DSOXR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 10:23:17 -0400
Received: by bwz25 with SMTP id 25so5648036bwz.28
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 07:23:16 -0700 (PDT)
Received: by 10.204.162.209 with SMTP id w17mr807547bkx.67.1271686996175;
        Mon, 19 Apr 2010 07:23:16 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 14sm3154186bwz.10.2010.04.19.07.23.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 07:23:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.279.g22727
In-Reply-To: <20100418115744.0000238b@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145298>

This is a resend of the last half of the series, from patch 6/11
to the end, to address some minor review comments.

Junio, I think you need to reset my branch to 0da8b2e7c80a6d
("http.c: Don't store destination name in structures"), and
then apply this group.

Total series diff since v3 is this shocking one line change, most
of the edits were to commit messages:

diff --git a/http.c b/http.c
index 83f6047..0813c9e 100644
--- a/http.c
+++ b/http.c
@@ -1028,7 +1028,6 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	const char *ip_argv[8];
 
 	close_pack_index(p);
-	unlink(sha1_pack_index_name(p->sha1));
 
 	fclose(preq->packfile);
 	preq->packfile = NULL;
@@ -1062,6 +1061,8 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		return -1;
 	}
 
+	unlink(sha1_pack_index_name(p->sha1));
+
 	if (move_temp_to_file(preq->tmpfile, sha1_pack_name(p->sha1))
 	 || move_temp_to_file(tmp_idx, sha1_pack_index_name(p->sha1))) {
 		free(tmp_idx);
