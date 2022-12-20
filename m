Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B81C001B2
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiLTAHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiLTAGb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:06:31 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83C210040
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:06:12 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id m4so10631229pls.4
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lsDJuIFxTUpOOkx8KdTBg+Fjr65tPTyb4bkgiYjkOU=;
        b=XvUVHOGZOfS+TCCq/HjKqyMf87U5Vi3QnaBNK57R4p98z9ltB+zFKrs0mXSsOHs3r+
         L7UXXyYd62dLpaCAcDJ2vrTtT/6f3vDsj6Ccry/6W4RPoNLgMn0g77/vPDd9SDoakQxf
         4Z//F8wTO/p3OpFcEIjQJXlMDAjR8p7XEGy1RpnSsWPbK+CSW9eZnl4TYroZmNLcDc2P
         cvHVCkcZJQ8OcuePki8vaALuvm/4j+1t9JBjxKMs5p0ukTc+tn7XUDBWnX6Y9SMgYsnY
         07UAC9e1K8t91rFPLYTDJvvG10/USTzqb5mn4uTjF/yHqzhUfMAGtslw8F8LxGOsAacv
         DSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lsDJuIFxTUpOOkx8KdTBg+Fjr65tPTyb4bkgiYjkOU=;
        b=x+A10i/aeuGdU5so5SjTjyGyY9yLriTcctDKdeZehgVCWzCQOLkg68Q/BsjPyMNLcO
         H9dCzMuQJN5QXlFl9XUMwZJ3A06I0nZ/psyw5pR6T/bbvWJSuSK0GTcS8w8I4eWfSAOp
         7ei+1dqr8Bgj0KzphWZ8IjgIsQH6CnTaPwRmrcDDh6cboYymokQVhP7K6gqhr8Nyta8E
         e7WuBY5y81jyUT0+8M1J7Iv1+HjDlUWObPJ/HOUc5p9iFdgsGftcVPuRr6Sx36ekbidX
         0iSbMHLscP0adncyiRnBMPjLHYQ3hoPI9oNjP3BrT3FCSdI0fJR/A6a13tOsEwVG5BJF
         4MDA==
X-Gm-Message-State: AFqh2kqhTh2e6CxX7J6Akbb4OMSuZrPYP/U+1Wbx1U588VK+Za7dwkt0
        W+r7NNnu79Wu5gj5OEfrq29Y9geVmPzg6Q==
X-Google-Smtp-Source: AMrXdXs1P/DdfVtmDZfmrHmbpQgdgTIaSXCGtES+Llhw9iMVZBoGEPvs2eSd7kAjIawRLnIwasju9w==
X-Received: by 2002:a17:90a:de98:b0:223:415c:6876 with SMTP id n24-20020a17090ade9800b00223415c6876mr20284304pjv.30.1671494772099;
        Mon, 19 Dec 2022 16:06:12 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id mi14-20020a17090b4b4e00b0020d67a726easm9902614pjb.10.2022.12.19.16.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:06:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 0/6] tests: fix ignored & hidden exit codes
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
        <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
Date:   Tue, 20 Dec 2022 09:06:11 +0900
In-Reply-To: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 19 Dec
 2022 11:19:23
        +0100")
Message-ID: <xmqq8rj32b2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> I think this should address all of the feedback on the v3, except
> Junio's suggestion of perhaps re-arranging this series around file
> boundaries.
>
> Given the potential size of that range-diff I thought it was better to
> mosttly keep the same structure.

Sorry, I do not recall making such a suggestion but if I did, it
probably was an indication that the group of patches I suggested
such a change were unreviewable as-is, and by definition range-diff
is irrelevant if that is the case (i.e. the part that was
unreviewable would be freshly reviewed with reorganization).

In any case, I think we have been seeing patches to unhide the exit
status from more individual command invocations, a theme this series
should fit well.  Thanks for working on it.
