Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D01CC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AB3613FF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFJN20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhFJN2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:28:25 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D1C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 06:26:28 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so27500593oth.8
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Dl+VoNy6h5jKURrNRao1UW2N9kyLaFRpJBQTNbtVP9I=;
        b=PRfIIg3cB+UQcvTnwJs5C3AV3xc0G1TCC+nGUxjiGizG4rDHb3yOwj6x3Oo8qmZ48O
         Ik52iYCuvH0a6sOok8pJIw6vdGEzdRyHVOw1EJ36QFTLLFccKWf5BEpsLzIAE7/awm6x
         MMNzK0i7dWyIRhAU0DUWHwFDBXWS8AqmUKwHstrE+Vol82oW7NV3ksPzCr1K48ua1b8m
         nZrfUX/01WZwIw+EeqsFjSrzEjnd3IKgHvwca5Lcga17QbFEBtZnYJkbIJ/+kVDgqBq9
         m97ozZV5DqHynGbYqQL0DyiMhtSSNyHXulqjsXdThXwWTjJ+Hw9P4mbCSpyC1wdRc8KH
         iviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Dl+VoNy6h5jKURrNRao1UW2N9kyLaFRpJBQTNbtVP9I=;
        b=AVgHbqm+N9HIsR1JS3Xlm03s02Qm3TXPqxv2PrhKu5B1HrnYElOrK/aic/sE1t9qwO
         NB+Q8dXqYATzt/1drrqQ8E9Yo+b984/4BSNcLo8vkKrut4HaSHnkS2Mb3A/y/m8zhIC8
         Xip3PUqFYPqBvjmUOaROcaegv63otlmApRNHnNrzdq7P60t7G8vIgLsAR67sJhG57RaX
         dAF0VmtkKxd/5iSRc/n3Km57gmT7ggT/dLezR/+RIq+Es5tfLptBuJiMMgr71u2FqhaA
         n/hayKj5O7rTxyBkpGsGla/XXjtEUVs+5fWSUVe8I3vszd5joCLWOrGBcNbeCGzO3mLT
         4H8Q==
X-Gm-Message-State: AOAM531jCA2wE3khA+5a9a5tvKYfvgE9s66fkQpUtNgvYd4xc3jOU6Hx
        YQ/oJs+6NlimCrYJW98FxkY=
X-Google-Smtp-Source: ABdhPJwH6rAVrMFOwvbaycQCdTVLGTbiZiSSNWEMy7V/ofCffEC6XmwZLv4zngxxgmTuMJUwIL5mPA==
X-Received: by 2002:a9d:628:: with SMTP id 37mr1964270otn.120.1623331587317;
        Thu, 10 Jun 2021 06:26:27 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 62sm536695oof.11.2021.06.10.06.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 06:26:26 -0700 (PDT)
Date:   Thu, 10 Jun 2021 08:26:25 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60c2130178831_b25b1208f5@natae.notmuch>
In-Reply-To: <b2436790-bbf0-2623-5e29-a6f6b4959974@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-2-felipe.contreras@gmail.com>
 <b2436790-bbf0-2623-5e29-a6f6b4959974@gmail.com>
Subject: Re: [PATCH 1/7] test: add merge style config test
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 09/06/2021 20:28, Felipe Contreras wrote:
> > We want to test different combinations of merge.conflictstyle, and a new
> > file is the best place to do that.
> 
> I'm not sure what this particular tests adds over the existing ones in 
> t6427-diff3-conflict-markers.sh.

That file is for diff3 conflict markers. The tests in this file are not.

> The commit message does not explain why a new file is better than
> adding this test to that file.

Because there's no file that is testing for this.

> There are already diff3 tests for checkout

This file is not doing diff3 tests.


As stated above, it's testing different *combinations* of
merge.conflictstyle, diff3 is only *one* of the possibilities, another
possibility is:

  git -c merge.conflictstyle=diff3 checkout -m --conflict=merge

That is *not* a diff3 test.

> > diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
> > new file mode 100755

> > +test_expect_success 'merge' '
> > +	test_create_repo merge &&
> > +	(
> > +		cd merge &&
> > +
> > +		fill 1 2 3 >content &&
> > +		git add content &&
> > +		git commit -m base &&
> > +
> > +		git checkout -b r &&
> > +		echo six >>content &&
> > +		git commit -a -m right &&
> > +
> > +		git checkout master &&
> > +		echo 7 >>content &&
> > +		git commit -a -m left &&
> > +
> > +		test_must_fail git merge r &&
> > +		! grep -E "\|+" content &&
> 
> ! grep "|"  would be simpler and just as effective.

But that would fail if there's a "command1 | command2".

> This is quite a weak 
> test, something like "^|||||| " would be a stronger test for conflict 
> markers

But that doesn't work in all the tests.

Cheers.

-- 
Felipe Contreras
