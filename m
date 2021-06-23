Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC5BC2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 01:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266F26128C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 01:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhFWBON (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 21:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhFWBOM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 21:14:12 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24558C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 18:11:55 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso331824otp.8
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 18:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Beq+qM8Xq+Ax4RLyeGyfgmJ8h2J3iWJ/Ldekq7nq+sI=;
        b=PNCP3UKz3SlZZIFPAUaTmfjIlteY6OLFG1lnw5PrPs0hSNXvUt0vU/8ShFupn8z8Wo
         FVLwZgtTNgoHvsMwSSoX7Dr6CPjnuHrn2GyiBQb2MipuJmP781JWz1v4Txx8+iqL2z+W
         58JLlWfbSDVvvhNIzNBHuA0yKLPANvK5+xXvn1H0UKKPLIXwwyv4gSILI9+DyCJGwiY4
         sV0nUI8pW8gADum1bsOdEbh9JuZ3ONB6VOP+lQhO091kjCBOgqNdtOFwiqv16pBQax5J
         WIR2abWJG6ejmP7JSrI309lfDoQYn9uK8kwbKPDv8YNfUWsS7DRy0w6H8QHTH0y8OCc2
         PhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Beq+qM8Xq+Ax4RLyeGyfgmJ8h2J3iWJ/Ldekq7nq+sI=;
        b=KoUGT3+AqB0uHN1OAmkBTQFSWdO1B3vKU7ulJZNj2C5/6xYA1MxSR0iNcXs1J6D4eW
         JQPHucK5vRQ1txmp3eEcY6JT0NrUj/A8uSyk5NV7byl3U9oS6mVOfL9D7Trfs5AHDcZV
         lXPeyXXIO8heKTtlLH3esO3ZN3JHENAk8SAxVV1OsQbGonWiD8e+oeEosBj42t3euZp+
         mVWel7sfKFnuusRjcq8Ro/4gzfrc1rrfJLGikEjQqyKOi9tOFqS5W+xRGJIjPYd5K0wS
         ZJ/MkF50yKaQ940NAXNNAsDaQfpoLaOI6Qhk7/QBCeVb75EXipSRwJuWDVESHWxv1vvF
         444Q==
X-Gm-Message-State: AOAM531YOwBaKxjvkcfTRBaOwJvjuLe5TBHUOyZeug4XMrM3+iXcliv5
        WyAY6hjRnb+urdi71OyqdKM=
X-Google-Smtp-Source: ABdhPJxN29P+k6tHniD8phYfmgIIyDSmDUIyqdHRjGV8YRJxlUaO+YK1+XREUFk34NeIF/6+6yjfpQ==
X-Received: by 2002:a9d:d55:: with SMTP id 79mr5655807oti.349.1624410714482;
        Tue, 22 Jun 2021 18:11:54 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id j14sm234210otn.18.2021.06.22.18.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 18:11:54 -0700 (PDT)
Date:   Tue, 22 Jun 2021 20:11:52 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Message-ID: <60d28a58e18f9_312208d9@natae.notmuch>
In-Reply-To: <0fd6f76d-a65c-6706-802e-c04d5091e83e@gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
 <0fd6f76d-a65c-6706-802e-c04d5091e83e@gmail.com>
Subject: Re: [PATCH 1/2] doc: pull: explain what is a fast-forward
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 22/06/21 00.52, Felipe Contreras wrote:
> > We want users to know what is a fast-forward in order to understand the
> > default warning.
> > 
> > Let's expand the explanation in order to cover both the simple, and the
> > complex cases with as much detail as possible.
> > 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >   Documentation/git-pull.txt | 41 ++++++++++++++++++++++++++++++++------
> >   1 file changed, 35 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> > index 5c3fb67c01..142df1c4a1 100644
> > --- a/Documentation/git-pull.txt
> > +++ b/Documentation/git-pull.txt
> > @@ -41,16 +41,41 @@ Assume the following history exists and the current branch is
> >   ------------
> >   	  A---B---C master on origin
> >   	 /
> > -    D---E---F---G master
> > +    D---E master
> >   	^
> >   	origin/master in your repository
> >   ------------
> >   
> >   Then "`git pull`" will fetch and replay the changes from the remote
> >   `master` branch since it diverged from the local `master` (i.e., `E`)
> > -until its current commit (`C`) on top of `master` and record the
> > -result in a new commit along with the names of the two parent commits
> > -and a log message from the user describing the changes.
> > +until its current commit (`C`) on top of `master`.
> > +
> > +After the remote changes have been synchronized, the local `master` will
> > +be fast-forwarded to the same commit as the remote one, therefore
> > +creating a linear history.
> > +
> > +------------
> > +    D---E---A---B---C master, origin/master
> > +------------
> > +
> 
> Isn't fast-forward merge simply moving HEAD to point at newly incoming 
> commit from origin (in this case commit C) without creating merge commit?

Yes, but that's not always possible. The changed documentation is trying
to shine a light into when it is possible, when it isn't, and why.

-- 
Felipe Contreras
