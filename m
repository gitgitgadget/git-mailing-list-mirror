Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1C9C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 15:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjDMPOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjDMPOE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 11:14:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBF9A5E1
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 08:13:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so14409659pji.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681398836; x=1683990836;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRzKNf/rWLsTQb8v7AjW87LRzgU62m2OaciRYvbOdH4=;
        b=neiGZ0tlxEu+APjO2Jn4OECUvoxNKgtOPoZw6nKZ5Nt/8JpPW3/csTgMYof2mvaYvm
         fAAVbml7PWFeVJvLKWreR5V0YHpNIyHvLK20mohQUpNY6+dEpKPQVQijuk2vP2i++0+U
         UEI4KP8eAYH7eCIiO0BLYBzomWHYTjyKkW0EjtwgxIrlWAevAH+nkZmQ2J9o8PEfdThh
         sdWbV2P2lugPgbm2N4+1Vos4QBz1+2BEKzWwTTEE1jVkHulLVFbgF/EvEDWUSf0EmEsz
         5gBA1K5fgyqHWQiPIAndK6mSEg9fWrq0CCb9Dfd5BMn6P17bI1WIY1iJcFvqsZRA0xOw
         UJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681398836; x=1683990836;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRzKNf/rWLsTQb8v7AjW87LRzgU62m2OaciRYvbOdH4=;
        b=AQTFsGLwEgMec5ZCJ2RFVYUmDLQFAmuu+rCt5EwZFHQB49VW+rHsGZQ9+9SRCrfb/k
         p9M09LQists+xyPxPylyJKcBdr8v8e/iITmR/3vNpjwgrcZF1hFz9k6TTLLiAbWZC1Nh
         PkjhLRN8IQYfD71jPP+Z55gnwKVFBbzk082Fn1CXnxF3+4+BKVg2dIu+3afC7nh8ridx
         mkr5bK9kDv7qKCOObKOAh9fGffT3HBMvqDbMxwgrsWXgTsqVI/ziHkNqyQbxPPf+KAHs
         LIV9zMYddfYbfzw+QaFZqqfS3LLXP18xjy1oNKmdpJQw87rP8xWJGxYJi18yCEoHCYB8
         pW5Q==
X-Gm-Message-State: AAQBX9cVkA/8j82FfVT1YkUS6xExhnL0GHh6MXRc6sw6ZgVrvBCDKg3b
        /2SltJa3nVqao1Z0TmswxpE=
X-Google-Smtp-Source: AKy350am+ITupWbmRyFZUKyFUogNxFVcYiFu68INIny82rJMTYtVBdu8BZCAGiGgl3E6KmRmpY4RWQ==
X-Received: by 2002:a17:902:a586:b0:1a6:3b9a:afda with SMTP id az6-20020a170902a58600b001a63b9aafdamr2433716plb.24.1681398836399;
        Thu, 13 Apr 2023 08:13:56 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709026b8300b001a688de1f0esm1403632plk.234.2023.04.13.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 08:13:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        peff@peff.net, phillip.wood123@gmail.com
Subject: Re: [PATCH v3] branch, for-each-ref, tag: add option to omit empty
 lines
References: <xmqqjzyoq35x.fsf@gitster.g>
        <20230407175316.6404-1-oystwa@gmail.com>
        <a8b34639-60fb-8a23-d1d9-1ef4410a2ba4@gmail.com>
        <CAFaJEqtWg-6wvLNQy1DVSquVOu==E67gN7QYw-sAUf9fufOngw@mail.gmail.com>
Date:   Thu, 13 Apr 2023 08:13:55 -0700
In-Reply-To: <CAFaJEqtWg-6wvLNQy1DVSquVOu==E67gN7QYw-sAUf9fufOngw@mail.gmail.com>
        (=?utf-8?Q?=22=C3=98ystein?= Walle"'s message of "Thu, 13 Apr 2023 09:17:02
 +0200")
Message-ID: <xmqqbkjrzufg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Øystein Walle <oystwa@gmail.com> writes:

> Sort of... I think I meant s/printed it/printed/ :-)
>
>> "git tag" is mentioned in the subject line, but not here.
>
> It should definitely be added, yes. Junio, should I resend or will you touch up
> the message? Not sure what the proper procedure is since it's already in seen.

As I write in "What's cooking", being in 'seen' does not count all
that much and we can freely replace them and erace the trace of
"past mistakes", until the series hits 'next'.  For small changes
like this, telling me to touch them up, as long as the necessary
changes are obvious, is just fine.  Sending out v4 is also fine for
a series of any size.

I just locally amended the commit log message.

Thanks.

1:  e0053ad012 ! 1:  aabfdc9514 branch, for-each-ref, tag: add option to omit empty lines
    @@ Metadata
      ## Commit message ##
         branch, for-each-ref, tag: add option to omit empty lines
     
    -    If the given format string expands to the empty string a newline is
    -    still printed it. This makes using the output linewise more tedious. For
    +    If the given format string expands to the empty string, a newline is
    +    still printed. This makes using the output linewise more tedious. For
         example, git update-ref --stdin does not accept empty lines.
     
    -    Add options to branch and for-each-ref to not print these empty lines.
    -    The default behavior remains the same.
    +    Add options to "git branch", "git for-each-ref", and "git tag" to
    +    not print these empty lines.  The default behavior remains the same.
     
         Signed-off-by: Øystein Walle <oystwa@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
