Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC64C433E9
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07E564E92
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhBBPcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbhBBPbK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 10:31:10 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BAEC0613ED
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 07:30:30 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id k25so23121655oik.13
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 07:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPFyHmui9NpQlipgb5kxDbyTgkwq+F5lggfOsYeOlQM=;
        b=sGw/bFTZmizxkg8t9DOIiUQY3EorGD2BV1THojKN3iKGq2OkQg1ltBquldZZ2frB91
         69Aijq9obWgQ9QzkOk96pNeD8dnnCkZoQgzjlxaYg6Cu9LWt3SuRfwxWs44Zeg21lyWJ
         ZfeMkgNsvk4ukI2BQsCpw8fEKO3+YV4IxLhoG26ewXWGyK7xh6ucnJMe+QB3woDnFGx7
         XbWSXEb32+FCY5lvwsUtPNaS3Qn5dSzLAa2W8tWlVu9dLdSmoUuVhsBCzSjZTGsjvCVj
         s5tqMT3bFUpI35tbK9VgLxGCon8xSmRQ3z/KsG6j3VTqQtFQEKyh3utPGESB5A/w5iVv
         hPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPFyHmui9NpQlipgb5kxDbyTgkwq+F5lggfOsYeOlQM=;
        b=FouQwobt+Kp3XztL4BP9vSvW/7LYz9kGjdoR/aq7a4m5QR5zMovTIAeJmPMhzG7Uf+
         8Jr2qL0AM6MLIN+pp9FpovSUY4EcZ7f9tYvn4hPeq/CYrnGnuE7bq8KOdfnN2i+2+QYi
         pErBGYkGRfsUAsoD8uRbb7rk//FG88xA4WfSThgd3d0IJ7fV0m7QZ8gdKMM6au8rnPHQ
         Kfi3ZabMDWHVbbcT7g8cuomvkRNt/h6/3GB0/roJdsbqJEwSRsiMc3Sw2d7IaZFT4nG0
         DKoDtXoLsXcWNGUaDMC6u7EwCN9kNfk5GUbdCqx2HChtLps6lctAsi2kYPq9+HTvdAS/
         T6FA==
X-Gm-Message-State: AOAM531mD+nCcch7irr/92opNQhZqn2+f+l/ja0ezXs93Avgw4fS2Fz9
        /UgqQJam+gRSuaKPT/sK8mMPsqeAaqRqzN7yM4E=
X-Google-Smtp-Source: ABdhPJzE8f5ixx480Z5hxAV62an7A192aA6CWwxA4BdBzEXQtW5SQg9blT03C9oQ2QpTE+0vSyE4aIjFi/OXHJjIEm8=
X-Received: by 2002:aca:db03:: with SMTP id s3mr3171547oig.48.1612279829772;
 Tue, 02 Feb 2021 07:30:29 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-10-charvi077@gmail.com> <f3e2b9ce-3dfe-e33a-6149-ca23397b1690@sunshineco.com>
In-Reply-To: <f3e2b9ce-3dfe-e33a-6149-ca23397b1690@sunshineco.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 2 Feb 2021 21:00:18 +0530
Message-ID: <CAPSFM5f_=-MFUnZtt9KKLBcd56L_m3SZ8OZr5xjUwG3zgo+7pQ@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] doc/git-rebase: add documentation for fixup
 [-C|-c] options
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Marc Branchaud <marcnarc@xiplink.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Feb 2021 at 08:53, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On 1/29/21 1:20 PM, Charvi Mendiratta wrote:
> > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> > ---
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > @@ -887,9 +887,17 @@ If you want to fold two or more commits into one, replace the command
> >   If the commits had different authors, the folded commit will be
> >   attributed to the author of the first commit.  The suggested commit
> > -message for the folded commit is the concatenation of the commit
> > -messages of the first commit and of those with the "squash" command,
> > -but omits the commit messages of commits with the "fixup" command.
> > +message for the folded commit is the concatenation of the first
> > +commit's message with those identified by "squash" commands, omitting the
> > +messages of commits identified by "fixup" commands, unless "fixup -c"
> > +is used.  In that case the suggested commit message is only the message
> > +of the "fixup -c" commit, and an editor is opened allowing you to edit
> > +the message.  The contents (patch) of the "fixup -c" commit are still
> > +incorporated into the folded commit. If there is more than one "fixup -c"
> > +commit, the message from the last last one is used.  You can also use
>
> Erm, s/last last/last/ or even better s/last last/final/
>

Okay, I will correct it as s/last last/final

> > +"fixup -C" to get the same behavior as "fixup -c" except without opening
> > +an editor.
> > +
> >
> >   'git rebase' will stop when "pick" has been replaced with "edit" or
> >   when a command fails due to merge errors. When you are done editing
>
> It seems like an extra blank line sneaked in between the updated
> paragraph and the paragraph which follows it.

Okay, I will remove it. Thanks for all the reviews!

Thanks and Regards,
Charvi
