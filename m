Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036B8C2D0DA
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA3F20740
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOE90Cul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfLZOau (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 09:30:50 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45070 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLZOau (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 09:30:50 -0500
Received: by mail-qt1-f195.google.com with SMTP id l12so22394388qtq.12
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 06:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hoL/yYewwGN845mWYYxFNbtMDxMKizAibkT5uE3blmU=;
        b=iOE90CulmPCFCgIKi6y4G4+xZyFySs/goqDQVsth6019xKnU2HnT2f+goYhUFGTgy3
         pIflBwFv1XLnpzVrF7TCMrLGZR9LMAMS5MAlhqAuFO/wcfun1Uu7FBAun1BGK27iAgm2
         Qkk0uR7u7JI3lbzXXCAC8S1cCmGHjp8wL9ilS8Mq8Vx/Iu+AdByTm2sQNE03eRwLOeu8
         WJbDpHtOSoRwgpLz+uMkk3E9HLYq7GqYS38hHQZwIPaWLUjv8D8dfjKg4izezR5/8bou
         KqgNYVFghtsbePGUsUJ+Zs5vUDYt+dFknTcTGlwNRFlpwe9DoiFqXGYpFc3cIRHVEbrU
         pGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hoL/yYewwGN845mWYYxFNbtMDxMKizAibkT5uE3blmU=;
        b=hi2y4IGVwpJHcpj5HOfj/6xxdThKcnNu3biHmHjrikeZPaDi0ypmwRnR0bPVO4n382
         ik3D8QSeFuBzKagyujhUCR83Y8okTSomQr6J7NdCPGbslCh2bzE3M/OswHq1F3lJ+8v+
         coT726ovyoVS0IglrOs+VrBXhPcYKCKRC7Yt8a3+IGLXQOznEwe9fd8rWoQDYAjY3ElU
         bro0wcQ1hr+YtDI8dg4uaPHJYFwS+d+V/+So7PdOsTIiLDK0hyCfKMJGuvVYEHWX8eJV
         mv/CEgm3PSwwl/AUv3sjO2SwPADae4NHpNB42b3iYQyRCZ1o0e8E/QFxvXpofxO7mfht
         7qvQ==
X-Gm-Message-State: APjAAAWrXl5pk5AW92sP8D+GDwMvKYdrVPu4DqNbZjp4WLlO1rGFaZp4
        fqSBEDYyC8xesccDufJCBgaZG2dH
X-Google-Smtp-Source: APXvYqxPn0HIjqf1NkRM3k6kRHD+fK7Qap/8TnK6oOOScdL4aji+fiCWH2nnI8cguOdoSsgwbpe95w==
X-Received: by 2002:ac8:21ad:: with SMTP id 42mr34558208qty.109.1577370649381;
        Thu, 26 Dec 2019 06:30:49 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:d596:b1c5:69e0:b2e5? ([2001:4898:a800:1012:86ca:b1c5:69e0:b2e5])
        by smtp.gmail.com with ESMTPSA id g21sm8671930qkl.116.2019.12.26.06.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 06:30:48 -0800 (PST)
Subject: Re: [PATCH 0/5] Enable protocol v2 by default
To:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20191224005816.GC38316@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0a4f064b-8260-1662-2ead-b2e2c930d706@gmail.com>
Date:   Thu, 26 Dec 2019 09:30:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191224005816.GC38316@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/23/2019 7:58 PM, Jonathan Nieder wrote:
> Hi,
> 
> The Git users at $DAYJOB have been using protocol v2 as a default for
> ~1.5 years now and others have been also reporting good experiences
> with it, so it seems like a good time to propose bumping the default
> version.  It produces a significant performance improvement when
> fetching from repositories with many refs, such as
> https://chromium.googlesource.com/chromium/src.

The benefits of protocol v2 are very clear, assuming the server
supports it. And I'm pretty sure there is no downside, as a v0
server continues responding to the v2 request without any extra
round trips to agree on protocol.

> This only affects the client, not the server.  (The server already
> defaults to supporting protocol v2.)
> 
> This could go in 2.25 (most of the "next" population is likely already
> using protocol.version=2, so the -rc period would be one of the better
> ways to expand the user population using this) or could cook in "next"
> for a cycle.  Either is fine by me.

I have no firm opinion on when this lands. The code change is much simpler
than I would have thought, and perhaps we had enough testing of the protocol
by experts.

This series looks good to me.

Thanks,
-Stolee
