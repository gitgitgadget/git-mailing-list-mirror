Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903A3C43457
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 20:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22202223EA
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 20:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="owYPFuvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgJSU2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 16:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJSU2K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 16:28:10 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A33FC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 13:28:10 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b15so1322412iod.13
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oZZXxpQcEC6HK5w/qt6T06O4H4oDok9MYaWcU0/mQz0=;
        b=owYPFuvtIJU8BoJUkyqlvsqQgeM6tm/DVPxWSixconuU8L5TsC4xULVFrRCBUjhDhL
         3cv40UJlA1TXOivKHdepMQEKpvTtCwr1nCzSKXK94YknwX7Gkqhd5hZO11iT4twcnWk7
         2aEkdoVXcINcT9F9cb5i/KawqB6Gxaej2Q2wZFrhxg53w91cs3VjIr8qVzDF6UGfCXcA
         ij8dJwGRRrJIwlruYdXRJ/5rSGQ++jDx/+c0aPyJgU94po85BGvMWFB3LvL05X/P7FS/
         ItgDIeRzeyu5pTglaAhReXfVq4YthOLpEBW3PZqffrhqCEdQ3mNyGMO06MM8xsj4pxcz
         8ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oZZXxpQcEC6HK5w/qt6T06O4H4oDok9MYaWcU0/mQz0=;
        b=Dem4H/bnieDuUfJ/wEo/RTTrqIXLCVsaSmtfOs2kpWCLdkcSBIEu60/CaAcOPtAmEu
         iH8xWWQiWY3W6QFwyDvcJSLJHn8JlZrUfhkzwnE+uIM2zAjyy8Z6PxMs4NFQPgOlS8Dz
         oFpfrEDoHDBguQ3yJRK+z5Owgm9G76cNVDfUBshwMACCKeWsS1yzTgrRkIdWrjJKgeFu
         JBl+Pag4TKoZXVNvwi+K07CXP340V84jMUtwVV5ytiW8x6aFnyfGbvxF37+9oamWsf2q
         cw9tN3DVVwNSTSyW0xiZN9oIhzFgfGvPsqrF/nAr5WUptaoFRY2uC4eoGCeUM34zYAq7
         XvkA==
X-Gm-Message-State: AOAM5332VgYwwjuDoJHeRFdBCFtMCJx4yfcAs3EjZnACYov2CjszYqVo
        ksxJEWhbIDC45DUouJX/xI1V1w==
X-Google-Smtp-Source: ABdhPJxYiLyDPzRLAZC23PlJpmYEkq3xK1nfiF2Lj6i229JkMcp3A0ejc14rit+pYMI+Ktz89v06Yg==
X-Received: by 2002:a5e:dc4d:: with SMTP id s13mr977912iop.139.1603139289465;
        Mon, 19 Oct 2020 13:28:09 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:c096:f5e9:cd72:773e])
        by smtp.gmail.com with ESMTPSA id c66sm926107ilg.46.2020.10.19.13.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:28:08 -0700 (PDT)
Date:   Mon, 19 Oct 2020 16:28:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Joey S <jgsal@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [OUTREACHY][PATCH v1] t7006: Use test_path_is_* functions in
 test script
Message-ID: <20201019202807.GA47395@nand.local>
References: <ERmIkC3rLZ3BAyv2Nq_GK0CjWvEQw6ejl8V-HVvwCsyIv0guQV67nO8KMLi7eA9qO5mo_ZJ8XB360uP_LtP-LY1xsaRBXHsc0F1uSID-KPE=@protonmail.com>
 <ff9619cd-8a31-9ce4-f0e9-c7291a4141d2@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff9619cd-8a31-9ce4-f0e9-c7291a4141d2@talktalk.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 12:28:33PM +0100, Phillip Wood wrote:
> Hi Joey
>
> On 19/10/2020 05:26, Joey S wrote:
> > Hi everyone,
> >
> > This is my first contribution to Git's public repo and, after using Git for several years, I'm very looking forward to becoming an active member of the community.
>
> Welcome to the list

Indeed :-).

> > In this patch for test t7006-pager, I have:
> >
> >    - ensured the guidelines[1] were followed
> >    - used the helper function 'test_path_is_file()' to replace all found instances of 'test -e'
> >
> > Please find the output of 'git format-patch' below.
> >
> > Thank you all, looking forward to your feedback and observations,
> >
> > Joey
> >
> > [1] lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/
> >
>
> All this text above is useful context for reviewers but appears as part of
> the commit message which is not what you want. If you add notes after the
> `---` line below then they will not end up in the commit message.

...Alternatively, this would fit just fine in a cover letter. Usually
cover letters are not necessary for single patches (where the patch
message itself conveys the full message, or a little bit of additional
context below the triple-dash line is all that's necessary to clarify
the intent). But, if you want to introduce yourself, a 0/1 cover letter
is fine, too.

> >   test_expect_failure TTY 'pager runs from subdir' '
> > @@ -65,49 +65,49 @@ test_expect_success !MINGW,TTY 'LESS and LV envvars set by git-sh-setup' '
> >   test_expect_success TTY 'some commands do not use a pager' '
> >   	rm -f paginated.out &&
> >   	test_terminal git rev-list HEAD &&
> > -	! test -e paginated.out
> > +	! test_path_is_file paginated.out
>
> It would be better to replace `! test -e` this with `test_path_is_missing`
> as the modified test will pass if paginated.out exists but is not a file.
> `test_path_is_missing` will print an appropriate diagnostic message as well.

Yup, great catch.

Thanks,
Taylor
