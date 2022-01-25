Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF4AC433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 17:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348819AbiAYRJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 12:09:40 -0500
Received: from mout.gmx.net ([212.227.15.19]:36475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354099AbiAYRHr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 12:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643130454;
        bh=0BzJfvWZ+hzVznOd9zFxxMqHjzksvu2xCOVtAe2mck0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BWZC6jtnod632oZTkrt9vS5pU8n080Us1hoILtuxBQ1T+Bu22/mtxmD8MpdwP8w7G
         8fhFR42xlf/jTgma340lQABeqx855bdJat4VkBwZ2oThtRq36ETYbejuiGkTzueKa0
         l1qLMbzTnL1GkBxegBANsgSYQLOMUvlLQoslTivQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9nxn-1n9Oc72iYv-005mnn; Tue, 25
 Jan 2022 18:07:34 +0100
Date:   Tue, 25 Jan 2022 18:07:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 04/12] merge-tree: implement real merges
In-Reply-To: <05bd17686e1404c81542b6bbf69dcd3decb83c5b.1642888562.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201251804250.2121@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <05bd17686e1404c81542b6bbf69dcd3decb83c5b.1642888562.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/97I+lz9V67YhrZLelVRHEs7xEkE2L/pgA/dmbBaKO+RrZimTZG
 ll60Dwacnbn0klBCgKK0ZTE29EBO4tFQPu+YYhPc/de6Fbp9HpyVutFZs5b1JQ0oCAM838T
 qXTKckUcJqx55MCMo6sAB60h+rT+bVR9djO6MqtycNQfaVsQz17hBTp+grqzy+PEitix/dW
 swWvpDOXQoSFmqC14HPGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lRH8Wcatszg=:nbK5i07lFx7e0oVOTt1r9l
 hkat9LvkSHYINqDY9Bj39Q1RICykZ+RuClvizHL8hsD7mjROV4bEHyow8jfc2Dj8HS5eIIMVh
 vJy/NTtP1jJ4ghbQZtpA6XdU6V1EfnOL6A23SW9nvPilN4ONo1e56K+eDZDvPCWsy++6RvoSV
 jsh6/I+ySaLoPdx338LWqRi9kNC3jlwrhmaDbILaI04H4HcdEro40BivTwOM/UpNQ3Ge07FkR
 ZWWEcAO0tyb1DFbEUO4lS3xR2zB4UVctNdF9Mh1kXr33SKULOHDW1WaWOPZcx+nyLJkqd1NFZ
 HzU/V2xoseeOqHmMS288OnYWzASqUktQEMHDLMgoTih9w1rc8ZudR+fq7BvizZJ+wmcoOKK/u
 L9uFHKzJ/CSWreSFJ4J2k93EEqqtqNNxmjf/565C3knU2WOnTb0Ub8gRjCEVVOu/JI4Am6yH4
 rIcibo9o/1iYdPvciLBCp1GJ4Cj21Hi3mzAb6wbjVZaOtu2Cr+6ixtx9wmuyL7w9J/qsUafrD
 qZBEWgBrV7YBW1qumcmsqlcM1c+echYp5DOkkd0ElBQb4OFTc6V6SOOH3MVqxOJjK+4SkghEb
 FJE4y4TZ+Nh3tGu3CpUqDkEOIjo+4MbUP477o11TPZ8WCWdsHn5Src/9gTQShZXqlrO5g5UDc
 YI6TLVkYjVEjigumgfC3aJtIH8t/JBZkvHQEPSe64WJ9t04Wnn6N5At74DvlGgf80+j7irNek
 S4jWfIWj7KShCLEJv3jLublizef5YIiliSqP4XXIen0iJg5xs7wa0Fk8zRKgZ1osBmi7wC00n
 ng7CHThRjBtyFm+4+gZDQJa5xbG1HEokcNQlOcBAoWlXnXStEnJLv0nmSK70TyRxocxjbn1Zq
 7BffX3vULhn4Bj8OhTpJXmrq933L0DpRnaqVLYXMa+8VJA7v2uLIKGrxLPJGAPDVbCR2Ls+T1
 aCm0CIkKm1t5Hhtl/woHXcbuMADrGFNkH2+BLBzQ7/EVNBxu8QMQKBqXqGczik7fyEG/13QnV
 oNGaAYPQ0TkuCVYgfqgmFfe5TThu/RdHADbPwpL/65pt0cM5etO0x6Gp0GyaCJBmzD+ahj6tD
 Xy3ernzlMlvVNU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 22 Jan 2022, Elijah Newren via GitGitGadget wrote:

> +The second form is deprecated; it is kept for backward compatibility
> +reasons but may be deleted in the future.  It will only do a trivial
> +merge.  It reads three tree-ish, and outputs trivial merge results and
> +conflicting stages to the standard output in a semi-diff format.
> +Since this was designed for higher level scripts to consume and merge
> +the results back into the index, it omits entries that match
> +<branch1>.  The result of this second form is is similar to what

There is a double "is" in this line. Taking a step back, I would suggest
to not only remove this paragraph, but to mark the `[--trivial-merge]`
option clearly as `(DEPRECATED)`.

> +three-way 'git read-tree -m' does, but instead of storing the results
> +in the index, the command outputs the entries to the standard output.
> +This form not only has limited applicability, the output format is
> +also difficult to work with, and it will generally be less performant
> +than the first form even on successful merges (especially if working
> +in large repositories).  The remainder of this manual will only
> +discuss the first form.

Thank you,
Dscho
