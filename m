Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6937DC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E12A321973
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="A3ZC5055"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgIROg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 10:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIROg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 10:36:56 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33628C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:36:56 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 16so6269424qkf.4
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pk6/dI/MUxuq5eH6MclWtOA4DcRJCd3Cz8s311buC1w=;
        b=A3ZC5055LOFU4jtDlIQrxLg1pxtH4tSF9KiMBq7gUVSrS14lgzCO2G4NsNC8hiysSn
         ant7//QiB9UADAmmdCvXX3UNKH3eOd9LnYdhlSkGLIn0QzuNZwv2uQJpiNf/r+i5Vnnu
         c0ShScBd/3DXjz+ChA3zFYgWhjG+GrasWxMZPXFcvtCNC/0lJ/DiWXTDAkEwcK+VhuO6
         1jB/zDFGO8ZPAgz+qZqzyVQdvtp2HIW4f12TIG/IM6VitHYkeDu7tIiR1HXQLwMu3FIN
         SidXEgKTEp6LDfFFg9a3qSr9PMhYhBKM0Cj67mN/GjOwYHtMpA64qC0qmJ8PcBz9DHp8
         eMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pk6/dI/MUxuq5eH6MclWtOA4DcRJCd3Cz8s311buC1w=;
        b=dgn9ODMvmjddJ6GhVtvksjFK41Tts/ebF++yEHZTxSVVWSm9oIKjX0KNJblIuuKVsK
         v+S+44jTNZlHUA0BOn3Pc0M4FTyAK3IUzENEcm8EEwo+LztGgxOWUYs1aq4GME40lUs2
         REOUgqQNDn1u44tAuwhZqjo4euGowiPFdD9FNEm1LQXVz0y6RwEzq32pbga38REdr1Wz
         ZLRAPmvK8Fu2c3NU04XSgRaMKw4Dascvm119TdtpIOcNU/n8GrH2DCDXmT7lS0F1jcXJ
         Df17lVe5DPJcnlWeIsYaHs5EziTWOiwkvwUIkLAo4L5ITJZRDJpVbVWgXW3uw4qI5tB3
         0wCw==
X-Gm-Message-State: AOAM531++AF4fVuBWYCSNTgYIQZre9rUEXy3Gmw264JQiEbRtz3vc119
        INaejsFpu//plnHu5haMhYhGD9TNZmNTghoCkfs=
X-Google-Smtp-Source: ABdhPJzQzSXRYnHKjGRDGnRmpNZyaToW3N51qeic9qRwIKbE9FD7eYP9s+YxpaP22X2zFevqK4rBIw==
X-Received: by 2002:a37:e94:: with SMTP id 142mr33784017qko.351.1600439812364;
        Fri, 18 Sep 2020 07:36:52 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id m10sm2296816qti.46.2020.09.18.07.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 07:36:51 -0700 (PDT)
Date:   Fri, 18 Sep 2020 10:36:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Thomas Guyot-Sionnest <tguyot@gmail.com>
Cc:     git@vger.kernel.org, dermoth@aei.ca
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff
 --no-index
Message-ID: <20200918143647.GB1606445@nand.local>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-3-tguyot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918113256.8699-3-tguyot@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Fri, Sep 18, 2020 at 07:32:56AM -0400, Thomas Guyot-Sionnest wrote:
> A very handy way to pass data to applications is to use the <() process
> substitution syntax in bash variants. It allow comparing files streamed
> from a remote server or doing on-the-fly stream processing to alter the
> diff. These are usually implemented as a symlink that points to a bogus
> name (ex "pipe:[209326419]") but opens as a pipe.

This is true in bash, but sh does not support process substitution with
<().

