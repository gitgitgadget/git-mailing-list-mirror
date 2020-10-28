Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585D1C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 01:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D518120731
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 01:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abNWlI+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgJ2BPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbgJ2BOj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 21:14:39 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE6BC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 18:14:38 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id y186so1623955oia.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 18:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dv52nRheChDNGKOvMtjbP5h01dKNuSVIXNv1lknaF+M=;
        b=abNWlI+XGzx7eldP3N03LUqwEt0Q30TvF7a/UE0w8NPWgSEl0TyXqqN0WN62UXA3fz
         dBHcuVrlL2mbwvPLopTfyqnGGrkEZFxNh2BB0Ka9M+zjyxnPhI5/JNokvpL8GsEJ0yeJ
         A0MRYmHbh/8sM60FrTuDAIz8ROHyk3vFxiHd4d9Iebm3c/vesQFO1GRmh5r3BnE7PPhH
         rTuDJAZB0Max5JtfpDAt6qfoJYp97RYxO6dVwDvMmjtMh/FewuCVGugqZ7XLfVyiZR1b
         UQx25ZoQul5IwjyjD+Swo5jFPT7W3+2JYh9t3TNOFyMV3aEmYrRxJEYgBiyv5kAZRAvi
         UR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dv52nRheChDNGKOvMtjbP5h01dKNuSVIXNv1lknaF+M=;
        b=mJXvKZyGCePo8iugUPtpfr7U4HbiiZAyfHaNgtSbARrrji7k4u/FMM8hSbYw6vvdOI
         C9XvJJnHZkHn48hbHIy+g4NkL4r6ugzFFpAlEPAMMMCtpzmWc1L72YVNuRqmYGQaIARs
         qqh5lRbWJBV+4AAtUBS7Z3tmJ+7aEidAvjkEMLsjnyC4aoZcLL3rJiDgyhW1nJEVx3XB
         ELYIjaJ+5Z+6iM/LeJpHHgiWlYP03Ww3XQTVApW0TtDe3/EIRtATqBFyi+0toGGTJ2iA
         H0xy6f1xWDq0lCqBNgi9rhCA3eNRVK1MPl3RasYj0vGdokeJvorq9c0LvjY+B25GmZ63
         QVIA==
X-Gm-Message-State: AOAM533ju1fjYFdf5scLnnmhgRnHMVFltnVb+gq/r8N0mh4ln4z974pb
        01pqeFVCoCNuap30SgND8XYS0RVsgbRXdtGY
X-Google-Smtp-Source: ABdhPJyCamPQuEhCNOeN+gyrAN4hgVwQTm7/M0pdRX5uv4c1UuOkJtL5e+q/X74fOMvYW8YZfy2SNA==
X-Received: by 2002:aca:3806:: with SMTP id f6mr3553987oia.66.1603850841360;
        Tue, 27 Oct 2020 19:07:21 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id f124sm2192164oia.27.2020.10.27.19.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:20 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 04/29] completion: zsh: reorganize install instructions
Date:   Tue, 27 Oct 2020 20:06:47 -0600
Message-Id: <20201028020712.442623-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start with the most important thing; the proper location of this script,
then follow with the location of the slave script (git-completion.bash).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 712ce2f4d1..05ccaac194 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -4,13 +4,6 @@
 #
 # Copyright (c) 2012-2013 Felipe Contreras <felipe.contreras@gmail.com>
 #
-# You need git's bash completion script installed somewhere, by default it
-# would be the location bash-completion uses.
-#
-# If your script is somewhere else, you can configure it on your ~/.zshrc:
-#
-#  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
-#
 # The recommended way to install this script is to make a copy of it as a
 # file named '_git' inside any directory in your fpath.
 #
@@ -18,6 +11,15 @@
 # and then add the following to your ~/.zshrc file:
 #
 #  fpath=(~/.zsh $fpath)
+#
+# You need git's bash completion script installed. By default bash-completion's
+# location will be used (e.g. /usr/share/bash-completion/completions/git).
+#
+# If your bash completion script is somewhere else, you can specify the
+# location in your ~/.zshrc:
+#
+#  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
+#
 
 complete ()
 {
-- 
2.29.1

