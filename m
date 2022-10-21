Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14713C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 02:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJUCCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 22:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJUCCt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 22:02:49 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA11EEA02
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 19:02:48 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id o13so912226ilc.7
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 19:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/zz/S0jnnPcmR441hiWMccOadDqrmcuHxvr1olwyY4=;
        b=IP5dAkEOST/80fUroVLXeI8uTu02jrrYbiv9YsbNUiS/+mjHsMjXPS5py4GMFIjxWg
         AaTvRL3/P5i1ZV/L3Brbjj6Aeyge8eFMrqja5qR9/W10BsIJXVDMKv+INmlG8WNMr5vy
         Sdfz76ghlIcAdKXFw58N4Wk32b9Lrx3Gc1/JcxVtlepACqzM7nNyoNd+AeKCprSgZWWO
         HXsrAXX3InH1LQPXyWw9mRDyoQur3WyIqRjCEK7BJFaepsLr4NM30dEy+QDTPCwqpBmm
         BqCP8feCn6opSHUAwusiSo05lzY9aY6cSMbQO6eFSiCgr40YjryBRzsfN/BJ/Ui6GPJG
         bBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/zz/S0jnnPcmR441hiWMccOadDqrmcuHxvr1olwyY4=;
        b=UlC9iZoej1C3ThW2k3QvBnhrkI3CDN/jYD/cG7xRCn0xlCDTemMQMFp7zXwaI5FDFx
         wuRGYrBYp8PCU3F89/Rvx/eqvzCiVDvMXIkNKlAeagQx2ybux3rOegM8CM5wo3VSB/Ov
         tTKPqLLS9MlxE/nX6VTMrerTAZY0FmOJonqT6T9DsmXPPM4b5GCMK8aNlkBqq1qIU6te
         Qr+1LWBb61QYqpGJZshd0txV21eNAbPj3P5i4mhdUUGCI8uJk/gDGA0RoQe9YYIixg/W
         nA26eqHJ6sBulwjESvwHS8bQ3eSDl7tTUJzKLrtY4HQHGgPY6A/qmPfWyF1DMV63muJW
         6f6A==
X-Gm-Message-State: ACrzQf1+wZWo6qM5wYQKJ1TbenOCMkyq0eJSNEJMcV2B2jmCxErbD/pn
        uiBhrefdS1jvV4UPiIKQf9O4iIVnV1nlzzSw
X-Google-Smtp-Source: AMsMyM58Aj8TV/8yuy2506DejhHqmgmEtjqXCS7ZO6MU1kLNETZFzx4LcdgfUHI0YauxPXmU1EcWQw==
X-Received: by 2002:a05:6e02:1d1a:b0:2ff:8741:f6aa with SMTP id i26-20020a056e021d1a00b002ff8741f6aamr736903ila.49.1666317767552;
        Thu, 20 Oct 2022 19:02:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j12-20020a02cb0c000000b00363aad36b7dsm3752663jap.174.2022.10.20.19.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 19:02:47 -0700 (PDT)
Date:   Thu, 20 Oct 2022 22:02:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 5/7] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Message-ID: <Y1H9xdDJS+xKW8mS@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <55a6ef7bc0082818fa51a0915c43002ede5c449f.1665448437.git.me@ttaylorr.com>
 <Y0TIMlrrifYKuBnR@coredump.intra.peff.net>
 <Y0TLf/J22ioQ5UCt@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0TLf/J22ioQ5UCt@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 09:48:47PM -0400, Taylor Blau wrote:
> > > diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> > > index f708d96558..aac8c7afa4 100644
> > > --- a/builtin/shortlog.c
> > > +++ b/builtin/shortlog.c
> > > @@ -245,15 +245,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
> > >  	}
> > >  	oneline_str = oneline.len ? oneline.buf : "<none>";
> > >
> > > -	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
> > > -		strbuf_reset(&ident);
> > > -		format_commit_message(commit,
> > > -				      log->email ? "%aN <%aE>" : "%aN",
> > > -				      &ident, &ctx);
> > > -		if (!HAS_MULTI_BITS(log->groups) ||
> > > -		    strset_add(&dups, ident.buf))
> > > -			insert_one_record(log, ident.buf, oneline_str);
> > > -	}
> >
> > This loses the HAS_MULTI_BITS() optimization. The idea there is that if
> > you have a single group-by that can't produce multiple outputs, then
> > there's no need to do duplicate detection.
> >
> > The equivalent in an all-formats world is something like:
> >
> >   log.format.nr > 1 && !log.trailers.nr
> >
> > (because trailers are special in that one trailer key can produce
> > multiple idents for a single commit).

Hmm. Shouldn't that "&& !log.trailers.nr" be an "|| log.trailers.nr"? It
doesn't seem to make sense to say "there are things that could produce
multiple outputs" if there's more than one format _and_ no trailers.

The logic should read "there are things that could produce multiple
outputs if there is more than one format *or* at least one trailer".

So I think the right change would be:

--- >8 ---
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 95ceab7649..7e1b56e2aa 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -216,7 +216,8 @@ static void insert_records_from_format(struct shortlog *log,

 		format_commit_message(commit, item->string, &buf, ctx);

-		if (strset_add(dups, buf.buf))
+		if (!(log->format.nr > 1 || log->trailers.nr) ||
+		    strset_add(dups, buf.buf))
 			insert_one_record(log, buf.buf, oneline);
 	}
--- 8< ---

Yeah?

Thanks,
Taylor
