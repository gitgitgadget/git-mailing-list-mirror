Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA44C433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 19:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbiBGT7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 14:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241689AbiBGT4M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 14:56:12 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59645C0401DA
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 11:56:11 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v4so8049029pjh.2
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 11:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=axyf1MYwEpP1JUuevm7wN1/MJM4bowO0Li0RrqAjUEU=;
        b=NRZZtaE2ocbSyHL0YHRmWV+6LyI7IOT6v/6/Ysbf169ptX0kRyPvWI4RIpGZWKVPJJ
         lwjsS6KDwKcIQ2W9ep1sH5ABGnKFtc2NDpmfJjSrjO89nxSSvefKn6YvjcEtdvBl2MMC
         9ViFQpydsMCqTCqzEDaDPWykQ7NNx7a38Qnb12xyh3btIwmJu8nxTyHI9kPlYBkcUQTK
         PS9ne/iKuvtEQBeFiHpI1LU/hUfIiNy4rDMJKbMEYDboOrPN55MYagmfd2CJKRa4GUIt
         e98fGBawpzGOFmx0n2vIHj81mJ+mqWJ7ecZtGpLzhEqA74HMhOCERgKs3KhSwj535cks
         sEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=axyf1MYwEpP1JUuevm7wN1/MJM4bowO0Li0RrqAjUEU=;
        b=H+B9C5rXlkH1E2ZLhbFxTaZJRJJUMFSzVsg7GdUlmlUhwdi/jYWUlf0/wOyWuUCkaK
         69iyzRSKzDIBMGcREbIIKfLy26hdN8Wgh2YR+UUsf4cZMCllS6UrK0XHpLPSXoFOCSLG
         Buwt0yfou8JELQmzDLASOHzqlhGHgywbcXJpLDnffGBRZy+g/5RqWhE+t51eFEOmkpzu
         4CYkfqwR45LTa+2qzFm+KeGiVg8JkWGfgZutGVu7beKU82kFbdq6kSBvQGHLXDFRSn3L
         ia2kUy5IK7b8vNuXbUCL5H0cKIw0BpPH+vyDAOxpZIBAFBiPN7vUZARyU9m+YJCS1lbe
         JH9g==
X-Gm-Message-State: AOAM533URvYN8hFVxvQKHiCDherq+i7e/o8m0ZuUysjeq7oeRYCwWVYK
        F0zlP8nO5x55Gj6Ev3eYnK7JLV1WQXQ=
X-Google-Smtp-Source: ABdhPJyIKYaW5VfNq3jVwL87YUeqAUvcox7DcJUlbcF1Fwm9dKmJnrcufJ7/yyJ/agQo1LnSHCjTIw==
X-Received: by 2002:a17:90b:1b48:: with SMTP id nv8mr545533pjb.195.1644263770696;
        Mon, 07 Feb 2022 11:56:10 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:c3a3:275c:6d99:cf07])
        by smtp.gmail.com with ESMTPSA id c12sm13828086pfl.130.2022.02.07.11.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 11:56:10 -0800 (PST)
Date:   Mon, 7 Feb 2022 11:56:07 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/5] teach submodules to know they're submodules
Message-ID: <YgF5V2Y0Btr8B4cd@google.com>
References: <20211117005701.371808-1-emilyshaffer@google.com>
 <20220203215914.683922-1-emilyshaffer@google.com>
 <220204.86pmo34d2m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220204.86pmo34d2m.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:
> On Thu, Feb 03 2022, Emily Shaffer wrote:

>> To be honest, I'm not all that interested in performance
>> - I want the config added for correctness, instead.
>
> And I'm honestly still at the point of not even being against this whole
> thing, although it probably sounds like that. I'm really not.
>
> I just genuinely don't get where this is headed. I.e. for the last
> iteration I did a demo patch on top that showed that there was no case
> added by the series where the on-the-fly discovery wasn't equivalent to
> the set-in-config value[4].

Here's a few examples:

1. Suppose I track my $HOME directory as a git repository.  Within my
   home directory, I have a src/git/ subdirectory with a clone of
   git.git, but I never intended to treat this as a submodule.

   If I run "git rev-parse --show-superproject-working-tree", then it
   will discover my home directory repository, run ls-files in there
   to see if it has GITLINK entries, and either see one for src/git if
   I had "git add"ed it by mistake or not see one.  In either case,
   it would it would view my src/git/ directory as being a submodule
   of my home directory even though I hadn't intended it to be so.

2. Suppose I have a copy of a repository such as
   https://gerrit.googlesource.com/gerrit/, with all its submodules.
   I am in the plugins/replication/ directory.

   If I run "git rev-parse --show-superproject-working-tree", then it
   will discover my gerrit repository, run ls-files in there to see if
   it has GITLINK entries, and use the result to decide whether the
   cwd is a submodule.  So for example, if I had run "git rm --cached
   plugins/replication" to _prepare to_ remove the plugins/replication
   submodule, then "git rev-parse --show-superproject-working-tree"
   will produce the wrong result.

3. Suppose I am not using submodules at all.  I have a clone of
   mawk.git and I am working there.

   If I run "git rev-parse --show-superproject-working-tree", then I'm
   presumably interested in doing something submodule-specific;
   nothing wrong with that.  But the series we're responding to is
   meant to support a wider variety of operations --- for example,
   suppose I am running a plain "git status" operation.

   If "git status" runs "git rev-parse
   --show-superproject-working-tree", then git would walk up the
   filesystem above my mawk/ directory, looking for another .git dir.
   We can reach an NFS automounter directory and just hang.  Even
   without an NFS automounter, we'd expect this to take a while
   because, unlike normal repository discovery, we have no reason to
   believe that the walk is going to quickly discover a .git directory
   and terminate.  So this would violate user expectations.

Thanks and hope that helps,
Jonathan

> 4. https://lore.kernel.org/git/RFC-patch-2.2-b49d4c8db7d-20211117T113134Z-avarab@gmail.com/
