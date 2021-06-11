Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9235FC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 14:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714E860E09
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 14:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhFKOmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 10:42:51 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:44853 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhFKOmv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 10:42:51 -0400
Received: by mail-oi1-f182.google.com with SMTP id a26so6007023oie.11
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8dZ/QXBMs29hOSocY8iiEApBce/fgdk8heBRrvEofpU=;
        b=i1HCrp8nLUjUo0VTMWsqGki88OI9KUytjXnHwTUPpfC5UG/rC0VIZTU2R8pD9B/8pP
         FRvpZem2ODEhDq+4DGs7l93AvjwG+nmkH+uEIoT6uaRK0JC3vp5yUMosSPj9wzJIR91q
         rvRfyw5ECVmWAVOgvYSVCgYRp3W2Wef4kxh+U75V0btmCtDIPG4mpN0Kvx4Qnl4DIddO
         Tl5eEs5ddF//hBQuh8nHfO0r/sjYbkPFR0g4On8Atx6CLenKyagFedjPz+Rx9Nivv0Jj
         nnTUSpayOkPCo6xtyJE2jDYswq0f1iGUTPQ1yMPjuNCwn338R2SnXf22Pmhp9XZJhja9
         FSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8dZ/QXBMs29hOSocY8iiEApBce/fgdk8heBRrvEofpU=;
        b=uFRUNDGHA+oj9PLwxgRvNX5bEBsJSpOg7Qb0xGKOMKxlebqNwxAANJLTvjGX953YEO
         fftKrXlj3jQ21xsDFYx703RuPLbr4SXrng4tOMoJRb+w0twNkvDvO1vgktIQKNcaoRK0
         wYoDFUUP7cUUDzV0n36kA5Qra7CraKhTacgekBEw4Vd6USlUQ7m0l2KW1ARt1sXcFVGb
         QBjh2aR99VGtaUPgxgdv7hmYEJcs5hEyu/E07bpUSEn1Bd2tp7nBefj0sZYyQgNPY+3s
         e2yOOBmyMff/q4eZkWQlhfgGAuCs/yjgzqSbA7GmNcNy8NzJ7J81o7Rdq3B0IxOvUNVW
         oJxw==
X-Gm-Message-State: AOAM532uslFq6TM3T7mpaHMvuRAcnT0shmzsGhseZhI4WhIi+1cytSqi
        gf9BIcvsUw8+rOWsR3D74kM=
X-Google-Smtp-Source: ABdhPJy+sPNzLC5vEWf06uxT8tnxxUG/b3xj//UeNgdPiPjHNRKjSJnuL3/4w2IUQZk1OjMkGSez9g==
X-Received: by 2002:aca:4703:: with SMTP id u3mr2711878oia.37.1623422393273;
        Fri, 11 Jun 2021 07:39:53 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x187sm1217273oia.17.2021.06.11.07.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:39:52 -0700 (PDT)
Date:   Fri, 11 Jun 2021 09:39:51 -0500
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
Message-ID: <60c375b7a8b90_3ad92084@natae.notmuch>
In-Reply-To: <0975b12c-82e1-344c-e09f-37f568c10514@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-2-felipe.contreras@gmail.com>
 <b2436790-bbf0-2623-5e29-a6f6b4959974@gmail.com>
 <60c2130178831_b25b1208f5@natae.notmuch>
 <bef8e373-20d8-3545-ba43-00108b2e77df@gmail.com>
 <60c2420a2dd73_b25b1208f1@natae.notmuch>
 <0975b12c-82e1-344c-e09f-37f568c10514@gmail.com>
Subject: Re: [PATCH 1/7] test: add merge style config test
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 10/06/2021 17:47, Felipe Contreras wrote:
> > Phillip Wood wrote:
> >> On 10/06/2021 14:26, Felipe Contreras wrote:
> >>> Phillip Wood wrote:
> >>>> On 09/06/2021 20:28, Felipe Contreras wrote:
> >>>>> We want to test different combinations of merge.conflictstyle, and a new
> >>>>> file is the best place to do that.
> >>>> [...]
> >>>>> diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
> >>>>> new file mode 100755
> >>>
> >>>>> +test_expect_success 'merge' '
> >>>>> +	test_create_repo merge &&
> >>>>> +	(
> >>>>> +		cd merge &&
> >>>>> +
> >>>>> +		fill 1 2 3 >content &&
> >>>>> +		git add content &&
> >>>>> +		git commit -m base &&
> >>>>> +
> >>>>> +		git checkout -b r &&
> >>>>> +		echo six >>content &&
> >>>>> +		git commit -a -m right &&
> >>>>> +
> >>>>> +		git checkout master &&
> >>>>> +		echo 7 >>content &&
> >>>>> +		git commit -a -m left &&
> >>>>> +
> >>>>> +		test_must_fail git merge r &&
> >>>>> +		! grep -E "\|+" content &&
> >>>>
> >>>> ! grep "|"  would be simpler and just as effective.
> >>>
> >>> But that would fail if there's a "command1 | command2".
> >>
> >> I don't understand. What are you expecting content to contain?
> > 
> > Not a sequence of |.
> > 
> >> Why doesn't "\|+" fail in that case?
> > 
> > It would, perhaps "\|\|+" would be better, or maybe "\|{2,}".
> 
> The point of my original comment was that you do not need an ERE - 'grep 
> "||"' matches the same set of lines as 'grep -E "\|\|+"'. As it is 
> testing for conflict markers anchoring the pattern to the beginning of a 
> line would probably be a good idea.

Right, I didn't add that because I saw some tests not doing ^ when they
clearly should, so I thought perhaps there was a compatibility issue,
but now I see that ^ is already used in many tests, therefore "^\|\|+"
makes sense.

-- 
Felipe Contreras
