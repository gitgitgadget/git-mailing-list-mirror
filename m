Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5351EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 12:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjFUMZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 08:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjFUMZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 08:25:25 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDEADD
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 05:25:24 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b58e439794so2036466a34.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 05:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687350324; x=1689942324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ5SLDqIYp3dGRb/epMVTLIrqD39AXTpojlLnIzC5zU=;
        b=QoIDfsREZddl8YMinzTq9vokZhTykr2bmg86ShRofDFxPT0+JBTe5zr8FJRiUPSqWn
         CvsyO/pLUEGmqmrD6W3Mc31IL6KtYwdQn7LRzZJZzAiAO5FJ8k3XTejNcipY5JKOA7DL
         cfWp/RLZBN2q6BluLB8OgG0D32mbh0oIEnL3CWLPs+J8DWvgj8uLI9xU8gorSbkB9XwQ
         uQizWG2fwxuDjV5K3chnpu/1FBKUH9uj/2yTLU2Ag4v7uYzyNWccuepN3TeZov3ymPgV
         oCGW9AV1a119esT4WlwD9gFPt1ZYsK3M5aNUzkVlZTevpYyl0sIoBnHFs89dSMTGxdRw
         ZUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687350324; x=1689942324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ5SLDqIYp3dGRb/epMVTLIrqD39AXTpojlLnIzC5zU=;
        b=lzSaupLpp9IwGWxN769IrM6WbefG2Nii0CsNWotD0QYduGiP7GmJ/xqoQKWsSkWFNt
         Qp/36b1oXwyfrtSIvBbIAWIp4Gl9244HowrFTww5rpcUVvEpVuygepYdVCNDyTVdXrxE
         nXz8F5Ob7AzO0RaAhUUMHWxzDzZQvLRlk9coT/Ys8IOSZJ1g4Rghnp8anmLy7P2nXs1k
         6IbzpVA/9+SJhI5bMCPIOp0wAiyltKj+P36mmmt/lyAArx/cyVqqB/lcxz8q29E66HxS
         z3DMIIn1ssAzT61HJXUFjIBOek7TIvxzgXJCWVfVMaWcsIKQbyM/OT3v/3ylyL+s/kki
         Umiw==
X-Gm-Message-State: AC+VfDzIbxNKYdT0ix/83n65II7TpdY4bM5+WGBiKYBr3Hz6btaXbl2t
        +B5fgdDwtw96YUSFFwA65SUs7A==
X-Google-Smtp-Source: ACHHUZ7wHDVAMAQzJ/RSfF0rc+KPovBp0pSDXpK6m9IehBRWUKVWpGcooUyUdgECwPr8JcgzL4mxwQ==
X-Received: by 2002:a05:6359:220:b0:130:e60f:6b1c with SMTP id ej32-20020a056359022000b00130e60f6b1cmr5676123rwb.15.1687350323857;
        Wed, 21 Jun 2023 05:25:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w187-20020a2530c4000000b00be865f3d4fdsm895473ybw.62.2023.06.21.05.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:25:23 -0700 (PDT)
Date:   Wed, 21 Jun 2023 08:25:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 8/9] repack: implement `--filter-to` for storing filtered
 out objects
Message-ID: <ZJLsMK73ae8Htec4@nand.local>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-9-christian.couder@gmail.com>
 <ZJLjvhnh0lSRCVzG@nand.local>
 <CAP8UFD388DOTqueok7fRF+=-+s_PNria1oB18AEed3gjdRrqJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD388DOTqueok7fRF+=-+s_PNria1oB18AEed3gjdRrqJA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 02:08:38PM +0200, Christian Couder wrote:
> > > @@ -1073,8 +1077,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> > >               strvec_push(&cmd.args, "--incremental");
> > >       }
> > >
> > > -     if (po_args.filter)
> > > -             prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, packtmp);
> > > +     if (po_args.filter) {
> > > +             if (!filter_to)
> > > +                     filter_to = packtmp;
> > > +             prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, filter_to);
> > > +     }
> >
> > Would you want an "} else if (filter_to)" here to die and show the usage
> > message, since --filter-to needs --filter? Or maybe it should imply
> > --filter-to.
>
> In the doc for --expire-to=<dir> there is "Only useful with `--cruft
> -d`" and I don't think there is a check to see if --cruft and -d have
> been passed when --expire-to is passed. So I am not sure if it's
> better to be consistent with --expire-to or not.

TBH, I don't think that my decision at the time to silently accept
--expire-to without --cruft was the right one. It should at least
require --cruft, or imply it. It doesn't make a ton of sense to use
without -d, but doing so is OK, so I wouldn't consider that a failing
condition.

In other words, I would be fine with something like:

--- 8< ---
diff --git a/builtin/repack.c b/builtin/repack.c
index 0541c3ce15..1890f283ee 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -866,6 +866,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
 		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "-A");

+	/* --expire-to implies cruft */
+	if (expire_to)
+		pack_everything |= PACK_CRUFT;
+
 	if (pack_everything & PACK_CRUFT) {
 		pack_everything |= ALL_INTO_ONE;

--- >8 ---

But that sounds like a good candidate for some #leftoverbits.

In the meantime, I would be absolutely fine with deviating from the
existing behavior of --expire-to w.r.t --cruft.

Thanks,
Taylor
