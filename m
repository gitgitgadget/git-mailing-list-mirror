Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0A2C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD91E611CA
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbhIIOu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241777AbhIIOtw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:49:52 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DB7C061095
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 07:47:02 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id m11so2609551ioo.6
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XDtdbQreCnZUmF0R082bypregLSDB5y7SFEed0WO6+I=;
        b=DYvKhOofNaMpNXjhBzwbmplwfqdKx6dwxGdfKz+fmSXYMo/TUdPIxefWBtE7VEbuSh
         lo1dfNdv/Y62W0P8Yr/1fpipdM1WzbgsH1bcNCNCcZptMyxsDE+RkMnZR1LfuWgq3d6a
         krWOEJDZVC2wgczxqWJPeGnzbWVRK4XSE6cqmrIPsC2word+FcKXu+I3/Woi+9gafKP6
         gbB9mhdiI8F0EpP44db8pWrJo5TrHtnapxoq0sLnC57F3YK0nRPdjgC9QCUfOHpZSdfO
         GKKcSiU8sT2qAMwpdcnJqPRAAxUKb3fwr/l9iaUCbf84jd+RKmtlV/QtsYFTV7qXOBx7
         REvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XDtdbQreCnZUmF0R082bypregLSDB5y7SFEed0WO6+I=;
        b=cF/lKEcqi3gF2JNkITX9IaOxLkijc/Nl3ANY6Oy4TZvfwEl+ZOKyvmt3+Idi8Kwu3j
         R5l2DSg7CW/9XSWTN0oFBD/cRm0tMNHj48CFhPrJfD/+BhceiLxndbMz/w1Wq9kSS+KP
         7QT3whbGfuKG1SR94a/e2sgT56+S4H5Vnm400g+/Aaf+f3a/eE3By8THif6klJISi64m
         cz3CaMhWg/gnnt432Cw080D0KHp6yt5ZtY/5AUiu+kuVtV13JHIUBBVTbhf/GP9VnId9
         fXNgrQLQ1rpaSk0Ma2LK25eIvrk41poe5CqZ3a6UgBhsQecNdaUbE5BD8jpbsr8v5gKj
         bjaQ==
X-Gm-Message-State: AOAM532iBXaiqZLVfdHT3as+1kFiMHhvmshPuy5fUmij8GgPqqYIsToS
        PORb5iKM4hHQUSampyhjJ4TLdXXJ9Zq93RC2
X-Google-Smtp-Source: ABdhPJzy5sjXBapdfRRQZaOi4q4Iocz4/+Q2EuizonxklvNFJViRYxOyR9snAc5GILf0HPGqtIuVEw==
X-Received: by 2002:a5d:9bcf:: with SMTP id d15mr3164475ion.88.1631198821611;
        Thu, 09 Sep 2021 07:47:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 12sm965512ilq.37.2021.09.09.07.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:47:01 -0700 (PDT)
Date:   Thu, 9 Sep 2021 10:47:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/4] midx.c: respect 'pack.writeBitmapHashcache' when
 writing bitmaps
Message-ID: <YToeZIIrFH42BRe7@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <be8f47e13c612f2fbe4d5f4f49794529b9424664.1631049462.git.me@ttaylorr.com>
 <874kavkfjg.fsf@evledraar.gmail.com>
 <YTgfuAKJv1rXXm7i@nand.local>
 <87zgsmdu6d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zgsmdu6d.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 10:18:10AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Tue, Sep 07 2021, Taylor Blau wrote:
>
> > On Wed, Sep 08, 2021 at 03:40:19AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >>
> >> On Tue, Sep 07 2021, Taylor Blau wrote:
> >>
> >> > +static int git_multi_pack_index_write_config(const char *var, const char *value,
> >> > +					     void *cb)
> >> > +{
> >> > +	if (!strcmp(var, "pack.writebitmaphashcache")) {
> >> > +		if (git_config_bool(var, value))
> >> > +			opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
> >> > +		else
> >> > +			opts.flags &= ~MIDX_WRITE_BITMAP_HASH_CACHE;
> >> > +	}
> >> > +
> >> > +	/*
> >> > +	 * No need to fall-back to 'git_default_config', since this was already
> >> > +	 * called in 'cmd_multi_pack_index()'.
> >> > +	 */
> >> > +	return 0;
> >> > +}
> >> > +
> >> >  static int cmd_multi_pack_index_write(int argc, const char **argv)
> >> >  {
> >> >  	struct option *options;
> >> > @@ -73,6 +90,10 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
> >> >  		OPT_END(),
> >> >  	};
> >> >
> >> > +	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
> >> > +
> >> > +	git_config(git_multi_pack_index_write_config, NULL);
> >> > +
> >>
> >> Since this is a write-only config option it would seem more logical to
> >> just call git_config() once, and have a git_multip_pack_index_config,
> >> which then would fall back on git_default_config, so we iterate it once,
> >> and no need for a comment about the oddity.
> >
> > Perhaps, but I'm not crazy about each sub-command having to call
> > git_config() itself when 'write' is the only one that actually has any
> > values to read.
> >
> > FWIW, the commit-graph builtin does the same thing as is written here
> > (calling git_config() twice, once in cmd_commit_graph() with
> > git_default_config as the callback and again in cmd_commit_graph_write()
> > with git_commit_graph_write_config as the callback).
>
> I didn't notice your earlier d356d5debe5 (commit-graph: introduce
> 'commitGraph.maxNewFilters', 2020-09-17). As an aside the test added in
> that commit seems to be broken or not testing that code change at all,
> if I comment out the git_config(git_commit_graph_write_config, &opts)
> it'll pass.

That makes sense; the test that d356d5debe5 added is ensuring that the
option `--max-new-filters` overrides any configured value of
`commitGraph.maxNewFilters` (so not reading the configuration would be
fine there).

> More importantly, the same issue with the commit-graph test seems to be
> the case here, if I comment out the added config reading code it'll
> still pass, it seems to be testing something, but not that the config is
> being read.

I think this also makes sense; since MIDX_WRITE_BITMAP_HASH_CACHE is the
default and is set in cmd_multi_pack_index_write(). So it may be worth
adding a test to say "make sure the hash-cache _isn't_ written when I:

    git config pack.writeBitmapHashCache &&
    git multi-pack-index write --bitmap

But I don't feel strongly about it (hence I didn't write such a test in
the original version which I sent here). If you think it would be
helpful in a newer version, I'm happy to add it.

Thanks,
Taylor
