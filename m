Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0F0C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2162522208
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8ualrTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgIKTYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgIKTYT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 15:24:19 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E74FC061757
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 12:24:18 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so8736054qtv.12
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1MeqGkMRyF0U2/UGKwovFaH4vCrcKLyPDkt9f+Ol+FY=;
        b=n8ualrTj5qEoyNVUpzqnkM5V1Dk2KD/O8RRRw7BTy2VoPiXXPOp5AGnaSrF7aIsZJY
         ejMZs86v17zuj+SvxkPgi2HKSJ9eKQbEhwPwlsccNl2zVcY06oaq9Fh5bJRw7r65Ofyw
         VrO/S76QBbIxsXm8Edn01rcLqKTB+1to5q8A75uuY4FvKEVmJ8rBZMARkRYHqPQEiV0w
         kpc4hI3NJi/2JHTDC6DYJE6OnNDPxIMMxRWPCUFxFEL5Fudv60gW8oFkyCUrZPL7SP1x
         aKkVEfIPZ3LSziiEImO2Qa/r/ttgjmURlqij90OfwirHGAs53D+rwqlS1h9yUFBH7pzn
         2vSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1MeqGkMRyF0U2/UGKwovFaH4vCrcKLyPDkt9f+Ol+FY=;
        b=YV321rohoAW67WYYkpu9BPFjDy9h/EWb8P1WPZw6wxvkhMybTt8r+1lge5mnkudwZf
         oPWf2u//P592N987Q8o49JnlT0UF7xF9K8kcf2LryZmjzkZMC5lclspwsDwRa1de/jBe
         +5+16l14WEYiyj1y8vzU9fUB54qLRTUUK1G1rqSKMkofKvW1ywHhhoQ5CRbtvn6YqmOy
         SkMDueZ7otXrTLpEL3jfnGjBoJWJPH9zaTpnbMtA/VIokiQXQcyH83SSW3T32LGUevJL
         o/IPJMSSzdGXHH5n8gqQnVbxILBvDVuPyk+l3qXT8pWUUlXWOExfe5HgvZKPGsmkARZs
         M01Q==
X-Gm-Message-State: AOAM533F4bzZl5k51qCcSiVgE01KnvddJLbotEQLGkqJbMdisTWGIwn/
        BlTIuzMcXZVMwAbtEG1FfUg=
X-Google-Smtp-Source: ABdhPJwYTvtZ3YIH+AWCjnt3wQtGseeYqWNeIuCzDFqro9f41ziI6RyfoV20UuM3mTxddxnoKvAE3Q==
X-Received: by 2002:ac8:7144:: with SMTP id h4mr3467132qtp.156.1599852256888;
        Fri, 11 Sep 2020 12:24:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3846:6663:b768:1725? ([2600:1700:e72:80a0:3846:6663:b768:1725])
        by smtp.gmail.com with ESMTPSA id b79sm4137061qkg.10.2020.09.11.12.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 12:24:16 -0700 (PDT)
Subject: Re: [PATCH 3/4] clone: validate --origin option before use
To:     Sean Barag via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
 <0dff8cd66930130ffd5f0d7d068ad3ed47cd1c81.1599848727.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bf0107fb-2a6c-68d3-df24-72c6a9df6182@gmail.com>
Date:   Fri, 11 Sep 2020 15:24:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <0dff8cd66930130ffd5f0d7d068ad3ed47cd1c81.1599848727.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2020 2:25 PM, Sean Barag via GitGitGadget wrote:
> +	strbuf_addf(&resolved_refspec, "refs/heads/test:refs/remotes/%s/test", option_origin);
> +	if (!valid_fetch_refspec(resolved_refspec.buf))
> +		/* TRANSLATORS: %s will be the user-provided --origin / -o option */
> +		die(_("'%s' is not a valid origin name"), option_origin);

Looking at this again, I'm not sure the translators note is
necessary. Also, I would say "is not a valid remote name".
That makes the string align with the already-translated string
in builtin/remote.c.

This code is duplicated from builtin/remote.c, so I'd rather
see this be a helper method in refspec.c and have both
builtin/clone.c and builtin/remote.c call that helper.

Here is the helper:

void valid_remote_name(const char *name)
{
	int result;
	struct strbuf refspec = STRBUF_INIT;
	strbuf_addf(&refspec, "refs/heads/test:refs/remotes/%s/test", name);
	result = valid_fetch_refspec(refspec.buf);
	strbuf_release(&refspec);
	return result;
}

And here is the use in builtin/clone.c:

	if (!valid_remote_name(option_origin))
		die(_("'%s' is not a valid remote name"), option_origin);

and in builtin/remote.c:

	if (!valid_remote_name(name))
		die(_("'%s' is not a valid remote name"), name);

> +test_expect_success 'rejects invalid -o/--origin' '
> +
> +	test_expect_code 128 git clone -o "bad...name" parent clone-bad-name 2>err &&
> +	test_debug "cat err" &&
> +	test_i18ngrep "'\''bad...name'\'' is not a valid origin name" err
> +
> +'
> +

Double newlines here! I personally appreciate newlines to
spread out content, but it doesn't fit our guidelines.

Thanks,
-Stolee
