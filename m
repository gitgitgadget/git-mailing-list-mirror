Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6817C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 23:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7281A205ED
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 23:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="GSkDh3to"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgC3X7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:59:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37400 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgC3X7w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 19:59:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id h72so9441050pfe.4
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 16:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AuiM14rlpW9Jv5d7bXRHZx97pz14WhXdt+w+zCJ+Ijc=;
        b=GSkDh3to/KLODZ6YjR7g+Z/4phEwsrsTjygyq0b7BkIKr6vxzzqgdK8QLaxXAsFpKN
         +YENwLTmyWnkqgY5zuLZfpHo0Awt7s+q5RwPN9IG7Mk831AzbPtU+urhU6Mx4Xlcp8jf
         RefDlRzQ4gk1AEhEgGIbSp7xjkQxEKiyKRH998fLfIXsovqIdfKx/mjdTdByq/zHITZm
         BNgOZzOMLXjXSOUi+tt3V3uPT9bBPdnHxQQeivECmCruqOuZTHEhYGgZc/AjcdJxR2du
         9AFBPHVQI7uEnZ+zOP5RKF1iqAm8iEecfJeQLzRd/M1QcXdwbVA9xuMEEsEZPxdzhYlQ
         YvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AuiM14rlpW9Jv5d7bXRHZx97pz14WhXdt+w+zCJ+Ijc=;
        b=NqDodZ1Q6VlFgfE4YeoFDmQVEskCl5brLkagNOgA38F85AHTVoZvMGPpne5PZLcr5E
         oKnY/DWQd5f4V9SQ2aHAOAG5sd6frYA8fgra3ODELyfh242Xeb0gGzS9hF6QKO/CUHmM
         OqvcobwYOkx7Wp3Yyhv6dHLPuS9Dbgb++Jham2HKJsQccmEsI0kphgo0QAh59O2esDNv
         om1IroE8Y/r/OeJINZ3ojFCTNOD4VRG7TZbtMS0DNi2P7cjlvsvegiPxXuqVoDyoaPiu
         Smx/XQhK46cUBLDe1uFOuB9vP1JNgg3TFOBcHdB9Vrf2LGClnbwqSiuV8RiDtu0hDc7l
         l4Hw==
X-Gm-Message-State: ANhLgQ3lt223o2+eBnoceke2oeb5a/yBZQx4i393RdmOkdF/VgNvrX++
        zBXlC8kJxVT2lB8dVtj9l1nTRA==
X-Google-Smtp-Source: ADFU+vsHf+Dvnvuhaj8oZL3kvFp6ObWWkRMuHmw5/wlSz0TDi7Eg5PGQ9/JbkxTSDhgeXA1VJgH2Ww==
X-Received: by 2002:a63:6b0a:: with SMTP id g10mr15500255pgc.386.1585612790669;
        Mon, 30 Mar 2020 16:59:50 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x189sm11044988pfb.1.2020.03.30.16.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:59:50 -0700 (PDT)
Date:   Mon, 30 Mar 2020 17:59:49 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: mark messages for translation
Message-ID: <20200330235949.GC83990@syl.local>
References: <20200328130515.17550-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200328130515.17550-1-alban.gruin@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

This looks good to me. I scratched my head for a little while wondering
about why these weren't marked for translation originally. They were
added back during the initial conversion to C. Some of the strings had
English-ism's such as "1st", "2nd", and so on, but weren't.

Johannes notes in [1] that marking those strings for translation was a
topic to be left until after v2.10.1, but I think he is busy enough that
this was easy to drop in the shuffle :-).

So, I am glad that you're addressing this. If you wanted, it may be
worthwhile to distill some of this into the patch message. But the
changes themselves look good to me.

On Sat, Mar 28, 2020 at 02:05:15PM +0100, Alban Gruin wrote:
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  sequencer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 6fd2674632..ba13a9a63b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3128,7 +3128,7 @@ static int do_exec(struct repository *r, const char *command_line)
>  	const char *child_argv[] = { NULL, NULL };
>  	int dirty, status;
>
> -	fprintf(stderr, "Executing: %s\n", command_line);
> +	fprintf(stderr, _("Executing: %s\n"), command_line);
>  	child_argv[0] = command_line;
>  	argv_array_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
>  	argv_array_pushf(&child_env, "GIT_WORK_TREE=%s",
> @@ -3841,7 +3841,7 @@ static int pick_commits(struct repository *r,
>  					fclose(f);
>  				}
>  				if (!opts->quiet)
> -					fprintf(stderr, "Rebasing (%d/%d)%s",
> +					fprintf(stderr, _("Rebasing (%d/%d)%s"),
>  						todo_list->done_nr,
>  						todo_list->total_nr,
>  						opts->verbose ? "\n" : "\r");
> @@ -4093,7 +4093,7 @@ static int pick_commits(struct repository *r,
>  			if (!opts->verbose)
>  				term_clear_line();
>  			fprintf(stderr,
> -				"Successfully rebased and updated %s.\n",
> +				_("Successfully rebased and updated %s.\n"),

>  				head_ref.buf);
>  		}
>
> --
> 2.25.0

Either way, if you decide to add more context to the commit message I'd
be glad, but this is probably just fine as-is, so please have my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor

[1]: https://lore.kernel.org/git/alpine.DEB.2.20.1609011658300.129229@virtualbox/
