Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856DCC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629EB61040
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbhIVTxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhIVTxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 15:53:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4D1C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 12:51:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u27so14200916edi.9
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oblE/jNL8jLejmGXjQc+w3JDUHXLvmoUs0hpHFGOm+w=;
        b=F89AtFzfYAsJl9jUCseye6Pbh6o+xZHpJKuFNHv+UB01BhnXunZhRIl0WMEGAfTwoz
         xUB9f8zw6znN8ii5886I2+Ql65h8BYFnRgKVKESHW6e51Jsruo/lqQx73gxTnNEqhhNW
         L+G/Zxj7Ory5v3rE5dGkyhXNLWpWeqEyZIg/4Quw27ep4O0oUSXztTv6yJszcX8UPiz7
         fH6pSKux9HTBKn5gEU6qazHSpxiZclAh89VYb762PuJLqQ3KQAlP8dEjRRZT7p8PJ3nl
         vYhDgd8njwPCZTOt1cDpybQpt05spfRJgWWSnuPo4+WZ7io+BThCJZZ9dieM84itHyFz
         W+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oblE/jNL8jLejmGXjQc+w3JDUHXLvmoUs0hpHFGOm+w=;
        b=f2PV7Cmz5Y3hjkjFU1FfO8G+Zhv3Sc7vpnDC17m3ljbQlPNj6A8WUhPwHM2k221nuo
         Ko3m1NVQlYneK71JrkhkLVkbomB65CZt71fDKa5W6VPf7hKgI9bGFuD97jX8grCPWcjn
         L1gvCfdtTeiW47eE/mxpViAGTX+YLsbfrh4e9F+PNTL/ikFpdEraNIatX3LJtIjk1/Z9
         4rtQPnhKP3taDjiPGwd+xt6vCjzm0dSfwTHvlXizix29kFtNxACbLMu6XTJgPuRxNqUw
         525avyvcYllDHmTAMuHrVjmhY10XowHWh0qCNRPz4mmUdiZb3LTFN29leZWLZPGDSjHJ
         NrCQ==
X-Gm-Message-State: AOAM532335FtOaoMN079pJhhcGrFIFLPgh51hW0QG0N7UUXD2AfBWK/K
        jnQuJgKniAyA2zfsTsW9xkniC2Px3yPysw==
X-Google-Smtp-Source: ABdhPJz3EZmK47PKVU6F/GtGwhET4zdT6+oK4PLHNgEUml+7jNYJtLkv3vuRKcJCjd/SEeer22N9kQ==
X-Received: by 2002:a05:6402:34c6:: with SMTP id w6mr1253512edc.97.1632340297817;
        Wed, 22 Sep 2021 12:51:37 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m22sm1690111edq.71.2021.09.22.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 12:51:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work
 with DEVOPTS=pedantic
Date:   Wed, 22 Sep 2021 21:45:52 +0200
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
 <xmqqmto48ufz.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqmto48ufz.fsf@gitster.g>
Message-ID: <87fstw75iv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 22 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The "COMPUTE_HEADER_DEPENDENCIES" feature added in [1] was extended to
>> use auto-detection in [2]. Then when -Wpedantic support was added to
>> DEVOPTS in [3] we started passing -Wpedantic in combination with
>> -Werror to the compiler here.
>>
>> This broke the auto-detection, but since we'd quieted it in [4] we
>> didn't find out.
>
> Are the references correct?  I am not seeing "quiet"ing in [4].  The
> redirection 2>&1 to cram error messages also to $(dep_check), hence
> making it impossible to match '0', was done in [2].

Yes it's incorrect, I meant [2]. I had this right in my head, just got
the references wrong somehow,thanks.

> We did make the pedantic mode the default and pass both -pedantic
> and -Wpedantic after [4].  Before we had only -pedantic.

*nod*

>> It was emitting all of this on STDERR under GCC:
>>
>>     /dev/null:1: error: ISO C forbids an empty translation unit
>>     [-Werror=3Dpedantic]
>>     cc1: note: unrecognized command-line option
>>     =E2=80=98-Wno-pedantic-ms-format=E2=80=99 may have been intended to =
silence
>>     earlier diagnostics
>>     cc1: all warnings being treated as errors
>>
>> Let's fix that bug by maintaining a NON_DEVELOPER_CFLAGS, it's like
>> ALL_CFLAGS but without anything we add in config.mak.dev, and
>> furthermore stop redirecting STDERR to /dev/null, this means that
>> someone whose compiler doesn't support this will see this output, but
>> also this new message:
>>
>>     Non-zero 1 exit with COMPUTE_HEADER_DEPENDENCIES=3Dauto, set it to "=
yes" or "no" to quiet auto-detect
>
>
> Hmmmmmph.=20=20
>
> I recentaly saw many .depend directories (not necessarily empty)
> left after "make distclean". After building on one branch, I often
> check out a different branch then run distclean on the new branch,
> so leftover build artifacts are not necessarily a bug in our
> Makefile, but the bug you found may explain it?

Yes, I'll update the commit message, the problem is that we'll empty the
dep_dirs list if we're not *currently* making them, that's a logic error
in a few places in the Makefile, i.e. conflating currently building X
with wanting to clean X.

[Will respond to the rest with a re-roll and/or in other replies in-thread]
