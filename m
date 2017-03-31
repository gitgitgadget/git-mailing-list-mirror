Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94A4E1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 20:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755260AbdCaUZm (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 16:25:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56525 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754879AbdCaUZl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 16:25:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5176B7E357;
        Fri, 31 Mar 2017 16:25:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=s
        uUKwyfAW6lXk5wcyBusv/FuUkU=; b=n6jMeslCQA33gTjHM46DOeRhw/tyRiio1
        HcKAlkvR5OrLp2unHe+XEMsB4RUVxhsG5RzNwjhzcLE1jXmZgCKDGIWvLrejTVVN
        lo/w5Uzps3WgB2XOLxNeAhq0+D/Ndde/+y/iD0igjxb2zfWSYqCPRJJrMf8AaZOX
        K38H/WUYRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=W87
        d30/EwB4iO1AIAcnHwfWCsqD0i3B1Z9DiV3pXTg/Pid/k0jBjafLwG8vueETVR/Y
        g5hazUIgZ6nLNqTmIjJQMPo5JdiNaWi952ugzPaEnMc+/BHb/h8SVHn1xoKkZCoe
        w7UBwfccd1x2KM+LgSZa+CBV1xTayDngVL6kbqhA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48DE67E356;
        Fri, 31 Mar 2017 16:25:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C7067E355;
        Fri, 31 Mar 2017 16:25:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] remote.[ch]: parse_push_cas_option() can be static
Date:   Fri, 31 Mar 2017 13:25:38 -0700
Message-ID: <xmqqbmshxkfx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34C455E4-1650-11E7-B6B7-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 068c77a5 ("builtin/send-pack.c: use parse_options API",
2015-08-19), there is no external user of this helper function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c | 2 +-
 remote.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 68901b0070..fc2df99b81 100644
--- a/remote.c
+++ b/remote.c
@@ -2178,7 +2178,7 @@ static struct push_cas *add_cas_entry(struct push_cas_option *cas,
 	return entry;
 }
 
-int parse_push_cas_option(struct push_cas_option *cas, const char *arg, int unset)
+static int parse_push_cas_option(struct push_cas_option *cas, const char *arg, int unset)
 {
 	const char *colon;
 	struct push_cas *entry;
diff --git a/remote.h b/remote.h
index 02d66ceff5..19a4905da6 100644
--- a/remote.h
+++ b/remote.h
@@ -260,7 +260,6 @@ struct push_cas_option {
 };
 
 extern int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
-extern int parse_push_cas_option(struct push_cas_option *, const char *arg, int unset);
 
 extern int is_empty_cas(const struct push_cas_option *);
 void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
-- 
2.12.2-750-g6626ddbf7f

