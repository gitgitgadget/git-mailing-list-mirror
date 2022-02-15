Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2180C433FE
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbiBOWOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:14:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244512AbiBOWOq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:14:46 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3668527CC9
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:14:36 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id h18so628232edb.7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=E4E0YNj+0i7LHmo7u6EQwSUXX7kzGwV3d34AMkvAIjs=;
        b=XqrHDoNoeUUhmxNB+qEquUymKGoDC0BJa4AGIKyIMpn+q8v+5h3ZYtkSa6Yu4XbEuS
         arEvj6OIivjDJ1YCyxREztq5u5wDjvsXa+wKHToZIpZi73+X1QV+9wtvXMjxz6TqY6Rh
         c7SR1IH+2vZYRE2s941O4SYtoZh0NMpKDPFJ0c+SVbNmuyGfkNb83iX65M2bbL9Ea9GY
         RmUE/9iorzmpGBW2vEYA3voj+2FFnss8zwbU05YLCFYhByPMAcAtmqWK/CQFp4qwGmCt
         42jII3hL/+Z5SDiUZx2wTPg4Uv5MrLeqY9mlXo3iKN93hqdcsbtqqz7DeCXgBSFAK4L9
         7p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=E4E0YNj+0i7LHmo7u6EQwSUXX7kzGwV3d34AMkvAIjs=;
        b=hf74IFR8O7OTnyZM+s97UXG2VEs16qdKFnE8oRG4/3X7Z4rFaAPpA47Dryizh7IyyQ
         EQcmqx1Eg8iJY/x2WwfMMx3nlwD2jQPiDZHGdbZLDpaflgZxmnRAC2+8tZroy8QUwzTh
         VJibAHgRydPUzssASuonegyNxulCOPfnmL77rSDJuyuEjAhauqIFvAs/xcgiyI5Ovq/O
         I66rci2uUwtLY2ALWp5ihdHuLd0xzlBEYbzbcjwzlRwl5pcKPY+cFZnG0SIN3rqTXBnm
         n1GdaIVTCT80HfqKzFo8X/lBc1qy0ZycACQ0QcW2l/B4VS9uzZp3cWgEU9Vb2RlZI4Jj
         ZQlA==
X-Gm-Message-State: AOAM531jEYD81O3coLrfdXiqCcg7Qc95CyXwejzSqqiOkbBFiXzW18h3
        qGPnKqsMkTZGf6nfUqoVb0c=
X-Google-Smtp-Source: ABdhPJymIHnCkfZgQLUcrToWQb/oUaVL8vO2jMQpkxpVz+1REQckfVp2voP+1LXokgFwN6LPKRQEEA==
X-Received: by 2002:a05:6402:f06:: with SMTP id i6mr1090706eda.440.1644963274754;
        Tue, 15 Feb 2022 14:14:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 26sm3269372eja.183.2022.02.15.14.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:14:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nK65h-002tzT-Ix;
        Tue, 15 Feb 2022 23:14:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Cogoni Guillaume <cogoni.guillaume@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        git.jonathan.bressat@gmail.com, guillaume.cogoni@gmail.com,
        matthieu.moy@univ-lyon1.fr
Subject: Re: [PATCH] t/t3903-stash.sh: replace test [-d|-f] with test_path_is_*
Date:   Tue, 15 Feb 2022 23:13:11 +0100
References: <20220211134655.1149320-1-cogoni.guillaume@gmail.com>
 <xmqq5yplcme1.fsf@gitster.g>
 <6fbd4188-3bb5-6d48-fd25-1bdbe9a3cbfb@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <6fbd4188-3bb5-6d48-fd25-1bdbe9a3cbfb@gmail.com>
Message-ID: <220215.86a6erwzee.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 14 2022, Cogoni Guillaume wrote:

>>   * verify that all existing users of test_path_is_file want to
>>     reject a symlink to file, and add 'test ! -h "$1" &&' to the
>>     implementation of the test helper in t/test-lib-functions.sh
>>     (we may want to do the same for test_path_is_dir).
>>
>>   * introduce test_path_is_symlink and use it appropriately.  This
>>     will be a more verbose version of "test -h".
>>
>>   * introduce test_path_is_file_not_symlink and use it here.
>
> We wouldn't modify test_path_is_file because this function is already
> use and we won't verify if every uses of this are rejecting symlink.

Perhaps it's not a good idea (I haven't checked) to change it like that.

But it's fine to change these sorts of test functions even if there's
existing users of it, our test suite isn't a stable API.

Of course one still has to consider outstanding patches, anything in the
list archive we may want to dig up etc., so it's best not to do so
without good reason.

But the "verifying every use" should mostly be just running "make test",
and pushing to the GitHub CI.
