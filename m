Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC81C433DF
	for <git@archiver.kernel.org>; Sun, 17 May 2020 02:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C7A207C3
	for <git@archiver.kernel.org>; Sun, 17 May 2020 02:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGd448He"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgEQCO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 22:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbgEQCOz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 May 2020 22:14:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0E2C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 19:14:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ms17so3006280pjb.0
        for <git@vger.kernel.org>; Sat, 16 May 2020 19:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YgCEecqZ4hbEOXajQcyYbLf4tSuSbmg00XMCFMTh5+Q=;
        b=uGd448Hes1dR4kO1OCi1iDOtOPSKVPHhrMW8LTQi+N2BuhKKcxrgj7XG5JkmXj208Y
         FhA2/28MkdGUtn93uieJUqSfVO9zndGZQ8KIPYfY/5s9TXlXKLyEA4P+9Dpj73Ad8/C1
         WEFrFBU33XKOmf/I260s8IX51Fg0rI6Adbu/Pe07P45vGalRTQz5i7/Z84D81jP5LbIW
         VHWU44dicBJkICNj55S5mFnO/HxpweJpZs3vuj54/eoyNCCiY1uuI8LiwUHqI5KeijYu
         7VPV+hYLZqfipxWPHuhv6KEXrgLqyE8qOhqEeOjxvyFgpzuiNI0ANrrPWp4RxYslYLB4
         Zulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YgCEecqZ4hbEOXajQcyYbLf4tSuSbmg00XMCFMTh5+Q=;
        b=qXKQM2Y058p1dnU9GN2+lbEJuhiIuKP+5KUpOm/LS8o2SqeyGwsU8ok8u+igejXHga
         /iNBewnxjhFCw2/dvAzC2anuN/03sR20Go5gxwL8htnK71u/ZegiUjqVethBJBFDBFJQ
         WRtskqxjmyq/JehygG9I5p4MsLpIn+/IQ1UMTEE9wvZAcV+STQbi1xXMhTe7GVdoeQy2
         RbrlGW4GY8LFsPY3Rq32/2sroUJR+3dOsPXQJ8ZxH/F7MyxAGn7FQAyotsyAqjKiHQEU
         HJurFwsqdjZ/7jWwm9cZU3BGSybDVcB6qujhah1IgMatc//jEe61no2wA/7BRurSFBg+
         EF1A==
X-Gm-Message-State: AOAM533k7eAKmQu9xLjYc3vOy4qE4Uk18hOYNodLdsQAKWzTbEAhGlWu
        M07zgfVXrHi/bmjFQFDc5Pg=
X-Google-Smtp-Source: ABdhPJwv2N8jSvZSgOqj+na9SEzcV76aKfBS8GSzs4daOxnhk2P1yxApENVFYMCBU9jC//pieQRG8Q==
X-Received: by 2002:a17:902:348:: with SMTP id 66mr5384605pld.267.1589681695103;
        Sat, 16 May 2020 19:14:55 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id g43sm4921500pje.22.2020.05.16.19.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:14:54 -0700 (PDT)
Date:   Sun, 17 May 2020 09:14:52 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Laurent Arnoud <laurent@spkdev.net>
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v4] diff: add config option relative
Message-ID: <20200517021452.GA2114@danh.dev>
References: <20200515155706.GA1165062@spk-laptop>
 <20200515233130.GC6362@camp.crustytoothpaste.net>
 <xmqq1rnk923o.fsf@gitster.c.googlers.com>
 <20200516173828.GB34961@spk-laptop>
 <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
 <20200516194033.GA2252@spk-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516194033.GA2252@spk-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Laurent,

On 2020-05-16 21:40:33+0200, Laurent Arnoud <laurent@spkdev.net> wrote:
> Subject: Re: [PATCH v4] diff: add config option relative

I think the subject should be changed to.

	diff: allow overriding --relative

> The `diff.relative` boolean option set to `true` show only changes on
> the current directory and show relative pathnames to the current
> directory.
> 
> Teach --no-relative to override earlier --relative
> 
> Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
> ---
>  Documentation/config/diff.txt   |  4 ++
>  Documentation/diff-options.txt  |  3 ++
>  diff.c                          | 16 ++++--
>  t/t9904-diff-relative-config.sh | 93 +++++++++++++++++++++++++++++++++

I think t99?? is used for miscellaneous tests.

To me, diff-relative things should be tested in t4045-diff-relative.sh

