Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF96C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 16:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B19F206F9
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 16:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="hwf9q6D4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415316AbgDOQN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415283AbgDOQN1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 12:13:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D97C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 09:13:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k15so175946pfh.6
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 09:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=STVmo3PNIjx7ntYMjMbkAqwL12uHoA2/KqaNoSMhG9o=;
        b=hwf9q6D4cTWcfMXLwmQGpToaMw6aLI9ND3iuJJcVvYVZjuvofrZZtiNM4sR4jj50fY
         DvrDwkJl/JbXbGD9obfQnyXUPmpq5ZBTFz6sw00NeASKNCPg1z6gCQrNwohmFW0N6B9y
         yRoTNlFdkE0iYzh5dTnElqhPue+JCfMUI8dvl0+iic8xiGs/RiPwI8sE2b3IPTn/WUr/
         Dcl6zoxMA5SmUPVz8bUsDO4gakH1h7JMdl1iuigksvKHWLudtHKqssIUR1Cm+sLY1LEx
         tntkaYKZ/e4fCAt+Vwc3Q8FnQpbrdfBmG71BKhVBPUkFGcrloJ8LM+JmjQmzPvr2MYo9
         EbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=STVmo3PNIjx7ntYMjMbkAqwL12uHoA2/KqaNoSMhG9o=;
        b=pjHEbbYt8CR0qKRpd/uuW6T7xpl21Y9NsUn5lFDy+Zm3gSsizJVGwasNuQNWZ3OVVu
         CnkNM3BJN07G0DIYy9SFX1qJnaBVN/aFWbinURWRBy8KphjUDrBIgSnaXC3bGLuNJqIm
         QQ81emOrKAepX+8vR9m1x2VFIYrJI5flVDOac0CiARI2/Ked2/7kCm1JH/UTUH3sfi9i
         2cslfgkbnrN5RcKLt8muO83V9k7rCzFGQJxdahzT089BPKEfGdUgb75b3al9sCrydiUX
         WdpCNK20K2YeHEi7Zg2Yhl77Ab8JVqMLYKksOIS+OBs+jeM/x5Ewo9X0yNb2roK0wbIy
         +KSA==
X-Gm-Message-State: AGi0PuYbNdjQ6kI8H1oCzV0N4GAFZdMh/4uPe4z4ufilVqrHrlpUTut1
        XbnIA6Br1ozxFxKTiLV9qkHe9Q==
X-Google-Smtp-Source: APiQypLmsfYUF6pWFvnDOXjW0J0NcwUHgBLsxDrTRTqJLpcxflMRD9OIidL05MRMqiF8F+vB2B/5Tg==
X-Received: by 2002:a62:3147:: with SMTP id x68mr28431405pfx.62.1586967206300;
        Wed, 15 Apr 2020 09:13:26 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 36sm13091677pgs.70.2020.04.15.09.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 09:13:25 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:13:24 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Vasil Dimov via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Vasil Dimov <vd@freebsd.org>
Subject: Re: [PATCH 1/2] range-diff: fix a crash in parsing git-log output
Message-ID: <20200415161324.GC22823@syl.local>
References: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
 <2375e34100e571f9c3ce658d28aba6648fba18a6.1586960921.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2375e34100e571f9c3ce658d28aba6648fba18a6.1586960921.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vasil,

Nice find. I have a question below:

On Wed, Apr 15, 2020 at 02:28:40PM +0000, Vasil Dimov via GitGitGadget wrote:
> From: Vasil Dimov <vd@FreeBSD.org>
>
> `git range-diff` calls `git log` internally and tries to parse its
> output. But `git log` output can be customized by the user in their
> git config and for certain configurations either an error will be
> returned by `git range-diff` or it will crash.
>
> To fix this explicitly set the output format of the internally
> executed `git log` with `--pretty=medium`. Because that cancels
> `--notes`, add explicitly `--notes` at the end.
>
> Also, make sure we never crash in the same way - trying to dereference
> `util` which was never created and has remained NULL. It would happen
> if the first line of `git log` output does not begin with 'commit '.
>
> Alternative considered but discarded - somehow disable all git configs
> and behave as if no config is present in the internally executed
> `git log`, but that does not seem to be possible. GIT_CONFIG_NOSYSTEM
> is the closest to it, but even with that we would still read
> `.git/config`.

I don't know of a great way to do this off-hand. Perhaps an internal
`--for-range-diff` option that ignores options that are incompatible
with range-diff's own parsing seems like an OK path forward to me.

Here, internal means that it's not part of the manual page. We can pass
'PARSE_OPT_NONEG' to make sure that a caller can't later overwrite it by
passing '--no-for-range-diff'.

> Signed-off-by: Vasil Dimov <vd@FreeBSD.org>
> ---
>  range-diff.c          | 13 +++++++++++++
>  t/t3206-range-diff.sh | 10 ++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/range-diff.c b/range-diff.c
> index f745567cf67..5cc920be391 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -63,6 +63,8 @@ static int read_patches(const char *range, struct string_list *list,
>  			"--output-indicator-old=<",
>  			"--output-indicator-context=#",
>  			"--no-abbrev-commit",
> +			"--pretty=medium",
> +			"--notes",
>  			NULL);
>  	if (other_arg)
>  		argv_array_pushv(&cp.args, other_arg->argv);
> @@ -106,6 +108,17 @@ static int read_patches(const char *range, struct string_list *list,
>  			continue;
>  		}
>
> +		if (!util) {
> +			error(_("could not parse first line of `log` output: "
> +				"did not start with 'commit ': '%s'"),
> +			      line);
> +			string_list_clear(list, 1);
> +			strbuf_release(&buf);
> +			strbuf_release(&contents);
> +			finish_command(&cp);
> +			return -1;
> +		}
> +
>  		if (starts_with(line, "diff --git")) {
>  			struct patch patch = { 0 };
>  			struct strbuf root = STRBUF_INIT;
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index bd808f87ed5..e024cff65cb 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -513,6 +513,16 @@ test_expect_success 'range-diff overrides diff.noprefix internally' '
>  	git -c diff.noprefix=true range-diff HEAD^...
>  '
>
> +test_expect_success 'basic with modified format.pretty with suffix' '
> +	git -c format.pretty="format:commit %H%d%n" range-diff \
> +		master..topic master..unmodified
> +'
> +
> +test_expect_success 'basic with modified format.pretty without "commit "' '
> +	git -c format.pretty="format:%H%n" range-diff \
> +		master..topic master..unmodified
> +'
> +
>  test_expect_success 'range-diff compares notes by default' '
>  	git notes add -m "topic note" topic &&
>  	git notes add -m "unmodified note" unmodified &&
> --
> gitgitgadget

Otherwise what you have here does look good to me, too. I'm just not
sure that there aren't other ways that a caller could circumvent placing
'--notes --pretty=medium' at the end, anyway.

Thanks,
Taylor
