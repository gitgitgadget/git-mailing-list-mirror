Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16411C77B7C
	for <git@archiver.kernel.org>; Wed, 24 May 2023 17:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjEXRko (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 13:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjEXRkn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 13:40:43 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C52122
        for <git@vger.kernel.org>; Wed, 24 May 2023 10:40:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso1291181b3a.1
        for <git@vger.kernel.org>; Wed, 24 May 2023 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684950041; x=1687542041;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fu/TkkQijMUDGeE8NeHiCV+J4Rj0e17Hj931Ms30BW8=;
        b=XAXleYIm396/sOjqze2LyB8wnDKToyNVql3uu2uavanZps3uhFkgVhTY8ajvozqx7b
         9k+tyIzsr9KjgyMbocTrMVb7T86qQ0syzAEJqIGOZkD49odS7eQenW0O1DztVIx+yzwF
         nnYaN+C00UngHce003nb2Bwec8wXW1OeOLh5I6HeUJyHfFiotyLNyt18oKvR9MyfBbwh
         AZC+OiRi721E16SJrapMdw+Fw8+Y2cQIBWc1VAfDKyU2ez66XggdrCp/I3aaAYBIkFyR
         Vb2z0SL3gNI3NrikPt1eLjW4lhDwc0sKS4pEjTUHz3t59esXy+cfe62BHafRBwzp7EkX
         fVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684950041; x=1687542041;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fu/TkkQijMUDGeE8NeHiCV+J4Rj0e17Hj931Ms30BW8=;
        b=LNDT9XwsEW4XWXacA6GxoiQMR1gB+Hw43VfPamYmB5XSkLSlw416EZVYfkRATa3CQ4
         3L8Qa3gQriHz1VVttLaf+FwNr/+hsEfxN1hlE5oDF0vYfYh+rUnhS4cqESPTTGAiL/BU
         Zf93tqw0s6g5njr72jj23Z6Xhey+i22x/yAGDlsNJ/TccOfTsdqZ9lOSKxnR0yG5GCyV
         n8cCGTYEaWp/q3tn8FbjSLScZiGhWUeUknIPFjzvgyoyjONVS++oU4UwfEvrSg/+aWpP
         Jo9RZMkhrw4AI2rvkGlfBjH4cmsp/AVx/qU3uti4eOgz+qg2PboEM1RKksyA5LVp9rJc
         Yl5Q==
X-Gm-Message-State: AC+VfDyP6Kqi5I3vRCEWRvGJiM8aa53UTdODHk4G8jVkszHpIDsQSRlX
        jCycHbtqBo9lVzwj4zWRCKsm0A==
X-Google-Smtp-Source: ACHHUZ5FPgPuML+SoeFjpm17DNS/LFCP23YevSRAS9MPhCt2+oQdF3O9LuiGKurZsMMlswZtnD5HRQ==
X-Received: by 2002:a05:6a21:3613:b0:101:62c7:9db1 with SMTP id yg19-20020a056a21361300b0010162c79db1mr14626566pzb.55.1684950041437;
        Wed, 24 May 2023 10:40:41 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:5483:1ab6:7b7c:43df])
        by smtp.gmail.com with ESMTPSA id q20-20020a63e954000000b00502ecc282e2sm8175995pgj.5.2023.05.24.10.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 10:40:40 -0700 (PDT)
Date:   Wed, 24 May 2023 10:40:35 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, avarab@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH RFC v2 2/4] unit tests: Add a project plan document
Message-ID: <ZG5ME0V1+qRnkmw1@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, avarab@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <20230517-unit-tests-v2-v2-2-21b5b60f4b32@google.com>
 <kl6lzg61xuox.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl6lzg61xuox.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.05.18 13:15, Glen Choo wrote:
> steadmon@google.com writes:
> 
> > Describe what we hope to accomplish by implementing unit tests, and
> > explain some open questions and milestones.
> 
> Thanks! I found this very helpful.
> 
> > diff --git a/Documentation/technical/unit-tests.txt b/Documentation/technical/unit-tests.txt
> > new file mode 100644
> > index 0000000000..7c575e6ef7
> > --- /dev/null
> > +++ b/Documentation/technical/unit-tests.txt
> > @@ -0,0 +1,47 @@
> > += Unit Testing
> > +
> > +In our current testing environment, we spend a significant amount of effort
> > +crafting end-to-end tests for error conditions that could easily be captured by
> > +unit tests (or we simply forgo some hard-to-setup and rare error conditions).
> > +Unit tests additionally provide stability to the codebase and can simplify
> > +debugging through isolation. Writing unit tests in pure C, rather than with our
> > +current shell/test-tool helper setup, simplifies test setup, simplifies passing
> > +data around (no shell-isms required), and reduces testing runtime by not
> > +spawning a separate process for every test invocation.
> 
> The stated goals make sense to me, and I believe they are worth
> restating. I believe this is mostly taken from Calvin's v1 cover letter
> 
>   https://lore.kernel.org/git/20230427175007.902278-1-calvinwan@google.com
> 
> so perhaps he should receive some writing credit in a commit trailer
> (Helped-by?).

Yeah, I missed some intended trailers while testing out b4. I'll make
sure it gets added back in V3.
