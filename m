Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4118C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 01:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJSBMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 21:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJSBMM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 21:12:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7252FDD8A8
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:12:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id q19so23017011edd.10
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJp7BI99M5F4x52b53oaFaUQToD4gKMwopxwnLLWqp8=;
        b=XHdVBWLiC6x2t5x4x1n7vRTNgWx/y1YjpdyTXQZE79mdbl4/xR0CPgtIZ1i/XG4QKq
         ptNCyPAoku7TdIrfdSn/Lahh3KASTfSRBus5cp+POWXZgOkTzsVAqWLrPypDXTAyTr9y
         aWpwcxluXn09Lg+jHGG12usWP3clZ91EpMG/5D4EmHxinj6sOy83TjoVLmXgzKFhpH/Z
         RiPIPLRy5EW/gLVj2w8jYCPSrsFyQZz+OUmc8pd5VdgwQ6I6IXr+NSSvyA3qpnhH4213
         EDOD2/ajGLeVhP46F+VZaXcFwj7hiVOnr1s0zqNxrylwS+ZPbArNhNELiVr503kSxqRs
         bYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJp7BI99M5F4x52b53oaFaUQToD4gKMwopxwnLLWqp8=;
        b=Iqm6bUEbnN844YKN8xPN47/6RO0LWH6t7E6QDYMgRlyCsYY6rEDfO3I6uZPx98n7hw
         MdN6YCYsc2tA97zuItw6vhfi6vCt66/+eDSf29wfWGW/2nEQebpl0tNU+FjLnW4s03/R
         fAzFpP/FIlLTQY8/zVLvGZk/qhH2SD5mfoL50mElSy3vMI4YHAhgEBTkBVaodm2mxvfS
         CI0FA5MkRiEGIzt6j6xm6VPLVMcTSVW7dt5Kijlnlv36E1zdZUEh6nnIMHJB9Lvj+68G
         6jP7f0hJV4btO2QCiESqq34X+meyGhWOIn9VmEDaDVXZAWcMgd8+E/isSxTZTkQ00nlf
         kZQw==
X-Gm-Message-State: ACrzQf3/k6yUnk2FNNSCSNHZseJAGnluPGp2UV4NCjiXKRIoNGukiIFW
        fR2yI8zILzRIgMnT2F3HPjYnG523DyW+Zw==
X-Google-Smtp-Source: AMsMyM5/yWpLhXuoFMU25p9cVsJgOxBMQFjm9QHI3ivxby+6NAbCDWH6bhk4nnTSjIJzUP3gzt8hSw==
X-Received: by 2002:a05:6402:4511:b0:45c:b2b4:3e69 with SMTP id ez17-20020a056402451100b0045cb2b43e69mr4965665edb.339.1666141929985;
        Tue, 18 Oct 2022 18:12:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063cb200b0073dc4385d3bsm8184583ejh.105.2022.10.18.18.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 18:12:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okxct-005wvk-3D;
        Wed, 19 Oct 2022 03:12:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
Date:   Wed, 19 Oct 2022 03:04:41 +0200
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
 <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqo7u9wyt7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqo7u9wyt7.fsf@gitster.g>
Message-ID: <221019.86fsfkhb14.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 17 2022, Junio C Hamano wrote:

> Glen Choo <chooglen@google.com> writes:
>
>> At $DAYJOB, we observed that this topic breaks MacOS builds with sha1dc:
>
> Thanks for a report.
>
> How dissapointing.  The thing is that the topic has been in 'next'
> since the 11th (i.e. early last week), and I know that you guys rely
> on the tip of 'next' in working order to cut your internal releases,
> but we did not hear about this until now.  What makes it taste even
> worse is that nobody else caught this, even though we seem to have a
> couple of macOS jobs at GitHub Actions CI, there we didn't see any
> breakage related to this.

FWIW I see you caught it on the 9th in
https://lore.kernel.org/git/xmqqh70c62w0.fsf@gitster.g/, but then the
base topic was merged down on the 17th.

> Possible action items:
>
>  * See what configurations our two macOS jobs are using.  If neither
>    is using sha1dc, I would say that is criminal [*] and at least
>    one of them should be updated to do so right away.

I submitted a v2 of my series to finally make OSX use SHA1DC by default:
https://lore.kernel.org/git/cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com/

As part of that we'll CI that & the current "apple common crypto"
implementations, currently we just do the latter, which is why we didn't
catch this.

We could follow-up and CI the OpenSSL one too, but that was a larger
change, so I punted on it.

In any case,
https://lore.kernel.org/git/patch-v2-1.4-392fabdb456-20221019T010222Z-avarab@gmail.com/
in that series un-breaks master, maybe you're interested in peeling it
off & fast-tracking it? I didn't submit it separately because I don't
know how much of a rush we're in there (given that CI isn't broken).
