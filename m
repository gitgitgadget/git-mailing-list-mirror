Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375A6C54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 15:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjAMPxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 10:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjAMPwK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 10:52:10 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC888A13
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 07:45:18 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id k6so13687350vsk.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=329Ui3V6xjDRL4pDpI+bITQhmYku1LIf/vHs1me1OaE=;
        b=c5fi3pBiZqd9yS/Km43ZyHvvfEZjMzqOgcumkWTl/ouAXqsfnVESCD4ZQ2E1B5M7oH
         zof463aQtIsQ3hObh6LbyT6B+JcBAIRzF20SbTq4fuIFkkA10xYKzeVBjjq0tHy+ytIu
         gCDRgG9Zh4SmivQsiaE/d+RjVKE61hIpe520U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=329Ui3V6xjDRL4pDpI+bITQhmYku1LIf/vHs1me1OaE=;
        b=W6p8gEafxH/5/SAfUIIPFaATSwpG29Gq/dpqgE1oOywgDPtNBjmo08cv7phpSwPgam
         rYY/pOs4JJZSx3GtXC8ciTjyNFCy4VoQb9ZlfpIsz9wgtYFKuSxCNoczKfYNXwF5uipi
         bnTkGtfwHPMsFiIJTgUHDaR8N/y6qbqZYSuwoM6kRx8HxD5jshnPDefLWRh5YXqPgD/Y
         ITh+Qquk3lGwRay7zDpcx+b80IUHCDWst//YB6d1lDqP1VSx8vR/E5N5aRp6fMymeNI5
         plKbcN0BOCIfKIhtYJiY1vKO78RiK3rPJn11LfUyEr8Nm7C+tf+LVVcbnWg1ZZkubDly
         4XrA==
X-Gm-Message-State: AFqh2krIGPhEZaLThhD+6TphGt13Ke8UgO+8eZUXDlGHZgTT/RrBrC95
        bHNlG67k81kMov9nQ6Y9BN+qcFsZFrEnPwnH
X-Google-Smtp-Source: AMrXdXstB1UfGMyjTZHZVJWnq3T/tX1XF6UIKmVx2YIN6GJBbaDPRK5t+TuKEkgOzmSv190ebXbo5w==
X-Received: by 2002:a05:6102:21d5:b0:3ce:c0e9:921e with SMTP id r21-20020a05610221d500b003cec0e9921emr16749102vsg.5.1673624717915;
        Fri, 13 Jan 2023 07:45:17 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a16aa00b006cfc9846594sm3639836qkj.93.2023.01.13.07.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:45:17 -0800 (PST)
Date:   Fri, 13 Jan 2023 10:45:16 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Message-ID: <20230113154516.jxm2cer4sogatayp@meerkat.local>
References: <39dd1a00-786b-acf5-8a40-2425f7dab6cc@selasky.org>
 <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
 <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 03:42:48PM +0100, Hans Petter Selasky wrote:
> > I do not understand the goal of this request. If it is possible to forge
> > hashes, then nothing in a git repository can ever be trusted. Signed
> > content will no longer be verifiable. The whole Merkel Tree representing
> > the commit history becomes easily corruptible by hackers and no upstream
> > remote repository can ever be trusted - or someone's own if someone
> > targets a repo with malware that rewrites hashes. Imagine a scenario when
> > malware replaces a blob in a repo and then forges the hash to pretend that
> > the replacement never occurred. Using git as a supply chain audit trail
> > becomes impossible. This is a potential vector for ransomware invading the
> > git ecosystem. This seems like a really fatal path to take for the
> > product.
> 

> If a hacker replaces a blob, everyone on the project will see it, because
> such changes typically generate a commit e-mail.

I don't think you have a very clear picture of how git works.

> And then an action will be made to revoke the access of that hacker. Now a
> clever hacker wouldn't do that. A clever hacker would just flip one bit
> somewhere in a random blob, looking like a hardware fault, and then force
> the project to rewind to backups every day, because the repository can no
> longer be verified.

That's not how it works at all. If there is a corrupted object, the admins of
the repository just put the correct object into place either from a backup or
from another copy of the repository. There is no rewinding required.


> There is no advantage from protecting from hardware errors, unless you can
> recover from them! Cryptographic hash algorithms are not suitable to recover
> bits. They only tell data is OK or NOK, and if there is no backup, you loose
> it!

This is true about all digital media.

> It is no solution for big repositories to rewind to backups just because
> of bit-flips. Such problems should be fixed w/o the need to roll-back,
> because that stops the entire production!

No it doesn't.

> > it can be repaired by a push --force
> 
> Hobby projects can do that, but not big projects like FreeBSD and the Linux
> kernel.

Sure they can, but not due to missing objects (a corrupted object is just a
missing object). If, for some reason, Linus ever needs to remove something
from linux.git, he will do it and just give a heads-up why and for what
reason.

I think you're misunderstanding some of the core principles of git.

-K
