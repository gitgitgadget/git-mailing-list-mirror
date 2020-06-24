Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595D2C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D9D20724
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5K8BxHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389862AbgFXOfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388652AbgFXOfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:35:32 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0153C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:35:32 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k15so2087332otp.8
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WSD5mWNbAOwCUH4AP4RuAe2FvkMvRToaQPW+2ifdcqA=;
        b=q5K8BxHW+7qn5vkLN6H8TGTvhHA8sUACY2CYGdT6Qa2+AjhChzECRYS2hDC8XhfA6v
         uDjf65zi48tYrtHViFOvAgeDaTjW1lKZxscFM/snvmK8KuFcdmfTqv4CbXn5QDR2e2j4
         P94MM5Gl2ZeY6gcs3SbC2yWjzrVtKxTkBQGEF7yeia8S1Qebr6vKgaKZTEjPLOjULDeC
         2DS1+a3mr7YZB7FxhBeQj+OzmU53l2KVbPJ4J9mhDxzLsXnxLBiuENObYGO/nP/x3VQB
         G7Fzr8SB9zS1aYZ5yegXQTo8ShA1FRNCZ0K/3PdOtHbRQTZ2dADGsV8MadntSvZcd9io
         aglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WSD5mWNbAOwCUH4AP4RuAe2FvkMvRToaQPW+2ifdcqA=;
        b=YER/36nIUS0kc+m12WgqnxykeFaPEPZTRQEUPxNEw4KrZAa/3fUlPCzQxGRluXZG+Y
         ufmQzSXIn0zgRqL3rqFJ8fmTD0xFxhhhccHE1tSOfHhM+HS8WfFMpm1cm6W6+HnPk/Fv
         gB+ZqIBO4xYB6Pfj5T5om5c8Ne6tG+5wqgh7A+gc8EYvUXfzHqYX8Zj76mJ7YASY63pk
         RYm89k+A6Q8+R2qxhEQbn/9nQr1uwL8OG7FucLF2BooovMcagFY1FHJD7Bp5oFy392S8
         5Glbd8OPaIje5fICM80lvVP2JBbacEjEIpZGG2aMpnFGFuoSf+/CrbQiDoxFXx42OX+m
         I1XQ==
X-Gm-Message-State: AOAM531zjFAC5UCRpqjmKaD9UlBW/H7JFqDw8r0zmAw2wRkNEWg+wHcO
        FhYvKpzi97DcJ4r4jHtyuVHWYbTIhqo=
X-Google-Smtp-Source: ABdhPJwLJKMQ0gWqogI3qoBehRIDh6g90dHCrxVdNXi+SIAmzfSSLrsq9MUaVPZUdgZls2tSF3SvUw==
X-Received: by 2002:a9d:62da:: with SMTP id z26mr24197699otk.369.1593009331765;
        Wed, 24 Jun 2020 07:35:31 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 89sm3050522otp.3.2020.06.24.07.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 07:35:31 -0700 (PDT)
Subject: Re: [PATCH 2/2] submodule: use submodule repository when preparing
 summary
To:     Michael Forney <mforney@mforney.org>, git@vger.kernel.org
References: <20200623205659.14297-1-mforney@mforney.org>
 <20200623205659.14297-2-mforney@mforney.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <33de1078-5f19-e76c-2a30-1754494d1e31@gmail.com>
Date:   Wed, 24 Jun 2020 10:35:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200623205659.14297-2-mforney@mforney.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/23/2020 4:56 PM, Michael Forney wrote:
> In show_submodule_header(), we gather the left and right commits
> of the submodule repository, as well as the merge bases. However,
> prepare_submodule_summary() initializes the rev_info with the_repository,
> so we end up parsing the commit in the wrong repository.
> 
> This results in a fatal error in parse_commit_in_graph(), since the
> passed item does not belong to the repository's commit graph.
> 
> Signed-off-by: Michael Forney <mforney@mforney.org>
> ---
>  submodule.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index e2ef5698c8..785ab47629 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -438,13 +438,13 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
>  	 */
>  }
>  
> -static int prepare_submodule_summary(struct rev_info *rev, const char *path,
> -		struct commit *left, struct commit *right,
> +static int prepare_submodule_summary(struct repository *r, struct rev_info *rev,
> +		const char *path, struct commit *left, struct commit *right,
>  		struct commit_list *merge_bases)
>  {
>  	struct commit_list *list;
>  
> -	repo_init_revisions(the_repository, rev, NULL);
> +	repo_init_revisions(r, rev, NULL);

This is how we properly initialize the repository in the rev_info.
It's unfortunate that this use of the_repository was pretty clearly
incorrect. This is submodule.c, so every instance of the_repository
should be examined carefully. Taking a brief look right now, the
rest seem to be correct in that they are finding submodules within
the super-repo. The only issue will arise when recursing into
submodules, which is known to be broken in-process and are handled
with subprocesses instead.

>  	setup_revisions(0, NULL, rev, NULL);
>  	rev->left_right = 1;
>  	rev->first_parent_only = 1;
> @@ -632,7 +632,7 @@ void show_submodule_summary(struct diff_options *o, const char *path,
>  		goto out;
>  
>  	/* Treat revision walker failure the same as missing commits */
> -	if (prepare_submodule_summary(&rev, path, left, right, merge_bases)) {
> +	if (prepare_submodule_summary(sub, &rev, path, left, right, merge_bases)) {
>  		diff_emit_submodule_error(o, "(revision walker failed)\n");
>  		goto out;
>  	}

Perhaps the test I requested in patch 1 is only appropriate
here? Or, maybe the test should be test_expect_failure in the
first patch and switched to test_expect_success here?

Thanks,
-Stolee


