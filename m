Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDDC62023D
	for <e@80x24.org>; Wed, 28 Jun 2017 21:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbdF1VQ1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:16:27 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36499 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdF1VQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:16:26 -0400
Received: by mail-pf0-f173.google.com with SMTP id q86so39365827pfl.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Z3PX3jxGjUb9BGN/HxJydXb+BBNpvJvfFznGP5+SAFc=;
        b=QnzBHodzgfi1R5Oc9NjPYO6qf0xQOupvckIBUcDMaV5PR0Ragk8Q6VQr9uNRFW1dyW
         vGlL6ARZKgVJdjSX66hDc6fd1vMMLwz6Ms7ZicTm9gqtdT8sDtC6w9k2tP1iD8YL+jHv
         ooRzdEqkt4MCDlN4l5KswCMQrqbxa2Kk/gxyzRag/p0TY7Bo3CLMa9Gfg0FdneukZ60s
         l4UtgRKdlWCauVld1RxMBqXrgaARpPomxKLO2EFCLLnbLSKEKXCc6czWrECkRHDq0ISQ
         t9C8ysLel0KGt0pKm3D/TGfBEOkOZIJhjPYblgOn5zYFvw61FQ+VIQxZGObud0RJhf+F
         /mfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Z3PX3jxGjUb9BGN/HxJydXb+BBNpvJvfFznGP5+SAFc=;
        b=bsGW1wGfvZDlvp2Z3wQiXpC2doU9l8zYluNXz8BIGaX0IdmB20781kvqV3TUkESv2n
         SUpnw7uJXbb7hhEmKNKEtS6VMQII2NSPJC0h5lhT4MFvpp3xtjaw5+2B4Smgkbh7VX3S
         53uVkQhxMN/M88nUDDJaB6O2+6bgrYP3ao0Lwi4Og1bu7na7GxZ8MtVPgJVtKV/+zjn8
         eC3oJroc9kSiZKAWGFcPxZRjkpOVylMsrWK+M+OT1gov0l5o5ZOKm9HDboaN0LgljrCa
         H3BdBe+VbLOI7Tc3uTxNFNnLJxohq8HdIiZJbiTEO2xQgmxHCYEi0eu0li1c3WACHdHX
         ok6g==
X-Gm-Message-State: AKS2vOxBYQWhq6fewcWZ5Cny3yNvp481M2KxxHN3M0e+NGQTOz+foV1d
        DGhDiFLQnGb7Ng==
X-Received: by 10.98.207.2 with SMTP id b2mr9031276pfg.16.1498684585416;
        Wed, 28 Jun 2017 14:16:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88a2:2d61:9b86:f64d])
        by smtp.gmail.com with ESMTPSA id c22sm8067381pfl.97.2017.06.28.14.16.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 14:16:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] diff.c: detect blocks despite whitespace changes
References: <20170628005651.8110-1-sbeller@google.com>
        <20170628005651.8110-7-sbeller@google.com>
        <xmqqshikye0o.fsf@gitster.mtv.corp.google.com>
        <xmqq37akya3j.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbsAi95+ZgjMem+MViKiXby7gZnGyg4Hbua5xw6TaPz_w@mail.gmail.com>
Date:   Wed, 28 Jun 2017 14:16:23 -0700
In-Reply-To: <CAGZ79kbsAi95+ZgjMem+MViKiXby7gZnGyg4Hbua5xw6TaPz_w@mail.gmail.com>
        (Stefan Beller's message of "Wed, 28 Jun 2017 13:36:56 -0700")
Message-ID: <xmqqpodnvmmw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Originally I wanted to do that, see prep work in [1], but Jeff explained that
> the additional pointer in the compare function is **not** supposed to be
> a additional payload (such as the diff options specifying the white space
> options.)
>
> [1] https://public-inbox.org/git/20170512200244.25245-1-sbeller@google.com/

Ah, yes, keydata is a wrong thing to use to give additional hint to
the eqv function.  We do need to fix the function signature of
hashmap_cmp_fn.  It is common for us to want to use a single
implementation of an eqv function that can be configured to behave
slightly differently but the customization will stay the same
throughout the lifetime of a hashmap.  IOW, hashmap_init() needs to
be able to take a pointer to such a configuration data
(e.g. diff_options), and then the comparison made between two
elements that hash to the same bucket needs to be given not just the
two elements but also that configuration data to tweak the function.

