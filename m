Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53295C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 08:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A0261168
	for <git@archiver.kernel.org>; Thu, 13 May 2021 08:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhEMIYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 04:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEMIYj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 04:24:39 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F47C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 01:23:27 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso22932226otb.13
        for <git@vger.kernel.org>; Thu, 13 May 2021 01:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=O4hPVFylfPzbksVb/LA3H5GxHANVuWTRE5jvBk6RlWs=;
        b=YN6EO6clRvIeoSJU685glRoOIwN1JqX0+5D46B4n2+/Znp6S0CXZY9eEII/KYO8vRg
         KB31X5/+2V+PBa6wc0jaWghfITXtq81tWf0i2T6Gh3aMhu9vzFXGAqjC5s5XttuTDWwy
         R5Bp977NiAGqgK61XXz8Zw51WlnXQZbjY0byJfI28h/6LArJD5ScqldBVFf6NXcA++AO
         aF5kXE8cQFvv3vLZYUZHmZC/Up5YLx59EJFnzF9RpXp8nLgBvyB1xVm4zr34YqpIQtkY
         LMqVnos9wNJLkdwHZnpLBYFUiniLiupkW4SKGw83je/P6h3aTsRSbFh5Tt0jqWBUSE/u
         sJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=O4hPVFylfPzbksVb/LA3H5GxHANVuWTRE5jvBk6RlWs=;
        b=HYPqVUdQKhNQ478W+Qi3Kb/B9ijAzrLTgY7mSBOjXMBbsXmy4ltz3uDr1XkTDRFUrp
         UKIuVI5Ljq8q9AjsRUa8sj7ChgFqT0upyQiN1Qh6GXlehYUXcg3qeUGuPTSabe6ZBRO7
         yeu4/2AXQg/+ICnGLOMcvncWhSIBlXnahmeBKZ8+UcdAR+p6TgX75G5Sr6j40jKM0NNM
         iWfB4qQ7RDlAftggyPmuPNkCpbi5dlWZOPzFBvkwy/XDllzyTUTw1XGEKTL315CK2SWq
         gWfT4RXYHoKQDLdOTcvxjph5cY9h7G3bRvDSxWkEgKu6KJAsDbrDXIfV8lafWG1kr29c
         qAtw==
X-Gm-Message-State: AOAM530aE4MWBiee0GdFcdnbZGy7iDsfySKxTIZocRkJAMMZ3ivL0+3h
        TVAzzIMCB8EQY6R/ZgTIQhM=
X-Google-Smtp-Source: ABdhPJyTWiHFisMlJ0sMm5rp/2Oeze1tVQb5PnQIv9/B/uo6lJHoAF7utSdIJZStZpayabOW+lHvzA==
X-Received: by 2002:a05:6830:1510:: with SMTP id k16mr20516341otp.290.1620894207270;
        Thu, 13 May 2021 01:23:27 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 67sm522643otp.68.2021.05.13.01.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 01:23:26 -0700 (PDT)
Date:   Thu, 13 May 2021 03:23:25 -0500
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
Message-ID: <609ce1fd6b614_5a8208e3@natae.notmuch>
In-Reply-To: <87pmxvrs73.fsf@evledraar.gmail.com>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
 <patch-11.11-217c5aed491-20210510T141055Z-avarab@gmail.com>
 <609ccaf67710b_3293208be@natae.notmuch>
 <87pmxvrs73.fsf@evledraar.gmail.com>
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
> =

> On Thu, May 13 2021, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> --- a/t/test-lib-functions.sh
> >> +++ b/t/test-lib-functions.sh
> >> @@ -1243,21 +1243,10 @@ test_atexit () {
> >>  		} && (exit \"\$eval_ret\"); eval_ret=3D\$?; $test_atexit_cleanup"=

> >>  }
> >>  =

> >> -# Most tests can use the created repository, but some may need to c=
reate more.
> >> +# Deprecated wrapper for "git init", use "git init" directly instea=
d
> >>  # Usage: test_create_repo <directory>
> >>  test_create_repo () {
> >
> > If this is deprecated why not add a warning?
> >
> >   echo "warning: test_create_repo is deprecated in favor of git init"=
 >&2
> =

> Because like test_i18ncmp, test_i18ngrep or whatever this is in the
> state of "don't use this for new code", but annoying everyone who runs
> the test suite with loads of this output under -v would be too
> distracting.
> =

> The attention of the developer community is much better spent on one
> person doing a s/test_create_repo/git init/ patch than having everyone
> see this warning until somebody does that.

Then it's not really deprecated; it's merely disfavored.

To deprecate means to express disapproval of. If we are not going to
express disapproval (i.e. annoy the users of the test suite), then it's
not really deprecated. You can't eat your cake and have it too.

I agree we shouldn't throw a warning right now, but at some point in the
future we should, *then* it will be deprecated.

Cheers.

-- =

Felipe Contreras=
