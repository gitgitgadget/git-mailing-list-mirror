Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A758FC77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 05:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjFAFxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 01:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFAFxK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 01:53:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3586910F7
        for <git@vger.kernel.org>; Wed, 31 May 2023 22:51:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d577071a6so633772b3a.1
        for <git@vger.kernel.org>; Wed, 31 May 2023 22:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685598628; x=1688190628;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35Kq2Io0anKaeAGpAp+aE43+LgFrTba5wirgE4v5yZc=;
        b=RyEQuvdFXtl+htlbRQxnhn2aj9FnqFRXHv9/cZBFvX5wqOc803sci4V1uRI08ri8KX
         gJz2Fnf79kihFbyLrB48+I3HNLqVY2LPi6TPa9YLYQWBoFQIhTwqYlo5RNZdLkDkPzjk
         jIcowvkM+OgWxKTd5HrJExqxw7+w1CXIks1m6YWiDc3+emRgy6COy8/ZiyBytS41IB2O
         ytK8Fb6DgIL+eLi8YgEEnmePshTlEVDmKz6Dm8mFzpZi3lSBkneN929+kk+ceecCN2h8
         UhNhxnJLuLBHk/vdc+OK0AAxu7XFOla5F+GHxVa+ScBx0btcDK6oUUw6BYnPjH6zb5Sy
         ncXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685598628; x=1688190628;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=35Kq2Io0anKaeAGpAp+aE43+LgFrTba5wirgE4v5yZc=;
        b=grJHW5gee/Bk8E8H5gFwvLRrwimM3V+g6OsFqmFBHlpQJEr3fDHVu9vGP2VnRMblmN
         v6tYF86GLfs6Vo6/+2OnhB6ER0naCnVzayrZdoubhz6v6K6nbVwqkRH/SgVvYu4g6xbE
         1fx2upypNSJ2b4Jjajwk19M0Upnps1TqcZX3IBQuaXgzYDOuqRmngec/OHKaSr8J4naY
         ZG9+e/aMBobNvBg/XdYXIV1LSbFbvMro23LKPgnWjzvcwn/eqInl7o7UMMuANnNpnHLS
         iyci2RIwY02jWrj2naMQ9i1SIqPEwPG81ss+mGnrsAmARTssQmUzYLuxyDmpOhSS8Tvy
         aLXg==
X-Gm-Message-State: AC+VfDwHuAgF/CJ/YOY6C2ujLhy99AkTnM59Pl+1wPCvNgOMt5EbCgHi
        xL6ot4+9tk5uBeGPTLzrPWw=
X-Google-Smtp-Source: ACHHUZ61ejt7rHOtwgChA52wkxipV3sFYUBSh15Oz7yj8JXhMRaoIN0sllP6Q1Y4hqADhgO91A5q1A==
X-Received: by 2002:a05:6a20:1058:b0:101:4e04:cef1 with SMTP id gt24-20020a056a20105800b001014e04cef1mr8143277pzc.27.1685598628080;
        Wed, 31 May 2023 22:50:28 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id bi1-20020a170902bf0100b001b06c106844sm2418208plb.151.2023.05.31.22.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 22:50:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com, peff@peff.net, code@khaugsbakk.name
Subject: Re: [PATCH v11 0/7] notes.c: introduce "--separator"
References: <cover.1684411136.git.dyroneteng@gmail.com>
        <cover.1685174011.git.dyroneteng@gmail.com>
Date:   Thu, 01 Jun 2023 14:50:27 +0900
In-Reply-To: <cover.1685174011.git.dyroneteng@gmail.com> (Teng Long's message
        of "Sat, 27 May 2023 15:57:47 +0800")
Message-ID: <xmqqjzwnd93w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> 1.  "--[no-]separator" to an independent patch which suggested by Junio[1].

I did suggest but not quite.

The 4th step you are fixing is already in 'next'.  You do not
replace a commit in a series that has been cooking there for a long
time.

In a more perfect world, you would have sent the "--separator" thing
that already supported "--no-separator" from the get-go.  You would
also have sent the 4th step that does not need ubsan fix.  You do
not have the luxury to do so when your series hit 'next'---you need
to live with your earlier mistakes.

Until we cross the release boundary, that is.  

I'll revert the whole thing out of 'next'.  Once the next cycle
opens after the dust from the release settles (i.e. around 10th of
June or so), please resubmit the series that does not need "oops, we
probably should have added '--[no-]separator' from the get-go" or
"oops, we had undefined behaviour here, and here is a fix", as if
you are a more perfect developer than you were when the version that
has been queued in 'next' was written (and in fact, you are, after
discussing the design and UBSan issues and stuff during the review).

Thanks.
