Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5642C1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 20:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbeGLUnD (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 16:43:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35735 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732431AbeGLUnD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 16:43:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id a9-v6so510404wmb.0
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pshHJeWpSrOv0rXA1x3z7QMk8GHJER4H1UoBoSUb0s0=;
        b=R0VcAZ6IkBKBEwZL6Qy5DnpFKccuOh2AVmt2Cvt6xEGY9WlVBEcrNVop0ZZW85ItEA
         Icg8fr60r5q5KaUP/m8+O3O4ue9NNXrlFAwZzSC0KIhfMEogg1NoYE0jiGbxxwYI1s/4
         jVxquMQmsrcWUGC04DX2im0bP/C+VjlMqSfb61BAVp0KP6XMykdHCDcpPWd0XpPoF9FX
         TVQctB9sIFaNCUtufTjFiNF9slva6XnzbgXuqkQS6if9TG3RVCsI+fzvTdpznfr+fb5i
         84TsDMUcRjkgNv6k9tj70d3L5fAmvdM2+/DaukJJiiW5mdsqH8xFbLLoJHgnvp2xo3ls
         8GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pshHJeWpSrOv0rXA1x3z7QMk8GHJER4H1UoBoSUb0s0=;
        b=YD8Aphaa1nUkkSJs031abTUAagjktM0rNjCaDl3PrLLp16vV6J6Ghe0CUWQN5GS8e0
         38+vOaQ/j7VHj3DDX8i/CEDSwr8pn5aid8tSpvKBZZwQsrIL+NdDdbnCBKS/heG31+0z
         GdPHY56KEaBmPBpDPoBP31uhMJrVDpRH8OrlmHsC1tNW03sfwHpH76ciyq4vuPFPHaB0
         2rFrr1VIc6fAymI7Hjt/jFQB/atCkldNWpQLoFg4m3G/Mi2SC55xVd1AvvVbQKb7vk7P
         NGHxfXQVygJdqzWticrFv6DoMnGPNphW9Lkc6Pf/kQ47Cjgr+/ZRYBOS7s0PtTCShg1l
         a6zA==
X-Gm-Message-State: AOUpUlHqAn0FiH+SuhVGP4iVhXf+eTFNMklezCmfeXdo+f2mqhImljZS
        D9FIrBOp/bpGGKTMiGeGGJw35H/Q
X-Google-Smtp-Source: AAOMgpd9cPiDVzHeLXcGqxuUM3EWpUJOyvvzA0Eb6dKfS4n2K/q9PILS4Ub/3lEQNyT+ZZzKhDNXxQ==
X-Received: by 2002:a1c:5e48:: with SMTP id s69-v6mr2122529wmb.19.1531427510592;
        Thu, 12 Jul 2018 13:31:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a2-v6sm4465839wmb.6.2018.07.12.13.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 13:31:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t3404: fix use of "VAR=VAL cmd" with a shell function
References: <xmqqefg8w73c.fsf@gitster-ct.c.googlers.com>
        <20180712201454.GA6281@sigill.intra.peff.net>
        <xmqq4lh4w6e8.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 12 Jul 2018 13:31:49 -0700
In-Reply-To: <xmqq4lh4w6e8.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 12 Jul 2018 13:22:55 -0700")
Message-ID: <xmqqzhywurey.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>>> index 7e9f375a24..fd43443ff5 100755
>>> --- a/t/t3404-rebase-interactive.sh
>>> +++ b/t/t3404-rebase-interactive.sh
>>> @@ -280,8 +280,11 @@ test_expect_success 'retain authorship w/ conflicts' '
>>>  	git reset --hard twerp &&
>>>  	test_commit a conflict a conflict-a &&
>>>  	git reset --hard twerp &&
>>> -	GIT_AUTHOR_NAME=AttributeMe \
>>> +	oGIT_AUTHOR_NAME=$GIT_AUTHOR_NAME &&
>>> +	GIT_AUTHOR_NAME=AttributeMe &&
>>> +	export GIT_AUTHOR_NAME &&
>>>  	test_commit b conflict b conflict-b &&
>>> +	GIT_AUTHOR_NAME=$oGIT_AUTHOR_NAME &&
>>
>> ...would you want to use test_when_finished here (both for robustness,
>> but also to make it more clear to a reader what's going on)?
>
> Perhaps.

Yes, but this one ends up to be overly ugly.

The restoreing of the AUTHOR_NAME must be done not just before this
test_expect_success finishes and control goes on to the next test,
but also before "git rebase -i" in the middle of this test that is
expected to fail with conflict, as we want it to see the original
author name (not the modified AttributeMe name).

 t/t3404-rebase-interactive.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 481a350090..489b6196e0 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -256,11 +256,18 @@ test_expect_success 'retain authorship' '
 '
 
 test_expect_success 'retain authorship w/ conflicts' '
+	oGIT_AUTHOR_NAME=$GIT_AUTHOR_NAME &&
+	test_when_finished "GIT_AUTHOR_NAME=\$oGIT_AUTHOR_NAME" &&
+
 	git reset --hard twerp &&
 	test_commit a conflict a conflict-a &&
 	git reset --hard twerp &&
-	GIT_AUTHOR_NAME=AttributeMe \
+
+	GIT_AUTHOR_NAME=AttributeMe &&
+	export GIT_AUTHOR_NAME &&
 	test_commit b conflict b conflict-b &&
+	GIT_AUTHOR_NAME=$oGIT_AUTHOR_NAME &&
+
 	set_fake_editor &&
 	test_must_fail git rebase -i conflict-a &&
 	echo resolved >conflict &&
