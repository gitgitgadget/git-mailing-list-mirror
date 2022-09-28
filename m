Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3FBC54EE9
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 15:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiI1P7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 11:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiI1P67 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 11:58:59 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103FAA287A
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 08:58:22 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id s18so847687ilj.5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yFHSIdkvPVkgWZ2HBjI1CBZoH5gbVbNWGi9ltlAWfpg=;
        b=EYjLxXdd8sOH4GmfOW2tnr6U/DBrvdD/fuesRz30TWfdIgqvuJtL/m2xU2qF8BrVO0
         sDb0P5WaGQlhzpCZXne1x33kmBQSLRmxfm4Dj0eazk4I6l8Gfjpp5SLzf77OjlX8vD5N
         qMfqlonpb2VWSfAOAXBvY0UQTwol8AWQ0ZInVgnPL6S2tOuumknXS+w8SSCGy4Z2XAis
         NTOWcljKN0sUcZvA6X6CCcYzwQMH6B/qihByWZvtq0tjIQAMUaKru++Q2IT+KSorUj47
         4zP9uzOzNJwudd1d1wKqtpQyMkTCEcHwQPplYT0463mwXkeig06KfdZ1GvCavT4ajRqI
         aQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yFHSIdkvPVkgWZ2HBjI1CBZoH5gbVbNWGi9ltlAWfpg=;
        b=aYR2RBQNop7s6uEFyqI5TqwtQxJ5hlxqTi+J2yxtOU3M1w1pzPfdSMZ0YIUEwDK1d3
         PbjuNVYBNK7hU33xkgmr5vrshX9Qg9zgp2wQ57rK1g7oCDlUoug3+YnF5S2nPXwupTw8
         8QEmiVm8ZJ6vC3VU1H0M6e02hikfk5HeAjgStLQBt42AQsiiku7zdKoAKoLvr8qZ/OJX
         zd3zLQzfD9M0MPMzouO3XtJ4i3kil5o69/EFLmcb5EADa3fVLt0eM7v4yE9jA/qvKp5h
         lPtIH2l8RLQ46SeBTtJsoxA5shPMHZMqIRKvej9/791H7rUG1U1+eHBD7ta7oBMs0CPz
         +ehA==
X-Gm-Message-State: ACrzQf1zJh7PxAXuQU+bo3W3V8KOSpqe3MW+bI0+L3kPE8PQkKJ+AF6+
        Xh0tBmahRy3imIBFdO6IBV5VZMGC+iUmvQ==
X-Google-Smtp-Source: AMsMyM7myF4d/55UXK/Zxa+YIHpgxRys4Oz2rPgtLhmwlu0py4V/CZWutzv5M9MGIJZHMrE+YqDPuQ==
X-Received: by 2002:a05:6e02:1baf:b0:2f5:a7b0:65a8 with SMTP id n15-20020a056e021baf00b002f5a7b065a8mr15109805ili.227.1664380701621;
        Wed, 28 Sep 2022 08:58:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r16-20020a02aa10000000b0034ac4b215c3sm1915523jam.102.2022.09.28.08.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:58:21 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:58:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/5] *: relax git_configset_get_value_multi result
Message-ID: <YzRvHFIOG3e6Lhch@nand.local>
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
 <af036388d4e5abe35c23acf4210d46cd69b2d264.1664287711.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af036388d4e5abe35c23acf4210d46cd69b2d264.1664287711.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2022 at 02:08:28PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>

Should the patch message be:

  *: relax git_config_get_value_multi() result

instead of referring to git_configset_get_value_multi?

> ---
>  builtin/submodule--helper.c | 10 ++++++++--
>  submodule.c                 |  2 +-
>  t/helper/test-config.c      |  4 ++--
>  versioncmp.c                |  8 ++++----
>  4 files changed, 15 insertions(+), 9 deletions(-)

All looks good here. I did a git grep for git_config_get_value_multi()
to make sure all of those spots were covered here. No comments from me,
other than a little thinking aloud below on a couple of the conversions.

> @@ -552,7 +553,9 @@ static int module_init(int argc, const char **argv, const char *prefix)
>  	 * If there are no path args and submodule.active is set then,
>  	 * by default, only initialize 'active' modules.
>  	 */
> -	if (!argc && git_config_get_value_multi("submodule.active"))
> +	if (!argc &&
> +	    (active_modules = git_config_get_value_multi("submodule.active")) &&
> +	    active_modules->nr)

Yuck ;-). I was going to suggest that the addition of a helper function
something like:

    static int any_configured(const char *key)
    {
      const struct string_list *vals = git_configset_get_value_multi(key);
      return vals && vals->nr;
    }

would be worthwhile for this and the below conversion, but the change at
the end of this series makes it a moot point. So the temporary eye-sore
is just fine.

> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 4ba9eb65606..62644dd71d7 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -96,7 +96,7 @@ int cmd__config(int argc, const char **argv)
>  		}
>  	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
>  		strptr = git_config_get_value_multi(argv[2]);
> -		if (strptr) {
> +		if (strptr && strptr->nr) {
>  			for (i = 0; i < strptr->nr; i++) {
>  				v = strptr->items[i].string;
>  				if (!v)

Good catch. I was thinking that this whole "if" statement could have
been dropped, but the goto that is hidden by the context meant that this
*would* have been a behavior change otherwise. So the conversion here is
appropriate.

Thanks,
Taylor
