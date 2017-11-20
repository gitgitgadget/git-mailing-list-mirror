Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2432C202A0
	for <e@80x24.org>; Mon, 20 Nov 2017 00:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbdKTAjE (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 19:39:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56467 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750952AbdKTAjD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 19:39:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D2FAB5003;
        Sun, 19 Nov 2017 19:39:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZpRsFcm3pRJ33DOkc+G/kPZNx4k=; b=dHvfUP
        XjE0bB5BMkuIQ6M6x407tGSxa+xGWQmBa4F6nDtiz9JGknngfDom49T+ZTulh3y7
        lROmDwwHjqGb0iyvPabk/kqNvRO3pNeYBsBx85n7YXgQ7VREjMq3PKbG3DapZlKB
        DXx+twjIRn4glwkmfYxa0jAH2w7nBDYSrIOHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IlK7nWM/U/2JAPKQiWuOPiWvNqpu+agn
        BV2QNUSkykwEOLiqWEvq74W4yZqUF0Ri2dK6oAamHEAX8eW2lrVIENnuhlUlg+Bq
        S5UV2G1Fm4fkWEHcDJteqjI363MuTvs91rRNFCGeOkoeFhCwFINuRSY1auUOAQLx
        04wrLxK7wWQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64C38B5002;
        Sun, 19 Nov 2017 19:39:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC159B5001;
        Sun, 19 Nov 2017 19:39:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 3/3] worktree: make add <path> dwim
References: <20171118181103.28354-1-t.gummerer@gmail.com>
        <20171118224706.13810-1-t.gummerer@gmail.com>
        <20171118224706.13810-4-t.gummerer@gmail.com>
        <CAPig+cQqbvuZg0Y8ZMObZc7mYXzohooVBFj0-o+CGGXrgGLp5w@mail.gmail.com>
        <CAPig+cTmqHt5s+C1vTFA7S4ZBwjqnzkn-2wA6i3jVeLw7i1_Lg@mail.gmail.com>
Date:   Mon, 20 Nov 2017 09:39:01 +0900
In-Reply-To: <CAPig+cTmqHt5s+C1vTFA7S4ZBwjqnzkn-2wA6i3jVeLw7i1_Lg@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 19 Nov 2017 15:20:00 -0500")
Message-ID: <xmqqefotokbe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34DD28F6-CD8B-11E7-BB7D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Nov 19, 2017 at 2:04 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Nov 18, 2017 at 5:47 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>> +To disable the behaviour of trying to match the basename of <path> to
>>> +a remote, and always create a new branch from HEAD, the `--no-track`
>>
>> Does --[no-]track deserve to be documented in the OPTIONS section like
>> the other options are?
>
> One other question: Since this is re-using the well-known option name
> --no-track, should it also get applied to the "git worktree add -b foo
> dir origin/foo" case, as well, which you pointed out (in the patch 2/3
> thread) already DWIMs tracking automatically? (I can easily see
> someone reporting it as a bug if "git worktree add --no-track -b foo
> dir origin/foo" does not suppress tracking.)

Sensible suggestion.  Thanks.
