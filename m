Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB5DC07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 06:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0DC61CDE
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 06:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhGHGsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhGHGsN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 02:48:13 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EC5C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 23:45:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f20so4604263pfa.1
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 23:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8dozhqCK8j5sPqH/4XJGxQNx3agO5Y5iZcDPitIvRrc=;
        b=ssNOFw4SMGxZXPAyfM6p6E32ARocB2GUAsJExia2YFQn4HAIN2+ts+LnAAhzKxz+tp
         S0k0BIDjCGY8bqYrnvzj23c/wjiz0dpkDqk0TqNbr42gaJ9lf41aXN1VGJXcWmx2s7zc
         sqRXsirUZ2qKAq9D6O0PqC76vMts73dP3RTw1NBKkiY8C8aa27UKX8HNJvt9qHlweUdL
         c1Iwe3y6fYlQ66e6BHPIoJR6vzL7QW+/WGlpp5jtd6PkdKowxURIKnFEfvwG7Ve9qGAb
         d9EZ19rBUl5q+KsZDiMJmSsXZ+kW3U4IO9uG6TC13V5NaFWe83X1ioA+KBka0FsdywBx
         6Pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8dozhqCK8j5sPqH/4XJGxQNx3agO5Y5iZcDPitIvRrc=;
        b=ixD8sLFPV7SC0oxxiNfjeJzjkUSxOxdnNFqqWsWKkILlSmMXdMyka2JFYlEk45hOOl
         Q5aaGK5cgBTp4t7RKnuF0uNoKRhhpPDk9PKCzmlTo/5oJPrpNdpta/hlpYyq7pwiMRVH
         xkXVahFrueTCBEekIXVNzdA5MlR2dnhBHWCEm8iYJ3r9ngFyTq5Lynr8kiuMZk7IMUfC
         7a5Z/rmvwZVojkMfVyOT5G49fG5XVk8UUy+kHxSyeACtMCsfO4qRUMyIr68cZF5El+ik
         L6i+g8CS81MFa70n4hE8O/uHRlcVNpuaEq/xQZ1QfkR5BzV9KDUj5YpRU6fNhHT16TMw
         kMVA==
X-Gm-Message-State: AOAM531ClFxv5mhDIf8VNMpapo6fm7W3PxRLW77jyif4p5NJBwkC4QDx
        1CrylWfz65RQsRTmM7Wmw3k=
X-Google-Smtp-Source: ABdhPJyqFBiYu3NUuubiuSdY9S6uch82+OXd4t411TqRfWtJr220sL9gg11d7L3vCiepEWBx7AP0vg==
X-Received: by 2002:a05:6a00:139b:b029:310:23d:f2ab with SMTP id t27-20020a056a00139bb0290310023df2abmr29761341pfg.54.1625726731205;
        Wed, 07 Jul 2021 23:45:31 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id n47sm1373989pfv.55.2021.07.07.23.45.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jul 2021 23:45:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [GSoC] [PATCH 3/3] submodule--helper: introduce add-clone
 subcommand
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <xmqqr1g9ew2f.fsf@gitster.g>
Date:   Thu, 8 Jul 2021 12:15:25 +0530
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <AED3D118-7613-45BE-824A-1350872A489D@gmail.com>
References: <20210706181936.34087-1-raykar.ath@gmail.com>
 <20210706181936.34087-4-raykar.ath@gmail.com> <xmqqr1g9ew2f.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08-Jul-2021, at 01:27, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Atharva Raykar <raykar.ath@gmail.com> writes:
> 
>> Let's add a new "add-clone" subcommand to `git submodule--helper` with
>> the goal of converting part of the shell code in git-submodule.sh
>> related to `git submodule add` into C code. This new subcommand clones
>> the repository that is to be added, and checks out to the appropriate
>> branch.
>> 
>> This is meant to be a faithful conversion that leaves the behaviour of
>> 'submodule add' unchanged.
> 
> Makes sense.
> 
>> The 'die' that is used in git-submodule.sh is not the same as the
>> 'die()' in C--the latter prefixes with 'fatal:' and exits with an error
>> code of 128, while the shell die exits with code 1.
>> 
>> Introduce a custom die routine, that can be used by converted
>> subcommands to emulate the shell 'die'.
> 
> I suspect that installing this with set_die_routine() might be going
> too far.  If some of the lower-level helper routines we call from
> here have to die (e.g. our call results in xmalloc() getting called
> and we run out of memory), die() called there will also end up
> calling our submodule_die(), not just new calls to die() you are
> adding in this patch.  Calling submodule_die() directly from the
> code you convert from the scripted version where we used to call die
> of the scripted version would be fine, though.
> 
> I suspect that it would be OK to use the standard die() instead,
> with the minimum adjustment as needed, namely, we may have to
> 
> * Adjust the messages the scripted version of the caller gave to
>   the scripted version of die, if needed (e.g. if the scripted
>   version added "fatal:" prefix itself to compensate for the lack
>   of it in the scripted "die", we can drop the prefix and call the
>   standard die());
> 
> * Adjust the tests if they care about the differences between
>   exiting 128 and 1.

Okay, will do. The latter will not affect the tests, but the inclusion
of a 'fatal:' prefix will require me to adjust one test that checks for
the error message.

