Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B6CF1F51C
	for <e@80x24.org>; Thu, 31 May 2018 07:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbeEaHYL (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 03:24:11 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37910 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754026AbeEaHYH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 03:24:07 -0400
Received: by mail-pl0-f68.google.com with SMTP id c11-v6so12695483plr.5
        for <git@vger.kernel.org>; Thu, 31 May 2018 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/9mpLWiDuIxaVJDwU6rRWWD6FLBkSrkYAcg5ctriDu4=;
        b=U5DgOBkObG5d3ShRf+ZkT6YI275gJsFoFAdqc8pQlDgNm6LpmY2+UrpnchrleQbuT9
         RHoyX0sL08oy7nFhULjoYfpQkE9o+EcVMEZVyieEQFwAUm1MEms7lVZ0d/J88GPGwX0y
         An3hncAGwglrePKCvuWBMdFhlUAJJuZKlnwuLwMrSOfYudLO/lpfDe8FVf4VAxyGZmkq
         at/+kHCHYqGugUYp+bImvA4uMDd1qn3JbgCapA8aPPfkAHrOVhYU7YYIRWf7nMAoPbYP
         9Bwy0lrs8997UGmO+9ejwD3JS6uZpkZ/JePR/FHF/dROR90hgm5LWRljt8UI86JLSuzz
         /U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/9mpLWiDuIxaVJDwU6rRWWD6FLBkSrkYAcg5ctriDu4=;
        b=NHA6oXRWXdBOx044aNnstA3k+WoNrBOqFrTcWTUhdcYbRu6voQVIYBKDrfJkSfA6S5
         NJBvQifWqSqHI28+ODoxmxf/iL+qfdvqw/7usKHUzsyqw640M9PHwNM2X8AzXXXvPyAf
         r98YfcY8PHVPbhAPPaVctlOryVT1LqSzZOgeX5NPWi1Va4/bo2Np1yj7j5tHqRJCLBkR
         aRogJD6tq7fUFBEN7f7aSnTsihjphmWrjDKb7e04HH1NvuTSYvPK3X0l9cGqOzYpZuyn
         n4yBsRkcUIl/tXIjsxfSvZEOIGaylKuFUYNoWXYGaBD1Sd28KOkZ8fwbhBpAbBXr7yNg
         HIUg==
X-Gm-Message-State: ALKqPwfhIZRUGYmjF3qkaemULgW8vkr+R/u5f/oTpDqr79AOp+Xzy8A+
        jBvAodXzEkiYynuAuYsggVw=
X-Google-Smtp-Source: ADUXVKJ8PvVuXz4BlsX2rRO8rdoNrsVyvfi8PSGhqZUUE2T/XXIHXK5bzHwtuSp9C18zJXqoZt/7gw==
X-Received: by 2002:a17:902:189:: with SMTP id b9-v6mr5986778plb.204.1527751446469;
        Thu, 31 May 2018 00:24:06 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n10-v6sm83510662pfj.68.2018.05.31.00.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 00:24:05 -0700 (PDT)
Date:   Thu, 31 May 2018 00:23:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fetch: do not pass ref-prefixes for fetch by exact SHA1
Message-ID: <20180531072339.GA43435@aiede.svl.corp.google.com>
References: <20180516225823.235426-1-bmwill@google.com>
 <20180516234822.182663-1-bmwill@google.com>
 <20180516234822.182663-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516234822.182663-2-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When v2.18.0-rc0~10^2~1 (refspec: consolidate ref-prefix generation
logic, 2018-05-16) factored out the ref-prefix generation code for
reuse, it left out the 'if (!item->exact_sha1)' test in the original
ref-prefix generation code. As a result, fetches by SHA-1 generate
ref-prefixes as though the SHA-1 being fetched were an abbreviated ref
name:

 $ GIT_TRACE_PACKET=1 bin-wrappers/git -c protocol.version=2 \
	fetch origin 12039e008f9a4e3394f3f94f8ea897785cb09448
[...]
 packet:        fetch> ref-prefix 12039e008f9a4e3394f3f94f8ea897785cb09448
 packet:        fetch> ref-prefix refs/12039e008f9a4e3394f3f94f8ea897785cb09448
 packet:        fetch> ref-prefix refs/tags/12039e008f9a4e3394f3f94f8ea897785cb09448
 packet:        fetch> ref-prefix refs/heads/12039e008f9a4e3394f3f94f8ea897785cb09448
 packet:        fetch> ref-prefix refs/remotes/12039e008f9a4e3394f3f94f8ea897785cb09448
 packet:        fetch> ref-prefix refs/remotes/12039e008f9a4e3394f3f94f8ea897785cb09448/HEAD
 packet:        fetch> 0000

If there is another ref name on the command line or the object being
fetched is already available locally, then that's mostly harmless.
But otherwise, we error out with

 fatal: no matching remote head

since the server did not send any refs we are interested in.  Filter
out the exact_sha1 refspecs to avoid this.

This patch adds a test to check this behavior that notices another
behavior difference between protocol v0 and v2 in the process.  Add a
NEEDSWORK comment to clear it up.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Here's the change described in
https://public-inbox.org/git/20180531010739.GB36515@aiede.svl.corp.google.com/
as a proper patch.

Thoughts of all kinds welcome, as always.

 refspec.c             |  2 ++
 refspec.h             |  4 ++++
 t/t5516-fetch-push.sh | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/refspec.c b/refspec.c
index c59a4ccf1e..ada7854f7a 100644
--- a/refspec.c
+++ b/refspec.c
@@ -202,6 +202,8 @@ void refspec_ref_prefixes(const struct refspec *rs,
 		const struct refspec_item *item = &rs->items[i];
 		const char *prefix = NULL;
 
+		if (item->exact_sha1)
+			continue;
 		if (rs->fetch == REFSPEC_FETCH)
 			prefix = item->src;
 		else if (item->dst)
diff --git a/refspec.h b/refspec.h
index 01b700e094..3a9363887c 100644
--- a/refspec.h
+++ b/refspec.h
@@ -42,6 +42,10 @@ void refspec_clear(struct refspec *rs);
 int valid_fetch_refspec(const char *refspec);
 
 struct argv_array;
+/*
+ * Determine what <prefix> values to pass to the peer in ref-prefix lines
+ * (see Documentation/technical/protocol-v2.txt).
+ */
 void refspec_ref_prefixes(const struct refspec *rs,
 			  struct argv_array *ref_prefixes);
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f4d28288f0..a5077d8b7c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1121,6 +1121,25 @@ test_expect_success 'fetch exact SHA1' '
 	)
 '
 
+test_expect_success 'fetch exact SHA1 in protocol v2' '
+	mk_test testrepo heads/master hidden/one &&
+	git push testrepo master:refs/hidden/one &&
+	git -C testrepo config transfer.hiderefs refs/hidden &&
+	check_push_result testrepo $the_commit hidden/one &&
+
+	mk_child testrepo child &&
+	git -C child config protocol.version 2 &&
+
+	# make sure $the_commit does not exist here
+	git -C child repack -a -d &&
+	git -C child prune &&
+	test_must_fail git -C child cat-file -t $the_commit &&
+
+	# fetching the hidden object succeeds by default
+	# NEEDSWORK: should this match the v0 behavior instead?
+	git -C child fetch -v ../testrepo $the_commit:refs/heads/copy
+'
+
 for configallowtipsha1inwant in true false
 do
 	test_expect_success "shallow fetch reachable SHA1 (but not a ref), allowtipsha1inwant=$configallowtipsha1inwant" '
-- 
2.17.1.1185.g55be947832

