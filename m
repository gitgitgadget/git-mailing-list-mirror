From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] get_ref_states: strdup entries and free util in stale list
Date: Tue,  1 Dec 2009 00:57:27 +0100
Message-ID: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 00:57:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFG7c-0004Z9-41
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 00:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbZK3X5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 18:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbZK3X5Y
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 18:57:24 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:46903 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbZK3X5X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 18:57:23 -0500
Received: by ey-out-2122.google.com with SMTP id 4so1067047eyf.19
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 15:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=cpKIBo1f92QNxmPCR8Qu3HWuKpj6+7b2Xc0HB0gXlLk=;
        b=D3cpaiH3rbgg3VvQV0PAo3W8zqJ9yKFZH/jffrIXeabXX9UKJwdWP2R8anf9ZeKV62
         RWgVPjbEASyj0NVGytA4LFKbYDIr5CTwRVSyzJkLnW1WxMzCxz3BMv3HQZGXCd6e7upo
         ENgzA/vBkyW6oFj/YxxY9+2Olu/eurNhOibYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aoghu2cLifHr+hpD7DL7GxK/+wEpt7UL2DEzKISi6eCE+xtabr1nwOj69NggB9/Ex9
         KE2uxfftPvqBNyIuQi+4jZVhSu/g1ierpnDkIl8AiHp6cJbum7APBO9LKohH6pwnR+XC
         myk/fWPFoWvamjyN+vb/XSmrWAvHFomtCYTCQ=
Received: by 10.213.37.137 with SMTP id x9mr644592ebd.78.1259625449443;
        Mon, 30 Nov 2009 15:57:29 -0800 (PST)
Received: from localhost (drsd-4db3f407.pool.mediaWays.net [77.179.244.7])
        by mx.google.com with ESMTPS id 14sm2827783ewy.15.2009.11.30.15.57.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 15:57:28 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc0.253.g1ec3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134148>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 builtin-remote.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 7916626..bb72e27 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -272,7 +272,9 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 			die("Could not get fetch map for refspec %s",
 				states->remote->fetch_refspec[i]);
 
-	states->new.strdup_strings = states->tracked.strdup_strings = 1;
+	states->new.strdup_strings =
+	states->tracked.strdup_strings =
+	states->stale.strdup_strings = 1;
 	for (ref = fetch_map; ref; ref = ref->next) {
 		unsigned char sha1[20];
 		if (!ref->peer_ref || read_ref(ref->peer_ref->name, sha1))
@@ -768,7 +770,7 @@ static void clear_push_info(void *util, const char *string)
 static void free_remote_ref_states(struct ref_states *states)
 {
 	string_list_clear(&states->new, 0);
-	string_list_clear(&states->stale, 0);
+	string_list_clear(&states->stale, 1);
 	string_list_clear(&states->tracked, 0);
 	string_list_clear(&states->heads, 0);
 	string_list_clear_func(&states->push, clear_push_info);
-- 
1.6.6.rc0.253.g1ec3
