Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72D3C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFB420674
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ABcsQle3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbgCPV3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:29:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64761 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbgCPV3J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 17:29:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4A8CAF908;
        Mon, 16 Mar 2020 17:29:07 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=bF9wjiUuGT5wkQTEUz5a0OI8A
        GE=; b=ABcsQle3wV9tqfvbnCdebS3z9Af08L4e0DjZpl2VmH3kBEcE94S/N2Xe+
        /JaggIJgp5IU1KidazI3XQtbWfuMmio9EXTXjBExWO6MF/4l8KvnhyQSnxigmZJS
        2dO6FcGg21bdDYwn/5NoGahkjAO3E11hPvXqk6urokH3AOnprs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=X9VveGI75fudHp1MWKy
        HQXePweuiD6GDFACgjz20MOn6g9brIn3mYz6rOjl/UHi+atDJBunuXrlTIhL1IJY
        I15vV9Pvscjzw+RTpfonxdgh9xsNsMm9+0Os59jmlLJ0JuKkejwltgd+zWKanWIY
        eKcnNUBqxvjOykdzMcG5036c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CC3CAF907;
        Mon, 16 Mar 2020 17:29:07 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E828BAF900;
        Mon, 16 Mar 2020 17:29:04 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] log: give --[no-]use-mailmap a more sensible synonym --[no-]mailmap
Date:   Mon, 16 Mar 2020 14:28:57 -0700
Message-Id: <20200316212857.259093-4-gitster@pobox.com>
X-Mailer: git-send-email 2.26.0-rc1-11-g30e9940356
In-Reply-To: <20200316212857.259093-1-gitster@pobox.com>
References: <20200316212857.259093-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 297406B8-67CD-11EA-A633-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option name "--use-mailmap" looks OK, but it becomes awkward
when you have to negate it, i.e. "--no-use-mailmap".  I, perhaps
with many other users, always try "--no-mailmap" and become unhappy
to see it fail.

Add an alias "--[no-]mailmap" to remedy this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-log.txt | 1 +
 builtin/log.c             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index bed09bb09e..619577f23b 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -49,6 +49,7 @@ OPTIONS
 	Print out the ref name given on the command line by which each
 	commit was reached.
=20
+--[no-]mailmap::
 --[no-]use-mailmap::
 	Use mailmap file to map author and committer names and email
 	addresses to canonical real names and email addresses. See
diff --git a/builtin/log.c b/builtin/log.c
index 83a4a6188e..ca1e789ba0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -173,6 +173,7 @@ static void cmd_log_init_finish(int argc, const char =
**argv, const char *prefix,
 		OPT__QUIET(&quiet, N_("suppress diff output")),
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
+		OPT_ALIAS(0, "mailmap", "use-mailmap"),
 		OPT_STRING_LIST(0, "decorate-refs", &decorate_refs_include,
 				N_("pattern"), N_("only decorate refs that match <pattern>")),
 		OPT_STRING_LIST(0, "decorate-refs-exclude", &decorate_refs_exclude,
--=20
2.26.0-rc1-11-g30e9940356

