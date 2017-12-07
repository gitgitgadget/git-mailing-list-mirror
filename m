Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040F920954
	for <e@80x24.org>; Thu,  7 Dec 2017 19:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbdLGTvx (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 14:51:53 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:44632 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdLGTvv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 14:51:51 -0500
Received: by mail-it0-f65.google.com with SMTP id b5so17551028itc.3
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 11:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6C5SUKsz707ukkmhrDTlQsTjM94yfdX7mOeeuHGdfaI=;
        b=pKa3v+DeFGQVtvVILaeJnM5rqYClE3uYpYYpf2W1iAX2/cMs/qneoRhWgnpY69xLBl
         bVUNFdYYY3RsTFnpXj3LNMlUe033OWATUCs2qsbrdG35s8/ck7bvpP8BxlGl+RQpIsJl
         8hmR8McvQ4LOWhlJd6+ANHKx0UC90+FAYQ9/Z56Z0Ka9cci31LwjtIN8d5TExSs/pu4w
         zzl6BD3OFdN+5mgVSS2pwlV6omtYJpoGQ3dZU/JQAeSCPrCu5+QdQXa/KB/ckCC0b4x7
         cE/eIljX7Otq6T8is1N2uCkkTVLMqemAjIajXpzQeu17s/nBpWPlkFiQ2QoTLkX7KMXi
         31mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6C5SUKsz707ukkmhrDTlQsTjM94yfdX7mOeeuHGdfaI=;
        b=FrcW1JBhNQm5WbyRQqci7PJbFYW555iAgCjWoCWdpKZv9yIee8QxMtp30JchU9qJ8t
         afbTDjvenLe2yoWGQrD3cJaTjyi4gKKAcOH0w3dVy14+XOUjWP09GDdW1bj6qIsa5ITK
         eweKWT2XiowS/XF2D3Y5ushYAZ0maJ3UqzoziUsxPNk3Tki1kr0d6Lzd7f/4cOHAEsBM
         C0WRc2VGEyRhauz1I8X0rmlF4xdycUDjNFjzqSulQwjfXtZgje6YE9IWj2PPUj5cxr0o
         NNzPHhnsHDv2ClPMUUX3tD7NHczd7TzuruZFcixUhTeud5Dh7QNaw7wlSkiY+l9ZH0DD
         aK9w==
X-Gm-Message-State: AKGB3mJfuWEsoYk7bC0JE6U85tHja3tGMjtX+h257Y555QtEKXSOLGKY
        rg6kw08fJ7/KH8wTVEouQ7QgH3Awi1c=
X-Google-Smtp-Source: AGs4zMZoMCfMCDRD6j46V2LyDHvrg90IrWld6nTy17Z2Q8givVji7iiNrCTqG9+HxmRwni7FuLmrpQ==
X-Received: by 10.36.238.67 with SMTP id b64mr2660867iti.37.1512676310040;
        Thu, 07 Dec 2017 11:51:50 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id k19sm2715885ioc.75.2017.12.07.11.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Dec 2017 11:51:49 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH] RelNotes/2.16: Fix submodule recursing argument
Date:   Thu,  7 Dec 2017 11:51:45 -0800
Message-Id: <20171207195145.11965-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some commands take a plain `--recursive` flag as an indication to recurse
into submodules, git-clone is a notable user facing example, an internal
example is in builtin/submodule--helper. Other commands such as git-merge
take the `--recursive` flag to indicate recursing in their specific area
of expertise.

Given these examples it is evident, that such a flag is too generic as
we can think of other recursive applications as well: recursing into trees
is another example.

That is why any submodule related recursing tries to use the explicit
`--recurse-submodules` instead. Any occurrences of the genric recurse flag
are historic accidents.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Junio, feel free to just squash this into a future update
of the release notes.

Thanks,
Stefan

 Documentation/RelNotes/2.16.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.16.0.txt b/Documentation/RelNotes/2.16.0.txt
index 431bd5e34a..8fbc233e56 100644
--- a/Documentation/RelNotes/2.16.0.txt
+++ b/Documentation/RelNotes/2.16.0.txt
@@ -275,7 +275,7 @@ Fixes since v2.15
    ask the underlying "git fetch" to go over IPv4/IPv6, which has been
    corrected.
 
- * "git checkout --recursive" may overwrite and rewind the history of
+ * "git checkout --recurse-submodules" may overwrite and rewind the history of
    the branch that happens to be checked out in submodule
    repositories, which might not be desirable.  Detach the HEAD but
    still allow the recursive checkout to succeed in such a case.
-- 
2.15.1.424.g9478a66081-goog

