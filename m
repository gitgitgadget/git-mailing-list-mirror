Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63121F453
	for <e@80x24.org>; Sun, 20 Jan 2019 18:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfATSTx (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Jan 2019 13:19:53 -0500
Received: from mout.web.de ([212.227.17.12]:46315 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfATSTx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jan 2019 13:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1548008374;
        bh=tnAs7V8r3nS7QgflQuxbzD1zWXv/b9M4ZrdEIuUxAZA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TEu8VYtHrOiIVx4WeO1UvXWjpOysiCm7Cq2FkQnKHegMtsNZdCLON+lSQyf2ZrSiZ
         dPMC7P3THUv2nR+fw7Un8gHLnIVHDQcS+JDGBUVmzAVGSS1MOjno5fSNg/RztxOgQG
         PSdzs+/jf+qQe506cql6aZAFtZ9SUX5z7RW72gns=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([79.237.240.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LvSPv-1hCOur287X-010cvc; Sun, 20
 Jan 2019 19:19:34 +0100
Subject: Re: [PATCH v2 2/3] blame: add the ability to ignore commits and their
 changes
To:     Barret Rhoden <brho@google.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>
References: <20190107213013.231514-1-brho@google.com>
 <20190117202919.157326-1-brho@google.com>
 <20190117202919.157326-3-brho@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f5170cb1-4109-4ae3-7722-8e3b62fb0b92@web.de>
Date:   Sun, 20 Jan 2019 19:19:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117202919.157326-3-brho@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KnGQoeRdVTzhlHh4CHsnDrsLXPdM4esX7lwmO3wYJxuq1M7n4Sp
 suy7xJ4vYgfiuqu6F6Ijfdd5zB3W6GJTAH9lNiB5yFZmKlgrRLLJCZrpo0zrKGwR+G1Q7Ae
 hIAqztnLmMLtLeWNKkL9xPh0O5X4PyYIFF665iJy90LI+Fscl8akYehJFnp1cYxGAldlgg6
 qQYNBeE+t1ZOwOxIKN3Sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AapDAmNLOHM=:j+OmFtdblJNWxw65auT5Cy
 6tuZmVWKtl5XSLa8sooZi0ClA6Lhp+548fMBmmtFOLHMamwJ9b/ktF9TZUxPRJlmgdoHCN56N
 G325nNCWweh4f7w3VLAQg68AKuDl/6BJNWbNvrlWkwXAX8++1dI3yiclZYubBMg7Y/6SO5TgL
 gSNhMLZkkX2ze7PvQlq6uF/qSS1xDpK9LecOivao2Owyk8GbsEtc/vFTmx+yDKMWzXQ9fvEi2
 Oby45VXNZLwPTvuXxsNXjyZAraQt3fvUDIHCgMlMAd3U2LETGO5jqCrRVsqanmr2J9df9zhgy
 LmVGmuluD3NZ/gcn1xw1bbYHP+B3aZohSCZ6Irk9P75PL9vd9A9hM0w4wNCAuRXFGRUQLVApq
 Xb3zgipFioz8TozlI5gWAdTtWjyEBfyK7NSc5QOKIgqRfH7/e3NVwSvUYhU9nD5g9uwxR1J3F
 Inx8H6LxXhZ3xx5TWkJ5AkzRpwNTxYE7+JjGkIw/Mv0/ik+MqRMqE1JoAK3rbhO+XlRWcRykE
 qOUwuR3S6RVGODvNsoL6BmxriFl8lWZEPuheaNpQszrpxt7VsEQ6tFEgcSCjtmrw+xfx/B0dE
 OxvmY/Vqn4O/JWn53Yu8PCz4zNcdqg0Jfy91euf+tRwE60Q+b7pp75C76HjGfMF8d6rdRy5jt
 RnjEMqwJ6++l77Q3eF38fwBWTqfq3se2igjPEZnitx1nmnl7Gvzt+yeuCiYb4CpszD88Qdv6B
 nGJP5jc3uJkzIpiK7YKVRbBHxoQ6ngPOFkMhhYBQ6DwNQLkuGLwabqZuy5euvqEMnSyMKUPjH
 J8nEjAn+1V7IxmO6+sbS0tc8yuPQXUNi/RkhMvWUOrdbYeaPKSoe5pS0yyqGTN+9rxswTUmup
 djQk2/+Yrgo+4vHHNv5XJV6VPel7m3ukJt0IxJfIa7DTAr9oDKzB5upOZUQxPt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.01.2019 um 21:29 schrieb Barret Rhoden:
> The blame_entry will get passed up the tree until we find a commit that
> has a diff chunk that affects those lines.  If an ignored commit added
> more lines than it removed, the blame will fall on a commit that made a
> change nearby.  There is no general solution here, just a best-effort
> approach.  For a trivial example, consider ignoring this commit:
>
> Z: "Adding Lines"
>  foo
> +No commit
> +ever touched
> +these lines
>  bar

Wouldn't it make more sense to assign such lines to unknown, perhaps
represented by an all-zero commit ID, instead of blaming a semi-random
bystander?

Ren=C3=A9
