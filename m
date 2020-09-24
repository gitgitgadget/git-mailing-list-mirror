Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0172CC4346E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 05:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A464723741
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 05:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNGZwJL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIXFeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 01:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgIXFeK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 01:34:10 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F0EC0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 22:34:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gx22so2728635ejb.5
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 22:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzLMi34RmSaGRtC62Pk1Vl9KbkqIgbHsTfDPowMWWQk=;
        b=TNGZwJL+tQewlYhipUlX76HIfARyUkW2KiGHL1vV3A6nkRuBiE7mAMgPqUVzzVd3zO
         zrbwbw/Q61OL/N1nFab0pxRMykLwyP+RShTjgjjaLDGxiBHiMxZq0K8l2/xyRDLcLmuU
         3nC7Vwvit8Pml1lVxMD+vBVi5d3h/XQU0WoaV414NEqhFPMlSbZFrCKWpb4ykmKq0vJS
         W7gcTb/AQNFMh7264n4iMJjAF0+QiUbXYTcVPAXYqxrbad462kIAtP3CK2BjsDG4JOj5
         pQ7ezZseZHxcX1FFqHpAUj02pO52W5kC1L9jS+N677qwbeeAQH6Lu0UiCqlrkydNLppy
         UTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzLMi34RmSaGRtC62Pk1Vl9KbkqIgbHsTfDPowMWWQk=;
        b=lifp3jNvEgyT6AlwOz0rZQ8A30sjwN6JaBksfBcjGUEfM3z0A5igFWK9lvu0E+XORe
         U9IQbDmRTq5V/gl3XEZ4YneSs/4Yio4y1AWYz1Xp3ISvfcaViCir47M4n5YjFNSc6yHK
         uPtZpec3Qc4kK/7ZlNSDoN5DpcrpWwHhshDM6DE4iWEIx6gWlnP9Z9IqQDztaxbCP0cL
         LAHTnJOIyN5FZ8DrCNG3KHH7DI6ij0NIHzpngCmH+m/5vnDcQEespis/0EuuNw3qekqb
         clXXNZZ0TTXsctZmxhMgyGgyWMjcmE7U9Az4YRtiK+ZUXtyzsNPAmtHtSOxBQ9n3XA+B
         2Jug==
X-Gm-Message-State: AOAM533tM5QCN/pDKO3JG7q3G/qMqX/C6U8UyTr6hznUu7gGEpQbTMD/
        tdPC/InFYxmiYyjZzh18eWB6RGtzsFEQfEOXMfY=
X-Google-Smtp-Source: ABdhPJyByDUTWNv44huuoXYOsLocg25m0RqDlX3J5AUrnvEalbM8ojb+xcO5Qx+drQq9Mab0zWEI1deUwUdx1efCn1s=
X-Received: by 2002:a17:906:68d2:: with SMTP id y18mr2931495ejr.197.1600925648850;
 Wed, 23 Sep 2020 22:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200831105043.97665-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2009031403510.56@tvgsbejvaqbjf.bet>
 <CAN7CjDDVp_i7dhpbAq5zrGW69nE6+SfivJQ-dembmu+WyqKiQQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2009231647370.5061@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2009232316570.5061@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2009232316570.5061@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 24 Sep 2020 07:33:57 +0200
Message-ID: <CAP8UFD1fXBChG3691HrKmbN-4vThCE7=0bL+Ty8-u4FFGTn2tQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] Finish converting git bisect to C part 2
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "Miriam R." <mirucam@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HI Dscho,

On Wed, Sep 23, 2020 at 11:26 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> On Wed, 23 Sep 2020, Johannes Schindelin wrote:
>
> > On Wed, 23 Sep 2020, Miriam R. wrote:
> >
> > > Applying some of your suggestions related to removing some 'eval' in
> > > git-bisect shell script, a bug has appeared. It seems it is related to
> > > a previous code merged before my internship.
> >
> > Now you got me curious: what bug did you see?
>
> I found your fork and ran the test, and this is the first symptom:
>
> -- snip --
> [...]
> ++ git bisect skip
> Bisecting: 1 revision left to test after this (roughly 1 step)
> [32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <hello>.
> ++ git bisect good
> ++ grep '3082e11d3a0f2edca194c8ce1eb802256e38e75e is the first bad commit' my_bisect_log.txt
> 3082e11d3a0f2edca194c8ce1eb802256e38e75e is the first bad commit
> ++ git bisect log
> ++ git bisect reset
> Previous HEAD position was 32a594a Add <4: Ciao for now> into <hello>.
> Switched to branch 'other'
> ok 22 - bisect skip: add line and then a new test
>
> expecting success of 6030.23 'bisect skip and bisect replay':
>         git bisect replay log_to_replay.txt > my_bisect_log.txt &&
>         grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
>         git bisect reset
>
> ++ git bisect replay log_to_replay.txt
> error: update_ref failed for ref 'refs/bisect/bad': cannot update ref 'refs/bisect/bad': trying to write ref 'refs/bisect/bad' with nonexistent object 10006d020000000068986d020000000054f65f00
> error: last command exited with $?=1
> not ok 23 - bisect skip and bisect replay
> #
> #               git bisect replay log_to_replay.txt > my_bisect_log.txt &&
> #               grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
> #               git bisect reset
> -- snap --
>
> So I dug a little bit further (and applied Christian's patch in the
> meantime), and it turns out that the `eval` has nothing to do with what I
> originally thought it would be required for: I thought that it wanted to
> prevent `exit` calls from actually exiting the script.
>
> Instead, those `eval` calls are required because the arguments are
> provided in quoted form. For example, during the execution of t6030.68,
> the `eval` would expand the call
>
>         eval "git bisect--helper --bisect-start $rev $tail"
>
> to
>
>         git bisect--helper --bisect-start '--term-old' 'term2' '--term-new' 'term1'

Yeah, that was also what I found (along with the bug I sent a patch for).

> Therefore, the `eval` really needs to stay in place (also the other `eval`
> I had originally suggested to remove, for the same reason).
>
> I would still recommend appending `|| exit`, even if it just so happens
> that we will eventually abort when the `bisect--helper` command failed
> anyway, because the next command will then fail, and abort. But it's
> cleaner to abort already when this invocation failed rather than relying
> on that side effect.

Yeah, I think it's a good solution.

Thanks for taking a look,
Christian.