> Git normally tracks symlinks targets. This patch makes it detect such
> pipes in --no-index mode and read the file normally like it would do for
> stdin ("-"), so they can be compared directly.
>
> Signed-off-by: Thomas Guyot-Sionnest <tguyot@gmail.com>
> ---
>  diff-no-index.c          |  56 ++++++++++--
>  t/t4053-diff-no-index.sh | 189 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 238 insertions(+), 7 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 7814eabfe0..779c686d23 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -41,6 +41,33 @@ static int read_directory_contents(const char *path, struct string_list *list)
>   */
>  static const char file_from_standard_input[] = "-";
>
> +/* Check that file is - (STDIN) or unnamed pipe - explicitly
> + * avoid on-disk named pipes which could block
> + */
> +static int ispipe(const char *name)
> +{
> +	struct stat st;
> +
> +	if (name == file_from_standard_input)
> +		return 1;  /* STDIN */
> +
> +	if (!lstat(name, &st)) {
> +		if (S_ISLNK(st.st_mode)) {

I had to read this a few times to make sure that I got it; you want to
stat the link itself, and then check that it links to a pipe.

I'm not sure why, though. Do you want to avoid handling named FIFOs in
the code below? Your comment that they "could block" makes me think you
do, but I don't know why that would be a problem.

> +			/* symlink - read it and check it doesn't exists
> +			 * as a file yet link to a pipe */
> +			struct strbuf sb = STRBUF_INIT;
> +			strbuf_realpath(&sb, name, 0);
> +			/* We're abusing strbuf_realpath here, it may append
> +			 * pipe:[NNNNNNNNN] to an abs path */
> +			if (!stat(sb.buf, &st))

Statting sb.buf is confusing to me (especially when followed up by
another stat right below. Could you explain?

> +test_expect_success 'diff --no-index can diff piped subshells' '
> +	echo 1 >non/git/c &&
> +	test_expect_code 0 git diff --no-index non/git/b <(cat non/git/c) &&
> +	test_expect_code 0 git diff --no-index <(cat non/git/b) non/git/c &&
> +	test_expect_code 0 git diff --no-index <(cat non/git/b) <(cat non/git/c) &&
> +	test_expect_code 0 cat non/git/b | git diff --no-index - non/git/c &&
> +	test_expect_code 0 cat non/git/c | git diff --no-index non/git/b - &&
> +	test_expect_code 0 cat non/git/b | git diff --no-index - <(cat non/git/c) &&
> +	test_expect_code 0 cat non/git/c | git diff --no-index <(cat non/git/b) -
> +'

Indeed this test fails (Git thinks that the HERE-DOC is broken, but I
suspect it's just getting confused by the '<()'). This test (like almost
all other tests in Git) use /bin/sh as its shebang. Does your /bin/sh
actually point to bash?

If you did want to test something like this, you'd need to source
t/lib-bash.sh instead of t/test-lib.sh.

Unrelated to the above comment, but there are a few small style nits
that I notice:

  - There is no need to run with 'test_expect_code 0' since the test is
    marked as 'test_expect_success' and the commands are all in an '&&'
    chain. (This does appear to be common style for others in t4053, so
    you may just be matching it--which is fine--but an additional
    clean-up on top to modernize would be appreciated, too).

  - The cat pipe is unnecessary, and is also violating a rule that we
    don't place 'git' on the right-hand side of a pipe (can you redirect
    the file at the end instead?).

Documentation/CodingGuidelines is a great place to look if you are ever
curious about whether something is in good style.

> +test_expect_success 'diff --no-index finds diff in piped subshells' '
> +	(
> +		set -- <(cat /dev/null) <(cat /dev/null)

Why is this necessary?

> +		cat <<-EOF >expect
> +			diff --git a$1 b$2
> +			--- a$1
> +			+++ b$2
> +			@@ -1 +1 @@
> +			-1
> +			+2
> +		EOF
> +	) &&
> +	test_expect_code 1 \
> +		git diff --no-index <(cat non/git/b) <(sed s/1/2/ non/git/c) >actual &&
> +	test_cmp expect actual
> +'

Thanks,
Taylor
