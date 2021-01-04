Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0644DC433DB
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC67F22519
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbhADXrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbhADXrp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:47:45 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11583C061794
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:47:05 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x126so17321391pfc.7
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=D3XIIQgY1pK6XYSYRHfVIwrsB6AeeI8Y3zcaqTNG+vo=;
        b=Qz33iSIe6hnVroYMpASx6fp+3g+828pXAcM/tpUEPlqcEJj70yfBU5ZK2OIzVy6Xu2
         0gkX1FRcKXx1Pf7Hqg1wTiYsornEzl4Q7pi8xDK+3hEgjY6b4fcCew7jqz59Ky1ol+Gf
         HVcO8ohBWWkymGnuJeBxWzKA4Oin07DufIe4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=D3XIIQgY1pK6XYSYRHfVIwrsB6AeeI8Y3zcaqTNG+vo=;
        b=tX+Yj89JRVk+arhzJ+Tes4GuEHRKLUF8jRN8EWS1lNwaYWrU2rwEl0v4jjMGfXpkXo
         l2IxPGTKpHqsQu+Uz3Xi3YGRXJS4BFT416r/o94sIRj2qHLeqNFr5NuIAL9WDrQ6wo5p
         Vany5YwfpIYW8UFINi+AYAD1UwXzKhJVxofrjsY1849I9yUXPr+0HxOsncRksUbC1iA1
         VjgqKhM3nl7MGmYv/66UKvZf3tBFq165zhDixOuj8pVHVHPjbudEJuvuheMMv5F2TmRH
         nvNkRFayH/efYG536/q3RnqTkthfte9l705dlW9RF4ZfoOZdiYbZzOkknDIxKlEQsyhY
         IRtQ==
X-Gm-Message-State: AOAM532JADmN8wEs6K/YoX0usAQDfESyQZiW4nne5xLnscGDE3ovHmGT
        XhutN/mAJ9xQncBSKcrgoGB2EixkcfiV0dGh
X-Google-Smtp-Source: ABdhPJw7CBiwsIyWafQIAmuaU5xxOlSfPNYLM56yF75PW76z7rCO/jMU0NVlYhUnHoZUFA4fxPy0Lw==
X-Received: by 2002:a0c:a789:: with SMTP id v9mr77444353qva.41.1609795223615;
        Mon, 04 Jan 2021 13:20:23 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id t184sm38683667qkd.100.2021.01.04.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 13:20:22 -0800 (PST)
Date:   Mon, 4 Jan 2021 16:20:20 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Stefan Monnier <monnier@iro.umontreal.ca>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Destructive access to an "objects/info/alternates"
 repository
Message-ID: <20210104212020.qnokgnpvsoxlm77j@chatter.i7.local>
Mail-Followup-To: Stefan Monnier <monnier@iro.umontreal.ca>,
        git@vger.kernel.org
References: <jwvpn2tdb0r.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <20201228190036.vnkgeu6puxmvgt5s@chatter.i7.local>
 <jwv8s9hd9cg.fsf-monnier+Inbox@gnu.org>
 <jwvlfdhbsbs.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <20201229154403.xutnk2aoawdrjfwx@chatter.i7.local>
 <jwv1rf26k9n.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <20210104135410.myjaygaulqnxcnsc@chatter.i7.local>
 <jwvlfd81le8.fsf-monnier+gmane.comp.version-control.git@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jwvlfd81le8.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 04, 2021 at 03:47:53PM -0500, Stefan Monnier wrote:
> > I agree with Stefan that this is undesired behaviour, even when it only
> > happens when attempting to clean up garbage -- git-gc (and git-count-objects)
> > should distinguish between garbage in the parent repository and its own
> > repository and not attempt any modification of the parent repository during
> > gc or any other operation.
> 
> Great, so IIUC:
> - this is a harmless warning

Well, this is a benign situation in general, since git only tries to delete
files that it determined to be garbage. Even if it succeeded in your case, it
wouldn't really modify the actual shared repository state/contents.

> - it's considered as a bug

I'm not really someone who decides if it's a bug or not. :) I *think* it's a
bug, since git modifies the repository from which it should be merely
borrowing objects (a read-only operation). Even if the results are benign,
it's not something that should be happening, in my opinion.

> - so my use case should work fine in practice and is not considered as
>   "too weird to be supported"

It's easy to replicate, if someone feels like fixing it:

mkdir repo1
cd repo1
git init
echo test > test
git add test
git commit -am test
touch .git/objects/pack/pack-abcd.idx
cd ..
git clone -s repo1 repo2
cd repo2
git gc
ls -al ../repo1/.git/objects/pack/pack-abcd.idx
/bin/ls: cannot access '../repo1/.git/objects/pack/pack-abcd.idx': No such file or directory

Hope this helps.

-K
