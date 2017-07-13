Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3A82027C
	for <e@80x24.org>; Thu, 13 Jul 2017 21:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbdGMVcb (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 17:32:31 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33957 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdGMVca (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 17:32:30 -0400
Received: by mail-pf0-f173.google.com with SMTP id q85so35338632pfq.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=G3xVwan74AY5baVGudjRQ8pF+Etp6vit0irAGXjG7fM=;
        b=G2xbvw4emeLaSX45g+NnQG8KFHiLbOc0c13GcyyU8inLmS7nOOOvPkB0rSoeDf0AdS
         wYtq2Y9F2PyvQ25+Hg8B0yOqmSurJ4TIB9XrbMA1SoJOBbUHuHBco9J13i7WKkt7oHGm
         yqtV8aJl5qigma2e4DqCetqT63foidw5obAEwO6MWpjnhT3VuR0/JJW+ECuFSxkS2K+k
         4p+7J04Cpcj2Uitz9byhqLSzNGhrXN1VnYFWXOFmvB/9fbS0aWnm6L50QovtbxvqEBT4
         W+0mOkfqpSpyszgyPXB8ZM+g1TCkMN5UCGIp0fEW/DNni+6DYAlYbikbEP/h3phI2ZoQ
         vwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=G3xVwan74AY5baVGudjRQ8pF+Etp6vit0irAGXjG7fM=;
        b=WJk2EKknlcceiXTek403nx+1sC0pq2M7iaqP0TAKA/MkEMEcSgG/GZwxolJY5hiGUc
         ZV7aIZDWdjAgsmtbTdlLpHYldg7VmEKSlUYIFV1QmrCJUkOsfvOXgMNliebnAnjg7LLT
         K2tVbSoor/De7IkBoOo+4eqWMCjE8Ifrq3zuVl0h79Qeq5pWfB3zBe+k/3WUv2Wq542A
         gc8k00cd12qLXd2ZehX6Bvs2uVIbcFiGcJEXvSZKmvR/UVEiH7CiZSB6xWyAmgHPjBaQ
         boM4OEPGtG8BI8c1JN8PRmKBFG1BrumfDYrVupOMTKOfFFToARZ6iaaC6OriLgFIL7xB
         CP9Q==
X-Gm-Message-State: AIVw111K73tsUnmtboaoA4tEAb6hKFYTzbz/47c/JQoxHvagmOyz8mi7
        UKq0ijMROmWJdA==
X-Received: by 10.99.44.68 with SMTP id s65mr11527679pgs.101.1499981549364;
        Thu, 13 Jul 2017 14:32:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id w125sm13677928pfb.117.2017.07.13.14.32.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 14:32:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 05/15] ref-filter: abstract ref format into its own struct
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
        <20170713150118.eof3xgu4zujmo6u6@sigill.intra.peff.net>
        <CAGZ79kag1B37FBrmDzbRFNVODHp=n1h=xSq_pi1b7Fs4wLoRBg@mail.gmail.com>
        <xmqqlgnsulco.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 13 Jul 2017 14:32:27 -0700
In-Reply-To: <xmqqlgnsulco.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 13 Jul 2017 13:34:47 -0700")
Message-ID: <xmqqmv88t444.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, Jul 13, 2017 at 8:01 AM, Jeff King <peff@peff.net> wrote:
>>
>>>  builtin/branch.c       | 14 +++++++-------
>>>  builtin/for-each-ref.c | 22 ++++++++++++----------
>>>  builtin/tag.c          | 30 ++++++++++++++++--------------
>>>  builtin/verify-tag.c   | 12 ++++++------
>>>  ref-filter.c           | 22 ++++++++++++----------
>>>  ref-filter.h           | 22 +++++++++++++++++-----
>>>  6 files changed, 70 insertions(+), 52 deletions(-)
>>
>> The patch looks good to me. So some off-topic comments:
>> I reviewed this patch from bottom up, i.e. I started looking at
>> ref-filter.h, then  ref-filter.c and then the rest. If only you had formatted
>> the patches with an orderfile. ;)
>
> As a reviewer, for this particular patchq, I actually appreciated
> that ref-filter.[ch] came at the end.  That forced me to think.
> ...
> I do want to present from Doc to header to code when I am showing my
> patch to others, so this is probably a good example that illustrates
> that the preferred presentation order is not just personal
> preference, but is different on occasion even for the same person.

So when somebody wants to do a "from design and explanation to
provider to consumer", we would probably want "doc, *.h, *.c at the
top-level and then things inside builtin/ subdirectory" order.  Of
course, on the other hand, "I do not trust me not getting swayed by
the fact that a developer more competent than me wrote the patch"
reviewer would want to use the reverse order.

Can we actually express "top-level first and then builtin/*" order
with the diff.orderfile mechanism?  It's been a while since I last
looked at the orderfile matching (which was when I originally wrote
it) and I do not offhand know if we now allow wildmatch patterns and
the directory level anchoring "/*.c" like we do in .gitignore files,
without which it would be cumbersome to make ref-filter.c listed
before builtin/branch.c in a generic way.