>  4 files changed, 113 insertions(+), 3 deletions(-)
>  create mode 100755 t/t9904-diff-relative-config.sh
> 
> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
> index ff09f1cf73..76537c3b0c 100644
> --- a/Documentation/config/diff.txt
> +++ b/Documentation/config/diff.txt
> @@ -105,6 +105,10 @@ diff.mnemonicPrefix::
>  diff.noprefix::
>  	If set, 'git diff' does not show any source or destination prefix.
> 
> +diff.relative::
> +	If set to "true", 'git diff' does not show changes outside of the directory

I think it's better to change "true" to either:
'true' (generated to <em>true</em>, or
`true` generated to <code>true<code>

Not sure which one is prefered, though.
This file uses both 2 styles.

I _think_ `true` is preferred.

> +	and show pathnames relative to the current directory.
> +
>  diff.orderFile::
>  	File indicating how to order files within a diff.
>  	See the '-O' option to linkgit:git-diff[1] for details.
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index bb31f0c42b..1b279904eb 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -651,6 +651,9 @@ ifndef::git-format-patch[]
>  	not in a subdirectory (e.g. in a bare repository), you
>  	can name which subdirectory to make the output relative
>  	to by giving a <path> as an argument.
> +--no-relative::

Please merge this option with `--relative[=<path>]` above.
And says something likes:

	`--no-relative` can be used to countermand
	both `diff.relative` and previous `--relative`

> @@ -5195,8 +5202,11 @@ static int diff_opt_relative(const struct option *opt,
>  {
>  	struct diff_options *options = opt->value;
> 
> -	BUG_ON_OPT_NEG(unset);
> -	options->flags.relative_name = 1;
> +	if (unset) {
> +		options->flags.relative_name = 0;
> +	} else {
> +		options->flags.relative_name = 1;
> +	}

Can this block be simplified as:

	options->flags.relative_name = !unset;

> +check_diff_relative () {
> +	dir=$1
> +	shift
> +	expect=$1
> +	shift
> +	relative_opt=$1
> +	shift
> +	short_blob=$(git rev-parse --short "$(git hash-object subdir/file2)")

I think current practice want to have git hash-object as separated.
And all git-related code moved inside test_expect*

diff --git a/t/t9904-diff-relative-config.sh b/t/t9904-diff-relative-config.sh
index 23ab1af5e0..4747647917 100755
--- a/t/t9904-diff-relative-config.sh
+++ b/t/t9904-diff-relative-config.sh
@@ -20,17 +20,18 @@ check_diff_relative () {
 	shift
 	relative_opt=$1
 	shift
-	short_blob=$(git rev-parse --short "$(git hash-object subdir/file2)")
-	cat >expected <<-EOF
-	diff --git a/$expect b/$expect
-	new file mode 100644
-	index 0000000..$short_blob
-	--- /dev/null
-	+++ b/$expect
-	@@ -0,0 +1 @@
-	+other content
-	EOF
-	test_expect_success "config.relative $relative_opt -p $*" "
+	test_expect_success "config.relative $relative_opt -p $* in $dir" "
+		hash=\$(git hash-object subdir/file2) &&
+		short_blob=\$(git rev-parse --short \$hash) &&
+		cat >expected <<-EOF &&
+		diff --git a/$expect b/$expect
+		new file mode 100644
+		index 0000000..\$short_blob
+		--- /dev/null
+		+++ b/$expect
+		@@ -0,0 +1 @@
+		+other content
+		EOF
 		test_config -C $dir diff.relative $relative_opt &&
 		git -C '$dir' diff -p $* HEAD^ >actual &&
 		test_cmp expected actual

> +	short_blob_file1=$(git rev-parse --short "$(git hash-object file1)")
> +	short_blob_file2=$(git rev-parse --short "$(git hash-object subdir/file2)")
> +	cat >expected <<-EOF
> +	diff --git a/file1 b/file1
> +	new file mode 100644
> +	index 0000000..$short_blob_file1
> +	--- /dev/null
> +	+++ b/file1
> +	@@ -0,0 +1 @@
> +	+content
> +	diff --git a/$expect b/$expect
> +	new file mode 100644
> +	index 0000000..$short_blob_file2
> +	--- /dev/null
> +	+++ b/$expect
> +	@@ -0,0 +1 @@
> +	+other content
> +	EOF
> +	cat expected

Above comment also applied here.
And remove this debug cat.

-- 
Danh
