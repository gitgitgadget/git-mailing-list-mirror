Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A3251F461
	for <e@80x24.org>; Mon, 13 May 2019 11:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfEMLPJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 07:15:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:60573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729346AbfEMLPI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 07:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557746093;
        bh=zVg6DdB1NjjxyHNWaTZgVCi7snD5J+/VqIwUovfq490=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iv4UzjV0EKcueW8q1WMW+6UDgl7PjpDSbA+1cc5q4Idj+GcGnML+SHbfKjSUAC5eC
         sIiRWEzpcboLwH3pViIJS1132dimSiffkcAwz7V4FQ168ANkbHKx3mTtBQFTcbBHbu
         Zi3QwtYSG/LMTqLgWDKgIgaU+cNTcONoTPJJEWvg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPD8G-1hLj4f1KBU-004UYa; Mon, 13
 May 2019 13:14:53 +0200
Date:   Mon, 13 May 2019 13:14:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] Start to implement a built-in version of `git add
 --interactive`
In-Reply-To: <20190501022123.GA22549@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905131313180.44@tvgsbejvaqbjf.bet>
References: <pull.170.git.gitgitgadget@gmail.com> <12978dc248a2cd07c90559691b8a2add84f45394.1554917868.git.gitgitgadget@gmail.com> <3149b9ba-2f5a-46ce-ad89-4105ec217795@jeffhostetler.com> <20190418160633.GB8054@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1904301935400.45@tvgsbejvaqbjf.bet> <20190501022123.GA22549@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bO6yDX0HMFz4C5DIlGy9hJxSasbG4KURTETkhJcSoH8XIEJrqov
 D7EDuX6yGJWpnIgj4/VUyBloRGiYNzopmldPDiLuPfF00UdD3Qcv3uhcMvgx/A7qlLtC+ge
 7YA13IskahHSaV1GF08zEcTQM+zmrtawhifB2dQMOFropSjJj/HjRI/UdVIJD5nnumg8eOC
 VjYMx8/+M+mPWjPC2fG9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WrEZNSwoBnY=:4UzEtRgYA6b3DKCOiRAxMS
 2FFFqgcFkIF2kcLQ1RwShEB5MRhD4pzs84Q2swMQE6REu2gAiDg2sKbCP6XfzNNqAVb6yUDFm
 pIjSdg2KEiJu7rZFn827ocEKHhEhNQ4EJLTbOlbUwKsUBwFLp4l1md3yVV8pbLy8s9z+6qBmQ
 aq7Qeezr6XkRShXJ9CSUUS5ZCvAl/rhaGXfnINRNT+j95EJY6cZamqi0uMI1477dAXSjvv7Ci
 CCWIZ4NW7miJKNcJhI5R7v7DRfhfeUHFWIc9/mdFfW8oS87xMRZl1tVJtQnOtWDzVbIjkkQWj
 7uDCtT17Rbxa4BhnWXjz/Vw283msKSPnzHVU8Yb8i5lfJtFEooU4hySaVjJqdjnJMhYARzT/a
 82Z97dUzRZHiic5RQ+1PozGoqwDpFim2wtgKozupeODAoP6xyH70K0pBeP0+KFU0sVHheT1rn
 YUacbUpU85SS4y58hIyJ3PainlZtBHnkpzC98Qg8N+0iC+JQHUEnv4NVA+CwZGo6tf1UFfcvk
 AsHhng9SyA48KgYgj7tfytKZJyDioOMBbey4wbhB8YM+xLurRJbIQN/0btCpC29fZnKE2dxBP
 3ryGm+V9VDZNkcIKR8vv5fY/49A8R2YC5Pj8cmxVyisuEopDCBKFR2V701E5g+2fhd6M8s27r
 jM+ZOWehJZBPfU4HQ6r0jHEUyd4HPbAYfy2eSgz0UoVU/xqAld0RugVxDt/igpWLWWH86pSjH
 XkGaFKgUbrO7YDTTCrXYGRwfC92pEKcOZ7dTfYpt1RAPGZS/BCC+bgGo896U92POpUjssU1S3
 8dcRBMOQnNjZOGuSss2++4mqecpDn6aeEeZONfT5Ln0mXsTnRbVQrZWSdbu9aJ2gr6ca8acta
 AaXmsQVeC4Uf1x2d1tj2A6NiZvJRzlbAng+oYr//GR7IcqgGawi0eV43iIUhgcBEEH7gegQnH
 Y6QMoqLNtrQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 30 Apr 2019, Jeff King wrote:

> On Tue, Apr 30, 2019 at 07:40:06PM -0400, Johannes Schindelin wrote:
>
> > And I also tried pretty hard to *not* bleed any internal state of
> > `add-interactive` into `builtin/add`, as I wanted the new code to be
> > as libified as possible (in a nearby thread, somebody wished for a new
> > `-p` mode that would essentially be a combined `git stash -p` and `git
> > add -p`, and with properly libified code such a beast is a lot more
> > feasible).
> >
> > Any idea how to deal with that?
>
> The most lib-ified thing is to just use the configset code. I.e.,
> wherever you need the config, just load it on demand via
> git_config_get_int or whatever.

True.

And it cost me *quite* a few days to implement the changes. But the result
is definitely a lot better, in my opinion.

> > Or I invent a new convention where `add_i_config()` returns 1 when it
> > consumed the key/value pair. But that would set a precedent that is
> > inconsistent with the entire existing code base, something I am
> > uncomfortable to do for the sake of `add -i`...
>
> Yes, don't do that. :) That was the same thing we finally got rid of for
> userdiff_config().

Thanks for stopping me. I did not remember about the userdiff_config()
thing.

Ciao,
Dscho
