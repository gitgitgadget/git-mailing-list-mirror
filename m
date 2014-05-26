From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 03/15] builtin/remote.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:44 +0900
Message-ID: <1401118436-66090-4-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:35:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WowvT-0004kf-QP
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbaEZPex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:34:53 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:46877 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbaEZPet (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:34:49 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so7736488pab.17
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AQpbsUkAQjeu9zRziO7KX/7GSKqAp3s13KGQh+xd1Fc=;
        b=qgWpbVc9viOIpyZsQimdSYOS3Ryez2xrxsZD8uRteYTFeEpzfdgAt6AzXQ57FrVTh1
         ozT2fBn9giCG7h0E6KH5Tr1WIt/PwCkzm05mp/nhM7BUnt8814Eb2GEJt/FilcmXY/hT
         +z7pGE8DSabE9nLqRduj78JBx4DYVz4uy8ogqNo90IQCs2Cstx2jaW3DTU79REVwV3mV
         jckjnkYY57+On/8DBnOqHuPJHj8XmhmOc6uqCrravV2UDdTKM1w8PIXLirtFWletXqIz
         9d1NWqnSbw1MrmW7I6DQrE7gFKPIxU8n01Mxt3aMIhfWO13eQlt079tx2IFLE/MBrko5
         8S/g==
X-Received: by 10.66.66.225 with SMTP id i1mr29228996pat.0.1401118489227;
        Mon, 26 May 2014 08:34:49 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.34.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:34:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250095>

xcalloc takes two arguments: the number of elements and their size.
builtin/remote.c includes several calls to xcalloc that pass the
arguments in reverse order. Rearrgange them so they are in the
correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 builtin/remote.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index b3ab4cf..9f62021 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -282,7 +282,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		item = string_list_insert(&branch_list, name);
 
 		if (!item->util)
-			item->util = xcalloc(sizeof(struct branch_info), 1);
+			item->util = xcalloc(1, sizeof(struct branch_info));
 		info = item->util;
 		if (type == REMOTE) {
 			if (info->remote_name)
@@ -398,7 +398,7 @@ static int get_push_ref_states(const struct ref *remote_refs,
 
 		item = string_list_append(&states->push,
 					  abbrev_branch(ref->peer_ref->name));
-		item->util = xcalloc(sizeof(struct push_info), 1);
+		item->util = xcalloc(1, sizeof(struct push_info));
 		info = item->util;
 		info->forced = ref->force;
 		info->dest = xstrdup(abbrev_branch(ref->name));
@@ -433,7 +433,7 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 	states->push.strdup_strings = 1;
 	if (!remote->push_refspec_nr) {
 		item = string_list_append(&states->push, _("(matching)"));
-		info = item->util = xcalloc(sizeof(struct push_info), 1);
+		info = item->util = xcalloc(1, sizeof(struct push_info));
 		info->status = PUSH_STATUS_NOTQUERIED;
 		info->dest = xstrdup(item->string);
 	}
@@ -446,7 +446,7 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 		else
 			item = string_list_append(&states->push, _("(delete)"));
 
-		info = item->util = xcalloc(sizeof(struct push_info), 1);
+		info = item->util = xcalloc(1, sizeof(struct push_info));
 		info->forced = spec->force;
 		info->status = PUSH_STATUS_NOTQUERIED;
 		info->dest = xstrdup(spec->dst ? spec->dst : item->string);
-- 
2.0.0.rc1.543.gc8042da
