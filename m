Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00204ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 22:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiHaWKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 18:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiHaWKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 18:10:09 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB4A3FA3F
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 15:10:07 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id m5-20020a170902f64500b0016d313f3ce7so10708258plg.23
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date;
        bh=9tSYJqQcpy2WlygY2gp0F/69kPm3fp8WFq1uKuDvPFY=;
        b=Ykqr7LBJjdwxXS+b9AR+vsfhk6vO/MVZ+mXdZ+BIl9THgnjUTK9A6diUSgSbe+zJss
         05LOlA10ExAY5Q3qvL+H5gaNBf+JuTkZz1GzPCPB5jq1jV3RsXpuzltghlz4NiC8hxzv
         ndJPHqiVNPKffgWrvxTY7keD3tsaBQn3Uw65sj3JdrWvn08kK4uxt4e2mWcYiwM6wuA/
         4qMDN9MRypx+UVBS6AEO9XrEmQYFMLFlQp2u8iEGOG+84RtmA7s5xHMfxrpqnucRCZmk
         q+7vEHu67p0W5aI2/4dWIuFBNoKz0rzpPTuf7UnzFx3FFTb+4TZHYMQ5Jm54X+36AYyG
         65cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9tSYJqQcpy2WlygY2gp0F/69kPm3fp8WFq1uKuDvPFY=;
        b=X+i2Wkf7XokswIedcM0Wj84iTe0AUKxc4jkOcqUM9W4GXNNRutjYyUegS4ZN1+AS3m
         RkPMQYkveeouXDCkPH1ATHmSaXvC2RyLapNRV6ycUg1S7azRu0+/55MsGelDf6wjm3j+
         XtutzAxqF3L6Bf7YyWKlkID8Slqyj4loH8KXlahSrooMmEMQeaRleYDVzSmh30TQkdKU
         1kqEb6MOtrmvFiOI56tGYb8Kf474gYPvA6sqtTKPpJ/lw2eTcEvWgqj+8i+gNIoKyh+T
         0eH/Cd2NWNQh2VdloIrIifanzPhBvdavcKCGQPm2EL8GsLBAwariGt0SYW/gfsuEjBjT
         6GVA==
X-Gm-Message-State: ACgBeo3ejlSsgYdOnPn5WfyAR49NpCRj0O0h5Xtp8Q9chVkU8J7n1e17
        C45DwcRIY5VszhCsfii45fY2v05GW12pB3FyfxL4
X-Google-Smtp-Source: AA6agR6PWwgwiFwMyiaNCf4bOguJqyAvGKenfR3V512H24wY/KAGdrXbK3tvyQcOIAj3RSbHv2HKyf+9KLqjCPxMd7+b
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with
 SMTP id ei24-20020a17090ae55800b001fbc4b71a24mr311959pjb.1.1661983806885;
 Wed, 31 Aug 2022 15:10:06 -0700 (PDT)
Date:   Wed, 31 Aug 2022 15:10:02 -0700
In-Reply-To: <e5c1d197-fdee-e03d-42e0-a6aff37e595b@github.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831221003.373578-1-jonathantanmy@google.com>
Subject: Re: [PATCH 2/7] bundle-uri: create base key-value pair parsing
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:
> On 8/22/2022 2:20 PM, Junio C Hamano wrote:
> > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > 
> >> diff --git a/Documentation/config.txt b/Documentation/config.txt
> >> index e376d547ce0..4280af6992e 100644
> >> --- a/Documentation/config.txt
> >> +++ b/Documentation/config.txt
> >> @@ -387,6 +387,8 @@ include::config/branch.txt[]
> >>  
> >>  include::config/browser.txt[]
> >>  
> >> +include::config/bundle.txt[]
> >> +
> > 
> > The file that records a list of bundles may borrow the format of git
> > config files, but will we store their contents in configuration
> > files in the receiving (or originating) repository?  With the
> > presence of fields like "bundle.version", I somehow doubt it.
> > 
> > Should "git config --help" list them?
> 
> I suppose that at this point, they should be left out, since
> writing them to your Git config does nothing.
> 
> In the future, having these config values present will advertise
> the bundle list during the 'bundle-uri' protocol v2 command. That
> could use some clarification in the documentation, too, perhaps
> with a "bundle.*" item discussing how all of the other items are
> related to that advertisement.

I think the main point of confusion is that these config variables
currently do nothing when in a repo config, but they will be
subsequently used once we implement advertising them, and it is
convenient that these configs delegate to other files that have the same
format (and that we can specify, at the CLI, a file of the same format).
Maybe documentation like this would clear up the confusion:

  bundle.*::
  	The `bundle.*` keys may appear in a repo's config, in a file
  	linked by bundle.<id>.uri, or in a file passed to "clone
  	--bundle-uri".
  +
  NEEDSWORK: Currently, only the latter 2 situations work. `bundle.*` keys
  appearing in a repo's config will take effect once support for
  advertising bundles in fetch protocol v2 is implemented.
  +
  See link:technical/bundle-uri.html[the bundle URI design document] for
  more details.
