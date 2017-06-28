Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF8F2023D
	for <e@80x24.org>; Wed, 28 Jun 2017 09:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbdF1Jyr (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 05:54:47 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33129 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdF1Jyp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 05:54:45 -0400
Received: by mail-lf0-f51.google.com with SMTP id m77so31749025lfe.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ttQXvo2J6GHDYHPHoBeCBVKYiWj9zErUcond/U0fxeA=;
        b=UMRgX0FOJLfoO3y+hI/3Z9jck74jNxVVkJN+o8fLYnJNFKpXZ8/DDhE6ROk3iREuIi
         b5s5N/yVkmpM0B2gfTkn15BWCehWYidnDhHuuLcca9jTwPV+mQotGalKPAEAMeAWdCeO
         Lfkr0yW8P5d4TDyxlwkGz6IVK634Fr+52Ct/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ttQXvo2J6GHDYHPHoBeCBVKYiWj9zErUcond/U0fxeA=;
        b=au6W6osG7vKlNFYwaLZaORwx5ATlzvYtq05sTDBBNUBh6BWkr0o52ijL7qnLMA1w96
         BVxYr6uvKK7PJ2IySLZIGHso6cCU7T1G9nqy8VJJGA7bGVCSgZKmxQxAeqfsEAiHmaBz
         rjzCY0EFA4AwYgiBRJTZHt+NdmpTCa3WuwOBV1tXyhtGWI66y/CfbsXKtR8iBi1ezFAk
         Yy0ZppG45BeZfzm16eGYc0AA5ztDS1KY37vgYJqGRvtFHTGxs9Mo7KuHnGWF08Zi0OMg
         7pHkU1rco7EeTVuH8l96qH2zfomFbTJeQAYrk/BO0P69IMLuQJ6+RGkzlm+QmtVefeJU
         xGgQ==
X-Gm-Message-State: AKS2vOzHckrpU618mdaRe3737cStxTkd/KyCsq1cA/IUNbCEQSYShSei
        Z7BxskvyC0vRzezoRQfPgVReIlinDehJ
X-Received: by 10.25.201.18 with SMTP id z18mr3274817lff.153.1498643683848;
 Wed, 28 Jun 2017 02:54:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.24.25 with HTTP; Wed, 28 Jun 2017 02:54:43 -0700 (PDT)
In-Reply-To: <xmqqk23wycso.fsf@gitster.mtv.corp.google.com>
References: <CAKYtbVY_=aMjcS=r2YyhcxKiUAaJUJA=OELTvXfau4GGz7Lz4Q@mail.gmail.com>
 <20170627191704.4446-1-miguel.torroja@gmail.com> <xmqqk23wycso.fsf@gitster.mtv.corp.google.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 28 Jun 2017 10:54:43 +0100
Message-ID: <CAE5ih78VwBVT+XHnwgnt-JcLB-c4d_Gf+9Wfb_bL=LcgkjDrUQ@mail.gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 June 2017 at 05:08, Junio C Hamano <gitster@pobox.com> wrote:
> Miguel Torroja <miguel.torroja@gmail.com> writes:
>
>> The option -G of p4 (python marshal output) gives more context about the
>> data being output. That's useful when using the command "change -o" as
>> we can distinguish between warning/error line and real change description.
>>
>> Some p4 triggers in the server side generate some warnings when
>> executed. Unfortunately those messages are mixed with the output of
>> "p4 change -o". Those extra warning lines are reported as {'code':'info'}
>> in python marshal output (-G). The real change output is reported as
>> {'code':'stat'}
>>
>> A new test has been created to t9807-git-p4-submit.sh adding a p4 trigger
>> that outputs extra lines with "p4 change -o" and "p4 changes"
>>
>> Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
>> ---
>
> It appears that https://travis-ci.org/git/git/builds/247724639
> does not like this change.  For example:
>
>     https://travis-ci.org/git/git/jobs/247724642#L1848
>
> indicates that not just 9807 (new tests added by this patch) but
> also 9800 starts to fail.
>
> I'd wait for git-p4 experts to comment and help guiding this change
> forward.

I only see a (very weird) failure in t9800. I wonder if there are some
P4 version differences.

Client: Rev. P4/LINUX26X86_64/2015.1/1024208 (2015/03/16).
Server: P4D/LINUX26X86_64/2015.1/1028542 (2015/03/20)

There's also a whitespace error according to "git diff --check".
:
Sadly I don't think there's any way to do this and yet keep the "#
edit" comments. It looks like "p4 change -o" outputs lines with "'#
edit" on the end, but the (supposedly semantically equivalent) "p4 -G
change -o" command does not. I think that's a P4 bug.

So we have a choice of fixing a garbled message in the face of scripts
in the backend, or keeping the comments, or writing some extra Python
to infer them. I vote for fixing the garbled message.

Luke
