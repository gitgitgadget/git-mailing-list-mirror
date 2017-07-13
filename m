Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87297202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 18:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbdGMShI (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 14:37:08 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36568 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbdGMShH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 14:37:07 -0400
Received: by mail-pg0-f51.google.com with SMTP id u62so33569961pgb.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NeiVTCTn8LqgLKPN83n1TFydAASPVf47N29hpSM+JuI=;
        b=mA/SVC7o4E4Z0qclNywDhUAeXQSgnA7i7upa/T9RwZ8JuT3tBm3OO6jcxB3y3OrvIR
         dQO/I9vg5iKvgmwFWZkDnMAEtEKNxU8/wb+LtsX4JJs/gJPMkMFZxPPnX1cUeaFkJ028
         Pj91fA+Fhx1kaLSRk9T+VuzDUWCVLpfvgTa1JjPbaRnPMEVGSCPOQEDIQyUKFVyf9FoV
         c+39GsroWXJs76s0GtL9XboR87Nwp3C1EmNeZVTtlVurM68LWNEVHv4tDn/nA4wrucfq
         HWR7aN1h53g85s/26IqXfBSWVNdpBVi6VBZUZKGVvyaKrlatSbWNN2ze3qbLOIO3oTUu
         E51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NeiVTCTn8LqgLKPN83n1TFydAASPVf47N29hpSM+JuI=;
        b=NZLAP5PAZeWWmuoeEuRPcZP3RQndhwnEj/Wkkfsu2zc5tHd2IGGmr76vCANd3Rrq4j
         0lTWE20gdxxmjFGhYvnrnDXV6Tv0m6Do9HIGMro8/S3WR11QORACze4x75JXYcgoI9e4
         uQdCyWLHrwKgAUFxZFaNsUddS0eWy/+zf4ndhaG+ewegD/ECT7Bes3YQFhF8z4iofCrq
         qgzL+h0zdWeSapD86a7n9F8IO1tr2tz5wBaG7NSokmLWXbPzOelRklNYKGrZIGeGti+G
         cNtMapdRLCiUgdKtbcGWRxPse6b3hveuB8w17c7aWFhO1gdohHObukqCBXYGYXxVp+TI
         Vevg==
X-Gm-Message-State: AIVw111R3UFvDNyikOHFdpgwVaa1HMc85AJ/qbRR0QCfESWDLQuYw/9G
        Rm+aDg8PDcMrGw==
X-Received: by 10.98.130.132 with SMTP id w126mr1015235pfd.50.1499971026330;
        Thu, 13 Jul 2017 11:37:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id o29sm13881151pfa.60.2017.07.13.11.37.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 11:37:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] submodule: use cheaper check for submodule pushes
References: <20170712234504.15811-1-sbeller@google.com>
        <20170713000117.GJ93855@aiede.mtv.corp.google.com>
        <xmqq60exyx5k.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaHX-YCMv01T-QE=mYeymjTnwrpg9-bsOrCjg3NWEunDA@mail.gmail.com>
Date:   Thu, 13 Jul 2017 11:37:04 -0700
In-Reply-To: <CAGZ79kaHX-YCMv01T-QE=mYeymjTnwrpg9-bsOrCjg3NWEunDA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 12 Jul 2017 22:14:34 -0700")
Message-ID: <xmqqa848xjxr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Jul 12, 2017 at 5:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>>> In the function push_submodule[1] we use add_submodule_odb[2] to determine
>>>> if a submodule has been populated. However the function does not work with
>>>> the submodules objects that are added, instead a new child process is used
>>>> to perform the actual push in the submodule.
>>>>
>>>> Use is_submodule_populated[3] that is cheaper to guard from unpopulated
>>>> submodules.
>>>>
>>>> [1] 'push_submodule' was added in eb21c732d6 (push: teach
>>>>     --recurse-submodules the on-demand option, 2012-03-29)
>>>> [2] 'add_submodule_odb' was introduced in 752c0c2492 (Add the
>>>>     --submodule option to the diff option family, 2009-10-19)
>>>> [3] 'is_submodule_populated' was added in 5688c28d81 (submodules:
>>>>     add helper to determine if a submodule is populated, 2016-12-16)
>>>
>>> These footnotes don't answer the question that I really have: why did
>>> this use add_submodule_odb in the first place?
>>>
>>> E.g. did the ref iteration code require access to the object store
>>> previously and stop requiring it later?
>>
>> Yes, the most important question is if it is safe to lose the access
>> to the object store of the submodule.  It is an endgame we should
>> aim for to get rid of add_submodule_odb(), but does the rest of this
>> codepath not require objects in the submodule at all or do we still
>> need to change something to make it so?
>
> Yes, as the code in the current form as well as in its first occurrence
> used the result of add_submodule_odb to determine if to spawn a child process.

The original added so that the return value of the call can be used
for that, and the current code still uses the return value for that
purpose.

That much is already known.  

I think Jonathan's question (which I concurred) is if we also ended
up relying on the side effect of calling that function (i.e. being
able to now find objects that are not in our repository but in the
submodule's object store).  By looking at the eb21c732d6, we can
tell that the original didn't mean to and didn't add any code that
relies on the ability to be able to read from the submodule object
store.  I am not sure if that is still true after 5 years (i.e. is
there any new code added in the meantime that made us depend on the
ability to read from submodule object store?).

My hunch (and hope) is that we are probably safe, but that is a lot
weaker than "yes this is a good change we want to apply".

