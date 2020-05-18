Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89405C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F362081A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNqCI194"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgERTML (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 15:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgERTMK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 15:12:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B3CC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 12:12:08 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cx22so286401pjb.1
        for <git@vger.kernel.org>; Mon, 18 May 2020 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EbVNkH8OqbDC3lMJs0p6qYAMvDS7bPEEBHt85ijx4aw=;
        b=WNqCI194u5elxnzUaQfsLXd14LUghwhR/BTS/C7S4DMcqx5DmEK61flqb04Z6FGRvd
         vp+OhMO0KrvELSIGCYPNK1ITgqmWj3Imdnnn5KbMOmNPF1z6x5lB1e/ZIoAcUJOByBHP
         E+A2M1bcyjYHllE0c4PXnSG7+ohbE7T6TwMsuwK/8NnCPATZX8EyUWi+b7aGKt5LI18L
         iulh++Bb4H0yWApM+ukKCN35U0ot9sItpCRYoJJ4zjSTjBdgCiSI2x5CsCg+6i71+oJh
         QQ4RkyYLuwDSUpeAlphtbFzbuEl/+Yt16hiFujDd7gzVpyGfjDPgARcYnTv+nwnupOmA
         uXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EbVNkH8OqbDC3lMJs0p6qYAMvDS7bPEEBHt85ijx4aw=;
        b=NGbncJHP9zBF1jELfIv4HMAZsG4iQlKxxZJuuIKZ+kgBwNI1snKMqrX2ivg+0BlMM9
         WBBslCmapdjAdC5/pBKLi/vpTmfhKU7R0TRGcRoAgT3IupZqWZmG8xAPqphacAHXh114
         jemSaQp7Fgqp460d8rHS+RXN2+RnGBuEIR4QpODzxxpjTxyMRqSOwDob7x6bNbBlPfPb
         pTpufSlPBuRH1pfZhIOisI6KuYg5rkV+5lQCnMfEZAcU5ZG+uyyfNpnzcdY2LePrBO/4
         2K947curnUPpXuYP69106D6XqXoBaVbaALlqaE3ot6WBPKa2/jJATS/92oHs6oSD9HER
         mUnw==
X-Gm-Message-State: AOAM53258lnkG/5Y01lmrfYnQNz19WertkCXkkb6IJ98ATj6lX3gtlk+
        jFM5A1WWkNScwgCtCiP1xZA=
X-Google-Smtp-Source: ABdhPJxyM71kUKO98e73rCojmFFcdViYLNbM2h9PH+26KVnu2UpZu/RNwvpKh9w4u9Xi99P3jT8o8w==
X-Received: by 2002:a17:902:d913:: with SMTP id c19mr16716006plz.229.1589829128458;
        Mon, 18 May 2020 12:12:08 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id s15sm8222161pgv.5.2020.05.18.12.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:12:07 -0700 (PDT)
Date:   Tue, 19 May 2020 02:12:05 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Laurent Arnoud <laurent@spkdev.net>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v5] diff: add config option relative
Message-ID: <20200518191205.GA1999@danh.dev>
References: <20200515233130.GC6362@camp.crustytoothpaste.net>
 <xmqq1rnk923o.fsf@gitster.c.googlers.com>
 <20200516173828.GB34961@spk-laptop>
 <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
 <20200516194033.GA2252@spk-laptop>
 <20200517021452.GA2114@danh.dev>
 <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
 <20200518094021.GA2069@spk-laptop>
 <20200518135656.GB1980@danh.dev>
 <xmqq4ksd5ggq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ksd5ggq.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-18 09:57:09-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Hmph, what do you exactly mean by "broken patch"?
> 
> I actually do not mind people who set "diff.relative" to do
> 
>     $ git config diff.relative true
>     $ cd t && git format-patch -1 --stdout
> 
> to get an incomplete patch that covers only the t/ subdirectory, as
> long as they can ask Git to optionally get the full view with
> 
>     $ cd t && git format-patch -1 --stdout --no-relative

Well, git-format-patch has never understood --relative,
which I think is a sane behaviour,
hence git-format-patch will never understand --no-relative after this
patch.

Oh no, to my surprise, git-format-patch does accept --[no-]relative, now.

We don't document --relative for git-format-patch, the --relative
documentation is placed under the guard, for that matter:

Documentation/diff-options.txt 


ifndef::git-format-patch[]
-R::
        Swap two inputs; that is, show differences from index or
        on-disk file to tree contents.

--relative[=<path>]::
        When run from a subdirectory of the project, it can be
        told to exclude changes outside the directory and show
        pathnames relative to it with this option.  When you are
        not in a subdirectory (e.g. in a bare repository), you
        can name which subdirectory to make the output relative
        to by giving a <path> as an argument.
endif::git-format-patch[]

Maybe time to fix the documentation.

-- 
Danh
