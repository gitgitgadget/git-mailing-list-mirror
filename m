Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A30C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 18:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjANSYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 13:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjANSYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 13:24:25 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F77FE3A8
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 10:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673720653; bh=LI+9l327uNXfH66YYs84Avl9lTVZLncNpLJdHFxbpKI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=S3yv2lqgDQ2+Q/p8z1wd3c+aHwiIUBb08nF+MH6ppi1cXz1RY5ElFoqJxm8S5uT1G
         x/bRMLs4eAkwnNYHWka1fQnZRB5kLsErYpe4wXGHHd52SA20/iPvmjjI4J8j+bpAbo
         Fcaldd/F2soBwOHnvKHxBLCb5YIkzNkxoEUsGxsNaR0bn+dqX3VVJuwULl0OgMeHpi
         7IhiWuULoD7vWFE83UviptE5LpvEd2VdTeIz6WA/mtMIryRDo0jegEYsYAqV8RLNpP
         Tv6rtdFb+/Qi00cEhCQ598X9D0wVPVixR5lreVH97G+Y5aQbqFA8K/iFR0QVl4mZaZ
         Binbs/dpPSTuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([79.203.21.69]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVaYi-1p8xh32GsW-00RcUD; Sat, 14
 Jan 2023 19:24:13 +0100
Message-ID: <442edda0-6988-a326-a25f-a84969dbb2c7@web.de>
Date:   Sat, 14 Jan 2023 19:24:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ls-tree: fix expansion of repeated %(path)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
References: <59f0a3f8-2dae-db47-5075-0cf50aada335@web.de>
 <xmqqmt6lkqrp.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqmt6lkqrp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FOngYVN10s9+Ag9bhV3aQgLFye+dcBPYXETMEuG4l8HJaoAHxLr
 Pzbft4YTTLVW8BEmo5OBYV4raAmanJ5ruAyTTOAbahrZUEKIp2tetDBsM6V8eEMjHLf3a7L
 Zl1j4I9u78jnyHJKoX+c/MRS00bL5ivgX+ow+5rAdruEg2+d5uXAm4A4DTC3eNfl9fCiHh2
 dPOuzKpHYyCdNAVwjjJdQ==
UI-OutboundReport: notjunk:1;M01:P0:YcJeWvbSDnc=;mancRlJbYv8GPJhGWya+/wpx7rs
 lwzO8FP1W8DVRGkLaBk2wQsXvRPEKtHVmEBs4W/vWW2BYM3Oeedpl9Z8jK5yOpLYzOGgkgPLN
 GbUhwnOEv6EQos/XW3h3i9EOEomncHm9k02nHK68riaAJ0VEw0h5X6xYPF3dhG25Efh2hRD9o
 0s9uowE8hqtjAydlOVKiJE2wRGrQnHKgnqwFVy8XTEO/rj/um8oRhye0K/csmrWaRcRCMU5cr
 LKkXOMdKUAtqgUw0vHmjQVQ5axQtKEYZqsVwRO034S8Tk8kBeeJ1BpFpb81uEEhgSKxKew+15
 eExwdfys4IGeQeXlqvUqzr2MiLE0j+uziJ97CS5wyuYsNmkI3qVqIeURlho7Jr9ss4PdM9WbC
 NYBaeozOMMmGYN19bQ6OcFJpVATxOIm7zyUlM7pRgmMoQzHC7CjDthiHteWjQRNg+yBEvovCp
 hvGqmqzlNORoa1JNU6RyVSuWWMsJmyJ5GJVO8ugDhL5J0au6WJAbo272jzDKdjG8Vtt0kjNec
 nXIR1eVqCufigCcWrs6anEc2KSlzKUJCPMj8DkEwfvjO8v5CATR/pb+yUz+k+8vNkIZy9qKSG
 ChFyESP4yTzyGkSU3DheSFAWStStdlwti970NjCRpNQcdNhAiXufqzWTaSFNDU2YbFAvXs3+n
 tuVURtQFko/hUXuaT0fgKj5ms9J2JPMum6wLjSPivwSxah7Gm6g9+/4yd+SKALxgu4B6Fo/Kw
 ZNeqmN69eVYL1vKl1O/sLrWOmgeKMqtxsB7aPfOVARaJoITI5RcAZob7ZTXfebg8pCh5JU5iM
 amqu0LFRDzzsyKhw9ePGaq2rukTyi7j8rnyBN/C7S4UFYXdCD51G9hTiE0NsSJVrm4jGAr46y
 h91jok5lBcOP3F+b39fk2hSfPnR4liFVGWSz+P9/k1FI67LGrjeA77HMC+3K0ndwHjXZ/Npfs
 HcqogsHAZxAWKPcuSBqco8v3MS4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.01.2023 um 17:46 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> expand_show_tree() borrows the base strbuf given to us by read_tree() t=
o
>> build the full path of the current entry when handling %(path).  Only
>> its indirect caller, show_tree_fmt(), removes the added entry name.
>> That works fine as long as %(path) is only included once in the format
>> string, but accumulates duplicates if it's repeated:
>>
>>    $ git ls-tree --format=3D'%(path) %(path) %(path)' HEAD M*
>>    Makefile MakefileMakefile MakefileMakefileMakefile
>>
>> Reset the length after each use to get the same expansion every time;
>> here's the behavior with this patch:
>>
>>    $ ./git ls-tree --format=3D'%(path) %(path) %(path)' HEAD M*
>>    Makefile Makefile Makefile
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  builtin/ls-tree.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> I wonder if this was broken from its introduction at 455923e0
> (ls-tree: introduce "--format" option, 2022-03-23)?

Yes.

> It seems to be the case.  With the following applied on top of
> 455923e0, the new test fails as expected, and your patch fixes
> the breakage, so I am tempted to squash the tests in ;-)

I didn't include a test because it's an odd bug which I didn't expect to
ever return.  But its current existence proves that it can happen.  So I
don't mind this addition.

>
> Thanks.
>
>  t/t3104-ls-tree-format.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git c/t/t3104-ls-tree-format.sh w/t/t3104-ls-tree-format.sh
> index 7f1eb699d3..7e6c4dc5da 100755
> --- c/t/t3104-ls-tree-format.sh
> +++ w/t/t3104-ls-tree-format.sh
> @@ -37,6 +37,12 @@ test_ls_tree_format () {
>  	'
>  }
>
> +test_expect_success "ls-tree --format=3D'%(path) %(path) %(path)' HEAD =
top-file" '
> +	git ls-tree --format=3D"%(path) %(path) %(path)" HEAD top-file.t >actu=
al &&
> +	echo top-file.t top-file.t top-file.t >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_ls_tree_format \
>  	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
>  	""
