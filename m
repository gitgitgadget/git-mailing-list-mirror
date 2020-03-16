Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79100C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2783520674
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JWFK5FH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbgCPV3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:29:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61869 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732672AbgCPV3E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 17:29:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCFAF613D3;
        Mon, 16 Mar 2020 17:29:03 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=ExgHhty1tvPvlQw5fcN9ei9Av
        gM=; b=JWFK5FH6CCLTJROE6LksmtBL5nSl5jxNgIjAORTBoQdQDDzTcMO6I/xm7
        A/UG73KXWN+vW4cdZN1E0QFeR+m88JMy2F4fyvwsXAeG3QoKQwXl883d5V6cBdGH
        zf2TJ0PWogkhQtHDc9ak8udpa53M7fI09BZmcam376sUu6IuJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=Xd0Q8V8mi5A31IZzcQX
        PeifgaLSsVD7IPVH7b7tNU3+DMxrfd8rdbapl6iEJKdbmJ2KUuO/MCTTRRaEJe1r
        1Hthnfc+B9QKpJ+FHIddp1ZoNhY1cR8pByUQ6txzJTgjTDSC0vCV49QvDuYdVDt6
        0DDoQ6tNNCPRMRW3hKy0PNN0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C07B8613D2;
        Mon, 16 Mar 2020 17:29:03 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02262613D1;
        Mon, 16 Mar 2020 17:29:02 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] clone: reorder --recursive/--recurse-submodules
Date:   Mon, 16 Mar 2020 14:28:56 -0700
Message-Id: <20200316212857.259093-3-gitster@pobox.com>
X-Mailer: git-send-email 2.26.0-rc1-11-g30e9940356
In-Reply-To: <20200316212857.259093-1-gitster@pobox.com>
References: <20200316212857.259093-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 284C3292-67CD-11EA-8118-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous step made an option that is an alias to another option
identify itself as an alias to the latter.  Because it is easier to
scan the list when a pointer goes backward to what a reader already
has seen, mention "recurse-submodules" first with its true short
help string, and then "recurse" with the statement that it is a
synonym to "recurse-submodules".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 The history of --recursive/--recurse-submodules options dates back
 to ccdd3da6 (clone: add the --recurse-submodules option as alias
 for --recursive, 2010-11-04), where we decided to encourage use of
 more descriptive "--recurse-submodules" over "--recursive" which
 does not say to what extent the process is allowed to recurse.
 Documentation/git-clone.txt mentions only "--recurse-submodules"
 for this exact reason, and it may not be a bad idea to start
 planning to deprecate the alias "--recursive". =20

 But that obviously is a separate topic.

 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 1ad26f4d8c..54b0acbe73 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -102,10 +102,10 @@ static struct option builtin_clone_options[] =3D {
 		    N_("don't use local hardlinks, always copy")),
 	OPT_BOOL('s', "shared", &option_shared,
 		    N_("setup as shared repository")),
-	OPT_ALIAS(0, "recursive", "recurse-submodules"),
 	{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
 	  N_("pathspec"), N_("initialize submodules in the clone"),
 	  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
+	OPT_ALIAS(0, "recursive", "recurse-submodules"),
 	OPT_INTEGER('j', "jobs", &max_jobs,
 		    N_("number of submodules cloned in parallel")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
--=20
2.26.0-rc1-11-g30e9940356

