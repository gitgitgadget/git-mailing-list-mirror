Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9216C433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 00:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKEAfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 20:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKEAft (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 20:35:49 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484A421834
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 17:35:48 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e189so5094102iof.1
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 17:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJsUXRrVsnbgSOmLYn7gM77MGl+/pJ/iKpxN5kAI8SY=;
        b=Sxd8b2M20tH+np5rmmsDw8yN48Owak7ybEuECelPKS9tro3HYLpCvZ7s6E3hEl5myq
         XOl/fkBNQmkhsdZsEwPGoymiG/IMDMHxbxFeKtG44+6D84ZMtiamdIIQdaKXA7XMQeKm
         L+gYutTYNSdShW4YR9173M5SUnoI4vX5aUGAGqF7P/QPoJYFo/1l39iLfFW60flO/s02
         U79ghyKssLygTGein5DJyXZu5xt/nFpRLM3yfD/s6IEkQiaVkLKKOd3FCOsLGzwGGOd7
         GSQATXwjzU+HrS1G0N3h76w4qhuamofyuwSPLGEgs+WcdPBQBIEChZzPP7HG3uJ2V4ON
         WwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJsUXRrVsnbgSOmLYn7gM77MGl+/pJ/iKpxN5kAI8SY=;
        b=YI9kgp8+zd7tlx4CIqkbJseXHAiLNqoYxVhLGWccySYoFsW5gFAPavdsKh3tECgPdo
         kO5SVP91W89bT2Rw5KdXadYwhpgQ8CAK7t0O90KSX/+/DrfX9jrJ6bELnzC84IxFsyh+
         7ZYllgCKEMUMd2iWWNSsNpcNBxBQfdaqgHb1nQMzE0xQv62XWSBECIvjTF/UY3QEUnuv
         Go2PT9SRenrfitFrVldSYXjM4kYisE64NgCLAevPMoEaftaw3R7RWWO3KQl9hTrkKr44
         zJeqz0eUtxgOU1VmYQ1QBZkki8tdh4NLfuQkYJer/ywAZgxg3bFLLBLE0krEg9x3poUi
         HjxQ==
X-Gm-Message-State: ACrzQf0k5jo86lK60UvEiH6KmW015UFVqT1sw2f7pIbZDxxnEzBoCJze
        F9Ng23X1gLJu1IB9P73r6b0gNQ==
X-Google-Smtp-Source: AMsMyM4re06WdpeOFMlQy2h4QMYj+9NkUEKHvUU1QKBraX6OZVcQ91C1HdpFT7M4fQrGqg/+WI9SXw==
X-Received: by 2002:a05:6638:3812:b0:375:a885:f945 with SMTP id i18-20020a056638381200b00375a885f945mr2493993jav.173.1667608546953;
        Fri, 04 Nov 2022 17:35:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c1-20020a023f41000000b003722e5b561csm168167jaf.52.2022.11.04.17.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 17:35:46 -0700 (PDT)
Date:   Fri, 4 Nov 2022 20:35:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     me@ttaylorr.com, avarab@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, gitster@pobox.com, moweng.xx@antgroup.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/1] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y2Wv4b7y0KS8KYHy@nand.local>
References: <Y2MWeE2f/P1iXPCY@nand.local>
 <20221103093532.40511-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221103093532.40511-1-tenglong.tl@alibaba-inc.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2022 at 05:35:32PM +0800, Teng Long wrote:
> I'm not sure if trace2 data will be given to end-users, at least as I understand
> it as you, it's not. If so, your opinion is very reasonable.
>
> So... maybe we could add a new configuration like "core.hideSensitive", and
> there are some supported values , "loose", "normal " and "strict":
>
>     loose: plumbing full information in trace2, even warning.
>     normal: plumbing full information in trace2, but not warning.
>     strict: plumbing part of information in trace2, but not warning
>
> But it looks like heavy, maybe not worthy... So, currently I will remove
> basename and print the pack with path if there are no new inputs here.

trace2 data isn't sent to users. So having read this after I took a look
at the updated round, I am glad that you pursued the approach that you
did :-).

> > > -test_expect_success 'complains about multiple pack bitmaps' '
> > > +test_expect_success 'complains about multiple pack bitmaps when debugging by trace2' '
> > >  	rm -fr repo &&
> > >  	git init repo &&
> > >  	test_when_finished "rm -fr repo" &&
> > > @@ -420,8 +420,13 @@ test_expect_success 'complains about multiple pack bitmaps' '
> > >  		test_line_count = 2 packs &&
> > >  		test_line_count = 2 bitmaps &&
> > >
> > > -		git rev-list --use-bitmap-index HEAD 2>err &&
> > > -		grep "ignoring extra bitmap file" err
> > > +		ls -tr .git/objects/pack | grep -e "^pack-.*\.pack$" > sorted-packs &&
> > > +		ignored_pack="$(cat sorted-packs | awk 'NR==1{print}')" &&
> > > +		open_pack="$(cat sorted-packs | awk 'NR==2{print}')" &&
> >
> > Hmmph. This test only passes if 'ls -tr' gives us the packs in order
> > that they are read by readdir(), which doesn't seem all that portable to
> > me. At the very least, it is tightly coupled to the implementation of
> > open_pack_bitmap() and friends.
>
> Yes, because the _order_ matters here I think originally. May you explain a
> little more about _portable_ problem please?

We're depending on the loop in open_pack_bitmap() seeing packs in an
order compatible with the output of 'ls -tr' here. In other words, for
this test to pass, we care very much that the pack we collected as
"$ignored_pack" is seen *after* the pack that we designate as
"$open_pack".

Does that help?

Thanks,
Taylor
