Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD0C1F462
	for <e@80x24.org>; Wed, 29 May 2019 21:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfE2VQc (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 17:16:32 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:40132 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfE2VQc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 17:16:32 -0400
Received: by mail-yb1-f202.google.com with SMTP id n7so2971338ybk.7
        for <git@vger.kernel.org>; Wed, 29 May 2019 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5ElvssYjgP0HICOmjUQbcOPuXaxAb/Isct6vj9iLjkc=;
        b=NkaFcHtCUiOzV7xeVr/pbnmAxMhZeutGyh+i6kGzcmuphXUM9LEUkSSXnXvYLE7wzL
         gIZFEXfl/u8WFxqgBHdjMp4ffxvoFdFM9jnp6j9AHRLBczJwaEQW9T3uOFiNLtB40dNc
         WIBoeUWCqQ9/dZNXasIZpmHF88G5J0qi/C4bw0nZvXM2aoQIb4BmhSK047jnUP757Shw
         GURBq0JLNt1dArXcE5LR9e86eqh3ZLRsyEJ8SVDsS/yTDs2cF/wvotJdlFP7zwEWckQv
         zS1alGHNtdpd9EM/7le6GdxWVVBn7c7OUCRsGCYYj80Q48bZ61NjoX9Tckke7AKvOtu4
         ln5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5ElvssYjgP0HICOmjUQbcOPuXaxAb/Isct6vj9iLjkc=;
        b=kxEkRxaa+Elv/JLSNuLbES4tH0IOtyXZe6VnMUn2Z6zWDNDllsbYVjWZJOZvXAvNDP
         NshYz24+B/MckJxkMdtKmG0Z3uCzX1H+4qnKN2mKYNHgZlt11uoera+2z6kDRjfQwQRJ
         tggCq0M9phK0hCbtlBy1YDuufveoweekBAAfguOpV3vjyb4s3EO9XYdJ7q8PBRUgKYFT
         nhSQLuJ2IkEEK4mObbnRSzcTL3HNBw5QGhBPeV9gwA7/AVtWjCLeK58ANz9zwyy8Tq/A
         thMXDKQVPS0pvMSHgSrk3AbjvEdvzgQ01mjI2eDfuD662XuG4El0AjwViqoDJgxs8ZR1
         RhqA==
X-Gm-Message-State: APjAAAXQcXVBeR8VCfIxEEBr2xxKHPMMPtt+s6AY0klDtZbcxSO34d7h
        QX0IBddGj+RPanE5E+HhxH64oEPZ46vN
X-Google-Smtp-Source: APXvYqw+vgjRaWnMOridCzO/zB4IA8VqPRl8r591SWfC/EEvyTq5czs8BbwGO+PZ28Lns6BkCwnQTfGcZLbW
X-Received: by 2002:a81:4c4e:: with SMTP id z75mr57886ywa.416.1559164591356;
 Wed, 29 May 2019 14:16:31 -0700 (PDT)
Date:   Wed, 29 May 2019 14:16:10 -0700
In-Reply-To: <xmqqr28hxc9t.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190529211610.190269-1-delphij@google.com>
Mime-Version: 1.0
References: <xmqqr28hxc9t.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v3] clone: respect user supplied origin name when setting up
 partial clone
From:   Xin Li <delphij@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Xin Li <delphij@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/clone.c  |  2 +-
 t/t5601-clone.sh | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..822208a346 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1215,7 +1215,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			remote_head_points_at, &branch_top);
 
 	if (filter_options.choice)
-		partial_clone_register("origin", &filter_options);
+		partial_clone_register(option_origin, &filter_options);
 
 	if (is_local)
 		clone_local(path, git_dir);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d6948cbdab..3595162c32 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -634,7 +634,7 @@ test_expect_success CASE_INSENSITIVE_FS 'colliding file detection' '
 	test_i18ngrep "the following paths have collided" icasefs/warning
 '
 
-partial_clone () {
+partial_clone_server () {
 	       SERVER="$1" &&
 	       URL="$2" &&
 
@@ -646,8 +646,14 @@ partial_clone () {
 	test_commit -C "$SERVER" two &&
 	HASH2=$(git hash-object "$SERVER/two.t") &&
 	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
-	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
+	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1
+}
+
+partial_clone () {
+	       SERVER="$1" &&
+	       URL="$2" &&
 
+	partial_clone_server "${SERVER}" "${URL}" &&
 	git clone --filter=blob:limit=0 "$URL" client &&
 
 	git -C client fsck &&
@@ -664,6 +670,11 @@ test_expect_success 'partial clone' '
 	partial_clone server "file://$(pwd)/server"
 '
 
+test_expect_success 'partial clone with -o' '
+	partial_clone_server server "file://$(pwd)/server" &&
+	git clone -o blah --filter=blob:limit=0 "${URL}" client
+'
+
 test_expect_success 'partial clone: warn if server does not support object filtering' '
 	rm -rf server client &&
 	test_create_repo server &&
-- 
2.22.0.rc1.257.g3120a18244-goog

