From: Arjun Sreedharan <arjun024@gmail.com>
Subject: [PATCH] fix calloc() and xcalloc() argument ordering
Date: Thu,  4 Sep 2014 19:33:15 +0530
Message-ID: <1409839395-1902-1-git-send-email-arjun024@gmail.com>
References: <xmqqegvt27ac.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 16:03:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPXdV-0007LT-AR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 16:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbaIDODU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 10:03:20 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:37403 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaIDODT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 10:03:19 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so20024070pac.25
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fukBZHdSOHt2a3NBRKmjaamiS8jbz6/xBn4Xi4K4Q34=;
        b=IWki5Mv+EvnrDDjmX/KponEL7lQY3iDcDqPu2UKlWmJ4A2nCK9mL5M5npBoOZ44HV6
         TpP3Wue/IlCeofOeeNItwkKG0QBwpaDQbTOU2XJfIhf0X9NfXn7hviRcM5YosZSRD41W
         wC2kq3qtBcqsEmrNOtRdKjnyr8O8fhXExZov9DFQ0gohZQ47RJ9W9yMobmwa7TVQlqkK
         SlDGrY9OSfkCX32jro9l/aWYSty6sLakjEMOhZPBJm1iF82/8USRu1IbGb8SzQouqBZo
         /4Tw9DBZvSmvDOBRRmovafGK98ky240bOvZaRvhz18JbAYTrl5lxdpkAos/s76mUnHV0
         UNSQ==
X-Received: by 10.70.126.194 with SMTP id na2mr9203601pdb.124.1409839397172;
        Thu, 04 Sep 2014 07:03:17 -0700 (PDT)
Received: from localhost.localdomain ([122.172.161.172])
        by mx.google.com with ESMTPSA id hz1sm1780863pbb.75.2014.09.04.07.03.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 04 Sep 2014 07:03:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <xmqqegvt27ac.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256443>

@number first, @size second argument.

Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
---
 builtin/for-each-ref.c | 2 +-
 imap-send.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 47bd624..69bba06 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -633,7 +633,7 @@ static void populate_value(struct refinfo *ref)
 	unsigned long size;
 	const unsigned char *tagged;
 
-	ref->value = xcalloc(sizeof(struct atom_value), used_atom_cnt);
+	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
 
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		unsigned char unused1[20];
diff --git a/imap-send.c b/imap-send.c
index 524fbab..02eb3e0 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -954,7 +954,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
 
 	ctx = xcalloc(1, sizeof(*ctx));
 
-	ctx->imap = imap = xcalloc(sizeof(*imap), 1);
+	ctx->imap = imap = xcalloc(1, sizeof(*imap));
 	imap->buf.sock.fd[0] = imap->buf.sock.fd[1] = -1;
 	imap->in_progress_append = &imap->in_progress;
 
-- 
1.8.1.msysgit.1
