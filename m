Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17281C4332D
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 17:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA15864DE3
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 17:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhA2RNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 12:13:48 -0500
Received: from mout.web.de ([212.227.15.4]:36985 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231396AbhA2RM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 12:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1611940222;
        bh=rspE6PKtsdlqNQdfKdg+/+3UAYkOs1cHWAiv0OEPexc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KjPLNQGBLQJNHL4c5MLfoQTgFBFJJAli4DLUTQyTzLpx3hAuYffgS+h1xzlEdDFtp
         /ta44J+tFi85AM/1ocfjMT0jR6Eml7Uqa47qXKIlIvXAsP51u9dVY6UQw8lSt2UV9n
         3YRFdvLiTSVI3JiTHBGblc8q0BTheQUw6eNp79/0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LqGCu-1laUNp3jnM-00dmfy; Fri, 29 Jan 2021 18:10:21 +0100
Subject: Re: [PATCH 1/3] commit-reach: use one walk in remove_redundant()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.net,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
 <3fe74e339fc5b7083398f2df51baae5a4a008060.1611851095.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d1c7b530-f1ef-8aee-32d3-6ac6707bad37@web.de>
Date:   Fri, 29 Jan 2021 18:10:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <3fe74e339fc5b7083398f2df51baae5a4a008060.1611851095.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2n0MPJ7g4yt1Va8DwsywVysp1a7yS22zjc5FPr7oSnMI6KnTn5+
 Tyi2dMFpgd5FVEOjpRIeUC3WoumzFPChFBxTSaLYagOWflSfNAk7zOryh4q74MF0QNmvY+/
 D0TC/ZPydGuXE/RWfdLjmWjNDuyrFeJftG7nn3HeSCOxfOrkjQsr+IxmDtbDQNg3OpNGzk4
 7qg7lm0WNrnsVnlKEDCWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3vQpp6ulDIk=:b3GSXnob8gZSrQ3Q1/+Y3R
 FKY6k+9RFngtzIV8pEFwxbfPZUUeN992eQKlSP300zsaaMZTX4WEoREZXkZ3HeB14eAz5l9Wm
 r8zHo/u7uChfrQspTRyVb1kJ0roNf0jRmgq8+j0snOjWoqteRUQGoBQkrGR8NkOCP2G2ccJwx
 dY1/sqATd7mrWP9HHFnEIJXCyQ82LTVKelv7w8AAIKVBkVHkrNc/4IxUqEz8187wDA1Kq/BCV
 qid0+/QAiJCaL6K14Z3oC2yRX0ToeVwjvtjiSBR0iGpYocqllPekQxifDrSAT75lGukSkbVCF
 1uSgRX/CchkY3sN46aDc4KLavKRnrrx3dqfjrKv4k7AzabCIsKF+UpLdDp/lg3LD2IS8AGTgj
 qGuktpHFcR4sCbSaAhKlupPvt9jv2wY59gRMt7HqXl9Cz062QXBt1ursIyZREDJPgdtVuGq4L
 if0mMjQU2rzfWuNToUux8aQXqARczvYHP13OPS1Ma0v+nIzu9vID6h60+tNsUVhmjZfxL6MUe
 U92ccExaxCC0MqTKNZwOHqxvqhB1Zup5GNr+XNO6N70AVgFnUCM4eiDFEAXAnV+HC99cTJ0y5
 rn+cbrYowgqGeUcsP8exZWva0jfsKMv+rSPdbqvUfl0IQH1uSmwIber2mC0wchKkZCiOx8ITx
 Vjhis35pN+epK0m67qYlfYiYk4ttia6qYRzKXRQcFMGsELX//ntLYkfzLCS/s2SkNH411MnvK
 3TH6q1vtODz8LltxJggJH9mVW7NzEYNsTWOxWG/aOzqcUVOaMJrLF7SImBlrPvimM8dzTUDV2
 NsAL7f0OywKBjqno1ezHCeCwIFFki3FwA3QxsqpQCl2/bmWcGYdKtw48tLCdSXGLW6UxWniGC
 uVuuRl2N5iyy9g8DZL/g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.01.21 um 17:24 schrieb Derrick Stolee via GitGitGadget:
> +	/* rearrange array */
> +	dup =3D xcalloc(cnt, sizeof(struct commit *));

You could use CALLOC_ARRAY instead here, which is shorter and uses the
correct type automatically.  Or -- seeing that the next line overwrites
all items anyway --  ALLOC_ARRAY.

> +	COPY_ARRAY(dup, array, cnt);

Ren=C3=A9
