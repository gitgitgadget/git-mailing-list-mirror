Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634B31FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 23:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755581AbdC1XmW (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 19:42:22 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33324 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753680AbdC1XmW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 19:42:22 -0400
Received: by mail-pg0-f67.google.com with SMTP id 79so18153pgf.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 16:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ykGxgAOamIC91rP7RT0y0okcQCe2MyvuC9CqxqFhM3I=;
        b=NJ50+s7DXnA0w3F+ISRPoaUzXswagoZM+Hs/mTG8Zs2Hy4dXi7JQUvTXuXByM5qvuR
         L46V+xXDNjjRz1sa51GmiqIsAZ0QtnmVaIumUlBvsNysehm8+hlS1za6MJ+dN0q45kVL
         Y/J+h+tvtTnEMy5QFTnav8ECYnkmcLeEgKy6w5bxYTzege0Uf/nlt5v4tiWEdDDpgPvB
         a7GBM/5yto7Jlx5B4e08Va9EzXANO9GwL/uXPQThIQ5cqXdpnMWqqfmac8WbWriJpPgk
         GVq9D+CjFQ8u+jiv0Sx/0UVGSGB1VXpf0YEysLoLZuydld/tfH49wO9rH+Vygum+B7N2
         W55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ykGxgAOamIC91rP7RT0y0okcQCe2MyvuC9CqxqFhM3I=;
        b=f2fXaKjUCpVHWRpy754VU3oyEJIED/16KwvaIjt/p3Xvht8ATtML2WgD3OEcqybR0z
         xzHEwI0xAb5yEDwn8NknjnHCn7XGf9Y3Rgnd2kJ7J8qBUdvJNf2SHFruLRVm7N1iOu3N
         RkXfdwLyRphHoKlT9TIEmxHwvPaQfIYgRoRdwUfKnx0n/8Xg0l2LMewHUhNBI2Q1KaVH
         +PlZOfEvRLMq2qMfQajtcqVxaBNyWTUZbSlaGaQtPHoDmYK/O2q53mgstFjHrAa8Si57
         nXAMCRrvF8JkqXgMxAGOu/sYKd5IKNB6yGh76E5nzucGYj4yIry0HuGtP0T/u5uzzLKI
         EyJA==
X-Gm-Message-State: AFeK/H2fHaHbmc3ZOvurqm7yLZV/c4qA6G4GjuSz5nj5SdkIhuwXNXEKN71aB2W8vRzRPA==
X-Received: by 10.98.2.21 with SMTP id 21mr34114110pfc.93.1490744540109;
        Tue, 28 Mar 2017 16:42:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:6c52:4b14:15fb:ecda])
        by smtp.gmail.com with ESMTPSA id u69sm9332566pfg.121.2017.03.28.16.42.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 16:42:19 -0700 (PDT)
Date:   Tue, 28 Mar 2017 16:42:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 2/2] submodule.c: correctly handle nested submodules in
 is_submodule_modified
Message-ID: <20170328234217.GU31294@aiede.mtv.corp.google.com>
References: <20170325003610.15282-1-sbeller@google.com>
 <20170328230938.9887-1-sbeller@google.com>
 <20170328230938.9887-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170328230938.9887-3-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Suppose I have a superproject 'super', with two submodules 'super/sub'
> and 'super/sub1'. 'super/sub' itself contains a submodule
> 'super/sub/subsub'. Now suppose I run, from within 'super':
>
>     echo hi >sub/subsub/stray-file
>     echo hi >sub1/stray-file
>
> Currently we get would see the following output in git-status:
>
>     git status --short
>      m sub
>      ? sub1
>
> With this patch applied, the untracked file in the nested submodule is
> turned into an untracked file on the 'super' level as well.

s/turned into/displayed as/

>     git status --short
>      ? sub
>      ? sub1
>
> This doesn't change the output of 'git status --porcelain=1' for nested
> submodules, because its output is always ' M' for either untracked files
> or local modifications no matter the nesting level of the submodule.
>
> 'git status --porcelain=2' is affected by this change in a nested
> submodule, though. Without this patch it would report the direct submodule
> as modified and having no untracked files. With this patch it would report
> untracked files. Chalk this up as a bug fix.

I think that's reasonable, and the documentation does a good job of
describing it.

Does this have any effect on the default mode of 'git status' (without
--short or --porcelain)?

[...]
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -187,6 +187,8 @@ Submodules have more state and instead report
>  		m    the submodule has modified content
>  		?    the submodule has untracked files
>  
> +Note that 'm' and '?' are applied recursively, e.g. if a nested submodule
> +in a submodule contains an untracked file, this is reported as '?' as well.

Language nits:

* Can simplify by leaving out "Note that ".
* s/, e\.g\./. For example,/

Should this say a brief word about rationale?  The obvious way to
describe it would involve "git add --recurse-submodules", which alas
doesn't exist yet.  But we could say

                                              this is reported as '?' as well,
   since the change cannot be added using "git add -u" from within any of the
   submodules.

[...]
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1078,8 +1078,27 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>  		/* regular untracked files */
>  		if (buf.buf[0] == '?')
>  			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
> -		else
> -			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
> +
> +		if (buf.buf[0] == 'u' ||
> +		    buf.buf[0] == '1' ||
> +		    buf.buf[0] == '2') {
> +			/*
> +			 * T XY SSSS:
> +			 * T = line type, XY = status, SSSS = submodule state
> +			 */
> +			if (buf.len < 1 + 1 + 2 + 1 + 4)

optional: Can shorten:

			/* T = line type, XY = status, SSSS = submodule state */
			if (buf.len < strlen("T XY SSSS"))
				...

That produces the same code at run time because compilers are able to
inline the strlen of a constant.  What you already have also seems
sensible, though.

[...]
> +				die("BUG: invalid status --porcelain=2 line %s",
> +				    buf.buf);
> +
> +			/* regular unmerged and renamed files */
> +			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
> +				/* nested untracked file */
> +				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
> +
> +			if (memcmp(buf.buf + 5, "S..U", 4))
> +				/* other change */
> +				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;

sanity check: What does this do for a "2" line indicating a sub-submodule
that has been renamed that contains an untracked file?  Do we need to
rely on some other indication to show this as a change?

Enumerating some more cases, since I keep finding myself getting lost:

 - if the HEAD commit of "sub" changes, we show this as " M sub".
   What should we show if the HEAD commit of "sub/subsub" changes?
   I think this should be " m".

 - if "sub" is renamed, we show this as "R  sub -> newname".
   What should we show if "sub/subsub" is renamed?  It is tempting
   to show this as " m".

 - if "sub" is deleted, we show this as "D  sub". What should we
   show if "sub/subsub" is deleted? I think this is " m".

It keeps getting more complicated, but I think this is making sense.

Thanks and hope that helps,
Jonathan
