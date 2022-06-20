Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6E2C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 16:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbiFTQ1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243613AbiFTQZh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 12:25:37 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB53417AAD
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 09:25:36 -0700 (PDT)
Date:   Mon, 20 Jun 2022 16:25:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1655742331; x=1656001531;
        bh=spYNtqrNnQHSLXJzX3k0vvjQ5Uyp81DMwGLR2c3sazo=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=DBRcYOfy9DbCUYvK0afi3O7kopM0vweb8dw3a/0CTFXPGAt1KP3A8oaaMwHylBggu
         /i/Wt4aLFJA8NkivGFuxFN4z+hfy2OZozLecTn+zS39HmsvnU6Df4PjDQesG2//UBC
         lZPuty257n1l5H4HJtvp9NzFOEnpFQ0S+gYPER3Zl8WruQKkSwia8+/D3R1izbX+oH
         mGg3NVrnGIFntLS+AVvUDfILt4op44SLC4a7dgOg+w70hqluOPtetlqCG5Er1E2uX6
         EJ1hoSjxXSr8yAbtpHCoNOt95Z5K+WC97Pn+8pU58tNIF+iGdjB8TibVIplz8VTsrQ
         J6LgSI0sKabbg==
To:     Paul Eggert <eggert@cs.ucla.edu>
From:   "Carlos L." <00xc@protonmail.com>
Cc:     "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>,
        =?utf-8?Q?Martin_=C3=85gren_=5B_=5D?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Reply-To: "Carlos L." <00xc@protonmail.com>
Subject: Re: [PATCH] grep: add --max-count command line option
Message-ID: <xy0kCdbtIjKb_GkXpHs7eeE8eWLbbct69_tVczBGS3CMnnnKTlTheaeNlH-RB1mMAfWThSTN6bMThsQ4lLtr0Ji6RwG3Nd52L1muiEqdtCU=@protonmail.com>
In-Reply-To: <449bede6-82b0-72ef-300d-bc0c49a1858b@cs.ucla.edu>
References: <pull.1278.git.git.1655740174420.gitgitgadget@gmail.com> <449bede6-82b0-72ef-300d-bc0c49a1858b@cs.ucla.edu>
Feedback-ID: 24333956:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Monday, June 20th, 2022 at 17:57, Paul Eggert <eggert@cs.ucla.edu> wrote=
:

> On 6/20/22 10:49, Carlos L. via GitGitGadget wrote:
>
> > + unsigned max_count;
>
>
> Why not make this intmax_t? That way, you don't have to worry about
> casting -1 to unsigned. Also on typical 64-bit machines you no longer
> have to worry about mishandling counts greater than 232 (the limit
> becomes 263 - 1 which is plenty).

This does not work well with OPTION_INTEGER, since it assumes the value to =
be int-sized:

parse-options.c:
 219             *(int *)opt->value =3D strtol(arg, (char **)&s, 10);

I also wanted to avoid using signed int so both sides of the comparison wit=
h `count` in grep_source_1() have the same sign.
