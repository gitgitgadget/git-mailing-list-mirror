Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9231FC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 09:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiHVJHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 05:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiHVJHg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 05:07:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51002E9FA
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 02:07:34 -0700 (PDT)
Received: (qmail 32554 invoked by uid 109); 22 Aug 2022 09:07:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Aug 2022 09:07:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28032 invoked by uid 111); 22 Aug 2022 09:07:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Aug 2022 05:07:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Aug 2022 05:07:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?546L5bCP5bu6?= <littlejian8@gmail.com>
Cc:     Daniel Stenberg <daniel@haxx.se>, git@vger.kernel.org,
        lj167647@alibaba-inc.com
Subject: Re: git clone with basic auth in url directly returns authentication
 failure after 401 received under some git versions
Message-ID: <YwNHVfvb10VD2ROe@coredump.intra.peff.net>
References: <CADmGLV32OAg6HU+n1UsP2Fq-MjcyUsFFF=q0_jZCB0JEop5VUg@mail.gmail.com>
 <YwCe6ONEaeIj4SO/@coredump.intra.peff.net>
 <o4sp3o6-75sp-o12o-2p29-r94s2s769r47@unkk.fr>
 <CADmGLV0F==7ep-xZKd2crZLi8JnFBFVkdX9Bi2T63NECcSAbVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmGLV0F==7ep-xZKd2crZLi8JnFBFVkdX9Bi2T63NECcSAbVw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2022 at 11:35:10AM +0800, 王小建 wrote:

> Thank you very much for your answer！
> And now I tried to add CURLOPT_UNRESTRICTED_AUTH  but it failed.
> Here are a few examples of what I've tried.
> 1. docker run -it -e CURLOPT_UNRESTRICTED_AUTH=1  5de1a96efc49  clone
> http://xxx:xxx@xxx/xxx/xxx
> 2. echo CURLOPT_UNRESTRICTED_AUTH=1 > $HOME/.curlrc
> I wonder if it's the way I'm trying to do it wrong

That won't work. CURLOPT_UNRESTRICTED_AUTH isn't an environment
variable, but rather a flag that Git could pass to libcurl via
curl_easy_setopt(). So we'd probably wire it up in Git to a config
option. I'd prefer not to unless there is a compelling reason, though.
The documentation would have to come with a big warning/disclaimer,
which is a good sign that we may be better off without the option
entirely. :)

-Peff
