Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C19B2202DD
	for <e@80x24.org>; Thu, 13 Jul 2017 05:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbdGMFOg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 01:14:36 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35194 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbdGMFOf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 01:14:35 -0400
Received: by mail-pg0-f45.google.com with SMTP id j186so23736718pge.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 22:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GAHxmbk3ofw7Zwr9HTYZv5iw2m54q6wRMlvl1Qu1YuY=;
        b=dKhSGDfADpICBjpNXRPj7LXNXB+YCenDitppo+2hYfuPRBKqOO5ZkO6kPWF19FqNJ5
         iEKu/P6h7xGR2cE5APfDl+jMJbIu0G0GdAQPN9uRMoUJAgoYZ9XftaOy7ks5QDr996Ne
         S0HVKoIEgUgA3PMQVs8cxd3Dg/eLcRVbyvbvQeXgB3H0tWJLwi9rS1f1oOrZMerDUYDG
         O2WO55uQoJlLDzyoDH5rjoo4gR3SfdWY8FLaFhdBS0SOGs91gHD+9aaRprmccuS4pe/q
         zK0gxKOdciOW1cgrfoytvKzcXHAyTzO7ojEdGISeJS0omt3vocr6U+NSq/YsxhlWLqD7
         nFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GAHxmbk3ofw7Zwr9HTYZv5iw2m54q6wRMlvl1Qu1YuY=;
        b=KPt+V9vznwS6J1dwUzDp/oOwz5yOVNeZ2wlhcyZWQouBVAGLlS7YeZovHKS5dBJutv
         rVah67jtIBr5GhgdKnrnqcxROFEzwX0n7XN8dkphugcQaJrCxiEqT/WcXRJZ10ngApPP
         w+i2IVduir2t1VHKo8AAKq3qZyZs0uHqRiMgDaprOjoBCBHYGcHr2UadThuEoiL3Tm4j
         sbFHFZL5z3A3UDY/LO2qI/A9z5BqWEjZzEucOwxOYcvtXURz8lnWwuIdWZ59slpR8aNz
         +M0iyNbIHmS9QhrdISuxkROY4sCe6218J9wNoQM9WdEIgCQYV/UnzdYtiW5EkU3Jqph3
         RtQA==
X-Gm-Message-State: AIVw113mOcLY0tVzh1FcD9P374g/uZ9UFFJ2zqMhVhPXSH/NQfUsiaNU
        Cy2UewhOX5aijGgvIUTG0vvzg/VxLFlb
X-Received: by 10.84.215.197 with SMTP id g5mr8012586plj.297.1499922875070;
 Wed, 12 Jul 2017 22:14:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Wed, 12 Jul 2017 22:14:34 -0700 (PDT)
In-Reply-To: <xmqq60exyx5k.fsf@gitster.mtv.corp.google.com>
References: <20170712234504.15811-1-sbeller@google.com> <20170713000117.GJ93855@aiede.mtv.corp.google.com>
 <xmqq60exyx5k.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Jul 2017 22:14:34 -0700
Message-ID: <CAGZ79kaHX-YCMv01T-QE=mYeymjTnwrpg9-bsOrCjg3NWEunDA@mail.gmail.com>
Subject: Re: [PATCH] submodule: use cheaper check for submodule pushes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 5:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> In the function push_submodule[1] we use add_submodule_odb[2] to determine
>>> if a submodule has been populated. However the function does not work with
>>> the submodules objects that are added, instead a new child process is used
>>> to perform the actual push in the submodule.
>>>
>>> Use is_submodule_populated[3] that is cheaper to guard from unpopulated
>>> submodules.
>>>
>>> [1] 'push_submodule' was added in eb21c732d6 (push: teach
>>>     --recurse-submodules the on-demand option, 2012-03-29)
>>> [2] 'add_submodule_odb' was introduced in 752c0c2492 (Add the
>>>     --submodule option to the diff option family, 2009-10-19)
>>> [3] 'is_submodule_populated' was added in 5688c28d81 (submodules:
>>>     add helper to determine if a submodule is populated, 2016-12-16)
>>
>> These footnotes don't answer the question that I really have: why did
>> this use add_submodule_odb in the first place?
>>
>> E.g. did the ref iteration code require access to the object store
>> previously and stop requiring it later?
>
> Yes, the most important question is if it is safe to lose the access
> to the object store of the submodule.  It is an endgame we should
> aim for to get rid of add_submodule_odb(), but does the rest of this
> codepath not require objects in the submodule at all or do we still
> need to change something to make it so?

Yes, as the code in the current form as well as in its first occurrence
used the result of add_submodule_odb to determine if to spawn a child process.
