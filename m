Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA10C07E9D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 22:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38E66100C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 22:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbhGSWSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385935AbhGSTQt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 15:16:49 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DD7C061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 12:51:08 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id m14-20020a4a240e0000b029025e4d9b0a3dso4766797oof.6
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 12:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=+RJTl5EOq0OxbZUmQPxj79TrKGumAaoGhyzKTqSO6HA=;
        b=B2ioF8WtPH/alUPVf0yj4wDQjptwAXv5zLeOQ2VJwTRBE2UAAtvna5RzI3WjD8G3YZ
         e9RrPS9bP1vZrdsJ2VH48+U4Ygg49uAWhtteTCWuDwshtXsL40qgOuu6/vDPV2lCqDmr
         7o4faT8JVFhsMMgdvRVW9RP/PE1eW6ZClgZNh81IVLsvKaDTVgcZOx0pwKDjsOZoGOWD
         Ogk3ahreiCyjQ6yYzdWGxEUvtGP2fL5Sc4oeXHUCO8+pufzBds1ruyRzS1/SweKDhrCc
         QQdORkXG2H0Se0YEgcewemjnXEonZYQYHYFkbpzQc4kuQseXyvQ80TpExT1MJuI+5xNT
         8Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=+RJTl5EOq0OxbZUmQPxj79TrKGumAaoGhyzKTqSO6HA=;
        b=o0yA5BpXAeCvNVzi+aMDkyc8lU6+RbUYWfZ5iuKOFrimbkp/tNcAW2RI4oVsrEVC1s
         3K7NXvfcStMJ7rCToyrEWRU9uv2buGm12gmk5xBUmINf+sRuh1+hH5AtrHk8cgN5GzGV
         7Uq2yO9foT/TJg/fKPYYOtCYr7jo+YttLRbW/k0Ra7KEALNqZdaM69ailkk+7cX8VSMe
         IJ90oSHypBAKjBgJ4Iv6HvX/LsNQMkKjTYmZ7IqYG+b1F+qGirVPeN25f0XSMT2ONqpX
         n99EMCVs1LF+WSQ+MKJrLhPWFwGNMzyiK14oA8HQjBMdJIWrjV7kIUFwNboXIKJB5M/v
         mo+Q==
X-Gm-Message-State: AOAM532mK6r08nY3A9+83uz2JkWUEjnGQuTBbrMJcvbgmmK562yA2aA5
        wIaf6tpgRyKw8RxhI26SDW8=
X-Google-Smtp-Source: ABdhPJzcZUFTlaQDTS8jzKf4QNMSr4yMLv+oM/wU/gSmRxN+YhHaCubUnDWB31sUNmfO3GYdGm9Xyw==
X-Received: by 2002:a4a:b5c4:: with SMTP id u4mr18704134ooo.18.1626724645405;
        Mon, 19 Jul 2021 12:57:25 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id v11sm1291280ott.68.2021.07.19.12.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:57:24 -0700 (PDT)
Date:   Mon, 19 Jul 2021 14:57:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Message-ID: <60f5d923848d3_145c71208cc@natae.notmuch>
In-Reply-To: <xmqqtukqkuzr.fsf@gitster.g>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <YPUrSB8+zEur+ZBt@ncase>
 <YPU48uSCxXbsjvGW@coredump.intra.peff.net>
 <YPVW50Q6oyTxQ4D4@ncase>
 <xmqqtukqkuzr.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Mon, Jul 19, 2021 at 04:33:54AM -0400, Jeff King wrote:
> >> On Mon, Jul 19, 2021 at 09:35:36AM +0200, Patrick Steinhardt wrote:
> >> 
> >> > On Tue, Jul 13, 2021 at 06:07:12PM -0700, Junio C Hamano wrote:
> >> > [snip]
> >> > > * ps/perf-with-separate-output-directory (2021-07-02) 1 commit
> >> > >  - perf: fix when running with TEST_OUTPUT_DIRECTORY
> >> > > 
> >> > >  Test update.
> >> > > 
> >> > >  What's the status of this one?
> >> > 
> >> > From my point of view this is ready, but it's still missing reviews so
> >> > far. The lack of interest seems to indicate that nobody has hit the
> >> > issue so far, and I wonder why that is. Am I the only one who sets
> >> > TEST_OUTPUT_DIRECTORY to a tmpfs directory in his config.mak to speed up
> >> > tests?
> >> 
> >> I had marked it to look at, but just hadn't gotten around to it. I just
> >> gave it a review (but the upshot is that it looks fine to me).
> >> 
> >> I don't set TEST_OUTPUT_DIRECTORY myself; instead I do:
> >> 
> >>   GIT_TEST_OPTS = --root=/path/to/tmpfs
> >> 
> >> TBH, I had never really considered using TEST_OUTPUT_DIRECTORY for this
> >> (--root predates it, and was written explicitly for the tmpfs case). But
> >> I also think --root is more convenient:
> >> 
> >>   - "make test" will run in the tmpfs for speed, but "./t1234-foo.sh -i"
> >>     will run locally, which makes it easy to "cd" in to inspect the
> >>     result
> >> 
> >>   - likewise, I find accessing the results in t/test-results/*.out a
> >>     little more convenient
> >> 
> >> But all of that is preference. I don't think you're wrong to use
> >> TEST_OUTPUT_DIRECTORY this way, but the above points might be
> >> interesting to you.
> >
> > It is, thanks a lot for the hint. But given your first point about
> > direct execution, this in fact makes me want TEST_OUTPUT_DIRECTORY in
> > contrast to `--root=/path/to/tmpfs`: especially in the context of perf
> > tests, I never run all of them together given that it takes such a long
> > time. So I instead either run them directly or via the `./run` script,
> > and in both cases I definitely want to have them in tmpfs given that
> > there's a lot of disk churn if you're using biggish repos.
> >
> > Patrick
> 
> Thanks, all.  Let me mark the patch for 'next'.

OK, if you don't care that TEST_OUTPUT_DIRECTORY is broken, so be it.

-- 
Felipe Contreras
