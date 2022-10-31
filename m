Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D08ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 12:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiJaMq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 08:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiJaMpF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 08:45:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C467673
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 05:45:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f5so7544925ejc.5
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 05:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A+V4MCobWWMYPG+Ihf65khlFWb/JyibRict0leZ8cdg=;
        b=CP02gLUeiwqCrMOJv0SDMmFUWFHz+ShOyKrc6b3caerMlfz7IAv65n4FhtohpTbVYR
         YCgLzq7b4Z+DivfhUWKLfiPiuNd9VAdSpNu89j8/EhMLQ93Kh6jWxbiOwHFNfrA+ffXP
         5buw8YmbQ1aPcj2xlfgtyOx9EI0a3TysQ5VeemLY4PfsdbU5Yf4GgqOvz7cw7Bb+Gn22
         6XzVcQcga7JPl09i91Z4vUnpW+RiU90DTSHp1QZ57DfL1iUq5IXFIREzMMtMpOevKfwT
         VkMFepjdca9Obi9e65qZzXRgGjInNgiB7wY/FH/seq+V62ZNllKrPgMXyLIlrGr1Qj4y
         8C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+V4MCobWWMYPG+Ihf65khlFWb/JyibRict0leZ8cdg=;
        b=HO84/J0J/FwX3o2t7xzVzqRoX0HXrbw193dGtZ0SOsgRfLYGxSRlC6iI+/b+eKNIkO
         uLcw/UkI0TCoN+Iplg+6dN18gJxE8sXmBjjK8x1WkRiVmB2C3QJzGDUsF/ILodz06I6l
         RW+ihrsLHfDCWU2CFlQ0arAW2FP8bG0W+gPzHRULXOFf9s00FzTXWvMJUEzg+SpV+Isl
         VMDhyCidBZSzKfcrZqzFN8cddOihqINbk7/HIXoUh7ENGZvZwuaSM4lLeJs2P097pWju
         lTAsyrVBvb8FCaUWs30K9KPTnrk0NlRy7aj3XHxl3wxDCZ6pn66uJjtfyK0rJO0DPtQm
         568g==
X-Gm-Message-State: ACrzQf1nBKnuZ3vs/D4/V4I//zc9QN1G388+m2N6j8Q5RpxB51VViriL
        s8LySm8vi2zOYzAJR8e0jZI=
X-Google-Smtp-Source: AMsMyM7+4lYJJQ7aAvHuyovVnE7H3Flvd2LR/j1agY43KuI1TNXXjb8RJFE10rMIh00wkrQq7ZN0GQ==
X-Received: by 2002:a17:906:8a54:b0:7ad:e517:1eb with SMTP id gx20-20020a1709068a5400b007ade51701ebmr647870ejc.567.1667220299686;
        Mon, 31 Oct 2022 05:44:59 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id dx2-20020a170906a84200b0074134543f82sm3000505ejb.90.2022.10.31.05.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 05:44:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opU9y-00Aai3-1k;
        Mon, 31 Oct 2022 13:44:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/3] hook tests: fix redirection logic error in 96e7225b310
Date:   Mon, 31 Oct 2022 13:44:44 +0100
References: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
 <patch-1.3-1ba41a5842c-20221029T025520Z-avarab@gmail.com>
 <Y12I7zSohPu2cyJt@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y12I7zSohPu2cyJt@nand.local>
Message-ID: <221031.86tu3k6u2d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 29 2022, Taylor Blau wrote:

> [+cc Emily]
>
> On Sat, Oct 29, 2022 at 04:59:45AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
>> index 43fcb7c0bfc..2ef3579fa7c 100755
>> --- a/t/t1800-hook.sh
>> +++ b/t/t1800-hook.sh
>> @@ -95,7 +95,7 @@ test_expect_success 'git hook run -- out-of-repo runs =
excluded' '
>>  test_expect_success 'git -c core.hooksPath=3D<PATH> hook run' '
>>  	mkdir my-hooks &&
>>  	write_script my-hooks/test-hook <<-\EOF &&
>> -	echo Hook ran $1 >>actual
>> +	echo Hook ran $1
>>  	EOF
>
> Looking reasonable to me. Though let's see what Emily thinks, too...

FWIW Junio looked at it back in
https://lore.kernel.org/git/xmqqczh84fpy.fsf@gitster.g/
