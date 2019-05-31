Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33FBC1F462
	for <e@80x24.org>; Fri, 31 May 2019 18:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEaSCC (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 14:02:02 -0400
Received: from resqmta-po-01v.sys.comcast.net ([96.114.154.160]:33656 "EHLO
        resqmta-po-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbfEaSCC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 May 2019 14:02:02 -0400
Received: from resomta-po-12v.sys.comcast.net ([96.114.154.236])
        by resqmta-po-01v.sys.comcast.net with ESMTP
        id WkLLh6w21HkmzWlqrhCKOl; Fri, 31 May 2019 18:02:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1559325721;
        bh=oZVqoL4RKSpo678tSWPn/15KADuCc42+nOh3WQtpzoI=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=rWS6opT9EEZbwKb7mPSYt2V3CTh2a7WK0gSKTw93BzIXnGP9z/GO/CoCewwZ/W9e5
         BXX4nAVpxAp2+7k3PCriialx6XHJlXvCG7uneY97RE4hcetsgAUkF4ZhyWoWfORV9X
         DFa81c4ipa/sTSkVVZ9evquv2J63TVK2mKW9HN5lIKjqtZ4AnuUHxDWQVppmupL9JJ
         YnrW+Fo7eStddduR10Dtcw7jd8Dlq3U69WWOYlJ6MSD4eFqDkpTGjI1wNU98pI8+gV
         CixYFUSWzGek8/f4yJe9vEyZMxn4vC0Fa1ArdINzuljYNKB1sBpOirWCyb1+ARpLC4
         mFt46iEcH/G8A==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:a4f1:9a8c:7e29:36eb])
        by resomta-po-12v.sys.comcast.net with ESMTPSA
        id WlqmhLjb7T55RWlqrhQdKs; Fri, 31 May 2019 18:02:01 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Fri, 31 May 2019 11:01:56 -0700
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com
Subject: [PATCH 1/1] list-objects-filter-options: error is localizeable
Message-ID: <20190531180156.GA7633@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "invalid filter-spec" message is user-facing and not a BUG, so make
it localizeable.

For reference, the message appears in this context:

	$ git rev-list --filter=blob:nonse --objects HEAD
	fatal: invalid filter-spec 'blob:nonse'

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c0036f7378..e46ea467bc 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -81,21 +81,21 @@ static int gently_parse_list_objects_filter(
 		filter_options->choice = LOFC_SPARSE_PATH;
 		filter_options->sparse_path_value = strdup(v0);
 		return 0;
 	}
 	/*
 	 * Please update _git_fetch() in git-completion.bash when you
 	 * add new filters
 	 */
 
 	if (errbuf)
-		strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
+		strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);
 
 	memset(filter_options, 0, sizeof(*filter_options));
 	return 1;
 }
 
 int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
 			      const char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
-- 
2.17.1

