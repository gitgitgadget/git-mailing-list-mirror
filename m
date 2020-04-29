Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD08BC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961342072A
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Uti6WS44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgD2QJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD2QJv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 12:09:51 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258C3C03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:09:51 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id l20so1211466pgb.11
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+EyVBzLCp+leoHTdvFGEcTGckt4vnYnnTotcCrvJUT0=;
        b=Uti6WS442/REpEptxZGNUrno1vCWh652nqeS/6yloAUD06knraoxqEhGPDPqo7ZCCO
         BPWT4u9DnnwOeaQusAF6ehBZAPCvViAava3UGjpfDeD3wuSiFofm3dASbyaBWMMXZv+O
         KBGIUijq61fcDVEi2uKwSBxLSQE13BG2QZbVR1RiUYIAOWOp8Rwl+F8zCzml5J7bUAgV
         BnLpWOSJgxNTWAZE7jjXW4XAG44qAvL8APNqrJF+EYfzG7rRmpXARC93NIwDetQS4ruw
         mBxvdA0Nwmn9EHfafAcLuaLvKz5VwmWXoARxNpGz3acxqY7Tqe277JE3vIcBTr76BkPO
         nt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+EyVBzLCp+leoHTdvFGEcTGckt4vnYnnTotcCrvJUT0=;
        b=IpDZi1hIyOF6xp9BLyvIMqEbbLwj2TCWUWDcm+cOEl4cR7eMd9O69VFum9YjwGw58f
         waLNWMEz+Xkv6EVvpsYAVLaBDC1Io9EC/Aq75NWXcMz072GwkXvO3wFUofXCpeP7bj4Y
         bOPzGLqX9xINs+bj7OBDxnP1ob7T/SqTNZgb733QMluqd77Ypeex61cAQeecnBkdkbk3
         Ss8VYFK3KL3BpH/JR17jo82rNTImEczOfDw6JtIKWUeaQZOS6yor6D3mVUY2eMXvzhBp
         zHS65WLOntKmmeGZn1eKIXA0UBDH7ue/HrEl5A5YbffKi/lIfUOhoNVg5OfToycA20+i
         MfnA==
X-Gm-Message-State: AGi0PuZivgpPNkBqIGS4P553jNcbpzw32YELCFptP4haIzgJ6YzxaKYA
        ELmxB900l3eHYwHpJf0hQBjpqg==
X-Google-Smtp-Source: APiQypLT2CBXy0b5VXbTTsegiqu4dC+YiEcfQLemUmdBOB34zy6HSFw4ruI6qmVIc2hELPhWtxx4WQ==
X-Received: by 2002:a63:d90c:: with SMTP id r12mr23695865pgg.158.1588176590353;
        Wed, 29 Apr 2020 09:09:50 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 1sm1349562pff.151.2020.04.29.09.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 09:09:49 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:09:48 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Robert Simpson <no-reply@MailScreen.com>
Subject: Re: [PATCH] switch: fix errors and comments related to -c and -C
Message-ID: <20200429160948.GB83442@syl.local>
References: <60af77100df823b4112c08e6c1b8533f.squirrel@socialwebmail.com>
 <0f7f9eefc056dd4d9b11dab737e00235b3243a2f.1588150804.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f7f9eefc056dd4d9b11dab737e00235b3243a2f.1588150804.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Wed, Apr 29, 2020 at 05:00:19AM -0400, Denton Liu wrote:
> In d787d311db (checkout: split part of it to new command 'switch',
> 2019-03-29), the `git switch` command was created by extracting the
> common functionality of cmd_checkout() in checkout_main(). However, in
> b7b5fce270 (switch: better names for -b and -B, 2019-03-29), these
> the branch creation and force creation options for 'switch' were changed
> to -c and -C, respectively. As a result of this, error messages and
> comments that previously referred to `-b` and `-B` became invalid for
> `git switch`.
>
> For comments that refer to `-b` and `-B`, add `-c` and `-C` to the
> comment.

I had to read this sentence a couple of times more than I would have
liked to in order to grok it fully. Would it be perhaps clearer as:

  Update comments in 'cmd_checkout()' that mention `-b` or `-B` to
  instead refer to `-c` or `-C` when invoked from 'git switch'.

?

> For error messages that refer to `-b`, introduce `enum cmd_variant` and
> use it to differentiate between `checkout` and `switch` when printing
> out error messages.
>
> An alternative implementation which was considered involved inserting
> option name variants into a struct which is passed in by each command
> variant. Even though this approach is more general and could be
> applicable for future differing option names, it seemed like an
> over-engineered solution when the current pair of options are the only
> differing ones. We should probably avoid adding options which have
> different names anyway.

