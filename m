Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187D9C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47E62146E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfLQTqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:46:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39108 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfLQTqr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 14:46:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so12624355wrt.6
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 11:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nj1KrBW9h7qcb4avNCukFBVGulVti5fxnUVBhpebL9Q=;
        b=I1Ftg4C0/PCMjMWJcqEkwrKqdt7JwMJUbUp3hQtZh/+XzbUjo1FyAr/1ekMXkQrcYG
         FLV1uNz/KPx8oEzZ6F/ozM+VkQ52FO2TY+r9ink/zzdLg/UEblBxa7Yy5uUFRCniHKxH
         hJaLUF32XyWJpBLtk29hFB8fYHTYQzw33pwo56ck+083TQ8RzGdUg20G0d2CveXg/aZz
         zbgAJlebB6xJtfKUc99OGjVPaobMIx4fUuWS08W0WTYwVnMkUnIakvtgHP88E1fVNCx8
         Try4VPpjmeVa30HlfXB5DlZWgdrFxSL5/yJzkPJ7swRfDHu0OkrT1OZihwccK58T7nYf
         mO0Q==
X-Gm-Message-State: APjAAAWy6luxqgRLw2CaUk7s0gVoG0jmJhZZLzeF+REbWQFR1WN4yuO2
        zVSCkY+E232c7dHpYK+A+ErvAvc1aUCaRqQ2mNNdq1PI
X-Google-Smtp-Source: APXvYqxVXG+bRea+8Rr/SlhKIDTsS93TCWGhXT7ljDqnQE/NHIg4QnwIHgfnZSjk5OjA8ZdLGujbVNUWWheif8w85B4=
X-Received: by 2002:adf:b193:: with SMTP id q19mr38971914wra.78.1576612005333;
 Tue, 17 Dec 2019 11:46:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576583819.git.liu.denton@gmail.com> <3d36511d5d95d2a2713b3cc8e2138b689d381c79.1576583819.git.liu.denton@gmail.com>
In-Reply-To: <3d36511d5d95d2a2713b3cc8e2138b689d381c79.1576583819.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Dec 2019 14:46:34 -0500
Message-ID: <CAPig+cSsJW3=3cYyFzwr2Lf0AcH+XUyrXMkHBGtNa4a5Smfp6w@mail.gmail.com>
Subject: Re: [PATCH 14/15] t1501: remove use of `test_might_fail cp`
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 17, 2019 at 7:02 AM Denton Liu <liu.denton@gmail.com> wrote:
> The test_must_fail() family of functions (including test_might_fail())
> should only be used on git commands. Replace test_might_fail() with
> test_non_git_might_fail().
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
> @@ -350,7 +350,7 @@ test_expect_success 'Multi-worktree setup' '
>         cp repo.git/HEAD repo.git/index repo.git/repos/foo &&
> -       test_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&
> +       test_non_git_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&

Can you update the commit message to show that this change is indeed
the correct choice so that readers of this patch don't have to go
through the same investigative reasoning process you went through to
convince yourself that it is correct. In other words, why was
test_might_fail() used in the first place? Is it because there might
not be a sharedindex.* file? Or is it because repo.git/repos/foo might
not be writable? Or what? The answer to these questions should explain
to the reader, for instance, why you chose to use
`test_non_git_might_fail cp ...` as opposed to a simple `cp -f ...`.
