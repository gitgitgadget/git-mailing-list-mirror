Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04514C04EBE
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD1B2145D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dg3zH5Us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbgJHP2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:28:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55753 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730856AbgJHP16 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 11:27:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 501C3872D6;
        Thu,  8 Oct 2020 11:27:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=fFb6OU73Ap4/tMQQ7di8qEjmc1Q=; b=Dg3zH5UsERfWqEmiUW28usFElFCv
        YD7WKUPBLKO4RtCsuYvwtoFHjRZ4xyFtK1pYxIkUrDTD80BW0Vo4NOAzMQs4iWQR
        7mDYw0P1ucwBrMUpcSpaI+Ki5fgv4JmIrT7KWcHS9/IOst/Hc+hwEg3u3iG4sx9T
        UcrwjSMH8jRae6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
        E9DkUe9576eCQK+A/D1s/XCXwUTIRjurxhqAuXNh7Ep311LIfcxZEIafDmQWFKKN
        4zY3LFjE/0Wj5HKY3SrHhVzGO1mz+6k8EpDbcSGkXdphOv2D5BQoFjUM9PvoKyLo
        wtWkOYD9Ovl2d7SQGH1lGKEsStgWA99DD/auzcHWGx0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48962872D5;
        Thu,  8 Oct 2020 11:27:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4722872D4;
        Thu,  8 Oct 2020 11:27:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] clean up extern decl of functions
cc:     Denton Liu <liu.denton@gmail.com>
Date:   Thu, 08 Oct 2020 08:27:55 -0700
Message-ID: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6BB31DA-097A-11EB-8ADB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Among external function declarations, somehow only these two
functions that return pointer-to-function were declared with
"extern" in front.

Ideally, we should standardise to _have_ explicit "extern" in front
for all function (and data) decls, but let's make things uniform
first.  Bulk re-addition of extern can be done without any extra
difficulty with or without this change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * A patch before morning coffee, could be totally off the mark with
   trivial thinko.

 git-compat-util.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7a0fb7a045..56e0e1e79d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -491,9 +491,9 @@ static inline int const_error(void)
 
 void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 void set_error_routine(void (*routine)(const char *err, va_list params));
-extern void (*get_error_routine(void))(const char *err, va_list params);
+void (*get_error_routine(void))(const char *err, va_list params);
 void set_warn_routine(void (*routine)(const char *warn, va_list params));
-extern void (*get_warn_routine(void))(const char *warn, va_list params);
+void (*get_warn_routine(void))(const char *warn, va_list params);
 void set_die_is_recursing_routine(int (*routine)(void));
 
 int starts_with(const char *str, const char *prefix);
