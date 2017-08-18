Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52EAF208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 16:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbdHRQu5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 12:50:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65515 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751060AbdHRQu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 12:50:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E67DDAC6F6;
        Fri, 18 Aug 2017 12:50:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RYsyZS6o02TOepoXK7kgAjH+woM=; b=mgJF++
        zKaq18GQsyXH4BrD4WouwAx33DrC47cpPCRC4VY0nKKytLs4if0Ie+tjzB6ivHak
        wQAtFkRsCoYoDYjNBhnGbbd0orPdy+4F7X4REIIhuhlaagoB046/hCY/Clz7ocmj
        iBqX1/dUAeEaOBoij8DymYWg3GKWcwdM1sAKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PIyRxtTnf37jFLGlv2/aJAigyFtTZF+o
        KlvhgfXbXvKzpffS7kzurx+XenFnYcp0dcGrcnsSTiv89ZfzV2YxD91kdTGdTq4q
        wrxVY8x2GfVl/7O+TaUFp19Cn/Wi7aF14+re3rVrUAfTEuy8HIizysLzgUt58kPk
        T6OuGsiWTCg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DECDBAC6F5;
        Fri, 18 Aug 2017 12:50:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F125AC6F3;
        Fri, 18 Aug 2017 12:50:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Submodule regression in 2.14?
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
        <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
        <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com>
        <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
        <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
Date:   Fri, 18 Aug 2017 09:50:47 -0700
In-Reply-To: <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
        (Stefan Beller's message of "Thu, 17 Aug 2017 21:02:15 -0700")
Message-ID: <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62C64634-8435-11E7-B27F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Aug 17, 2017 at 7:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Are you saying this might be a design mistake and
>>> the .update ought to be respected by all the other
>>> commands? For example
>>>     git reset --recurse-submodules
>>> should ignore the .update= none?
>>
>> I have been under the impression that that has been the traditional
>> desire of what .update ought to mean.  I personally do not have a
>> strong opinion---at least not yet.
>
> In this context note v2.14.0-rc1-34-g7463e2ec3
> (bw/submodule-config-cleanup~7, "unpack-trees:
> don't respect submodule.update") that is going opposite of
> your impression.

Exactly.  We are in agreement that recent developments seem to go
against the traditional desire and it is understandable Lars sees
this as a regression.  I still do not have a strong opinion either
way, if this is a regression or a progress.

> Maybe, I'll think about it. However there is no such
> equivalent for trees (and AFAICT never came up) to
> treat a specific directory other than the rest in worktree
> operations.

I am not sure if I follow.  Submodules are not trees and one of the
reasons people may want to separate things into different modules is
so that they can treat them differently.  If submodules allow you
a richer set of operations than a tree that is part of a monolithic
project, is that necessarily a bad thing?
