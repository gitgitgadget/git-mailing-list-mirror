Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361591FAE2
	for <e@80x24.org>; Tue, 13 Mar 2018 09:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeCMJgE convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 13 Mar 2018 05:36:04 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:37815 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeCMJgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 05:36:03 -0400
Received: by mail-qk0-f173.google.com with SMTP id y137so14606270qka.4
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 02:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wlvedET7x7V+uanJqJzdco4m8ZOsLQUFmRCPw3YuYRM=;
        b=igSXr1agihkPAQSw7Sd4VLLhxdyxEgAvMIxS/xoYkZcIyntOWfhs8txKGXMf/Le/DX
         RQo+Xff6t5CDyMhsYA2FkPPvp2rP0X1ygXeepyzktHUEGZLMwJiBRm3eLfiden36xXhy
         0YCssSpGflHtKKqqkwPiOya5SW4lGYQgqVyitXADKQ1ZmI06PssHIQF8u68Aq6sh2PwH
         Fj+4qrPtjeXMYMzHrolV3BOEayXV9dthgcHZKZeQS9C4amrPtf6NGkuwl2mIilfCBSt0
         4c9Ao5oDjEqnpjbLxNEyuUsktmCpO5yhqFd7Ii5rt/GsFyqnwBEt6qmRZimZQGaGCvPh
         Gaow==
X-Gm-Message-State: AElRT7FWRTrcqAWm2KsUEWTkmzuBO+hqJF10UA1UX5gFZv49yUiySYRy
        7JABiFVU2L7YJK0bfP/OgetezLqyvKH92DRSnR1Id7yD
X-Google-Smtp-Source: AG47ELsGmuGS0g0suk6CDSJF3SMngC+O/yu78iyeJ1WhcSJJlqzCtv1vzJ+qW9iPQNi+GSpqK8NBYF/svHc83YoOSDA=
X-Received: by 10.55.139.193 with SMTP id n184mr15475938qkd.299.1520933762882;
 Tue, 13 Mar 2018 02:36:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.42.235 with HTTP; Tue, 13 Mar 2018 02:36:02 -0700 (PDT)
In-Reply-To: <873714qr7i.fsf@evledraar.gmail.com>
References: <CANT8FXTF41-4zvqvrEek262D8OZRhA4nsiPguyNTL9mwF1+mkg@mail.gmail.com>
 <873714qr7i.fsf@evledraar.gmail.com>
From:   Michal Novotny <clime@redhat.com>
Date:   Tue, 13 Mar 2018 10:36:02 +0100
Message-ID: <CANT8FXTT=5sGp9Wn4h5t=k4TiiADQrf--hDv5EmCx=KoGHgwXg@mail.gmail.com>
Subject: Re: allow "~" to be present in a tag name
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 13, 2018 at 10:07 AM, Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Mar 13 2018, Michal Novotny jotted:
>
>> Hello,
>>
>> currently, if I try to create a tag that has tilde "~"  in name, an
>> error is raised. E.g.
>>
>> $ git tag rpkg-util-1.4~rc1
>> fatal: 'rpkg-util-1.4~rc1' is not a valid tag name.
>>
>> Now, actually it would be very cool if tilde was allowed in a tag name
>> because we would like to use it for tagging pre-releases of (not-only
>> rpm) packages.
>>
>> Is there some deep technical reason why tilde cannot be present in a
>> tag name? I tried that e.g.
>
> Yes, because a trailing tilde is part of git's rev syntax, see "man
> git-rev-parse", or try in any repo:
>
>     git show HEAD
>     git show HEAD~2
>     git show HEAD^~2

Right, reading the man pages:

<rev>~<n>, e.g. master~3
           A suffix ~<n> to a revision parameter means the commit
object that is the <n>th generation ancestor of the named commit
object, following only the first
           parents. I.e.  <rev>~3 is equivalent to <rev>^^^ which is
equivalent to <rev>^1^1^1. See below for an illustration of the usage
of this form.

Would it be acceptable to disallow only ~<n> (<n> as [0-9]+) in a tag
name but allow ~[^0-9].*, i.e. if the immediately following symbol
after '~' is a letter, do not
interpret ~ as a special character. Could it work?

Thank you!
clime

>
> etc.
>
> Although I guess git could learn to disambiguate that form from the tag
> you're trying to create.
>
>> git tag rpkg-util-1.4%rc1
>>
>> but percentage sign does not seem to be particular fitting for
>> pre-release marking.
>>
>> Thank you
>> clime