Yeah, I don't think we should spend much time trying to figure out a
general solution here when these are the only differing pair.

> Reported-by: Robert Simpson <no-reply@MailScreen.com>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> Notes:
>     Robert, is the email listed above correct? If not, please let me know
>     which email to use. (I hope that this reaches you somehow.)

I'll be shocked if this is his real email address ;).

>  builtin/checkout.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 8bc94d392b..0ca74cde08 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1544,9 +1544,16 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
>  	return newopts;
>  }
>
> +enum cmd_variant {
> +	CMD_CHECKOUT,
> +	CMD_SWITCH,
> +	CMD_RESTORE
> +};
> +
>  static int checkout_main(int argc, const char **argv, const char *prefix,
>  			 struct checkout_opts *opts, struct option *options,
> -			 const char * const usagestr[])
> +			 const char * const usagestr[],
> +			 enum cmd_variant variant)
>  {
>  	struct branch_info new_branch_info;
>  	int parseopt_flags = 0;
> @@ -1586,7 +1593,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  	}
>
>  	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
> -		die(_("-b, -B and --orphan are mutually exclusive"));
> +		die(variant == CMD_CHECKOUT ?
> +				_("-b, -B and --orphan are mutually exclusive") :
> +				_("-c, -C and --orphan are mutually exclusive"));

Hmm. Do we need to generate an extra string for translation here? If the
string was instead:

  _("%s and --orphan are mutually exclusive")

where the first format string is filled in something like:

  die(_("%s and --orphan are mutually exclusive"),
      variant == CMD_CHECKOUT ? "-b, -B" : "-c, -C");

may save translators some work.

>  	if (opts->overlay_mode == 1 && opts->patch_mode)
>  		die(_("-p and --overlay are mutually exclusive"));
> @@ -1614,7 +1623,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  	/*
>  	 * From here on, new_branch will contain the branch to be checked out,
>  	 * and new_branch_force and new_orphan_branch will tell us which one of
> -	 * -b/-B/--orphan is being used.
> +	 * -b/-B/-c/-C/--orphan is being used.
>  	 */
>  	if (opts->new_branch_force)
>  		opts->new_branch = opts->new_branch_force;
> @@ -1622,7 +1631,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  	if (opts->new_orphan_branch)
>  		opts->new_branch = opts->new_orphan_branch;
>
> -	/* --track without -b/-B/--orphan should DWIM */
> +	/* --track without -b/-B/--orphan for checkout or -c/-C/--orphan for switch should DWIM */

This line is getting a little long. Would you mind wrapping this as a
multi-line comment instead?

>  	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
>  		const char *argv0 = argv[0];
>  		if (!argc || !strcmp(argv0, "--"))
> @@ -1631,7 +1640,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  		skip_prefix(argv0, "remotes/", &argv0);
>  		argv0 = strchr(argv0, '/');
>  		if (!argv0 || !argv0[1])
> -			die(_("missing branch name; try -b"));
> +			die(_("missing branch name; try -%c"),
> +					variant == CMD_CHECKOUT ? 'b' : 'c');
>  		opts->new_branch = argv0 + 1;
>  	}
>
> @@ -1785,7 +1795,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	options = add_checkout_path_options(&opts, options);
>
>  	ret = checkout_main(argc, argv, prefix, &opts,
> -			    options, checkout_usage);
> +			    options, checkout_usage, CMD_CHECKOUT);
>  	FREE_AND_NULL(options);
>  	return ret;
>  }
> @@ -1823,7 +1833,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
>  	options = add_common_switch_branch_options(&opts, options);
>
>  	ret = checkout_main(argc, argv, prefix, &opts,
> -			    options, switch_branch_usage);
> +			    options, switch_branch_usage, CMD_SWITCH);
>  	FREE_AND_NULL(options);
>  	return ret;
>  }
> @@ -1860,7 +1870,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
>  	options = add_checkout_path_options(&opts, options);
>
>  	ret = checkout_main(argc, argv, prefix, &opts,
> -			    options, restore_usage);
> +			    options, restore_usage, CMD_RESTORE);
>  	FREE_AND_NULL(options);
>  	return ret;
>  }
> --
> 2.26.2.548.gbb00c8a0a9

All of the rest makes sense, thanks.

Thanks,
Taylor
