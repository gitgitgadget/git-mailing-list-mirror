Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9EBC433E1
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 20:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE3DB2080D
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 20:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="zgGQF1ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgGTUFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgGTUFc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 16:05:32 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3627C061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 13:05:31 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h7so981867qkk.7
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qlVFYxGueX1IntA8NyeTxma8QmYwRq+1AzToGbMoxmk=;
        b=zgGQF1ksVS8oh1N5AtdBXV1TksB5AV2Lv6RJKcWJeKYgnSowp+LhZgBUcZpqtQmrDs
         Goos3l+QP1e4kdCrfdvK0glZTPtWPyJY3H+h93V+ncqhYCLIfhn8ZF19VzHnAEyCVcDh
         a+xgqzFOuwrxta49doFDxNIbxzNMJRck2qpTZoS929jkBKZoAubF+k43QndM7cyMbTai
         j6p+gY+CoaaAYuuHbgSJmyFz8rrO7VUHAP/C4vHAE/zM+avgjI+4Fz4XzQCjeGHGPPkG
         nK7y6Y6Zaf4FhRvBwmbu5TiJ5XXza9/wbLKwb10QrfIP3DHSqGSUEcIuKL2/bluQ/0kk
         8Byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qlVFYxGueX1IntA8NyeTxma8QmYwRq+1AzToGbMoxmk=;
        b=CfNwKKD7R+aswVC4nYzqVnJqSrtJQJfl+sVbS4TkHrJDEwM1J4AhrWGwAzv/K7mruY
         IR4YKCT53+3zW1PkSl3QTbGjECEjv2vlEpwj7s4L8OJBhC4sUsqM5uTUHr9vtqmf94KT
         nTVsvqNJyxg5WhWmLZ8VwRoRnNHFUqZYp87ASyOqa2BxCNIvq86g17opvZw5KoxWYk6P
         +k/RlRcuMsBJ5yNbR27iohz1smgCbIhVpp87pzKN7vlPLXMycyY8qKmZj9+XsEPTLl39
         DZYgDIAFVOI4blMg5LthcylS7q6UJ/wTGkNqxDPGwsN8oUY7jCnJ2OWOCvKRZDEUVcZF
         P6/w==
X-Gm-Message-State: AOAM531t6ZVPaEqXRc/jhrMuLkwOuxxlH55/7EX3mVVAo/H5oX7trenz
        jyYUR9N8PFzU0jKbNcxg3qHhuZb+ocGkDw==
X-Google-Smtp-Source: ABdhPJzubIBZq8kuGDSLl7HFbLHYU10PmFQXZIGzJGTApqtkYhcA54cAV5xBK0LKzkR1LVKDJTNrlg==
X-Received: by 2002:a05:620a:151:: with SMTP id e17mr3565112qkn.173.1595275530900;
        Mon, 20 Jul 2020 13:05:30 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1456:25db:8327:2471])
        by smtp.gmail.com with ESMTPSA id q198sm179023qka.51.2020.07.20.13.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 13:05:30 -0700 (PDT)
Date:   Mon, 20 Jul 2020 16:05:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <20200720200528.GA91942@syl.lan>
References: <cover.1593720075.git.me@ttaylorr.com>
 <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
 <20200708084527.GB2324177@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200708084527.GB2324177@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 08, 2020 at 04:45:27AM -0400, Jeff King wrote:
> On Thu, Jul 02, 2020 at 04:06:32PM -0400, Taylor Blau wrote:
>
> > +static void parse_object_filter_config(const char *var, const char *value,
> > +				       struct upload_pack_data *data)
> > +{
> > +	struct strbuf spec = STRBUF_INIT;
> > +	const char *sub, *key;
> > +	size_t sub_len;
> > +
> > +	if (parse_config_key(var, "uploadpack", &sub, &sub_len, &key))
> > +		return;
> > +	if (!sub || !skip_prefix(sub, "filter.", &sub))
> > +		return;
>
> Just while I'm thinking about the config name and case-sensitivity (from
> the cover letter): if we did want to use this scheme, then
> skip_iprefix() would make this behave more like a regular part of the
> section name.
>
> But I'd prefer to just do away with it by using a scheme that doesn't
> have the extra layer of dots.

Yeah. I definitely flip-flopped on this when preparing this for the
list. I still feel like 'uploadpackfilter' is gross, so I was hoping to
send it with 'uploadpack.filter' (which reads nicely, but forces us to
write some gross code), but both options are frustrating to me for
different reasons.

Playing around with it more, though, I think that uploadpackfilter is
our best bet. I'd hate to introduce a string manipulation bug by munging
the reuslt of 'parse_config_key()', which is so clearly designed for
something like 'uploadpackfilter[.<filter>].allow'.

> > +	if (sub != key)
> > +		strbuf_add(&spec, sub, key - sub - 1);
> > +	strbuf_tolower(&spec);
>
> On the flip side, I'd actually consider _not_ matching the filter name
> case-insensitively. We don't do so elsewhere (e.g., "git rev-list
> --filter=BLOB:NONE" will complain).

I dropped the case-insensitive matching in the latest revision. I don't
think that we need to be overly accommodating here.

> -Peff

Thanks,
Taylor
