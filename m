Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17583209FD
	for <e@80x24.org>; Fri, 26 May 2017 01:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758972AbdEZBFQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 21:05:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33481 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdEZBFP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 21:05:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id f27so42410004pfe.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 18:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3IR1yIkRAzoFLm8QMQWzornM7YimptXz5xYEQV2mKoU=;
        b=Y+OBl/zvaXaSeEmpEQwkKYdhpQQfAuGJeduo3reFvxQlDLPp7Va543mRtWH/YLuqKy
         x4kWQpe1/6gS5wIjovNXYpv1/Okc7IL01hJNwwkR0mHAPMtU15M3GYf7AEqAjCbNY+y9
         kFeBuPBAX33gfwfwMH9t1RSFV3nIICu/BGMhiJcEBaitCzjFKF4kvM1rTWdHOjbr8QrH
         BlD0rYYyYE4L+gZ+t5Fxr8IFw5sdNT+ndgEOhWmBxjJtrVGDtzSWn1Q+487Pd9I82GQS
         FRe0TwjpVEknuh30O9uFaejf/oAguYTcTY2Z7D9xv0aZenQzW5/22LBk1nQec9ulTEPs
         dvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3IR1yIkRAzoFLm8QMQWzornM7YimptXz5xYEQV2mKoU=;
        b=jdq063M5fntGy4HQtonRibSaoY6TcgbapXr1PwP6ckPeqfkZh/Wta3Sy1bw0cb1CPH
         RKa5p61nfADK61dJnMrBjEetSm4SBYxfNa3PN2v8OQ66Bfbzt8EdcnI0KRTkT4CbnRN0
         bExW8hOCJ/MDTk2XHiXHX0LK099xl+dd9ZFX8aMz3SA4zjbYE02OyImLSBno0Kwk1Er8
         TMZ8OcQ9zh44xO6X+QkUsVpbtzWG2x+LXD/auDEJkyG8034ow9AXG94VLwaPObxGXXjn
         6CNVjQ400lk64gXoKBpOjxdWXsqWMizEqgoQsFu7SUwEdSWDzRe94gxIpH0B1x31fi0U
         X1ww==
X-Gm-Message-State: AODbwcBrKleKUJ2gCXjtgHrhp1oPgBLDOXz18RbGirvWOryrMyIhqfWi
        BJrYyn4x8ZMg7Q==
X-Received: by 10.84.215.197 with SMTP id g5mr54374526plj.131.1495760713945;
        Thu, 25 May 2017 18:05:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id e20sm15929865pfd.34.2017.05.25.18.05.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 18:05:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 6/6] clean: teach clean -d to preserve ignored paths
References: <20170523100937.8752-1-sxlijin@gmail.com>
        <20170523100937.8752-7-sxlijin@gmail.com>
        <517a9182-0366-d51a-b7e5-f9085df5b4f9@web.de>
        <CAJZjrdXZkxjHt3XFFhS2BDWwwW8Gmz7frfbUzxgBBwcFYBZe3Q@mail.gmail.com>
Date:   Fri, 26 May 2017 10:05:12 +0900
In-Reply-To: <CAJZjrdXZkxjHt3XFFhS2BDWwwW8Gmz7frfbUzxgBBwcFYBZe3Q@mail.gmail.com>
        (Samuel Lijin's message of "Thu, 25 May 2017 11:36:35 -0400")
Message-ID: <xmqqh908ctrr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> On Wed, May 24, 2017 at 12:14 AM, Torsten Bögershausen <tboegi@web.de> wrote:
>>
>>> diff --git a/builtin/clean.c b/builtin/clean.c
>>> index d861f836a..937eb17b6 100644
>>> --- a/builtin/clean.c
>>> +++ b/builtin/clean.c
>>> @@ -857,6 +857,38 @@ static void interactive_main_loop(void)
>>>         }
>>>   }
>>>   +static void correct_untracked_entries(struct dir_struct *dir)
>>
>> Looking what the function does, would
>> drop_or_keep_untracked_entries()
>> make more sense ?
>
> To me, drop_or_keep_ implies that they're either all dropped or all
> kept, nothing in between, which is why I went with correct_, to
> indicate that the set of untracked entries in the dir_struct prior to
> calling the method needs to be corrected.

Neither is a particularly good name, but if I have to pick, I'd say
we should keep yours.

drop-or-keep may indicate some are dropped while others are kept but
it does not say what the function is for.  correct is better in the
sense that the readers can guess that there is something wrong in
"dir" at the point and needs correcting by calling the helper, but
still does not convey what exactly is wrong.  How the wrong-ness is
corrected does not have to be explained in the name (i.e. I am
saying that drop-or-keep does not give us much useful information),
but I wish that the name of the helper hinted what kind of wrongness
is there to be corrected to the readers.



