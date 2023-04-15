Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62F3C7619A
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 05:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDOFfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 01:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDOFfo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 01:35:44 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C6930D1
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 22:35:42 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w15-20020a056830410f00b006a386a0568dso17193769ott.4
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681536942; x=1684128942;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjQH7k3E0FqT0v5W6VHaFXR0YmTlG7simhUUD7TN9uA=;
        b=E8zesCJlPgggEOcYYkWIdrfs0MjPyzw8OboYiJy9Cx1+eXz/Q00KA5WDX/TZgMGfLT
         QE1DRQH4rmei2HqS0FhLATa0R8yXKW4TMSnj1NdjdppFCFQurvBcZgAm1LadDNW53Qlk
         Jdrq0WtmvGD5MbJPUX7ugAvqLVoBWi1cVO6QC7RynU7R9TsLAU3cdIowfKG/OSozIMuE
         OOQL8a9tARotlYiTI7LooctztP4D2cDToNsnzTB7sAkd9TjLbc7TxB0dpeG9JcatdiRy
         IvTmq4gpcrgYVdsIQaVApi1TAkQuvCMVPuHSVMPDZOy/WIH1qAhvfLpoZcJH5CJ678BP
         kjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681536942; x=1684128942;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kjQH7k3E0FqT0v5W6VHaFXR0YmTlG7simhUUD7TN9uA=;
        b=Eugzrculbqilfs68HkuqH2fdefQdh7vJZ61KDHyMHxRNhH8OmxU2DCtx+hnWIhRNoL
         b1UPLUurcuk6cW6ZAtSg7aPCUTUXhSsLR3U2zLgVkzVdFtvVwuxStpVZpPSLok1iosih
         IjicAXIeyRtooLHzd3O3aVF6T9hjgQWfa1Tw1cWZBVFnUYtCplIVcN9mGChGLZce3jAz
         Ch2cBsauXH9P2oVYPmkqWIt12A0I6fL9etFFNq5oHKQFl5o6csk1YTA8qrapHDW3foph
         oiUMr7ytCDiEd/UsEGlhffWadQatLmkEcDPt/pVomCCBcP2eDWl7EBMXzjYu9mDbXq+E
         zsNg==
X-Gm-Message-State: AAQBX9fNLQlXbTgk2AvcNEVdYSj7tmCPlNQlp99y/ZyvZ1w5QBxLChQ7
        5i3lLBHfqzN8MhdZF0qwyh+Nuad9AQ8=
X-Google-Smtp-Source: AKy350Z6sjEyX7414Lmj4jUj1LTSi5fw1+WlVjQOt/6MsN8Z4mJ/FBne678UTt5Uz9JQbwk6BMIDGA==
X-Received: by 2002:a05:6830:4391:b0:6a4:3b0a:eef6 with SMTP id s17-20020a056830439100b006a43b0aeef6mr3763965otv.0.1681536942111;
        Fri, 14 Apr 2023 22:35:42 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k7-20020a056830150700b0069fa6ca584bsm2464309otp.40.2023.04.14.22.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 22:35:41 -0700 (PDT)
Date:   Fri, 14 Apr 2023 23:35:40 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <643a37acadf7f_1466294bb@chronos.notmuch>
In-Reply-To: <ZDnCMegeiw0kT5oj@nand.local>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
 <66c7e514157f3c8220eb994cea7c4659d5241042.1681495119.git.gitgitgadget@gmail.com>
 <ebcf2426-db40-e967-9db5-532869cac8ff@github.com>
 <ZDnCMegeiw0kT5oj@nand.local>
Subject: Re: [PATCH 1/5] revisions.txt: document more special refs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> On Fri, Apr 14, 2023 at 12:49:16PM -0700, Victoria Dye wrote:
> > To help with that, you could create visual separation in the rendered doc by
> > adding a '+' between each special ref description; converting them into a
> > bullet pointed list would also work, I think.
> 
> In case you're looking for another option, you could convert these into
> a description list, which would be consistent with the outer-most list
> in this document.
> 
> I had to refresh myself on how the spacing and continuations work in
> ASCIIdoc, but I think the following (which applies on top of this patch)
> is right:

Fortunately it's easy to test:

  asciidoctor - <<\EOF >foo.html
    `HEAD`:::
      names the commit on which you based the changes in the working tree.
    `FETCH_HEAD`:::
      records the branch which you fetched from a remote repository with
      your last `git fetch` invocation.
  EOF

Yes, the format is fine, I'd just use `::` instead of `:::` as that's generally
the first level, but in practical terms doesn't really matter.

https://docs.asciidoctor.org/asciidoc/latest/lists/description/

Cheers.

-- 
Felipe Contreras
