Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E226C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326E3610F9
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbhIMTge (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbhIMTgd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:36:33 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC031C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:35:16 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id j18so13641519ioj.8
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QThOC7t0Zv6adfGs1KlBi/ctYAi5ffHtrzf+xJhoQSg=;
        b=Cn00TYMi+jF22Dgiyhr0abcKbybzJd7ndYH+cHj9Yrd3eUny/MSUI+cAIzINOGljEO
         /nJaTOJiTfLn1Wj9Sk/rl6O2JrhfBmR3NNXhYJcwwwoEi75DQK8MARwqM+AqUh3i5SwB
         8Pe+VKDbay4Fef133wSt+5hBnux9MCQk2lh4jxTKTuyqWGWqsQXLTME4FgMl5K5hjRlX
         D2xP8baA9+jvtf5g2YzRkEnbuktqst5s8Hk1T5rYniqYTTlT2q/lvAg0s2OmsPNUgVu3
         rBgdziSy8i8FxvOMHCYU7gf9da/CV2GhVh4uNXF4wuuygm6qsQZ5n6ZmSWvHZkZryOYy
         y1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QThOC7t0Zv6adfGs1KlBi/ctYAi5ffHtrzf+xJhoQSg=;
        b=PF7Czu6IvWBXTTLZKYHqGWztan8z0ZJUXML/M7JhwnfV/XqlSypxZFk1wCGbra+Z9t
         2LzglXxQTI5717CIiRKKlfPO2dcS1qa+LJtRl9Z+Mu9gOXGbqIRLAzAMjVuWFXED4z6a
         Ry/ogivQzzCPhRWenvQThcOuxV6Slk2xquPUJVQuy9lXetthyYrd58sQcB+oh/SPU9l+
         Ezw1g9xhygtTSV+7HNwirFzIpjyc42r20Lp+uQoNCl21GBMRrklFvMCbv9zo9IVElQN7
         hu2CvxTqpGlTKhDR8xppl9+dEzMLJP2Pd31kNqt3izGjv5hXQTZANU34v5BVNoIzpaby
         PovA==
X-Gm-Message-State: AOAM531wxfIEGXJjhGpIGC3SibsToun6WWKglXPqHbB/IIkvdd2vvYei
        +/kLSAn+zqGs/oqnNHCy8LKhMqo7v5bYp4m+
X-Google-Smtp-Source: ABdhPJzt8GVuehEWOIVq1cN5iWoaY414WR32ucJ2Z2L8/gUGyrh+3W8R3jFhw1zJeRTcPeTtSwslJQ==
X-Received: by 2002:a05:6602:117:: with SMTP id s23mr10470622iot.124.1631561716332;
        Mon, 13 Sep 2021 12:35:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d14sm5385941iod.18.2021.09.13.12.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:35:16 -0700 (PDT)
Date:   Mon, 13 Sep 2021 15:35:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Subject: Re: [PATCH 2/3] fsck: verify multi-pack-index when implictly enabled
Message-ID: <YT+n81yGPYEiMXwQ@nand.local>
References: <20210913181221.42635-1-chooglen@google.com>
 <20210913181221.42635-3-chooglen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913181221.42635-3-chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 11:12:20AM -0700, Glen Choo wrote:
> Like the previous commit, the_repository->settings.core_multi_pack_index
> is preferable to reading "core.multiPackIndex" from the config because
> prepare_repo_settings() sets a default value for
> the_repository->settings.

My same suggestion about referencing the first commit for which this
would have been broken applies here, too. In this case, that'd be
18e449f86b (midx: enable core.multiPackIndex by default, 2020-09-25).

> Replace git_config_get_bool("core.multiPackIndex") in fsck with the
> equivalent call to the_repository->settings.multi_pack_index.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  builtin/fsck.c              |  2 +-
>  t/t5319-multi-pack-index.sh | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 1c4e485b66..5bbe8068ec 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -925,7 +925,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>
> -	if (!git_config_get_bool("core.multipackindex", &i) && i) {
> +	if (the_repository->settings.core_multi_pack_index) {
>  		struct child_process midx_verify = CHILD_PROCESS_INIT;
>  		const char *midx_argv[] = { "multi-pack-index", "verify", NULL, NULL, NULL };

Good.

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 3d4d9f10c3..1a17446cf0 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -404,12 +404,25 @@ test_expect_success 'verify incorrect offset' '
>  		"incorrect object offset"
>  '
>
> -test_expect_success 'git-fsck incorrect offset' '
> +test_expect_success 'git-fsck incorrect offset (config set to true)' '
>  	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
>  		"incorrect object offset" \
>  		"git -c core.multipackindex=true fsck"
>  '
>
> +test_expect_success 'git-fsck incorrect offset (config set to false)' '
> +	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
> +		"incorrect object offset" \
> +		"git -c core.multipackindex=true fsck" &&
> +		git -c core.multipackindex=false fsck
> +'

This test is a little awkward, since it looks like the first command is
the same as the previous test (making it unnecessary). But it turns out
that it *is* necessary, since it sets up the corrupt MIDX (which is
thrown away at the end of each test).

So I would suggest one of two things:

  - Either replace this with a more flexible version of
    corrupt_midx_and_verify that allows the enclosing test to pass. Note
    that this may be awkward, since the whole point is that we want to
    notice the corruption in the first place.

  - Or, (more favorably) combine this all into a single test, like so:

        corrupt_midx_and_verify "$MIDX_BYTE_OFFSET" "\377" $objdir \
          "incorrect object offset" \
          "git fsck" &&
        test_must_fail git -c core.multiPackIndex=true fsck &&
        git -c core.multiPackIndex=false fsck

Which does all of the setup for the three tests at once, and then
specifies each behavior individually.

Thanks,
Taylor
