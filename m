Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AF3C433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 03:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D287222E9
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 03:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Fs8friso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391027AbgJTDPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 23:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391024AbgJTDPR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 23:15:17 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EBDC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 20:15:15 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id 67so864339iob.8
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 20:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vn8IJfLfhXVaN89Ue1g40faFtqaJKUlnFLzzCN5U7zk=;
        b=Fs8frisoVKtY+q9XfxUEGoh6NyzjZAkjZv4EokjGHLtkHrhSXKezAju4+r4iDpXPEi
         BANkWjSJWhduF1//hCEsbwYEAiL7p/Jds5BVSJAVk5Tn7fjwmv53zujVSop7D4xhiLSr
         kJsQWF5peqDFajMWRyH822mVX5KK1WeXAPI2TLeEnUMsucicTueymbSwnuEJEIS6TeP/
         j2kvXMhy2lek1zVo06RKix9DuF6BbEQJuI0zNFl0NoTzb15BpvJsNVKkp5l2FiCJd40Y
         HLoJ7WPu/I6p+WWef7HaMyHm7CwKJzymIBh4aG+KdLIh00jEuXYrirwQlN8FoF/GMoRi
         7JpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vn8IJfLfhXVaN89Ue1g40faFtqaJKUlnFLzzCN5U7zk=;
        b=Yfm7NH/vkQDj5KltsiSe/tXip8G/slVUyXUKVMwwXD/H8uUKw6OmVXDwScUvNnTeEm
         1TrGwR2/7ioiJNvY+44hklgeEueJilyRsMkm1NtiXIfJc1+kmrDk5gjEvM00D0OgNLOP
         Ed5iaKOPf93blyAX+5bbcZSWyfZg02I9Z9D4ZeVsITCXlVCKdzh3n5O/+JLcdmwPW3qa
         lPKQhWO+f7T87rfpLDfuVLe0skMspMeB3i+cbTpDQFv9qTwigEJsssnb2QHmzFx/J6sN
         PBXoT5tGKj21FFCnxErh5J1IZym7kddm5sDHhszQ5FtJFkVtbLP12QI9tZ9t9Kh8f6fY
         4NNA==
X-Gm-Message-State: AOAM533DO4FwGhcNaKQikYItphum3axh9+wE+g+OkOE+9OBfrwyHZsBf
        Cr3HPzWToUHx9h7fgiBL3rg8eA==
X-Google-Smtp-Source: ABdhPJyFWvZfkEee9Jemo7LG5GVDZcJifB1dO+sxq3WT724Ei1h6I8Yu5JJIIzh6MLbCOqiWzApZ+Q==
X-Received: by 2002:a5d:84c6:: with SMTP id z6mr712984ior.0.1603163714832;
        Mon, 19 Oct 2020 20:15:14 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id q23sm466687iob.19.2020.10.19.20.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 20:15:14 -0700 (PDT)
Date:   Mon, 19 Oct 2020 23:15:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Subject: Re: [PATCH v3 5/7] perf lint: check test-lint-shell-syntax in perf
 tests
Message-ID: <20201020031509.GA56322@nand.local>
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
 <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
 <28c1e488bf644786af071e66b73450baa47ccc44.1603147657.git.gitgitgadget@gmail.com>
 <20201020023857.GC54484@nand.local>
 <xmqqlfg1d22n.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfg1d22n.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 08:10:56PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >>  		echo change$i >unrelated-file$i &&
> >> -		seq 1000 | tac >>unrelated-file$i &&
> >> +		test_seq 1000 | tac >>unrelated-file$i &&
> >
> > Makes sense. I wouldn't be opposed to breaking this out into an earlier
> > change (e.g., "it's about to become not OK to use seq in t/perf, so
> > prepare for that by replacing any invocations with test_seq()"), but I
> > think it's probably not worth it, since this patch is small as it is.
>
> test_seq is fine, but I do not think tac is portable (only saved by
> the fact that not many people, especially on exotic platforms, run
> perf scripts).

Serves me right for reading while I'm tired! I glazed right over 'tac'.
If you need a truly unrelated file, you could write random data into it
(there are some examples in t/test-lib-functions.sh), but I'd just write
'test_seq 1001'.

Thanks,
Taylor
