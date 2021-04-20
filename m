Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4984EC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 07:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A316101E
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 07:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhDTHuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 03:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhDTHuL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 03:50:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D11C06138A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 00:49:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v6so55527887ejo.6
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 00:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fbB/Wb/cgbdO89MBXrQ8XCJYTFNIaa4MqriOJkm48uE=;
        b=DLYZ35iemruYujSM881Ay0GlSzSds6ckYK43IAKvWz42lWTX4lksWQRXJc24bDb968
         04eujlHG6Dl0J/MjRrSxRdx0SyL8pRUgm2rztE+9P/q/AoLF9yEY+TnEU5yLyUh9EcYS
         vHt6KdV1EIlUAZt3QQvjDNeTKP+Vqga4GXXBS03dLk/ldv8Q2I/ifkbv7N0Rdu1d9jWo
         GEYNKokTHN3lgTTNRxQj8K9xbhEyIJGLg7BpIwYm2e0DNdQ0Vr/ymXlmZPtoUVknAd9R
         xk7biavVoEE6Nn0jT6a9qAxe77ezmZKsCFwFmO7weIJRHPe6YBQ9pj/T08HCljSLzkFw
         vWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fbB/Wb/cgbdO89MBXrQ8XCJYTFNIaa4MqriOJkm48uE=;
        b=iVsGJVu7QqT+LREAcdaVRG3/lUTp5YGviHWjlxZUUwQN3nXvwvAG2wXAiPhlmcW6Bt
         un6CXe/N0WsYYXBnPrMBJSrR9lvaRBi+69GbZAZzDlG+HmaQtSYzcLc0EKjS+zl+oe1Y
         tvPURQtW458tYPf/XdXsNMOIOE2xGAz8RxhYxtG6IHQ3h/d6whHkuFaYWIfeqJcPHPW5
         yU5hS6PQRaOCHwnwrwVTOrwN1IhkvsZ+jPgQNjpy4Ix+IISZEyf6TYjdY/QnW8PU5lQ5
         aXg0VyhhPNOKTTops1teLwvq3AlP0x0DvvK2OunSfh8a5Tm88ihSm7B6QETmodl621fi
         T31g==
X-Gm-Message-State: AOAM532o3xO+ubVEuUulQFkrMmxAWtWiYMhhpomrFt6pcR7pvB5sGGTb
        Tg493s/IGRx3ABV3J8O7kLc=
X-Google-Smtp-Source: ABdhPJyvx350dAnGrqMB84a/EJzi5BHIK9+NzwXgA0AXuE2xtmK23ZbqNESiyz9MZHqNQ/A7F05fQw==
X-Received: by 2002:a17:907:9811:: with SMTP id ji17mr19337258ejc.188.1618904978371;
        Tue, 20 Apr 2021 00:49:38 -0700 (PDT)
Received: from C02YX140LVDN.corpad.adbkng.com ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id s8sm4281733edj.25.2021.04.20.00.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 00:49:38 -0700 (PDT)
Date:   Tue, 20 Apr 2021 09:49:35 +0200
From:   Son Luong Ngoc <sluongng@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Pain points in PRs [was: Re: RFC: Moving git-gui development to
 GitHub]
Message-ID: <YH6Hj2/fGimrLuZ+@C02YX140LVDN.corpad.adbkng.com>
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
 <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com>
 <86k18rbbyz.fsf@gmail.com>
 <CABPp-BG2SkH0GrRYpHLfp2Wey91ThwQoTgf9UmPa9f5Szn+v3Q@mail.gmail.com>
 <CAGr--=LKBq17XSLpe=uJbEPSfCp5Fpi_uw4d87DgJ8-S4Md0kQ@mail.gmail.com>
 <CABPp-BEcpasV4vBTm0uxQ4Vzm88MQAX-ArDG4e9QU8tEoNsZWw@mail.gmail.com>
 <20210419203327.GV2947267@szeder.dev>
 <xmqqsg3m7xin.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsg3m7xin.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Apr 19, 2021 at 02:52:16PM -0700, Junio C Hamano wrote:
> 
> Interesting.
> 
> I recently had a similar experience with Gerrit, where a patch I
> have seen quite a few times on Gerrit at $WORK had an embarrassing
> syntactic issues I did not discover until it hit the public mailing
> list.  It may be different from reviewer to reviewer, but at least
> to me, e-mailed workflow forces me to apply the patch to my tree
> before I can say anything non-trivially intelligent about it and
> once applied to the tree, it actually let's me play with the code
> (like, say, asking the compiler to give its opinion on it).
> 

I think this is very much the point of having a good CI pipeline:
  - Apply patches into tree
  - Compile
  - Run relevant tests

I'm not sure about Github PR, but Gitlab's MR workflow also provide a
merge queue implementation(Merge Train) coupled with CI to ensure the
merge result is accurately verified against tests.

What might be missing from (most) CI services is a bisect pipeline that
help us identify culprit commit that broke the tests, but that could be
engineered.

> The experience I had with Gerrit at $WORK gave me side-to-side diff
> with context with arbitrary on-demand width, even with per-word
> differences highlighted, and it may be wonderful that I can get all
> of these _without_ having to apply the patch myself, but what it
> gave me stopped there.  There are a lot more things that need to
> happen beyond looking at what changed in the context of the files
> during a review, from grepping in the tree for functions and
> variables used in the patch to see their uses in other parts of the
> system that the patch does not touch, to make various trial merges
> to different topics that are in flight, and Gerrit didn't help me an
> iota, but still gave me a (false) impression that I _did_ review the
> patch fully, when I only have scraped its surface, and the worst
> part of the story was that the UI feld so nice that I didn't even
> realize that I was doing a lot more shoddy job in reviewing than
> what I usually do to e-mailed patches.
> 

Yes, having context beyond the diff is very important for Code Review.
This is why I strongly recommend SourceGraph usages to folks I know.

  > https://sourcegraph.com/github.com/git/git/-/blob/builtin/repack.c#L61:13
  > https://sourcegraph.com/github.com/git/git/-/commit/9218c6a40c37023a1f434222d501218cf8157857#diff-01ec5e99d04fb7ba9753f219ab638469R64

(I have no affiliation with SourceGraph, just really enjoy their product)

A mordern codesearch service like sourcegraph could help decorate diff
with relevant code intelligent like finding references, definitions and
assist with the Code Review process.

Afaik, sourcegraph has been building more integrations with Github and
Gitlab, not too sure about Gerrit (but Im sure it's not far reach given
their GraphQL API).

So I guess mordern toolings are available for these usecases, but
fragmented and subjective to personal workflow.

Regards,
Son Luong.
