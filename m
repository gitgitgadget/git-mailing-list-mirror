Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC79C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 23:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbiCCXgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 18:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiCCXgY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 18:36:24 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8552B26B
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 15:35:36 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id t11so7705423ioi.7
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 15:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OreKQSqMehJ7gYAO6lZukrhzYb2yeKuRO1jrADvVMPY=;
        b=6cIXNPWOmUhKqVHf+wVI4Qu/NmyeJ5civBhHHVbEBZb3QnHMJN+gHZKkl2Ry/g+r34
         PSvExEwTvnzO279X9zyNOQAYRUR6pSvQDMOiuG+cJut4/NFvrlDS0NNgKkSVoKVPo1b/
         dkkrUsjXmzmUdRPsjV1yp6U0B4LuW9qRDokhxSWOpJc+/cuLqtJ4UUUCdZTCPGPUjrMh
         zeN/NIx5/imPcDdoewBF1BTJ/u06OJkEtIcX2RJSftNqdpX7ytsKljF+/zs1KgRfAInp
         BJ+D+1jw/EDjbRVg6d35vV4fQlruXirHUgyUup+ZjfIQGiDR1s0nesrNojJUsiaTokv9
         kuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OreKQSqMehJ7gYAO6lZukrhzYb2yeKuRO1jrADvVMPY=;
        b=ynj6UL9z3T8bLCkNSeztThBo/Zxs9PtsMhqvMBvAQpNq7veER4Mf3rBeiWlEqWspoc
         +RLa9Bj2p1g5YQv+D2K/0/iMTRlp6AJS2t/En/NOrlfvy31OrNGP+650L5/4XnzzjM9U
         pgPjB+6TN+o0TeIzFMZzF0DTW3XMEII6VCIzNC/BWfhoCXqQo2rcwyddIdH1MJoh0ePj
         i2Kng4XwvdiAGPst6L/0rgQKIYYSIyNi8qwmS4K9MsszJFV1UdClFTSU4OMtpOcH01Q7
         VyEDHDsmFGTxuOZ1wd/qrjAbs6x/NgOBlXadDhINzOh1SDaINHHCrFR9YVzf0aIE1gEI
         sfdQ==
X-Gm-Message-State: AOAM531F6r43B1hAW8PFyeFRkO9ZebL9MgAUJGAjigs9se+FliErOLIL
        E5GWMIbln8EHuLh+LgJrxBNyqg==
X-Google-Smtp-Source: ABdhPJyLMl4cvMGRkyxi0z4zaoBY9aPQN5omvkS4NlvKxnCoPAPheFiyB87YCUpvEHr6LLvWZDMFYg==
X-Received: by 2002:a05:6638:22c3:b0:314:519e:d990 with SMTP id j3-20020a05663822c300b00314519ed990mr30431805jat.209.1646350535534;
        Thu, 03 Mar 2022 15:35:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k6-20020a056e02156600b002c2f7c95b7esm3563942ilu.51.2022.03.03.15.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:35:35 -0800 (PST)
Date:   Thu, 3 Mar 2022 18:35:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, tytso@mit.edu,
        derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH v3 05/17] pack-mtimes: support writing pack .mtimes files
Message-ID: <YiFQxsmkcqb63azh@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
 <0600503856dbccb135aaead27693b6815a774b4f.1646266835.git.me@ttaylorr.com>
 <220303.86ee3j2dae.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220303.86ee3j2dae.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 03, 2022 at 05:45:23PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Wed, Mar 02 2022, Taylor Blau wrote:
>
> > Now that the `.mtimes` format is defined, supplement the pack-write API
> > to be able to conditionally write an `.mtimes` file along with a pack by
> > setting an additional flag and passing an oidmap that contains the
> > timestamps corresponding to each object in the pack.
> > [...]
> >  void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
> > diff --git a/pack.h b/pack.h
> > index fd27cfdfd7..01d385903a 100644
> > --- a/pack.h
> > +++ b/pack.h
> > @@ -44,6 +44,7 @@ struct pack_idx_option {
> >  #define WRITE_IDX_STRICT 02
> >  #define WRITE_REV 04
> >  #define WRITE_REV_VERIFY 010
> > +#define WRITE_MTIMES 020
> >
> >  	uint32_t version;
> >  	uint32_t off32_limit;
>
> Why the hardcoding? The 010 was added in your 8ef50d9958f (pack-write.c:
> prepare to write 'pack-*.rev' files, 2021-01-25). That would be the same
> as 8|2, but there's no 8 there., ditto this new 020 that's the same as
> 1<<4 | 1<<2, but there's no "16", just WRITE_REV=4.

I'm not sure I understand. These are octals, so octal "20" (or decimal
16) just gives us bit 5 -- the next available -- by itself.

Thanks,
Taylor
