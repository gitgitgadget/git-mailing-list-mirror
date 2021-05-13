Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FF6C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43EF61440
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhEMUMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 16:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhEMUMN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 16:12:13 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C59C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 13:11:02 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so24658957otp.11
        for <git@vger.kernel.org>; Thu, 13 May 2021 13:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Xi2QA5XxswRWfcGIYJiN575AbVSkX8lmHWQILgeBp3I=;
        b=E1OZidr9lKK+TQgER8eeDYhXBkJBlgi5ay3A4Fx4fz2WxVbCQFFnvebgtpzpcNsGP0
         mBBqU2zmGq4zwRVYIJIOfIA/nYIUb2+bFMDJLLmGA8SGD162F1rsfmJH6MNylF3mY0IW
         NWXq5f86eR2lDS8Kkh9uwYaTYzBzLSkTw14sZfXgT1c900NHluXrhukaeTCP1c+7oGwR
         YqcQ7T6Qvc3TLDDD/zGzMTGy8MppkCcMoVS1icjJXpX/joc1ZnvpqkXk+cHqN32AXhfn
         J7aCttpTOMy8YWRm4dfa2RmQWT2QZmklz9mOO50XMQADF5T7m00r5iAh39rvkTZtiic7
         Tz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Xi2QA5XxswRWfcGIYJiN575AbVSkX8lmHWQILgeBp3I=;
        b=lG1YMOXc45tgRSV7DAtjiVmBIRPGBQjvHJCHIYjcjkvg6TtTRtLVT5hpyZgKs6ozCi
         1DHuhqJPVd/BlGK9HYN8XTTBjaRgtlc0Gf8Ygx20R5pt4gFPyfB3i5iDvgN/s2cuDwgb
         RNsIdvO/GKRsElDnfWPG30DP5S6Iq8ZW8yKzTGI7KyEtLnnVV+oqIfJMCaSTJK+ty8cT
         CSpGM6KlPBKxqaOovp/4QFA47yB6vA5pzukA2zv9TVCEfdBP6LKXJgQiXaa564nYBySo
         BeKcaSPhttcpj5LC69BaX1bQjYYPwB/C2X83S2/iykfap0vXSpu9Hl+b6+6EPaij5wHo
         rw4g==
X-Gm-Message-State: AOAM530UBXynaJuB9TV0bWNtB0dwEHnoVNMvqjzTILdaIWCp1JdbOC0a
        Z1CjHgZ7fNqZKm09U8m39+HMztBi9ZuNVQ==
X-Google-Smtp-Source: ABdhPJzQ1rMcnrH7B3hxMwdJVFXWEvxfe1ScQjq0/+tEDM6tTqxPGltNeTHUsss9FG8SSp2YJJMKsg==
X-Received: by 2002:a05:6830:1f27:: with SMTP id e7mr36233391oth.341.1620936661953;
        Thu, 13 May 2021 13:11:01 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r7sm875829oom.46.2021.05.13.13.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 13:11:01 -0700 (PDT)
Date:   Thu, 13 May 2021 15:11:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Message-ID: <609d87d457433_80a220856@natae.notmuch>
In-Reply-To: <87eeeasumj.fsf@evledraar.gmail.com>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
 <patch-11.11-217c5aed491-20210510T141055Z-avarab@gmail.com>
 <609ccaf67710b_3293208be@natae.notmuch>
 <87pmxvrs73.fsf@evledraar.gmail.com>
 <609ce1fd6b614_5a8208e3@natae.notmuch>
 <87eeeasumj.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v6 11/11] test-lib: split up and deprecate
 test_create_repo()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, May 13 2021, Felipe Contreras wrote:

> > Then it's not really deprecated; it's merely disfavored.
> >
> > To deprecate means to express disapproval of. If we are not going to
> > express disapproval (i.e. annoy the users of the test suite), then it=
's
> > not really deprecated. You can't eat your cake and have it too.
> >
> > I agree we shouldn't throw a warning right now, but at some point in =
the
> > future we should, *then* it will be deprecated.
> =

> I don't feel strongly about either term, as long as it's consistent.
> =

> I do think that "deprecated" is consistent in the way I'm using it
> within the git project. If you grep various things we've "deprecated" w=
e
> usually just do so by noting so in the docs. In this case the docs are
> the comments in test-lib.sh.
> =

> We do also have things like git rebase --preserve-merges which emit a
> warning, but we use "deprecated" for both. By contrast we don't have a
> single git for "git grep -i disfavor".
> =

> Anyway, for now I'd prefer to just have this land as-is and sort out
> such minor things later, given the v6 and having two other topics
> waiting on this...

Fair enough.

-- =

Felipe Contreras=
