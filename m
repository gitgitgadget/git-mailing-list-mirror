Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C12EB64DD
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 22:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjGRWbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjGRWbR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 18:31:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7E19B0
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 15:31:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0AA1928CF3;
        Tue, 18 Jul 2023 18:31:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NjOGOk0NJ194twg5I9vjIiMFYd9vR2tC+8g3e8
        PxvKo=; b=alrnqC/vlOPj+YUw2BWqaEqee6ZmWpmfWFkDN8D90BIYfFQkSRefqX
        Od/Azm1Avx0jtvumw58yettZe9/X9sJ0T0+spp1KY5FqjHfcZhSMf7UBjINoB5Br
        uO3qB/cWn2yL4ugKV/EJVGaL2lGSzf1FmWSSOSew1oRFIaWLmqNTw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E951228CF2;
        Tue, 18 Jul 2023 18:31:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 631CF28CF1;
        Tue, 18 Jul 2023 18:31:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] remote: simplify "remote add --tags" help text
References: <xmqq5y6gg8fn.fsf@gitster.g>
Date:   Tue, 18 Jul 2023 15:31:03 -0700
In-Reply-To: <xmqq5y6gg8fn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        18 Jul 2023 15:29:32 -0700")
Message-ID: <xmqqzg3setso.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7F95C3A-25BA-11EE-A013-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The help text for the --tags option was split into two option[]
entries, which was a hacky way to give two lines of help text (the
second entry did not have either short or long help, and there was
no way to invoke its entry---it was there only for the help text).

As we now support multi-line text in the option help, let's make
the second line of the help a proper second line and remove the
hacky second entry.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/remote.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 1e0b137d97..09fb9ae30d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -167,10 +167,9 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL('f', "fetch", &fetch, N_("fetch the remote branches")),
 		OPT_SET_INT(0, "tags", &fetch_tags,
-			    N_("import all tags and associated objects when fetching"),
+			    N_("import all tags and associated objects when fetching\n"
+			       "or do not fetch any tag at all (--no-tags)"),
 			    TAGS_SET),
-		OPT_SET_INT(0, NULL, &fetch_tags,
-			    N_("or do not fetch any tag at all (--no-tags)"), TAGS_UNSET),
 		OPT_STRING_LIST('t', "track", &track, N_("branch"),
 				N_("branch(es) to track")),
 		OPT_STRING('m', "master", &master, N_("branch"), N_("master branch")),
-- 
2.41.0-376-gcba07a324d

