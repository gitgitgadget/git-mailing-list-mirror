Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 510391FD09
	for <e@80x24.org>; Wed, 31 May 2017 23:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbdEaXfZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 19:35:25 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:34856
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751033AbdEaXfY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 May 2017 19:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1496273713;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=vDqgkLQc5eAx62euGR75pkhzA8UwuGJx2dxhtd0kZu0=;
        b=PDaIcPJv+RuhMdjszs0jHYxvS+GFfZaVALIoFXgQcTdXgvLyrJr+pJ7CC7rXKYzT
        kF1TbA2iqwS8GcJIFEPWqv1WLLTKC/s2rrVO/2oM9trbJj6FcoAbrluS91PLqk8uin+
        8pz+NGDE3javKmLOzTjpserOoiZfz/ON7qrAFQH0=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015c60dcf6cf-b17cfda3-0d72-4271-a5ba-63e5db0af952-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015c60dcf5f6-057de56f-3355-40dc-a0d3-ee62fa9b8259-000000@eu-west-1.amazonses.com>
References: <0102015c60dcf5f6-057de56f-3355-40dc-a0d3-ee62fa9b8259-000000@eu-west-1.amazonses.com>
Subject: [PATCH/RFC v2 6/6] branch: don't copy or rename config when same
 branch name
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 May 2017 23:35:12 +0000
X-SES-Outgoing: 2017.05.31-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It doesn't make sense to trigger config section copy or rename method if
both the branch names are same.

For example - git branch -C a a
In such a case, it shouldn't try to copy or rename the git config
section.

Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f3cd180e8d4cb..df82f196a4bba 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -502,7 +502,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	strbuf_release(&oldref);
 	strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
 	strbuf_release(&newref);
-	if (git_config_copy_or_rename_section(oldsection.buf, newsection.buf, copy) < 0)
+	if (strcmp(oldname, newname) && git_config_copy_or_rename_section(oldsection.buf, newsection.buf, copy) < 0)
 		die(_("Branch is %s, but update of config-file failed"),
 			 (copy ? "copied" : "renamed"));
 	strbuf_release(&oldsection);

--
https://github.com/git/git/pull/363
