Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4052AC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 13:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A4120674
	for <git@archiver.kernel.org>; Mon, 18 May 2020 13:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETF//zXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgERN5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 09:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgERN47 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 09:56:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7676CC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 06:56:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n18so4977709pfa.2
        for <git@vger.kernel.org>; Mon, 18 May 2020 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FM5jyNl41r5TL0rMEdwR66rhVuVpaSdYXAM1UG07Rbw=;
        b=ETF//zXhhsgfXGld2cZsbbZu80w0AFXZBZbnru4pEDg3GyZRa5Yjya5SYbu6IJ1IMj
         faubwCfHoeB4lmZTQZJGaScGF0VQDEq7IITq2WJfRh7pS5Vi8l2ny5DpAwwegv7APPWP
         BcevjNSQcqG/m9bsuNfEaQaoYZpZHPogu+P+JbbHmelS4Ydh9Tm1belw0LI1W9luEvLv
         qQeeLuSsGvQuO2+/2GbnvYdVKP6njDmee5WXM7+XFd+Pbg08kCVCDjceNEjRn/va6qGT
         0xjKrVoQ3XdVTh2fuz/WTUdIP0p9KIwEdRQNZd6wTpmaf7lNCjILDuCHuZR1eoEPFvD5
         0Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FM5jyNl41r5TL0rMEdwR66rhVuVpaSdYXAM1UG07Rbw=;
        b=LR39//o0+hxXdY+YOdq9bdiMwc4iMQr4FNR4g1/VUE9pCGkBcaAwCwIea30ioDxovX
         Df4AkCC+GhiQDGV+dqyM5No96bE5wbKZ05hlnC0kcrLk19zXJ71+IPnm/cFTUGPob+4Y
         uuk4VsX0w6sPo6jmb4XqsRvmCbYPwoD9O4rFPKU2BRaaC21fitq8H2B2V4e+p7Ys6ohx
         4/Nlj2wqym7KVwu/GjOv3OE/SSo1yp9dYo2hBd/fhQwOd+HUeQFzdofeq/n8BkGHZHoy
         MCe/dv8EsS5maDDjNr9KMozfhAa7/1A87lPiCpdzU7m7nXZJvlENGU4NDfO/dQtzfQ7i
         Ml9w==
X-Gm-Message-State: AOAM531ajoIsAt5h7WeLA/dFzVTAZgCUemXwV+cX6q69kYFr6rkPGlBe
        2YV3/Kg4VZBy4qDhvK52cZk=
X-Google-Smtp-Source: ABdhPJx0NY9+T7Desy+MGUN556l5bOxxLUiUg7XY9wBu5z+roEji5RIPog3mEeeGmg8SwbMgp24imA==
X-Received: by 2002:a63:9556:: with SMTP id t22mr14086870pgn.83.1589810219031;
        Mon, 18 May 2020 06:56:59 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id q189sm9022616pfc.112.2020.05.18.06.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:56:58 -0700 (PDT)
Date:   Mon, 18 May 2020 20:56:56 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Laurent Arnoud <laurent@spkdev.net>
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v5] diff: add config option relative
Message-ID: <20200518135656.GB1980@danh.dev>
References: <20200515155706.GA1165062@spk-laptop>
 <20200515233130.GC6362@camp.crustytoothpaste.net>
 <xmqq1rnk923o.fsf@gitster.c.googlers.com>
 <20200516173828.GB34961@spk-laptop>
 <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
 <20200516194033.GA2252@spk-laptop>
 <20200517021452.GA2114@danh.dev>
 <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
 <20200518094021.GA2069@spk-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518094021.GA2069@spk-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Laurent,

On 2020-05-18 11:40:21+0200, Laurent Arnoud <laurent@spkdev.net> wrote:
> The `diff.relative` boolean option set to `true` show only changes on
> the current directory and show relative pathnames to the current
> directory.
> 
> Teach --no-relative to override earlier --relative
> 
> Signed-off-by: Laurent Arnoud <laurent@spkdev.net>

Thanks for addressing my comment.

