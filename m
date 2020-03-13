Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BEEC4CECE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC582072C
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNeNV1gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgCMRaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:30:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45215 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgCMRaW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 13:30:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id t2so3079496wrx.12
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ap1yhfoNpiYVqLKMlQItgKjsq3NVvNW9GqXccSWUIeI=;
        b=lNeNV1gbJ0gIrZYArhd/mHZieBhRq4VnWgwcdglWPHYt/YXaQzrQvXxKX82D0WG0Am
         eYC2BDzvU72vy4eC/YOHd6ttPDKRVkTBGARcbGdWoOTY9p65jLRIMf5tc5lyRWyHypas
         SkxcuQt7PyHP1DHOw8bpChUhOdXmcx1W13aMCz9XSGHVZ3cm6XSmKdze88H4klJvC1zS
         TilzhkWN1g2wpJuc4vUVdR5muatmbeIMAcEZ9W3CpXpHTHEh6Cmr05tMYpypSzjiW0ja
         7CDGn4da07vzRbNWW16RtP8/XV/c/qkRzmdCVL7HGVbjyq7y8s7Nt4+flH7nrNO8i4+M
         KwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ap1yhfoNpiYVqLKMlQItgKjsq3NVvNW9GqXccSWUIeI=;
        b=PZfLxN46xWX7Hnb3CK7SpSWEkC6eK0Vcb3FpHp8y3ouo22QVG4UXTVDkLJ5LkqH8gZ
         VZC06jRm1ILkGxAkU0embnEdTNpdnTilIxH6jmmi2wIipTu3+3nq81WPIxcRSGorUN5D
         XotbESLPG7P9di4tzkPJw/6vZF24GVZldznljyS+J0soJG65qCeine8K5zuTWcKQeUrv
         fQ4ZMNAh7/rX2C783b4uoibK3QSXrHmusiaBCdNu2kP3bDUhagd5JO7gtzC7z96NF7Pm
         60qxyZCE+vgEA/Bwf46fEwVGuMEoPvlmcS2AiqqEvGf2/h5FQPkArCGgZJmbt/B92C93
         e1vw==
X-Gm-Message-State: ANhLgQ2Hv5sE5SWyuFSuJzBe+vAZHIwho+TMLlPJMosMPSzPWu3WYldf
        Uum7uwHyhsDcsXxmptftVzg=
X-Google-Smtp-Source: ADFU+vu0C33LZBUUF9e/wLtIEk8AnsdKGYGU4dKJ1LRqddLJPo4d+Ue88KBp19Q5U2Yfg9BdmlPkew==
X-Received: by 2002:adf:f002:: with SMTP id j2mr19501037wro.296.1584120620622;
        Fri, 13 Mar 2020 10:30:20 -0700 (PDT)
Received: from szeder.dev (94-21-29-150.pool.digikabel.hu. [94.21.29.150])
        by smtp.gmail.com with ESMTPSA id t126sm15824999wmb.27.2020.03.13.10.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 10:30:19 -0700 (PDT)
Date:   Fri, 13 Mar 2020 18:30:16 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] t6022, t6046: test expected behavior instead of
 testing a proxy for it
Message-ID: <20200313173016.GG3122@szeder.dev>
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
 <26d0c34cd1d4a54dab28d0c9c2242336244e8a3c.1582762465.git.gitgitgadget@gmail.com>
 <20200313171248.GA613@szeder.dev>
 <CABPp-BGt4xaqG+3m3q=PfMTmfotjvze2TPp5JhthE2YHsLa=-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGt4xaqG+3m3q=PfMTmfotjvze2TPp5JhthE2YHsLa=-Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 13, 2020 at 10:18:29AM -0700, Elijah Newren wrote:
> On Fri, Mar 13, 2020 at 10:12 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 12:14:23AM +0000, Elijah Newren via GitGitGadget wrote:
> > > diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
> > > index 6f196aaf276..d97cf48495b 100755
> > > --- a/t/t6022-merge-rename.sh
> > > +++ b/t/t6022-merge-rename.sh
> > > @@ -242,12 +242,23 @@ test_expect_success 'merge of identical changes in a renamed file' '
> > >       rm -f A M N &&
> > >       git reset --hard &&
> > >       git checkout change+rename &&
> > > +
> > > +     test-tool chmtime =31337 B &&
> > > +     test-tool chmtime --get B >old-mtime &&
> >
> > Here you compare the mtime of 'B' before ...
> >
> > >       GIT_MERGE_VERBOSITY=3 git merge change >out &&
> > > -     test_i18ngrep "^Skipped B" out &&
> > > +
> > > +     test-tool chmtime --get B >new-mtime &&
> > > +     test_cmp old-mtime new-mtime &&
> >
> > ... and after the merge.
> >
> > > +
> > >       git reset --hard HEAD^ &&
> > >       git checkout change &&
> > > +
> > > +     test-tool chmtime =-1 M &&
> > > +     test-tool chmtime --get M >old-mtime &&
> >
> > Here, however, you compare the mtime of 'M' before the merge ...
> >
> > >       GIT_MERGE_VERBOSITY=3 git merge change+rename >out &&
> > > -     test_i18ngrep ! "^Skipped B" out
> > > +
> > > +     test-tool chmtime --get B >new-mtime &&
> > > +     test $(cat old-mtime) -lt $(cat new-mtime)
> >
> > ... with the mtime of 'B' after the merge, i.e. the mtimes of two
> > different files.
> >
> > Is that right?
> 
> No, sounds like a copy-and-paste-and-forget-to-update bug.  Thanks for
> spotting it.  Since you found it, do you want to submit a patch with
> the fix?

No :)  There is no file 'B' in branch 'change', so I think the fix
requires your expertise to make sure that the test checks what it was
supposed to check.

