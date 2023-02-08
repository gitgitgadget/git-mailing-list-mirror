Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE93C636CD
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 00:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBHAnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 19:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBHAnv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 19:43:51 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162D03CE20
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 16:43:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a2so14965183wrd.6
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 16:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHcjZMh8fbjnJMBdNEY4mT+YFkMDCJH7XFkcvP7dJ7c=;
        b=d2mn50did1MuhosWRA8wwtPxtgHxuSE/fNEqDuPDvHn4URHFfnAlxA3296QNpdrDsN
         OuVcI7ZnnCb+uH1yGCqpACtGz/WI9Di9+qSggLZBCNz7G8TqvhEw5jkyjPiCAQVVJw2R
         srDGgoI4EKDz6CRgBmrRoWHE316eqWNTRpcw30BiqQ46P1cArIUGOhJif+kN+WC2bFzn
         jrfMc8qm9LPCfrAMs3ANdKVwyEey/WfifpYOOTHWbG/e3Ye/n2niLmR1tI3LnguNY8Rj
         3aTcs5wQ4i6jxDKYTJdEYNeFesK+OfdCxtf7KZwRELDQiGPVAFJJFKY+MYtXp8WT8KOk
         H53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHcjZMh8fbjnJMBdNEY4mT+YFkMDCJH7XFkcvP7dJ7c=;
        b=c+VvzR1eifma3BOq7F+TWrV0/ooSAwVOn0HPM2mlDHo6lapqR4ijF0h9B0arvnbpr4
         HJ+7WSpU+p0Z5SStdRE/9qPQhG8+LjW1J9xZUKNu7GwWqaIV7sHD5+i89aDZlqN4IOOn
         Ode4AZRC3EzCzPKe0I5wwMac0Gu1ZNQ5MpbLovq/EzL0jhfOtyerUze5IQWMFASGBjYY
         w/r3m0yEbIhu1f5r9r6/V/lpDn4TCx3oPxZB5kwGMe53/Jq+N+puK+6sffazIpl4bXZp
         5i0/UwUImeTUro5tayTJ+g+daHAOaZd3Desd4/C5vVvIWXyIO3LmoT35bhllqRwarmLn
         iBCQ==
X-Gm-Message-State: AO0yUKWpwBBy16qzcH9T6adDSUWZE9+rGlZpSvm9w13s4kVocALcKt13
        SjIOxGmA/LNaixEg5pIQMfI=
X-Google-Smtp-Source: AK7set8srHtLKWGjb/n9/R/En941OgtdZEGRVt295xM7/ta0w49TtZbGY1O2oqwQSuzPGvoV9VH+Fw==
X-Received: by 2002:a5d:6791:0:b0:2c3:f00c:ebaa with SMTP id v17-20020a5d6791000000b002c3f00cebaamr4630205wru.4.1675817028654;
        Tue, 07 Feb 2023 16:43:48 -0800 (PST)
Received: from [192.168.2.52] (141.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.141])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b002c3e167232bsm8758662wrr.92.2023.02.07.16.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 16:43:47 -0800 (PST)
Subject: Re: [PATCH v3 3/4] rebase: refuse to switch to a branch already
 checked out elsewhere (test)
To:     phillip.wood@dunelm.org.uk,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
 <5b0d5b6e-5055-6323-1b6c-fe98137e81f6@gmail.com>
 <230206.86wn4u6859.gmgdl@evledraar.gmail.com>
 <4580b825-b117-4581-4ea2-ab30e350b6ad@gmail.com>
 <f4be3c97-eb15-790e-9746-96d0c9bbc5a7@dunelm.org.uk>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <19e3e0d9-406e-ac2f-c43a-b4e994035529@gmail.com>
Date:   Wed, 8 Feb 2023 01:43:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f4be3c97-eb15-790e-9746-96d0c9bbc5a7@dunelm.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07-feb-2023 10:52:39, Phillip Wood wrote:
> Hi Rubén
> 
> On 06/02/2023 23:16, Rubén Justo wrote:
> > On 06-feb-2023 17:59:11, Ævar Arnfjörð Bjarmason wrote:
> > 
> > > > Let's add a test to notice if this changes in the future.
> > > 
> > > I for one would find this series much easier to follow if you started
> > > with this test, possibly with a test_expect_failure, and as we fix the
> > > relevant code flip them (both this and the subsequent one) to run
> > > successfully, and include them as part of the commit that fixes the
> > > bug).
> > > 
> > > Maybe there's reasons for why that's tricky to do in this case, so
> > > please ignore this if so.
> > 
> > I'll give it try, I like the idea.  Thanks.
> 
> Squashing the last three commits together so that the tests are introduced
> in the same commit as the fix as Junio suggested in his comments on the
> previous round would be very welcome.

Yes, I considered that, but I think that keeping the tests in their own
commit is reasonable.  The tests protect against a malfunction that we
did not notice when the implementation was done.  The commits reference
(and use similar subjects) to the original commit where we should have
introduced the tests.  If the tests fail, I think it will be easier and
less confusing to reach the original commit where the implementation was
done if we keep them separated, rather than combining all three commits.

I'm going to reorder the commits and change to use test_expect_failure().
This way the commit with the fix will also be linked.
