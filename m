From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3 v2] mailmap: use higher level string list functions
Date: Mon, 24 Nov 2014 13:52:12 -0800
Message-ID: <1416865932-18285-1-git-send-email-sbeller@google.com>
References: <xmqq3898w9v4.fsf@gitster.dls.corp.google.com>
Cc: Stefan Beller <sbeller@google.com>
To: marius@trolltech.com, gitster@pobox.com, julian@quantumfyre.co.uk,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 22:52:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt1YZ-0000Da-Ej
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 22:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbaKXVwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 16:52:21 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:46613 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbaKXVwT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 16:52:19 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so9841446iec.10
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 13:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AaKdhhEDNg+w7W+0Tc6E1z2h2UHJcOp/96Ba06Rq7+o=;
        b=NthJmheMQH8zwne5ToCSQDzUiQJ9VGUyDoaKSpxl2zMsPgwkfOCgQ+g1WnMvOXgWo+
         GMCuSBaDHvjiMhngX7/PUBs85EmohFsVibGUVlNaJIwKwSr1bg8C+0wbxVvdQX0ptx5M
         /EAmA7NH3ztM0Ro7xPxzWi7ut3+W9F1Xx0itnWseq+/uiEHjjyd7VRzGBwYXyjAHp+zI
         lGIq0YdQsb1uBjLSsQFNmxK8GynexF2cWPZulkqVLRfjqkPWDkx1gNEGZ0CvU6/9+TtP
         wV6WMEjj8NI4Zk1w4cS3a86U6qlbINqlwzKBwRAuEajq2KJpti8i5UQ+cWOBOfLG+fdu
         O2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AaKdhhEDNg+w7W+0Tc6E1z2h2UHJcOp/96Ba06Rq7+o=;
        b=RlDN1gXpM8ai415aX/Y/SrzNUE2+PcADXlZsuKbx5b0wu/ukDiYGpuWmzmj7zcNEJT
         H0Ix6rkSjhNUNH2tvRYevkzbbx2cgoddIkBZyyAgY0/hfxqBuY4jU/p3QSKBEBIfyPQL
         FwvW/wwrEhDUWUo6vC/zgEGSn1tDfC+MlT9zs7FFrJiymIOyk6g34+uCz2HGe2T22g8y
         ZhmPKzq4217GjjZWzIUi00u02pkPUlwA1/ssCUST4dvMBOL6Fi7Xn78JW+c0QcrqpBCR
         AMMGbFlei4Qi4nCkyeEwtia51gSfzWtyvExUgmCDc+aZ856FEz1LUgyNFnFNaL7zjbwi
         qxMw==
X-Gm-Message-State: ALoCoQl7KON6gTFczyHofBJG2qUDK9TUNqRC5uH8afqRwHUwNIJA9///WFI6nlF8/0D6FmeMF2tF
X-Received: by 10.43.104.3 with SMTP id dk3mr26681044icc.47.1416865939247;
        Mon, 24 Nov 2014 13:52:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:413f:9e9a:731:9749])
        by mx.google.com with ESMTPSA id n126sm384716ion.13.2014.11.24.13.52.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 13:52:18 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <xmqq3898w9v4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260156>

No functional changes intended. This commit makes user of higher level
and better documented functions of the string list API, so the code is
more understandable.

Note that also the required computational amount should not change
in principal as we need to look up the item no matter if it is already
part of the list or not. Once looked up, insertion comes for free.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Changes since Version 1:
* Remove declaration-after-statement.

 mailmap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 81890a6..3b00a65 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -71,6 +71,7 @@ static void add_mapping(struct string_list *map,
 			char *old_name, char *old_email)
 {
 	struct mailmap_entry *me;
+	struct string_list_item *item;
 	int index;
 
 	if (old_email == NULL) {
@@ -78,15 +79,10 @@ static void add_mapping(struct string_list *map,
 		new_email = NULL;
 	}
 
-	if ((index = string_list_find_insert_index(map, old_email, 1)) < 0) {
-		/* mailmap entry exists, invert index value */
-		index = -1 - index;
-		me = (struct mailmap_entry *)map->items[index].util;
+	item = string_list_insert(map, old_email);
+	if (item->util) {
+		me = (struct mailmap_entry *)item->util;
 	} else {
-		/* create mailmap entry */
-		struct string_list_item *item;
-
-		item = string_list_insert_at_index(map, index, old_email);
 		me = xcalloc(1, sizeof(struct mailmap_entry));
 		me->namemap.strdup_strings = 1;
 		me->namemap.cmp = namemap_cmp;
-- 
2.2.0.rc3
