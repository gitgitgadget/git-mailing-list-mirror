Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34F121F406
	for <e@80x24.org>; Tue, 15 May 2018 19:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeEOTlA (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 15:41:00 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40133 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeEOTk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 15:40:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id f189-v6so546731pfa.7
        for <git@vger.kernel.org>; Tue, 15 May 2018 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e+wbKnKGeaQISNjdeiE+cstnfACP1HNrxK4doXBebbw=;
        b=KRvfQj0eiggp7EQOEr/CZW8hXUs8GWnnXF8yJjwF6cGNqKgTUGEpEQzcE7+Zsq4RW4
         JuNGNYuM20T3wC9zu1k4gzw8j78k1Sd4qPRx17lLkRewS+DT4in45YqxyNWSNqg9mT1X
         JcuiG8wdyifjx+eH+fuBPGsIyBOsHdlOxr2QKovnB2wkLKhxeSfkNyBpwRRgp277mQZa
         Uh1ho2+BBxfWwSVSdlB7D6f8nCeAnQV+dGPVY6LbA9NW1jTwi0TPZd21FmhyKf9npyYJ
         EigbtpqcZGkdm7R50c3cAYy8PapUiOsZeFx07X3Bk7pubAL4jxUQPhh82BQ5ZBga/RwJ
         bbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e+wbKnKGeaQISNjdeiE+cstnfACP1HNrxK4doXBebbw=;
        b=nsrH92NsDeVa4fD8BRuZ0hBGp9G8vvQzlgJ6T3AbJ4lrxMxiZSUNt61yObEnIRd63g
         Ld/huqk4E/uj+OlqpudTMOQb5wV5RF4p6QAyvY62hLsn/5yAWdQZy3QfI4BRx2/GLQXm
         EphY7YtB9HA0WElG3Le1dXsHw/iGRDdaU2iGjNo6F+daPM6gR0I3nAxB6OGNXIe9MAvs
         B10z+WvrZyCyI2NsnMxfNd1VfXMaCXeu3yP9+BIcfWHl0795QzZQz2PpCuNLJ0YUKkGn
         KJ17O4qJp1GwxScyZ/I7lRGLv/WeDTr3r+HVC6GTtM/V6MDsBmdmNYS+69S6KTMSVz4R
         T/TA==
X-Gm-Message-State: ALKqPwccxl8V92Csw0ThipMeEIW+ffdpsgq+DbTjAT1Jj8YXZA+i8y48
        KoFXvnn/y9CKsGjC6bME4aNZaw==
X-Google-Smtp-Source: AB8JxZpkhhSZya5GY+uzwaW/USeGGvhlmN7nzwzUjwYJf/v/cX2zBEh4Dve5ItThKKvNWVMpHLMMfw==
X-Received: by 2002:a63:494:: with SMTP id 142-v6mr9212226pge.179.1526413258022;
        Tue, 15 May 2018 12:40:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id e87-v6sm1240171pfl.65.2018.05.15.12.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 12:40:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
Subject: [PATCH] git-submodule.sh: try harder to fetch a submodule
Date:   Tue, 15 May 2018 12:40:54 -0700
Message-Id: <20180515194054.84388-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <CAGZ79ka_8GmL9j9mTNLkbqN3xNkfCfedzs2st-tH8jMjQ2A4DQ@mail.gmail.com>
References: <CAGZ79ka_8GmL9j9mTNLkbqN3xNkfCfedzs2st-tH8jMjQ2A4DQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the logical continuum of fb43e31f2b4 (submodule: try harder to
fetch needed sha1 by direct fetching sha1, 2016-02-23) and fixes it as
some assumptions were not correct.

The commit states:
> If $sha1 was not part of the default fetch ... fail ourselves here
> assumes that the fetch_in_submodule only fails when the serverside does
> not support fetching by sha1.

There are other failures, why such a fetch may fail, such as
    fatal: Couldn't find remote ref HEAD
which can happen if the remote side doesn't advertise HEAD and we do not
have a local fetch refspec.

Not advertising HEAD is allowed by the protocol spec and would happen,
if HEAD points at an unborn branch for example.

Not having a local fetch refspec can happen when submodules are fetched
shallowly, as then git-clone doesn't setup a fetch refspec.

So do try even harder for a submodule by ignoring the exit code of the
first fetch and rather relying on the following is_tip_reachable to
see if we try fetching again.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 24914963ca2..00fcd69138f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -614,7 +614,7 @@ cmd_update()
 				# is not reachable from a ref.
 				is_tip_reachable "$sm_path" "$sha1" ||
 				fetch_in_submodule "$sm_path" $depth ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
+				say "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
 
 				# Now we tried the usual fetch, but $sha1 may
 				# not be reachable from any of the refs
-- 
2.17.0.582.gccdcbd54c44.dirty

