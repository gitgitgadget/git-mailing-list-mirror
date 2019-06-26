Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF231F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfFZXvS (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:51:18 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:39483 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:51:18 -0400
Received: by mail-pl1-f201.google.com with SMTP id r7so295265plo.6
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WGAwoi10ZwQ3gkHiE4e9AGONWrkjxHpg22xP0Yx7mSM=;
        b=eABcZxN0FBLL1V1mds1ZBI1xjPagCZVYvQtelt/EQlXFWGV2UXOepwYCFT/ahEeTpt
         0o2bRd04y+lPovKzusgQ0l8L7XbOqWgitsFXdxHgtNB9P7qU6Vff+ZokWkqg+i4uwx5X
         xbsRp/6JRJtQ46J7j+5jfNOMsEgYMWJOzAgav3M18zyXQUUap0oG51d+D0LqXjezH4Dy
         aQcZoc1QL2kfIgw4jDCGLpV7bIGnII7NgssT5LmXpKvXUpLt8u37ml2GbZfocO7HHQks
         YWNNHBUa1pqw3PfGvLtiV+h/n/22MtLqITwcRN4ujTVYgi5xdimi+ErNvYv9fHTYVM2H
         F9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WGAwoi10ZwQ3gkHiE4e9AGONWrkjxHpg22xP0Yx7mSM=;
        b=Qe1GnAezq5UknFMwrh3rnhVLlmlqcMXFR+dK7c6Wp6KtVFfMvCd2pTz1V+yaGrCq6+
         zE16YEofW737BQ/95dnY8UORDW0/creT8YUPNdmGjEyVx2OjyvgzMh8zRT+Rcs4Y4ZiX
         zjbFxS92xqtJNlIiVUkZx3+6dy7youHlvoAySHmFyGYLJ0AtIRVpqqKTtbp6RtOPtAio
         iDcblWor9mH2SB/w4rbrFwdoznnDcNyiIyIoNlapTQfjnMfONQGv/vqcFaDY95K/5JyV
         zkAJc5pdjSae+wxL2JEbOHCgVhfvb80NmqXj53dFmV+Sd5A+UHhvul4y03XngX4fxly2
         Ok8Q==
X-Gm-Message-State: APjAAAUc39eNLE0lprrIqLoIMCXQgtpcSwHqrSBySRIcHvcVJAV94qqf
        I3FvlIqmkk/JDxEhoLOwb55f/9KGoq1Gw7MW15iv5NJDW3WmxQ3oso2+hdyyc/Ty4QjXzXRuMcH
        41xQ1p9PQgVNgsGGC5sCZIilf6E+Zsv+DRGyfa8QkvZQwrrXWX74P3YqUYVUjhElPSD3owdRifw
        ==
X-Google-Smtp-Source: APXvYqy3ifXsiw9O9/fLYJIbsHxp6CNJCRlg1WGf07tyXcN2WKCt4loV1x6r3ENMi+6mjFDa+Xdgr2h9drqF+TwUBI0=
X-Received: by 2002:a63:5d61:: with SMTP id o33mr649945pgm.114.1561593077486;
 Wed, 26 Jun 2019 16:51:17 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:28 -0700
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 09/13] walken: demonstrate reversing a revision walk list
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The final installment in the tutorial about sorting revision walk
outputs. This commit reverses the commit list, so that we see newer
commits last (handy since we aren't using a pager).

It's important to note that rev->reverse needs to be set after
add_head_to_pending() or before setup_revisions(). (This is mentioned in
the accompanying tutorial.)

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index 6cc451324a..958923c172 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -69,6 +69,9 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
 
 	/* add the HEAD to pending so we can start */
 	add_head_to_pending(rev);
+
+	/* Reverse the order */
+	rev->reverse = 1;
 	
 	/* Let's play with the sort order. */
 	rev->topo_order = 1;
-- 
2.22.0.410.gd8fdbe21b5-goog

