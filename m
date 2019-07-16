Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74F821F461
	for <e@80x24.org>; Tue, 16 Jul 2019 17:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfGPRVY (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 13:21:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59363 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfGPRVY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 13:21:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4119A16DE80;
        Tue, 16 Jul 2019 13:21:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=juag6Ji16pJ6hsPbVpq/Dd65WQo=; b=BNAvQl
        UVMXIBMa6uahP8IisnEyY1Giwr2QyJTC3WLst1nXl5pGVPGD1zd6uJm+O66msV8v
        CWP8VffFPx9eSSqNfEfFnBpReLjHfNe/2RzzvUmMQBxScTVn2HjeAlcFCor1d+aj
        ilc3TWeZ//r+bHYPiKsBKobfu6LuOghlkawco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kiDZAGW88ixoCQoStiZvbR/g7NvA1fYj
        s0Z5ucZVlCO/4Zjq0eRHFZZSkWheeIWhNNSg/6rItyYUTAX6lXUHSJ0JWBzKUJGo
        wQsEopBKe4Ve8DHi6C/bRYaIsWrf5uQi4VyWtWOfHfqOCQNB8/JM+7E4UEFHiVCD
        9Opt60xPVpg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35A2E16DE7F;
        Tue, 16 Jul 2019 13:21:22 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9569F16DE7E;
        Tue, 16 Jul 2019 13:21:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [RFC/PATCH] CodingGuidelines: spell out post-C89 rules
References: <20190702005340.66615-1-emilyshaffer@google.com>
        <20190709211043.48597-1-emilyshaffer@google.com>
        <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
        <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 16 Jul 2019 10:21:20 -0700
In-Reply-To: <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 16 Jul 2019 09:53:59 -0700")
Message-ID: <xmqq4l3l520f.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 216C0BA4-A7EE-11E9-9520-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though we have been sticking to C89, there are a few handy
features we borrow from more recent C language in our codebase after
trying them in weather balloons and saw that nobody screamed.

Spell them out.

While at it, extend the existing variable declaration rule a bit to
read better with the newly spelled out rule for the for loop.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1169ff6c8e..53903b14c8 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -195,10 +195,24 @@ For C programs:
    by e.g. "echo DEVELOPER=1 >>config.mak".
 
  - We try to support a wide range of C compilers to compile Git with,
-   including old ones. That means that you should not use C99
-   initializers, even if a lot of compilers grok it.
+   including old ones. That means that you should not use certain C99
+   features, even if your compiler groks it.  There are a few
+   exceptions:
 
- - Variables have to be declared at the beginning of the block.
+   . since early 2012 with e1327023ea, we have been using an enum
+     definition whose last element is followed by a comma.
+
+   . since mid 2017 with cbc0f81d and 512f41cf, we have been using
+     designated initializers for struct and array.
+
+   These used to be forbidden, but we have not heard breakage report,
+   so they are assumed to be safe.
+
+ - Variables have to be declared at the beginning of the block, before
+   the first statement (i.e. -Wdeclaration-after-statement).
+
+ - Declaring a variable in the for loop "for (int i = 0; i < 10; i++)"
+   is still not allowed in this codebase.
 
  - NULL pointers shall be written as NULL, not as 0.
 

