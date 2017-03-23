Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8B720958
	for <e@80x24.org>; Thu, 23 Mar 2017 22:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933751AbdCWWeW (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:34:22 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:34857 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932811AbdCWWeU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:34:20 -0400
Received: by mail-it0-f42.google.com with SMTP id y18so295286itc.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ljSyvAGwLxPLDpzvq9GqiJ9v6ljm/3jWWVNmZ4JL6tE=;
        b=BkUaJZ3HsgdSRlvNwY3ItsSm/mUKWvQBRkZEl38ulnoO4LwnPxE4pKgKns+Ha3uGel
         th+CwLrPVpNG6xaqhQcvqalv++Ycrbwe6w6ntuwHWwjb/OFLGmSCC6/Dtux8/hIcbiHD
         5Mqd9PrgVgUOeaiN8vHEf7a5NIWZdiwRiYUJQ+EaSQJTHSzlaahuZfhS24vR4WHQQNxe
         b9VM/yaXsQFTNZFxViIf/kk2x6rXmVxXrG5fdReIqZIYRaGFnrmWYcgGNhLyOLd/Ir3x
         T2Eu857T8X9rg98rH7Ds7b/I9qAsto9cm+1OXi8KkCIRLpz/K0u+1hfyWNUSYr4mlgfC
         sSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ljSyvAGwLxPLDpzvq9GqiJ9v6ljm/3jWWVNmZ4JL6tE=;
        b=RnACBnEyqQHmv3HHczv/nmb2wtbp2D3gTO8xSGP9jj4ZEIRhgpcHH7NX34VlgaTIpD
         XefbYpC2pT9qJWbtfFQolSCBHQxk+AbIIY4SR7MdKG8bktT3A/sxHn4iNqyO9XHCefsh
         UIVq5AVKE4CHqPi7KnVuN6LOO30Qk/R//0XsOL1CDmAbHKyzpPGlp/VkO3x+b5L2fhzN
         +oSnZT7Vqs2N5n/0zW0sVlSXzvDOaKS1ZTTaS2zBL/6Ws41wF7FvxEBkCL+jECwDDcIU
         j9pMnS7d4iSxETBYhQBLNcdxYdb2+TBtoB54T7eIeudyM/0iC9o/+VQ51ww5y/i8ke9N
         +Wug==
X-Gm-Message-State: AFeK/H2dl+cxn9j9LumtXfldzi3oMdi1BZqTDx3hUu8YLqJ/MDaM0SL3/nqpirtX+jjO6nJ6
X-Received: by 10.36.155.11 with SMTP id o11mr101080itd.11.1490308458879;
        Thu, 23 Mar 2017 15:34:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id p204sm19330itp.19.2017.03.23.15.34.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 15:34:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/7] submodule.c: stricter checking for submodules in is_submodule_modified
Date:   Thu, 23 Mar 2017 15:33:36 -0700
Message-Id: <20170323223338.32274-6-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323223338.32274-1-sbeller@google.com>
References: <CAGZ79kZP6JhgcFQ5+Ytc6LexpA7C4EwR-7C0QZkiWhfrRCpd6g@mail.gmail.com>
 <20170323223338.32274-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By having a stricter check in the superproject we catch errors earlier,
instead of spawning a child process to tell us.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 93d6f08b50..e06e52b993 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1050,11 +1050,12 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	git_dir = read_gitfile(buf.buf);
 	if (!git_dir)
 		git_dir = buf.buf;
-	if (!is_directory(git_dir)) {
+	if (!is_git_directory(git_dir)) {
+		if (is_directory(git_dir))
+			die(_("'%s' not recognized as a git repository"), git_dir);
 		strbuf_release(&buf);
 		/* The submodule is not checked out, so it is not modified */
 		return 0;
-
 	}
 	strbuf_reset(&buf);
 
-- 
2.12.1.438.gb674c4c09c

