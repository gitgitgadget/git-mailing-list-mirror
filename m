Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B6FC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64C764F50
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhCLX2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 18:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbhCLX1k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 18:27:40 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FDCC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 15:27:40 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so11456637pjq.5
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 15:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FQ3yBuKciZDFLINCPZKu+kqdVbsaf0ZZrZziG7V1/g4=;
        b=T8Uj1dngAi5lXxgHRCL9biyfmVogW7lSkCwIQyqzKsyvY1V8RIYnH13vQNTBzAjVBU
         BJ8Jkd7y7Kld/Xveo3IkGJt50xks/G24ktBtRZo0CDK0YMY19JbZpjhHuox+n8U0X6iD
         osXGDVBn45TQXRye86MJf7cj3vKMoKW8H8zc7UOv5WFWS9Nm/SRZDWxHNEODL5GnMkGV
         l6m1ycQSLOGHv7CQMI+rJ0vBJ2/HtuSG/t7rcRUdrzDFxm9WieR+eNiuJtYJmAhc8fuK
         4oH80JAF2mS2yedQ0pXeZukXp+aehPfn/QkuPEWmA0KZcampPggqkGAP3FLq/BiNT3pn
         auiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FQ3yBuKciZDFLINCPZKu+kqdVbsaf0ZZrZziG7V1/g4=;
        b=BRDH8sAV89IukE/nr17ccayslksKrj40LwVevOPoxOlwDaNgDBfelNyn1VnkG4KK+k
         LZKQucRSrcfd/qDgDH3KKeGnvChk1Pw2fsxixOsUHJVLYwg20EDjAQqEUbFMkiD7rhu5
         TfvtIvLL2t2igqiEl8pbfqpMnAhiLviLOoOoG0tp1gJzUDt69288FQR71Az6O8+/kHoX
         uZupeFJelaE2itoaIB3KquGkYi7nN+offYbb4V2nrvYVv99HtvO6UtNzdnwavmDQf+47
         RQzk0kjMVMwolS2vJA2ZlNb+nuioVf+cqPO5e5XfzpNv/es7PDdSXx0gQgPX5EOxiY/T
         pCLQ==
X-Gm-Message-State: AOAM532Es6Npc9ihKBeK+tbdcPhj1OG2mCqrFUqkdc6HKuOcL4LMCNXo
        7Ws4HWJdJ81YUu/htUdB6u/Q6g==
X-Google-Smtp-Source: ABdhPJzvZEDfq2HUyyz9NI2eCI2lhG4XApjHsYHf3W5EF/cs47RQ9zXv7Ql5M0yxBZxkI9DhCbScFA==
X-Received: by 2002:a17:90a:e00c:: with SMTP id u12mr631250pjy.133.1615591659856;
        Fri, 12 Mar 2021 15:27:39 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:b463:c495:6445:6cb3])
        by smtp.gmail.com with ESMTPSA id u20sm6495015pfm.146.2021.03.12.15.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 15:27:39 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:27:34 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v8 00/37] config-based hooks
Message-ID: <YEv45hrEytdM00iI@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <xmqqim5xba4d.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqim5xba4d.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 02:26:10PM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Since v7:
> > - Addressed Jonathan Tan's review of part I
> > - Addressed Junio's review of part I and II
> > - Combined parts I and II
> >
> > I think the updates to patch 1 between the rest of the work I've been
> > doing probably have covered Ævar's comments.
> >
> > More details about per-patch changes found in the notes on each mail (I
> > hope).
> >
> > I know that Junio was talking about merging v7 after Josh Steadmon's
> > review and I asked him not to - this reroll has those changes from
> > Jonathan Tan's review that I was wanting to wait for.
> 
> I picked it up and replaced, not necessarily because it is an urgent
> thing to do during the pre-release period, but primarily because I
> wanted to be prepared for any nasty surprises by unmanageable
> conflicts I may have to face once the current cycle is over.
> 
> It turns out that it was a bit painful to merge to 'seen' as there
> are in-flight topics that touch the hooks documentation, and the
> changes they make must be carried forward to the new file.
> 
> But it was not too bad.  
> 
> The merge into 'seen' is 3cdeaeab (Merge branch 'es/config-hooks'
> into seen, 2021-03-11) as of this writing, and the output of
> 
>     $ git diff 3cdeaeab3a^:Documentation/githooks.txt \
>                3cdeaeab3a:Documentation/native-hooks.txt
> 
>     (i.e. the version of the file before the merge, where your topic
>     being merged took material to edit to produce the new "native-hooks"
>     document, is compared with the result)
> 
> looks reasonable to me, but please double check.

I had a look at that diff (but targeting 6da6893c, which is what I see
for "Merge branch 'es/config-hooks' into seen" when I fetch from
gitster/git today) and it looks fine to me, very reasonable. Thanks for
doing that.

> 
> Thanks.
