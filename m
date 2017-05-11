Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B0F20188
	for <e@80x24.org>; Thu, 11 May 2017 04:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbdEKEb7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 00:31:59 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34262 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753637AbdEKEb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 00:31:58 -0400
Received: by mail-pg0-f68.google.com with SMTP id u187so1996148pgb.1
        for <git@vger.kernel.org>; Wed, 10 May 2017 21:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KHGQBEG/gght56OMRQXp8QNfd8K5dNo5uhTLobHLeOU=;
        b=g+vjgK+OdO2QADvP3EzVOCs9vYxMW3mlxiBrWKTZT/stXNdao2U2SJWLceMS9n/KOQ
         a+Wvvl6zMR/bjhhG5uLeqYSo6D+xkcxJgRgrFtSbsH2u78XCdIs4o88CxfI3xkn8jGl5
         1vQBy0GZEylThBGBaHJYNgQm8WdI4L4r+wKU6fGSQ9pKRhMIzJfD0mfq389vzJHtFxdp
         thOI+zsJKc4Mh5UOxno9ZE70T2s4nLscYc2APuPuu6L4g5eNbkmW2IrPsuUi0Adz6kxs
         jNVpGlEsytTYhOaFaSVmIm7op6byevv5ixnkXUFwkY4jABrcU7khtMKq1qGKnvwxLsPq
         KtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KHGQBEG/gght56OMRQXp8QNfd8K5dNo5uhTLobHLeOU=;
        b=tago7BZLC+EMO/h/DiKzVY+G0ObhaKH+TqQvLj6KAAw7S+rE1GOFr9CQulk/jce//5
         RJA7RTUcT3fos1wq5tQkKxOSxlFT0T/imqEySLgx3wtnrIz/SiFVdTM+mZLNdJuza5XT
         WMQdB7/Jz8hU4rsz263MqOcA/9//639FZv169ooQ46BVKPb6kUtIuiS/PXowg/AAis69
         tS81aaHrHJisL8Upjht49AUdpCd1eHoCv9tEx/7dgN2LByKAXguAQmwDp3GcthxYfNmi
         sLElj/8QtlKwfwkyWxYrFNRBeb9PlWZm8oPZj5G5Wp0TaHylCnP76uIp+Os+U1wWg26N
         v+YA==
X-Gm-Message-State: AODbwcAl6TAzWShUU89SojmpsTAw1HacW0BW6P3iv4za+Pb2SvIlVTNn
        yP3DEOwnl2Eldw==
X-Received: by 10.99.124.68 with SMTP id l4mr7423512pgn.175.1494477117737;
        Wed, 10 May 2017 21:31:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id s18sm791235pfi.16.2017.05.10.21.31.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 21:31:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH] read-tree: "read-tree -m --empty" does not make sense
References: <20170503162931.30721-1-jn.avila@free.fr>
        <20170503210726.24121-1-jn.avila@free.fr>
        <20170503210726.24121-2-jn.avila@free.fr>
        <xmqq60h8cay3.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 10 May 2017 21:31:54 -0700
In-Reply-To: <xmqq60h8cay3.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 10 May 2017 20:46:28 -0700")
Message-ID: <xmqqwp9oau9x.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fb1bb965 ("read-tree: deprecate syntax without tree-ish args",
2010-09-10) wanted to deprecate "git read-tree" without any tree,
which used to be the way to empty the index, and encourage use of
"git read-tree --empty" instead.  

However, when used with "-m", "--empty" does not make any sense,
either, simply because merging 0 trees will result in a different
error anyway.

Omit the deprecation warning and let the code to emit real error
message diagnose the error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    Junio C Hamano <gitster@pobox.com> writes:

    > Jean-Noel Avila <jn.avila@free.fr> writes:
    >
    >> "git read-tree -m" requires a tree argument to name the tree to be
    >> merged in.  Git uses a cutesy error message to say so and why:
    >>
    >>     $ git read-tree -m
    >>     warning: read-tree: emptying the index with no arguments is
    >>     deprecated; use --empty
    >>     fatal: just how do you expect me to merge 0 trees?
    >>     $ git read-tree -m --empty
    >>     fatal: just how do you expect me to merge 0 trees?
    >
    > This shows another issue.  The "emptying ... is deprecated" message
    > shouldn't be given when -m is present.
    >
    > I am not saying that that needs to be fixed by you and/or as a part
    > of this patch.  Just something I noticed while reviewing the patch.

 builtin/read-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 23e212ee8c..284de743c3 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -210,7 +210,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			die("failed to unpack tree object %s", arg);
 		stage++;
 	}
-	if (nr_trees == 0 && !read_empty)
+	if (!nr_trees && !read_empty && !opts.merge)
 		warning("read-tree: emptying the index with no arguments is deprecated; use --empty");
 	else if (nr_trees > 0 && read_empty)
 		die("passing trees as arguments contradicts --empty");
-- 
2.13.0-336-gf73534b083

