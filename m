Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34E7820365
	for <e@80x24.org>; Thu, 13 Jul 2017 20:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbdGMUew (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:34:52 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36607 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752889AbdGMUeu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:34:50 -0400
Received: by mail-pg0-f53.google.com with SMTP id u62so34858650pgb.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 13:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aW9+d8DYdNgW2XwEIqZVUSiA7II4etZVgCARk4Fqg5M=;
        b=AGeGLaAaB6FW76P4mdy+MBlgG+/bSs+9G30CXiE+s0jZisjlpIxtI75vmtp4HX9h4C
         6jjfivN86JCr8B35MKDCMy6jaPKi1gKznr3XqshzqtfE/m4hbD5FeIQ0VAAT/7gOiUld
         B6h6f8BBuSrk6Iz4HhcJw0Ay8pZ4aFt0wwW2aL16PC446WqsI+zPUP+3To1HgdbF3Mnn
         +JhlqDuPllWYTnVq/O/8CtohgLViIAV0vM1J1Q9EXDn+qYluYJkiV8x2+C7Ns4OQFK3t
         LtxbD1c8eWTfAg0aEGmgFoLp64VTrFOBzWVIrc/fdaf5F5M2+1xDE9Rryqcj4vLbufIG
         IYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aW9+d8DYdNgW2XwEIqZVUSiA7II4etZVgCARk4Fqg5M=;
        b=AQdThgMLVq8Hhva0nSoHoaQpO1T43ZyuYhpOXAu6dKDMppsWRZCkxnS5DanrUQ6teq
         b65gL0vaUuxAVQRWvwQIfyCKRMKGjYc0oFYXyo7hjPDGuqoshXhlevwW52fVg2pNG8m7
         MUhAJRCSLhr3rtXlMViZxawtfmTuY3+DqrL1BuqNSFtzgCxxWJvWTz1tg6XrPaQjSS0K
         pNyczE7jbuwVWPUNaC+rqrIRFoD2NN+kXJlNilloqHIXTEnIaJUF+hRaMhemSPeLLm+9
         kG0p/Rp3pNEbkawEx2cPjGDYV3g7aLbpUYdzMdg0tBYT139Wflj49lv3TYiXe5upY8gp
         Nllg==
X-Gm-Message-State: AIVw1128nYlR35BSKUTLHvOqpOxVyZIi3ZqcRx6gNMfHQkIDAXcgeX4o
        8UkmcN3vfuPE9g==
X-Received: by 10.98.89.129 with SMTP id k1mr1481107pfj.28.1499978090004;
        Thu, 13 Jul 2017 13:34:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id 83sm12722892pfa.113.2017.07.13.13.34.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 13:34:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 05/15] ref-filter: abstract ref format into its own struct
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
        <20170713150118.eof3xgu4zujmo6u6@sigill.intra.peff.net>
        <CAGZ79kag1B37FBrmDzbRFNVODHp=n1h=xSq_pi1b7Fs4wLoRBg@mail.gmail.com>
Date:   Thu, 13 Jul 2017 13:34:47 -0700
In-Reply-To: <CAGZ79kag1B37FBrmDzbRFNVODHp=n1h=xSq_pi1b7Fs4wLoRBg@mail.gmail.com>
        (Stefan Beller's message of "Thu, 13 Jul 2017 11:51:44 -0700")
Message-ID: <xmqqlgnsulco.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Jul 13, 2017 at 8:01 AM, Jeff King <peff@peff.net> wrote:
>
>>  builtin/branch.c       | 14 +++++++-------
>>  builtin/for-each-ref.c | 22 ++++++++++++----------
>>  builtin/tag.c          | 30 ++++++++++++++++--------------
>>  builtin/verify-tag.c   | 12 ++++++------
>>  ref-filter.c           | 22 ++++++++++++----------
>>  ref-filter.h           | 22 +++++++++++++++++-----
>>  6 files changed, 70 insertions(+), 52 deletions(-)
>
> The patch looks good to me. So some off-topic comments:
> I reviewed this patch from bottom up, i.e. I started looking at
> ref-filter.h, then  ref-filter.c and then the rest. If only you had formatted
> the patches with an orderfile. ;)

As a reviewer, for this particular patchq, I actually appreciated
that ref-filter.[ch] came at the end.  That forced me to think.

When I see something that used to be 0 is lost from the parameter
list of show_ref_array_item() at a callsite, I was forced to guess
what it is by looking at what is moved into the new structure
nearby, and keep doing that "figure out what is going on" game until
the "author's answer" is revealed at the end of the patch.  

By the time I reached ref-filter.[ch], I had a pretty good idea what
was done by only looking at the callers and being able to see if my
understanding matched the "author's answer" at the end of the patch
turned out to be a very good way to double-check if the patch was
sane.  If I were given the author's answer upfront, especially an
answer by somebody as competent as Peff, I'm sure I would have been
swayed into believing that whatever is written in the patch must be
correct without thinking the changes needed in the patch myself.

I do want to present from Doc to header to code when I am showing my
patch to others, so this is probably a good example that illustrates
that the preferred presentation order is not just personal
preference, but is different on occasion even for the same person.