Sorry for detecting this late.
Since I usually only look into end of mail-archive to see any
interesting topic.

And sorry for this late email,
I want to run full test before replying with this.

I've just seen this:
https://lore.kernel.org/git/xmqq1rnk923o.fsf@gitster.c.googlers.com/

I've written some test and concluded that we'll need this fix-up
to make sure git-format-patch(1) doesn't generate broken patch:

----------------8<----------------
 builtin/log.c            |  1 +
 t/t4045-diff-relative.sh | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d104d5c688..5949a4883e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1744,6 +1744,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.max_parents = 1;
 	rev.diffopt.flags.recursive = 1;
+	rev.diffopt.flags.relative_name = 0;
 	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index ac264ccc2a..a73b104d66 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -11,7 +11,8 @@ test_expect_success 'setup' '
 	blob_file1=$(git hash-object file1) &&
 	blob_file2=$(git hash-object subdir/file2) &&
 	git add . &&
-	git commit -m one
+	git commit -m one &&
+	git format-patch -1 --stdout >expect.patch
 '
 
 check_diff () {
@@ -107,7 +108,9 @@ check_diff_relative_option () {
 	test_expect_success "config diff.relative $relative_opt -p $*" "
 		test_config -C $dir diff.relative $relative_opt &&
 		git -C '$dir' diff -p $* HEAD^ >actual &&
-		test_cmp expected actual
+		test_cmp expected actual &&
+		git -C '$dir' format-patch -1 --stdout >actual.patch &&
+		test_cmp expect.patch actual.patch
 	"
 }
 
@@ -140,7 +143,9 @@ check_diff_no_relative_option () {
 		test_config -C $dir diff.relative $relative_opt &&
 		git -C '$dir' diff -p $* HEAD^ >actual &&
 		git -C '$dir' diff -p $* HEAD^ >/tmp/actual &&
-		test_cmp expected actual
+		test_cmp expected actual &&
+		git -C '$dir' format-patch -1 --stdout >actual.patch &&
+		test_cmp expect.patch actual.patch
 	"
 }
--------------------8<------------------------- 
> @@ -4558,6 +4563,8 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
>  		options->b_prefix = "b/";
>  	}
> 
> +	options->flags.relative_name = diff_relative;
> +

Nitpick:

I don't think this option is too special to add a newline to separate
it from the rest :)

Sorry about not seeing this earlier, I'm a very careless person.

Anyway, I think (just a matter of my _personal_ preference),
it's better to move it up 21 lines, together with:

	options->flags.rename_empty = 1;

> diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
> index 258808708e..ac264ccc2a 100755
> --- a/t/t4045-diff-relative.sh
> +++ b/t/t4045-diff-relative.sh
> @@ -8,7 +8,8 @@ test_expect_success 'setup' '
>  	echo content >file1 &&
>  	mkdir subdir &&
>  	echo other content >subdir/file2 &&
> -	blob=$(git hash-object subdir/file2) &&
> +	blob_file1=$(git hash-object file1) &&
> +	blob_file2=$(git hash-object subdir/file2) &&

This rename from blob to blob_file2 is a noise to this patch.
Not sure if we should make a preparatory patch to rename, though.

*I* would say yes, and another patch to move all git-related code
into test_expect_* family. Then, all new testing code for git in this
patch should be placed inside test_expect_*, too.

I think it's better to wait for other's opinions :)

> @@ -86,4 +87,80 @@ do
>  	check_$type . dir/file2 --relative=sub
>  done
> 
> +	diff --git a/$expect b/$expect
> +	new file mode 100644
> +	index 0000000..$short_blob_file2
> +	--- /dev/null
> +	+++ b/$expect
> +	@@ -0,0 +1 @@
> +	+other content
> +	EOF
> +	test_expect_success "config diff.relative $relative_opt -p $*" "
> +		test_config -C $dir diff.relative $relative_opt &&
> +		git -C '$dir' diff -p $* HEAD^ >actual &&
> +		git -C '$dir' diff -p $* HEAD^ >/tmp/actual &&

Please this leftover from debugging.

-- 
Danh
