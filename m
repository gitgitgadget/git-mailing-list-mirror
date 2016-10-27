Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783A820193
	for <e@80x24.org>; Thu, 27 Oct 2016 16:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755627AbcJ0QXJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 12:23:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57580 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755540AbcJ0QXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 12:23:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1729149053;
        Thu, 27 Oct 2016 12:23:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fH/3ai8VRFRdgaM4d1BMtxtNMy8=; b=jV/VYn
        vJwxQHucOiz8UlVNTGHwW8/lwsIjUlsJCkbwsc4UaKjD36S4owy4kAnm0bFtbhTO
        R7cWlb3KmC4tYc+LZN2y/HM3wSoSJ8v7T4yB+Q75mZXhJdm18UvAzjnDte78cQg/
        IiWYQ+cq1izNgLwBUPRs5iF0ofmZYheajuGMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uHydn5nKQM1XlGdFfMLwE/kLQ4YkblF8
        /QvjNwpUAsDzs4y/0d2zGNgqVEd+2GVWCqlrDLxm1+76/1tncfUL4RYTv/+EpYl8
        WosECat8cVD+63m2HNYQCPfHTxEVQtFsLyWG0uBL9JaobgCu5YqlHN8tIEW6camC
        TKpUDi51Dwg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EB5249052;
        Thu, 27 Oct 2016 12:23:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 78B7149051;
        Thu, 27 Oct 2016 12:23:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset: --unmerge
References: <xmqqa8dttkbw.fsf@gitster.mtv.corp.google.com>
        <CACsJy8B-GcMNv7pYYLpaUXc2kKnvyYEYm6w=fiaHy7rt4aug1Q@mail.gmail.com>
        <CACsJy8D4cT2EV_t6=+XTHxLmjV+NtAE+KgiN3ZiP7JQzvu29oQ@mail.gmail.com>
        <xmqqmvhsc8kn.fsf@gitster.mtv.corp.google.com>
        <87d1il3hhs.fsf@linux-m68k.org>
Date:   Thu, 27 Oct 2016 09:23:04 -0700
In-Reply-To: <87d1il3hhs.fsf@linux-m68k.org> (Andreas Schwab's message of
        "Thu, 27 Oct 2016 18:05:03 +0200")
Message-ID: <xmqqzilp7od3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A463AA30-9C61-11E6-8F12-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Okt 25 2016, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Somebody with a bright idea decided that vc-git-resolve-conflicts
>> variable should be on by default in Emacs 25.1 X-<
>
> This is consistent with the behaviour of the other VC backends, where it
> isn't even customizable.

The problem I had was "M-x save-buffer" (after resolving the
conflicts in it manually) running "git add" on the resulting file,
robbing from "git diff" an opportunity to help the user to see how
the result looks relative to both branches.

Do you mean that VC mode broke the same feature equally other SCMs,
too?  Do other SCM supported by VC backends take advantage of
unmerged stages in the index (until you say "$scm add") by allowing
you to verify the combined diff with "$scm diff"?



