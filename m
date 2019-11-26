Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029C6C432C3
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EC42068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJc9BUiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKZBRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:17:50 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:41121 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBRt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:17:49 -0500
Received: by mail-pj1-f65.google.com with SMTP id gc1so7454181pjb.8
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/8oQyuhlgHZAJtCYHSIRwkFMjgd735KXwMjjOYt4/fU=;
        b=eJc9BUiKwyClxp3CX9kQDsPeulIsZ4F3D700ypkyPiAyhCQHsgkpn3rRP6VqVHM9eW
         gMoSwLK3sx3tXksXMKRMUz6U7GuKh2jbWCRiPLTIrtdetjXZWG+Qsfv+QLeYA6zI6fg6
         AafbTiGVzFeCwigxk8iCh9SpepZy0ZATiGobdf8j4Y2jVb8CswhUYGoNMx4k59jRAxYO
         psuPjcxHpUaVR/+eoLxLGzksQKtdB2oYKkilAgpYSjVtyfX0mH5w1Ew/+zg/wCll7CdB
         DRvtXXHezqBqpG3nACWfjqKB3YrpIHt008kqkU9S8Qxk3OyA5NJoZs3Zq8ke6bkCERWN
         MvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/8oQyuhlgHZAJtCYHSIRwkFMjgd735KXwMjjOYt4/fU=;
        b=LMMdeW1g2xR5mXgt1/2mVxexhpKhOz7wucbcbeaSRkH1+PBNj3h03YB+cK5/f2GIrd
         6BgwF4k1lHAsNa3sGosD7WYdso3vtUpZ5TBY8JZqsClntXJj4VlGP1k3EQVP+XSCqgZv
         HwABJbMgO9hpnW+/YIFn2CYZopR35gbVsZgU3ICBlBQ7HYHgevb9pZv36gCNaB6PVtcm
         kE9O0rWZb05Q3scZxyJ+WgjG2PFoCeIJ6qh9OMEyp1TOTLsRB58LaaG6E6jfgpNHtZpt
         8mIxpc+FUVF7yeLBbxUKXXlRbqKeoQN2E9N77AEmmt3wykr3QO9sJvlxIXEOtBAmOe2d
         AoyA==
X-Gm-Message-State: APjAAAWL46Pt823PaRutGHM1dAaNaEA9tsd/Bm3oV5lfoVs0ywE/3Z7z
        j6H7ri9WhRfwLrogVOnErCs5jE0A
X-Google-Smtp-Source: APXvYqyE9WRxW/uV8HYxd3ER9L3bi0FwfF+QVNLguz5zx742Lky9ysI/lL3igRxTP45dm3jDGYJ//Q==
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr26639824plq.325.1574731068708;
        Mon, 25 Nov 2019 17:17:48 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id y4sm10057494pgy.27.2019.11.25.17.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:17:48 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:17:46 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 01/27] lib-bash.sh: move `then` onto its own line
Message-ID: <9085cc00af10408d9425cfdff5a8b2c49008ae7b.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code style for tests is to have statements on their own line if
possible. Move the `then` onto its own line so that it conforms with the
test style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-bash.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/lib-bash.sh b/t/lib-bash.sh
index 2be955fafb..b0b6060929 100644
--- a/t/lib-bash.sh
+++ b/t/lib-bash.sh
@@ -2,10 +2,12 @@
 # to run under Bash; primarily intended for tests of the completion
 # script.
 
-if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
+if test -n "$BASH" && test -z "$POSIXLY_CORRECT"
+then
 	# we are in full-on bash mode
 	true
-elif type bash >/dev/null 2>&1; then
+elif type bash >/dev/null 2>&1
+then
 	# execute in full-on bash mode
 	unset POSIXLY_CORRECT
 	exec bash "$0" "$@"
-- 
2.24.0.504.g3cd56eb17d

