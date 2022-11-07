Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A58FC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiKGVrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiKGVq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:46:56 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D022610A
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:46:54 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id m15so6575154ilq.2
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t3F02o4Z4XeewzbEMuIcphZNI3wtq5q0GKgCaAjVuU4=;
        b=yZl0s3wf4sPAQXa8UFDnW1Mcn87HCM17D13CAQh7LhNUobPqcYWhVDO5WMfakPP4je
         mr0SDxw3bDDMeF62F7kBjZ2QRBiBf6d4AFSdbt7pY7PUUWZSqt68H2eDKZeTt9s59onx
         yYhyS8kpAv6USmwZZevidBIsEJS3hzuqqKD6u8weDlFSCnPRbJZSfKCzujb2FEJsaTxW
         DGj1MlNZZvpSiJZ3WjRtB/NNmsqS6T+53itfUOOGFZY8Ba2RZ4xgyiuG3dDWeQPGhIZf
         Wd986N6Y9YpARQcgKf5wjh8azrXhdb6ezeg9pnoEdx3cyTfafRE5NN9wBln/lcTFybSz
         ennw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3F02o4Z4XeewzbEMuIcphZNI3wtq5q0GKgCaAjVuU4=;
        b=tAzZGpe9xumxeHml49E01Jcv5y9DbsKML//WzdsZfTF4lSLqxMHrDY+y/uaf0GUlOv
         F7rxTXPA7kIJJlnDtOeT3U8mtfmY2CiNleI1dTBqj4/5sPNZ/b75zsALo5hCO9VkrXOe
         kDuRIRt6uy+gBpsW7NbRtlKJ7uudFnR7rBosEYR0rwgRegpDWlnhe6QBLimA+mac65dt
         duXwerIQTgoFc3K7eB1JrCQ4MEEIuLoBzIKxKm5V12143elpwOhYIrNkaUsuf+fXWhdP
         MceMLoS4gKRTufD+mrYFLAzdyYfv+36YdRD02vrwNFSMBe/T1OQnxMtssCh0oDBYfqZ/
         r+fw==
X-Gm-Message-State: ACrzQf2wHyE4bpZOcaOQRtRjIVqVz+eCbTjynf6iDFPI6WIShF/oeCCy
        ChGUTqaGu0NBB3oa2aRe64N/Vg==
X-Google-Smtp-Source: AMsMyM6EuSd4Q+xitT5XzAbgpMbdnlfyArB5vex0VeC9sILVXWcAt72+hnljP3/7oYmujyWS9cOEkg==
X-Received: by 2002:a92:c142:0:b0:300:e232:e0d4 with SMTP id b2-20020a92c142000000b00300e232e0d4mr12228514ilh.73.1667857613639;
        Mon, 07 Nov 2022 13:46:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 188-20020a020ac5000000b003728cd8bc7csm3078601jaw.38.2022.11.07.13.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:46:53 -0800 (PST)
Date:   Mon, 7 Nov 2022 16:46:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Message-ID: <Y2l8xhB+PGS+jBmQ@nand.local>
References: <cover.1667828335.git.dyroneteng@gmail.com>
 <2381947abdd6b965c02e114af297fc908ed3132b.1667828335.git.dyroneteng@gmail.com>
 <221107.864jvax1hz.gmgdl@evledraar.gmail.com>
 <CAPig+cS+8ER=K9byUZs9+MxZ1x9zVxnGKrKm8CGs1zJvvCoSEQ@mail.gmail.com>
 <221107.86a652vfth.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221107.86a652vfth.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 06:22:34PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Nov 07 2022, Eric Sunshine wrote:
>
> > On Mon, Nov 7, 2022 at 9:56 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> >> On Mon, Nov 07 2022, Teng Long wrote:
> >> > When appending to a given object which has note and if the appended
> >> > note is not empty too, we will insert a blank line at first. The
> >> > blank line serves as a split line, but sometimes we just want to
> >> > omit it then append on the heels of the target note. So, we add
> >> > a new "OPT_BOOL()" option to determain whether a new blank line
> >> > is insert at first.
> >> >
> >> > Signed-off-by: Teng Long <dyroneteng@gmail.com>
> >> > ---
> >> > diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> >> > @@ -159,6 +161,11 @@ OPTIONS
> >> > +--blank-line::
> >> > +--no-blank-line::
> >> > +     Controls if a blank line to split paragraphs is inserted
> >> > +     when appending (the default is true).
> >>
> >> Just make this:
> >>
> >>         --no-blank-line:
> >>                 Suppress the insertion of a blank line before the
> >>                 inserted notes.
> >>
> >> Or something, i.e. when adding a "true by default" let's add a "no-..." variant directly.
> >
> > This is the exact opposite of Junio's advice[1], isn't it?
> >
> > [1]: https://lore.kernel.org/git/xmqqsfjsi7eq.fsf@gitster.g/
>
> I read that as him mainly talking about what we name the variable (which
> I agree with, but didn't comment on here). I'm talking about what
> interface is exposed to the user.

Having --blank-line as an option is convenient for scripting, so I'd err
on the side of the original interpretation of Junio's suggestion.

We can clearly support '--[no-]blank-line' and allow latter arguments to
override previous ones. The documentation is fine as-is.

Thanks,
Taylor
