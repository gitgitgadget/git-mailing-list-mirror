Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B3EC433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 21:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiBZVop (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 16:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiBZVoo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 16:44:44 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DB557166
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 13:44:09 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q8so10708612iod.2
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 13:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dZ/h1L8+W41soGKQbGrF7MSSlJyeoDSW9eCu25DZmlg=;
        b=gxGhNgwO0+IsJsf6TR7WEv3Gt1256kr05aGCq3lgstRov8lKkOq276lqwLK15jxh+o
         aUKZS06OFMpTSoY1VNpjC3vFBHj6oAD6gWV9knT3Kdf3YlWNROowuDSEUMHPQF0JLj9l
         3yVuTU3p5wkZGTBzhv8xOHSLCcjqysLr1HEQklobXrfZeVLlLeIGNHuL+tqsZAGLlNrW
         4gAJC2J31U4rsJTRu0FfemoTVoF7bzogUQsYtOE1fPsgv1yiiKgbEkUwrUEB9W9Wb4fy
         8kWULIv3fC8xStOOfc0orHMH+LBFRaHvtwJUHX493q50OIlYFQctM8ewQQ5FdiEF+CJ2
         RKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dZ/h1L8+W41soGKQbGrF7MSSlJyeoDSW9eCu25DZmlg=;
        b=0QnjRp6Vv8on9m9leLMQ3Ay43JRbCeuBM+ZZKuTghiqrqqmnRF2/gFg/+qT160fwtA
         jw2JHBFsSeFdisaTEZt+idHgxQF5X1YLyULa59jzUaA9o5jDnzA/VEN63A7oz03hznn1
         qYR/GDifdRSLFcL/frHlqlMGClm1rR5xK8/zgmCBh7iepqFt5L+4jl+IqzGj4fzRHpjl
         PdPwNFh4AZJZcPkpEPYsN4EV8BAZrVwnP5rriZfekc4N1lqPIeu4bYogxv9i/tB44QoK
         gwytuGXrPp6auszS6NmB3q8jcy9KhlO36ShSC9XwykfLOoHpYQrlVgTclr65xiN16+Hr
         U6BA==
X-Gm-Message-State: AOAM533fVUM8zEN4I83n83qdiZand/zh6pQ6v26gtfAqQ1YhH/sKgCFs
        FY97VtngH3Ufl4zsgvElSRN8fA==
X-Google-Smtp-Source: ABdhPJwwt8n4bdCInRdUpM4vyKcWZq6Ar4lPeENqHkriNwaku58Sr7kf24QD/nC0O1Vg7mPNn4U0ng==
X-Received: by 2002:a05:6638:25cc:b0:311:9033:4496 with SMTP id u12-20020a05663825cc00b0031190334496mr11523655jat.225.1645911848902;
        Sat, 26 Feb 2022 13:44:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 7-20020a056e0220c700b002c22480d578sm3769899ilq.66.2022.02.26.13.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 13:44:08 -0800 (PST)
Date:   Sat, 26 Feb 2022 16:44:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Message-ID: <YhqfJ8lFD9p6BPBx@nand.local>
References: <YhMC+3FdSEZz22qX@nand.local>
 <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
 <YhQHYQ9b9bYYv10r@nand.local>
 <CAP8UFD3U4t-inWC5mZYhybWpjVwkqA7v4hYZ5voBOEJ=+_Y1kQ@mail.gmail.com>
 <xmqqv8x5v0qc.fsf@gitster.g>
 <36CA51FE-8B7F-4D08-A91D-95D8F76606C9@gmail.com>
 <YhpjbQeFaMNVnyP9@nand.local>
 <47AC2D8D-ADB2-4280-86F0-6B1E239C1EBE@gmail.com>
 <YhqNy+t5SARNivQ5@nand.local>
 <5106811D-2937-49CB-AC93-875D3B3BC241@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5106811D-2937-49CB-AC93-875D3B3BC241@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 26, 2022 at 04:05:37PM -0500, John Cai wrote:
> Hi Taylor,
>
> On 26 Feb 2022, at 15:30, Taylor Blau wrote:
>
> > On Sat, Feb 26, 2022 at 03:19:11PM -0500, John Cai wrote:
> >> Thanks for bringing this up again. I meant to write back regarding what you raised
> >> in the other part of this thread. I think this is a valid concern. To attain the
> >> goal of offloading certain blobs onto another server(B) and saving space on a git
> >> server(A), then there will essentially be two steps. One to upload objects to (B),
> >> and one to remove objects from (A). As you said, these two need to be the inverse of each
> >> other or else you might end up with missing objects.
> >
> > Do you mean that you want to offload objects both from a local clone of
> > some repository, _and_ the original remote it was cloned from?
>
> yes, exactly. The "another server" would be something like an http server, OR another remote
> which hosts a subset of the objects (let's say the large blobs).
> >
> > I don't understand what the role of "another server" is here. If this
> > proposal was about making it easy to remove objects from a local copy of
> > a repository based on a filter provided that there was a Git server
> > elsewhere that could act as a promisor remote, than that makes sense to
> > me.
> >
> > But I think I'm not quite understanding the rest of what you're
> > suggesting.
>
> Sorry for the lack of clarity here. The goal is to make it easy for a remote to offload a subset
> of its objects to __another__ remote (either a Git server or an http server through a remote helper).

Does the other server then act as a promisor remote in conjunction with
the Git server? I'm having trouble understanding why the _Git_ remote
you originally cloned from needs to offload its objects, too.

So I think the list would benefit from understanding some more of the
details and motivation there. But it would also benefit us to have some
understanding of how we'll ensure that any objects which are moved out
of a Git repository make their way to another server.

I am curious to hear Jonathan Tan's thoughts on this all, too.

Thanks,
Taylor
