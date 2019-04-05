Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1FC20248
	for <e@80x24.org>; Fri,  5 Apr 2019 03:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfDEDh5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 23:37:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39810 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbfDEDh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 23:37:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so2483907pfo.6
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 20:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jKy0qoTPDs6MceJ1/QoSplmrd/fS2qAbAaAih34meOQ=;
        b=gG2a4P5Z8MzcgJ5dDh2o71JMkgflFoY1QvKSwb6qXiePsA/u23+s5IAJgNWvqO8dPI
         mnt1xW/bjxXUPpZft9A+zYggRAc99i7B4IM8p7lOagmy+StqdPC/8sb4cPrh8llPumn2
         zvT/OdbfOA/E6l7XdDZ06CAlbuDBbuvf6X51Z8IQUPXxGL7o3YL9ZgpwnxDSPgPUd1NM
         HQoJu1NGnuhW6xRZjgP650H7huVJlvETj6311U/KYjD1lDt0dojWAKFamUGLC1E5hhyC
         /NtrCB70oe+2zrS4WIrrNAssvo1jTbkWSN249bQu46SLRk0p1pIwpqWg7rvMPsWfjuOp
         Q03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jKy0qoTPDs6MceJ1/QoSplmrd/fS2qAbAaAih34meOQ=;
        b=KMLh6T9D+BieRnyilimLXTFGh7l3ZSc6g8Hr9VjdHuf9JjRRtV23h5DzjG9gXf6T/o
         xTX8CW3KGwnLcFXDGDKX+UdJqYumaE4+wrhX+fRgqSFnBci0+OVhtgzDSabZtLEGQ/qA
         vfAuMiIwZA+KhCX+QW5w68weNFXfXTVOyZ/qe97U0eOTQ7frTxNV8i8ZMCpmqC4ENPmj
         4m4w5ax4RxMrxBWqGuA5OqU/xVHJbwQncmxdo3zgmPXDbWTWHOfkpVcp7em4oog80y6q
         5pjre2/CDPWKzr+gKHi40IJvFeSwDHv3QthIN5j0aeGF8QpaUa7iuID6RsAfV2DZejS+
         Lh0w==
X-Gm-Message-State: APjAAAWcu0cTnDxKcGwR8EKkdOC1bUj9u9018LGqp9C2K5LdPUybgZ8g
        k/ydIWqbyNQY3bEyXWrq7hjuiaBzZ3Ga6g==
X-Google-Smtp-Source: APXvYqw1e+8CkBcpBEK83Y1MiDzzaoGvYs2t4flxfkaz3QN44jrWReBNx9KIr35AgXIEUvmhk85yGA==
X-Received: by 2002:a62:5144:: with SMTP id f65mr10039034pfb.13.1554435475239;
        Thu, 04 Apr 2019 20:37:55 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:9900:4016:ceb4:1574])
        by smtp.gmail.com with ESMTPSA id p17sm27330433pfn.157.2019.04.04.20.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 20:37:54 -0700 (PDT)
Date:   Thu, 4 Apr 2019 20:37:54 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH 6/7] rev-list: let traversal die when --missing is not in use
Message-ID: <a3a80b4b2a988eb65d85a5acd54c584d047073c7.1554435033.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554435033.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Commit 7c0fe330d5 (rev-list: handle missing tree objects properly,
2018-10-05) taught the traversal machinery used by git-rev-list to
ignore missing trees, so that rev-list could handle them itself.

However, it does so only by checking via oid_object_info_extended() that
the object exists at all. This can miss several classes of errors that
were previously detected by rev-list:

  - type mismatches (e.g., we expected a tree but got a blob)

  - failure to read the object data (e.g., due to bitrot on disk)

This is especially important because we use "rev-list --objects" as our
connectivity check to admit new objects to the repository, and it will
now miss these cases (though the bitrot one is less important here,
because we'd typically have just hashed and stored the object).

There are a few options to fix this:

 1. we could check these properties in rev-list when we do the existence
    check. This is probably too expensive in practice (perhaps even for
    a type check, but definitely for checking the whole content again,
    which implies loading each object into memory twice).

 2. teach the traversal machinery to differentiate between a missing
    object, and one that could not be loaded as expected. This probably
    wouldn't be too hard to detect type mismatches, but detecting bitrot
    versus a truly missing object would require deep changes to the
    object-loading code.

 3. have the traversal machinery communicate the failure to the caller,
    so that it can decide how to proceed without re-evaluting the object
    itself.

Of those, I think (3) is probably the best path forward. However, this
patch does none of them. In the name of expediently fixing the
regression to a normal "rev-list --objects" that we use for connectivity
checks, this simply restores the pre-7c0fe330d5 behavior of having the
traversal die as soon as it fails to load a tree (when --missing is set
to MA_ERROR, which is the default).

Note that we can't get rid of the object-existence check in
finish_object(), because this also handles blobs (which are not
otherwise checked at all by the traversal code).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c                     | 4 +++-
 t/t6102-rev-list-unexpected-objects.sh | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 425a5774db..9f31837d30 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -379,7 +379,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	repo_init_revisions(the_repository, &revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
-	revs.do_not_die_on_missing_tree = 1;
 
 	/*
 	 * Scan the argument list before invoking setup_revisions(), so that we
@@ -409,6 +408,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (arg_missing_action)
+		revs.do_not_die_on_missing_tree = 1;
+
 	argc = setup_revisions(argc, argv, &revs, &s_r_opt);
 
 	memset(&info, 0, sizeof(info));
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 30976385a8..c8d4b31f8f 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -29,7 +29,7 @@ test_expect_success 'setup unexpected non-tree entry' '
 	broken_tree="$(git hash-object -w --literally -t tree broken-tree)"
 '
 
-test_expect_failure 'traverse unexpected non-tree entry (lone)' '
+test_expect_success 'traverse unexpected non-tree entry (lone)' '
 	test_must_fail git rev-list --objects $broken_tree
 '
 
@@ -64,7 +64,7 @@ test_expect_success 'setup unexpected non-tree root' '
 		broken-commit)"
 '
 
-test_expect_failure 'traverse unexpected non-tree root (lone)' '
+test_expect_success 'traverse unexpected non-tree root (lone)' '
 	test_must_fail git rev-list --objects $broken_commit
 '
 
-- 
2.21.0.203.g358da99528

