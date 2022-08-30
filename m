Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6FBECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiH3JfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiH3Jdv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:33:51 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8BBD83E2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:58 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11dca1c9c01so15402729fac.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lqgV6bwWDdhSDhwKNmNPOfLUKx8xvgABH1zgJqg9wjE=;
        b=H2QF77ZoYC3Xm8CqUJq3k+vHA4Qr1KDR/4/GPlT/nEXIYw7fRjwSSc+qh6LqN8ANld
         mDE9mDgPzFhP7yWNVk653mnvhq2QrHe+C5j3qdOzVkbC0Hevdtk+R69/TT8PbtPEehrj
         f8HG1WN3Lpo9VvUmQN3CJlMi/nUM1NjhU1HDwCID5SMUJSC4xs90zUnd7N3iou4/W1Ny
         2COpTMcMU2Mo3E0L4D4tabx04/A41FnYbmsgWyo4w5+mbhsge3myxH2yzq/ziso1Fnkz
         AQs56S9kwVyjbf/jtEyoG/eDY0bLtVnPTqRslIPYqTaZH4kN6uZQZOB96mjMO15Dt6m1
         E+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lqgV6bwWDdhSDhwKNmNPOfLUKx8xvgABH1zgJqg9wjE=;
        b=IUuhFDH6JJbdyOK+r7sCyAynQfj0QwI/Dhn4DdOCt9F9hZvVTZYQS9p70fbU78h0Xi
         E3uAurCuXJ8RgHYgpWSV7AJkdeDsF2+OfUW6hcaZwvi3lGdl3GNjiVl/cf+/NTn4Wlgp
         O7ppUMVAOl9sJIJ84yrPxq+852YLwxDWPEhe+nD0K7nBQbEBi9swUfjPSVolVfyhsZ/I
         n4Wk8b9vXP4XJHkkWiVfD6hjvMNHbChzGev8r4tjwtxHXAVBdQ6u6mLHNmx3OtIJ+l9t
         +3gui09t6MHco7+bn8fS5UNKFS9caml4AbFe9G+RJfcK920thoA7iAr7gkB7DrSiWojF
         7xWQ==
X-Gm-Message-State: ACgBeo0EpgT6s6lRugUWj59D+aF6T2uqB3r6nFgfZFePwBnmtpCPmMcn
        hIXMN2mNeZfA66ot0RwugdgkWFWYKoY=
X-Google-Smtp-Source: AA6agR7FkCK0nsGTFxv9XhEUvuPhpV5aZz6qh3FjevnpnLICQWxN4YF0SPWglvEmlh7E3AI9ycxOdQ==
X-Received: by 2002:a05:6870:4308:b0:10b:8cbe:c945 with SMTP id w8-20020a056870430800b0010b8cbec945mr9463038oah.220.1661851978114;
        Tue, 30 Aug 2022 02:32:58 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id y16-20020a056870429000b0010bf07976c9sm7473781oah.41.2022.08.30.02.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 45/51] completion: bash: simplify _get_comp_words_by_ref()
Date:   Tue, 30 Aug 2022 04:31:32 -0500
Message-Id: <20220830093138.1581538-46-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need the whole functionality of _get_comp_words_by_ref(), we
know exactly what we need from that function, so only do that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 30 ++++++--------------------
 t/t9902-completion.sh                  | 21 ++++--------------
 2 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1fb99265e4..45550f7839 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -413,30 +413,12 @@ __git_reassemble_comp_words_by_ref()
 if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
 _get_comp_words_by_ref ()
 {
-	local exclude cur_ words_ cword_
-	if [ "$1" = "-n" ]; then
-		exclude=$2
-		shift 2
-	fi
-	__git_reassemble_comp_words_by_ref "$exclude"
-	cur_=${words_[cword_]}
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		cur)
-			cur=$cur_
-			;;
-		prev)
-			prev=${words_[$cword_-1]}
-			;;
-		words)
-			words=("${words_[@]}")
-			;;
-		cword)
-			cword=$cword_
-			;;
-		esac
-		shift
-	done
+	local words_ cword_
+	__git_reassemble_comp_words_by_ref "=:"
+	cword=$cword_
+	cur=${words_[cword]}
+	prev=${words_[cword-1]}
+	words=("${words_[@]}")
 }
 fi
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index eb8e173e6b..fc09bafa07 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -40,23 +40,10 @@ GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
 # So let's override it with a minimal version for testing purposes.
 _get_comp_words_by_ref ()
 {
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		cur)
-			cur=${_words[_cword]}
-			;;
-		prev)
-			prev=${_words[_cword-1]}
-			;;
-		words)
-			words=("${_words[@]}")
-			;;
-		cword)
-			cword=$_cword
-			;;
-		esac
-		shift
-	done
+	cword=$_cword
+	cur=${_words[cword]}
+	prev=${_words[cword-1]}
+	words=("${_words[@]}")
 }
 
 print_comp ()
-- 
2.37.2.351.g9bf691b78c.dirty

