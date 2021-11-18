Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCFCC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0109761A8A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhKRQxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52818 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbhKRQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 84E98218F0
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXELKBo8uDsU1cFv5GK5dy25OPf51KgwTnrazDfAPbg=;
        b=SX8cLGbQkqLeE40j+H3pkKQKJzSf+VHq5cNYszKDbro9HMwKlWC3u3wdJOHE2R0mB3bG/j
        359WIWkmfaB8ftQem1VuI9xRuU/7LJQMqHnLqM9MPVpW4Zq/zwSqKF21G1mNV7BhJkcCW5
        cXs0gQiU1Y2H9fQ1FkO8+oXR3s+BVuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXELKBo8uDsU1cFv5GK5dy25OPf51KgwTnrazDfAPbg=;
        b=yDX8uK/5K43lZ4J7VnAVEbEP8uPjD3gwklXkFguqttx3I4oudjIJcN95GwilYjyLR8GQ88
        WRGWxtx9yubgWkBw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 79EC0A3B99;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A46CE1F2CB1; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 15/27] bisect: Rename clear_distance() to clear_counted_flag()
Date:   Thu, 18 Nov 2021 17:49:28 +0100
Message-Id: <20211118164940.8818-16-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

clear_distance() only clears COUNTED flag. Rename the function to match
what it does. No code changes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 7416a57db4e3..675e8d433760 100644
--- a/bisect.c
+++ b/bisect.c
@@ -68,7 +68,7 @@ static int count_distance(struct commit_list *entry)
 	return nr;
 }
 
-static void clear_distance(struct commit_list *list)
+static void clear_counted_flag(struct commit_list *list)
 {
 	while (list) {
 		struct commit *commit = list->item;
@@ -339,7 +339,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		if (bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY)
 			BUG("shouldn't be calling count-distance in fp mode");
 		weight_set(p, count_distance(p));
-		clear_distance(list);
+		clear_counted_flag(list);
 
 		/* Does it happen to be at half-way? */
 		if (!(bisect_flags & FIND_BISECTION_ALL) &&
-- 
2.26.2

