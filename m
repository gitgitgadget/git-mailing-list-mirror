Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D16AA1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 18:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeFZSPK (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 14:15:10 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39909 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbeFZSPK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 14:15:10 -0400
Received: by mail-yw0-f195.google.com with SMTP id 81-v6so6399031ywb.6
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 11:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGR3iL3mpmnon6iESbxuwZAgzgUjZXL/TpjO0yMnd1E=;
        b=fB7nA48WAYKPN4HmnxCdfyhsQe91+iQfpYyyChyT41g4gB+Wk2T9T5wQNG8576Bu/l
         QcnZxpp8fZhKV13mZ1ZSc7DVmkcZeC1JOhc4d9hAHbXo2DYSwbqn2d6mLsDHCoXOQEZS
         auVCMgwRXzHJCpite9mZ2OO39vj1NTsx9aS92B4u06QcGeqWCXU0ZnYtB7clo31SJyoe
         J3BRd+wIG3GeSOLNyzpn2egUKC7vHjI72jYogFdPddAVQJToibjbD5tE8bKlcYhp0xhP
         8yk42D7ZJ1vIWC0VYStjH5PiOGao9p/u0JUOF8wN6vnbNQHOOxw9FeA7lkxfA8dcQc6j
         shdQ==
X-Gm-Message-State: APt69E3FbqzJR7obGZfGvm3dA1WfaJ/QMiDAwTqkh118w3stkJ5nrBwU
        vDJdIZTEodiCEnaqskx0n46gEVclyy0fFo3GNV0=
X-Google-Smtp-Source: AAOMgpel8cIwhiKv8IcRjNd1QfaucqvnWU0lT52TKuVql/ZEIlhm0y0FQOKacL1IPlvn7N6F2N8OAx4F8faoSb8ZkBQ=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr935301ywr.16.1530036909266;
 Tue, 26 Jun 2018 11:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-18-sunshine@sunshineco.com> <CABPp-BFmfN6=E+3BAKt-NH5hmU-368shgDnrnkrnMRvKnx07BQ@mail.gmail.com>
 <CAPig+cRTG625H3CF1Zw30vQt2W8uKf1xLxVaQni2YbJ=xAif2g@mail.gmail.com> <29d090a2-bbe4-0d87-6dda-037ae675d4a3@kdbg.org>
In-Reply-To: <29d090a2-bbe4-0d87-6dda-037ae675d4a3@kdbg.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Jun 2018 14:14:58 -0400
Message-ID: <CAPig+cRnbW9fRh68ZorNQHjDFHQBWmqfEPSO+H7qgMJVOcbJmQ@mail.gmail.com>
Subject: Re: [PATCH 17/29] t: use test_must_fail() instead of checking exit
 code manually
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Elijah Newren <newren@gmail.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 2:06 PM Johannes Sixt <j6t@kdbg.org> wrote:
> Am 26.06.2018 um 11:21 schrieb Eric Sunshine:
> >> On Tue, Jun 26, 2018 at 12:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >>> +               p4 help client &&
> >>> +               test_must_fail p4 help nosuchcommand
> > [...] So, despite
> > the (somewhat) misleading test title, this test doesn't care about the
> > exact error code but rather cares only that "p4 help nosuchcommand"
> > errors out, period. Hence, test_must_fail() again agrees with the
> > spirit of the test.
>
> test_must_fail ensures that only "proper" failures are diagnosed as
> expected; failures due to signals such as SEGV are not expected failures.
>
> In the test suite we expect all programs that are not our "git" to work
> correctly; in particular, that they do not crash on anything that we ask
> them to operate on. Under this assumption, the protection given by
> test_must_fail is not needed.
>
> Hence, these lines should actually be
>
>                 p4 help client &&
>                 ! p4 help nosuchcommand

Thanks for the comment; you're right, of course. I'll certainly make
this change if I have to re-roll for some other reason, but do you
feel that this itself is worth a re-roll?
