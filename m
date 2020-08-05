Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8267C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9306F20823
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v95iQp0p";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="vg+kgk0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgHEX7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:59:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52892 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgHEX7k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 19:59:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B01FE78FD;
        Wed,  5 Aug 2020 19:59:39 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=7jFT9NwXvGXcBhfjAtmG8YU9IRE=; b=v95iQp
        0pmkPbOes7JB4qI7UKcKX9j3uc1/WMQDdhrqRuDiVBC7roVHkXWmAEzY0STPBUSW
        oOm5WMDFwxIBQh3X5CucEfTzElrzXgh70iKVreek3U0YsH64CGvh9TD+MYsmpr7t
        PA46WiFlyQ8/5WwcXJtbtFCVAW8/A32q1+bmo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03530E78FA;
        Wed,  5 Aug 2020 19:59:39 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=7uehjs9my11xQsA5HKCEMzKamUGqcaV3cUr1O2winME=; b=vg+kgk0GFC4+Foh9j25hAxsiEsXZn6qN/K1vr+LDTSb6DKhcRvJEB0tRHck5bRMimyYw93Ur/TTqz8EHZzbl0opI/BAQRAqSE3WxoK2YG1LgFzJcieTFQW0tssFkIq/846BqjJ2pF9iP9NhRlBw2JFBA7c3AQ6en131ush5zu14=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9AC55E78F9;
        Wed,  5 Aug 2020 19:59:36 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     christian w <usebees@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ls-files bug report
In-Reply-To: <CADjceoQxoL932W4mkfhG6VOgrQBhs9k6tXkWSkraKVPmUP+uCw@mail.gmail.com>
References: <CADjceoQxoL932W4mkfhG6VOgrQBhs9k6tXkWSkraKVPmUP+uCw@mail.gmail.com>
Date:   Wed, 05 Aug 2020 19:59:33 -0400
Message-ID: <878ses4pay.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B769FE4A-D777-11EA-8B67-843F439F7C89-24757444!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

christian w writes:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> git ls-files --others 'some/path/*.some.extension'
>
> What did you expect to happen? (Expected behavior)
>
> only list files under some/path/ that had .some.extension
>
> What happened instead? (Actual behavior)
>
> It listed those files and also all untracked folders underneath some/path/

I tried to follow your description, and I don't see this on my end.  In
a fresh repository:

    $ mkdir -p some/path/d0
    $ mkdir -p some/path/d1
    $ touch some/path/f0 some/path/d0/f0 some/path/f1.some.extension
    
    $ git ls-files --others
    some/path/d0/f0
    some/path/f0
    some/path/f1.some.extension
    
    $ git ls-files --others 'some/path/*.some.extension'
    some/path/f1.some.extension
    
    $ git version
    git version 2.28.0

Could you provide a more detailed recipe to reproduce the issue?

> [System Info]
> git version:
> git version 2.28.0
