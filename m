Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E8C201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 22:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbdBUWQ1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 17:16:27 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:35872 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdBUWQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 17:16:26 -0500
Received: by mail-it0-f44.google.com with SMTP id h10so119962217ith.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 14:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ToN5DPR7txAmXC3waWVXRaHAsDULESzv14O8rM4XezM=;
        b=HYpExv9RH0F4Dc6cGyNvcyy3Xc+A96Sh21UnqwixhYqKoaaaMM6bktmlvfZtZ+fhF6
         +T8jvL1QkLtIASoJkdSfXJUjKC1XfGzeyHHL7Y2H+4SZkaAEcCnUJrZes60eP7pCKI3F
         GYXZFWtry9SWbiUamXxor8A1Cz+4bJ66DWR9gfjnx8r8kAjGC6kaKIlMHPNTD+Q90A1s
         8W/1B7eM+cWmdOAGrA3TGfyAM423x0/5iQx92Ul031mslaNg35j84/TFW76FJpdQwlCd
         9kEId+/AoLJbCzHnzDVyzvSJDRHxczNsPyl4UpH5RxOXLPE3cJbynmZXXwI92Se7VDFW
         LKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ToN5DPR7txAmXC3waWVXRaHAsDULESzv14O8rM4XezM=;
        b=hQiZydAnICqquOmrS9E4bbugL5PQM+3s/CteTISjsYC+OSbIZAgjefaGsqaeF0dEt7
         leDSFi/hVywSU1S77sm5qcUmdoYMbJ8OirOdLXJA390+wMjhLvYdisBYlw1tSBxemPYf
         pAl1c1uws6lbuQmglNmPNk9ziIpSERYEcsSROtxGOHN2KbFY30eKx0pUqRwmJBTL825M
         ltXpMJXtbOOeW1jThlPvto42qpGV52EeO8i5+JiVhqLSZg+3Gll4U5V1qUHNjenVsh1l
         15ay9evXakNXRuA/Q8ZO36FGNSXRStZ4pavvf6qPEVkC1Y1I8L6id9AERGg2un0HDi2Z
         falQ==
X-Gm-Message-State: AMke39nScwBV0jpUGcndIfQOPliVm576TOMVfVe74ov5FwGL2fJckIOOgj/+mFRa9fnwh7+ji9PjDvVRier1VZKO
X-Received: by 10.36.40.198 with SMTP id h189mr29830370ith.114.1487715385111;
 Tue, 21 Feb 2017 14:16:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 21 Feb 2017 14:16:24 -0800 (PST)
In-Reply-To: <CA+P7+xrwxb9G3QVOascSZqnBa_vGEx95nv0jN9USmBqB5Q_Mzw@mail.gmail.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-13-sbeller@google.com> <CA+P7+xrwxb9G3QVOascSZqnBa_vGEx95nv0jN9USmBqB5Q_Mzw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Feb 2017 14:16:24 -0800
Message-ID: <CAGZ79kahCN2dd9=CzqXJWSJKrkOfvd3HeQ-NORhyP=6B=KCrqg@mail.gmail.com>
Subject: Re: [PATCH 12/15] unpack-trees: check if we can perform the operation
 for submodules
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 10:42 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Wed, Feb 15, 2017 at 4:38 PM, Stefan Beller <sbeller@google.com> wrote:
>> +       if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED))
>
> Here, and in other cases where we use
> is_active_submodule_with_strategy(), why do we only ever check
> SM_UPDATE_UNSPECIFIED? It seems really weird that we're only going to
> check submodules who's strategy is unspecified, when that defaults to
> checkout if I recall correctly? Shouldn't we check both? This applies
> to pretty much everywhere that you call this function that I noticed,
> which is why I removed the context.

I am torn between this.

submodule.<name>.update = {rebase, merge, checkout, none !command}
is currently documented in GIT-CONFIG(1) as

       submodule.<name>.update
           The default update procedure for a submodule. This variable is
           populated by git submodule init from the gitmodules(5) file. See
           description of update command in git-submodule(1).

and in GIT-SUBMODULE(1) as

       update
           [...] can be done in several ways
           depending on command line options and the value of
           submodule.<name>.update configuration variable. Supported update
           procedures are:

           checkout
               [...] or no option is given, and
               submodule.<name>.update is unset, or if it is set to checkout.

So the "update" config clearly only applies to the "submodule update"
command, right?

Well no, "checkout --recurse-submodules" is very similar
to running "submodule update", except with a bit more checks, so you could
think that such an option applies to checkout as well. (and eventually
rebase/merge etc. are supported as well.)

So initially I assumed both "unspecified" as well as "checkout"
are good matches to support in the first round.

Then I flip flopped to think that we should not interfere with these
settings at all (The checkout command does checkout and checkout only;
no implicit rebase/merge ever in the future, because that would be
confusing). So ignoring that option seemed like the way to go.

But ignoring that option is also not the right approach.
What if you have set it to "none" and really *expect* Git to not touch
that submodule?

So I dunno. Maybe it is a documentation issue, we need to spell out
in the man page for checkout that --recurse-submodules is
following one of these models. Now which is the best default model here?

Thanks,
Stefan
