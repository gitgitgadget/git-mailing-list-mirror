Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6328DC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 08:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244953AbiBBIcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 03:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244946AbiBBIcx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 03:32:53 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76042C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 00:32:53 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u6so39037822lfm.10
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 00:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aeNhfC+2bwptnat//qvZ/KCWNDrb7XTcAEsyhbSIPs8=;
        b=KpIKYK+hXrwDno49k8XB+2U1S4SiwSoM8ndnykFdbfUWgCRJRLyWsAZFJyOmrSahSa
         dlN+jhy791uejPUXcWim+gwP9XlEAckbnQc1oRBwTF6rs+ulHJWMAyPvC1Rw7HroYuA9
         qLeEMnAQ8MMkTHd1ifvJBSoeQIfAuTjAqk3zsSmyREBErCH9dvGjsfpplTU9PCooOc8b
         pO9X/yMK1r21xrbU/y3ngfHNDuUcI4jK3j4OV4CARQkfcxKCYCSV9DmIksRf5RR8LLHq
         HX1IL+VoxHKz4f5SQT9yMaix9eXX0+lPvWMkOhJ5T/BZMRmCWiWW/ABUwt9rWpg8Vwnt
         Hc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aeNhfC+2bwptnat//qvZ/KCWNDrb7XTcAEsyhbSIPs8=;
        b=xB4fY+6C9dDX5oGRrTYUrWmzIIjXc+VABDyZFr3128TWYV/73Zr28I+EuHIXhotltt
         BEIaYCojhXJ7qWhpZP30tWTVGC+/7BFmnlvgzbBHVPYn/hpDA/p/KMMf7XtA4e5Rwrza
         yaczSfZkXnUtIDMAfU6jHe27zDY6Yo2Z3EBiqixqq+Ocerd4d+Kyby0k3BTwcpO0kfCV
         dUfXoVtEmx+Hg0Uw8AuBYJouvg88fNQLT0ABlQwAU/T6EIMge0cRZRvyug9KDWeY1Wq4
         U8aOUumbUniDwsv70DdUWadfiSsRMkwuWrGmvH5udIPeVIhP3QDgBkomOkOIb/1u1vBh
         kEeg==
X-Gm-Message-State: AOAM531Fau2IYDeriA5uN1C/oiTFvfxFPk2cSAyUjJEND386vQZuSjNn
        SAyXLjhb3YKt6G+NO7d0yv8Y2yDrVKCstp6h9b9txoEle2aIFg==
X-Google-Smtp-Source: ABdhPJwsuhsLtCp9sG5l95UMgipPlkY8t2rMWW75eeE63CPOSn2U391uvJ5T9DvMj/iGZ8DyBoaXnmXyq4MRkunAwDc=
X-Received: by 2002:a05:6512:68e:: with SMTP id t14mr22914853lfe.366.1643790771605;
 Wed, 02 Feb 2022 00:32:51 -0800 (PST)
MIME-Version: 1.0
References: <20220108085419.79682-1-chiyutianyi@gmail.com> <20220120112114.47618-1-chiyutianyi@gmail.com>
 <220201.86wnie8eg0.gmgdl@evledraar.gmail.com>
In-Reply-To: <220201.86wnie8eg0.gmgdl@evledraar.gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Wed, 2 Feb 2022 16:32:40 +0800
Message-ID: <CAO0brD2Pe0aKSiBphZS861gC=nZk+q2GtXDN4pPjAQnPdns3TA@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] unpack large blobs in stream
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 5:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Thu, Jan 20 2022, Han Xin wrote:
>
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> >
> > Changes since v8:
> > * Rename "assert_no_loose ()" into "test_no_loose ()" in
> >   "t5329-unpack-large-objects.sh". Remove "assert_no_pack ()" and use
> >   "test_dir_is_empty" instead.
> >
> > * Revert changes to "create_tmpfile()" and error handling is now in
> >   "start_loose_object_common()".
> >
> > * Remove "finalize_object_file_with_mtime()" which seems to be an overk=
ill
> >   for "write_loose_object()" now.
> >
> > * Remove the commit "object-file.c: remove the slash for directory_size=
()",
> >   it can be in a separate patch if necessary.
> >
> > Han Xin (4):
> >   unpack-objects: low memory footprint for get_data() in dry_run mode
> >   object-file.c: refactor write_loose_object() to several steps
> >   object-file.c: add "stream_loose_object()" to handle large object
> >   unpack-objects: unpack_non_delta_entry() read data in a stream
> >
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
> >   object-file API: add a format_object_header() function
>
> I sent
> https://lore.kernel.org/git/cover-00.10-00000000000-20220201T144803Z-avar=
ab@gmail.com/
> today which suggests splitting out the 5/5 cleanup you'd integrated.
>
> I then rebased these patches of yours on top of that, the result is
> here:
> https://github.com/avar/git/tree/han-xin-avar/unpack-loose-object-streami=
ng-9
>
> The range-diff to your version is below. There's a few unrelated
> fixes/nits in it.
>
> I think with/without basing this on top of my series above your patches
> here look good with the nits pointed out in the diff below addressed
> (and some don't need to be). I.e. the dependency on it is rather
> trivial, and the two could be split up.
>
> What do you think is a good way to proceed? I could just submit the
> below as a proposed v10 if you'd like & agree...
>

Yes, thanks for the suggestions, and I'm glad you're happy to do so.

Thanks.
-Han Xin

> 1:  553a9377eb3 ! 1:  61fcfe7b840 unpack-objects: low memory footprint fo=
r get_data() in dry_run mode
>     @@ Commit message
>          unpack-objects: low memory footprint for get_data() in dry_run m=
ode
>
>          As the name implies, "get_data(size)" will allocate and return a=
 given
>     -    size of memory. Allocating memory for a large blob object may ca=
use the
>     +    amount of memory. Allocating memory for a large blob object may =
cause the
>          system to run out of memory. Before preparing to replace calling=
 of
>          "get_data()" to unpack large blob objects in latter commits, ref=
actor
>          "get_data()" to reduce memory footprint for dry_run mode.
>     @@ Commit message
>
>          Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>          Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
>     +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>
>       ## builtin/unpack-objects.c ##
>      @@ builtin/unpack-objects.c: static void use(int bytes)
>     @@ t/t5328-unpack-large-objects.sh (new)
>      +
>      +test_no_loose () {
>      +  glob=3Ddest.git/objects/?? &&
>     -+  echo "$glob" >expect &&
>     -+  eval "echo $glob" >actual &&
>     ++  echo $glob >expect &&
>     ++  echo "$glob" >actual &&
>      +  test_cmp expect actual
>      +}
>      +

I have a small doubt with this, it works fine with dash, but not
others like zsh. Wouldn't
it be better to do compatibility, or would it introduce other issues
that I don't know?

Thanks.
-Han Xin
