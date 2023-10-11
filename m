Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1402CDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 21:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjJKVcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjJKVcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 17:32:16 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F1B9E
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 14:32:14 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41808baf6abso1920251cf.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697059933; x=1697664733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O0xoCjcIMHfWQAiSqAbU9i8yhY2Iyomi1Lj0YM5yf7c=;
        b=KIaDMJ81a957e99RDvtDPMCyQtD/5kxvHQVQ6kPppZLOEJxRlNPRu6gLsju85IWFyI
         70nNWtm7DCH9YsawTvErJQ8btO0xd4iA3ztVfuWQn7eKEpls8dr+mfdSr7ROwHf9o+IN
         P8lN3jl/g1DhF/twSSRPgxXO/4FnBSKu5QID80TVDYm9dlEhEvEfBFKyM71foNigEUZe
         FhN81Q0K/Pn/kCBLJ1xQ70oX0WgAV7uOPEepvolBNLlQtrSMPVJVpnQebBcsDokbNAZj
         LI7yNgmKihv+Iky6mPP5iDOPJ9kpNWq2VKLn6Zi6abW83tTnjS/wJPTXnrT9XloWgWGg
         InSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059933; x=1697664733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0xoCjcIMHfWQAiSqAbU9i8yhY2Iyomi1Lj0YM5yf7c=;
        b=F7lXpGaHhYpG5SQSGHbBLAnEBaYb5panVVXZNgKRMlXDf431GyhOqtSJhhKfjHm+t7
         YqPnXNzCQ4yo0QrJgtOeNtv10C9iB62Avm8qQCCH3Ze73QA+QSyOHdZGJiCEG+94Dy54
         Zd8YknQpRFPxCEob4VpC7BnDAQN3leQ3feGDweoq5ankqVGLWYwGlqgH3ZzZgthXme6M
         GDwpaCL9brDEn+iTw9OTRIvZK7uj0xLYWvfKAPzPdwPWeovgdW/o/v82VUGlwqkQ+L9h
         yleBf3owNcLqKcdGedZZJqqRyGJY9BHptJf7i1Ppz46HcnzUHiH6Hy5beSsZIzPl5YX6
         d2sA==
X-Gm-Message-State: AOJu0YwXcQGSJZhxiaAvXTq9nLRUXDosPr7R+CpFabkA3k28X6kDs73n
        HCZnG/T+OpkoBeKtoy9jmm6mCFJAuFvr8SCXgyCngA==
X-Google-Smtp-Source: AGHT+IGmaydQS1F9Ki8KwX0Yx1JtjFOUhpxajFygIKkTBtChYm6ovuffs9BDlDSQeMK2BCAKPFdA2w==
X-Received: by 2002:a05:622a:1811:b0:417:934e:ade with SMTP id t17-20020a05622a181100b00417934e0ademr28411083qtc.15.1697059933672;
        Wed, 11 Oct 2023 14:32:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k24-20020ac84758000000b004199f47ccdbsm5662080qtp.51.2023.10.11.14.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:32:12 -0700 (PDT)
Date:   Wed, 11 Oct 2023 17:32:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH] upload-pack: add tracing for fetches
Message-ID: <ZScUWrj6CQTg05HL@nand.local>
References: <pull.1598.git.1697040242703.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1598.git.1697040242703.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 04:04:02PM +0000, Robert Coup via GitGitGadget wrote:
> From: Robert Coup <robert@coup.net.nz>
>
> Information on how users are accessing hosted repositories can be
> helpful to server operators. For example, being able to broadly
> differentiate between fetches and initial clones; the use of shallow
> repository features; or partial clone filters.

Indeed. One of the custom patches that GitHub is carrying in its private
fork is something similar to this that dumps information from
upload-pack into a custom logging system specific to GitHub (called
"sockstat", in case anybody was curious).

I suspect that we would still live with that patch because we depend on
some of the custom logging infrastructure provided by sockstat, but this
is definitely a good direction to be pursuing for git.git nonetheless.

> @@ -1552,6 +1553,32 @@ static int parse_have(const char *line, struct oid_array *haves)
>  	return 0;
>  }
>
> +static void trace2_fetch_info(struct upload_pack_data *data)
> +{
> +	struct json_writer jw = JSON_WRITER_INIT;
> +
> +	jw_object_begin(&jw, 0);
> +	{

Is there a reason that we have a separate scope here? I think we may
want to drop this as unnecessary, but it's entirely possible that I'm
missing something here...

> +		jw_object_intmax(&jw, "haves", data->haves.nr);
> +		jw_object_intmax(&jw, "wants", data->want_obj.nr);
> +		jw_object_intmax(&jw, "want-refs", data->wanted_refs.nr);
> +		jw_object_intmax(&jw, "depth", data->depth);
> +		jw_object_intmax(&jw, "shallows", data->shallows.nr);
> +		jw_object_bool(&jw, "deepen-since", data->deepen_since);
> +		jw_object_intmax(&jw, "deepen-not", data->deepen_not.nr);
> +		jw_object_bool(&jw, "deepen-relative", data->deepen_relative);
> +		if (data->filter_options.choice)
> +			jw_object_string(&jw, "filter", list_object_filter_config_name(data->filter_options.choice));

I'm pretty sure that list_object_filter_config_name() returns characters
that are safe for JSON-encoding, and/or that jw_object_string() does any
quoting beforehand, but worth checking nonetheless.

> +		else
> +			jw_object_null(&jw, "filter");

These all seem like useful things to have.

Thanks,
Taylor
