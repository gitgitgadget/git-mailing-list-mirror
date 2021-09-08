Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1409EC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E653960F0F
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbhIHC3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 22:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbhIHC3R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 22:29:17 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A0C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 19:28:10 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z1so1176056ioh.7
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 19:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aokSaH2y/vmPKEYW+jNsYZWtUVbXV8U/CmduVhC/VzU=;
        b=ECsEDTwQYca6iy99X20tzblJngUZCYDlnCK7SFKLZ2rQRLP7SDvCni/a94TFFE/Xim
         U86n+8e0heH1nCS2DBfSpZ74BRJy8DQmpkubhmnjOroporJWAAP0CcpwhEKHpIBOupJN
         UhqdMn0s/PmjIe/ssnl16RJYVnm6xriWr56DMhMM2TfaQJPKn7KRGwj3Ykuv8CfbIEuV
         YPdNmViZLzRVyRXEqk1zwA0rh2pyjd6Rsxvhm4TiG0XAzR160iM4aBPRKvwntkU2pejq
         X7/RQOl4O2/NOKR82wa3ZCU565a0JbuYxYYmZaYa3pKO33uqQ6osVowv+XPf22ayBchu
         BcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aokSaH2y/vmPKEYW+jNsYZWtUVbXV8U/CmduVhC/VzU=;
        b=lUiN6xxVBwxN2lCYq76oPorKUiKrpeJH3vVEk3ZqoNJsflwEtNf6xz6ohD+68oBM+W
         VlES9OvNobm/7f06e+vh5TRUlxAUJXl0exKwtlHi842+eh5PSQ+Yz5wZP7dEku7utFA3
         QYn+6VG0/Aw1d0Mh9nqRo+6SInbG1mskT0ME78ymiaBcHlAI4ORNZY+Pv6/ZjFg0NuNz
         s/jo1qHTX/Xd51EacvShwMU+PO2HvkbK1agkcSXG74xAJ9xa/bnZ+lMOqZ/xV873TsGi
         ey5IgMclhi2MdG433fYNP+tM3Pc2wZHfSS4ytTBE9col49E1ybx89KCEA9aDRSCbLh+d
         ChGA==
X-Gm-Message-State: AOAM533IOK/uMiDgDJpO7AcdZhS91M8Lk1IXjq8Rb0peijVNefcKIcca
        V5HR8dnvfsgERtaPBamFGgDxEkmDYMTUYSf6
X-Google-Smtp-Source: ABdhPJxnyCJyEkaz9B7kIIzkStqHH7WpX3A4EdkCaY/qNyxwtOEFPPoe+5W5XkBDhEo54aKqdkDuIA==
X-Received: by 2002:a6b:f007:: with SMTP id w7mr1207519ioc.112.1631068090343;
        Tue, 07 Sep 2021 19:28:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e1sm443826ils.76.2021.09.07.19.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 19:28:09 -0700 (PDT)
Date:   Tue, 7 Sep 2021 22:28:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/4] midx.c: respect 'pack.writeBitmapHashcache' when
 writing bitmaps
Message-ID: <YTgfuAKJv1rXXm7i@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <be8f47e13c612f2fbe4d5f4f49794529b9424664.1631049462.git.me@ttaylorr.com>
 <874kavkfjg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kavkfjg.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 03:40:19AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Tue, Sep 07 2021, Taylor Blau wrote:
>
> > +static int git_multi_pack_index_write_config(const char *var, const char *value,
> > +					     void *cb)
> > +{
> > +	if (!strcmp(var, "pack.writebitmaphashcache")) {
> > +		if (git_config_bool(var, value))
> > +			opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
> > +		else
> > +			opts.flags &= ~MIDX_WRITE_BITMAP_HASH_CACHE;
> > +	}
> > +
> > +	/*
> > +	 * No need to fall-back to 'git_default_config', since this was already
> > +	 * called in 'cmd_multi_pack_index()'.
> > +	 */
> > +	return 0;
> > +}
> > +
> >  static int cmd_multi_pack_index_write(int argc, const char **argv)
> >  {
> >  	struct option *options;
> > @@ -73,6 +90,10 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
> >  		OPT_END(),
> >  	};
> >
> > +	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
> > +
> > +	git_config(git_multi_pack_index_write_config, NULL);
> > +
>
> Since this is a write-only config option it would seem more logical to
> just call git_config() once, and have a git_multip_pack_index_config,
> which then would fall back on git_default_config, so we iterate it once,
> and no need for a comment about the oddity.

Perhaps, but I'm not crazy about each sub-command having to call
git_config() itself when 'write' is the only one that actually has any
values to read.

FWIW, the commit-graph builtin does the same thing as is written here
(calling git_config() twice, once in cmd_commit_graph() with
git_default_config as the callback and again in cmd_commit_graph_write()
with git_commit_graph_write_config as the callback).

So I'm not opposed to cleaning it up, but I'd rather be consistent with
the existing behavior. To be honest, I'm not at all convinced that
reading the config twice is a bottleneck here when compared to
generating a MIDX.

Thanks,
Taylor
