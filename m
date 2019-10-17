Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E935A1F4C1
	for <e@80x24.org>; Thu, 17 Oct 2019 03:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391873AbfJQDR0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 23:17:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57697 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfJQDR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 23:17:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD41E3F769;
        Wed, 16 Oct 2019 23:17:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SXe0ANOp9tokM0fOyTzKa12yPms=; b=Di6PB5
        NuGZtAfzw0CmtstcNVHNm1a2hSrPyY3SMwH5PeMYTFaqL91xTUTc1pC6LWgQUhb7
        H9iEVDkXB4AGj1Zd2KxuNueRJ3cOFMkTsGD72Q96Bppyhtlh5AOnkGh/ox00hoNK
        S0iYkDgf9IGNzYKzXHwbjVmn9Bx61JtmYiHW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IEzJ4IqgGHK1xXVaTyC2/N5801TShnJo
        uLBuCF/9vvvrMkcfwFxBoAjDeuJF0nzJUX2PJmYc81iUdODMqN1vmAkRQMvuWj2x
        6k/vDOaYT5bbO3cEd9U9XBx1gE8snXuBn5Yfon+BtFR5We3HKeSvrI3aUz6Cy6eW
        cN6r/UFDnWQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3EDC3F768;
        Wed, 16 Oct 2019 23:17:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FE8C3F767;
        Wed, 16 Oct 2019 23:17:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
Date:   Thu, 17 Oct 2019 12:17:21 +0900
In-Reply-To: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com> (Vegard
        Nossum's message of "Wed, 16 Oct 2019 12:22:54 +0200")
Message-ID: <xmqqeezc83i6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2F3D7C4-F08C-11E9-BBD0-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> Step 1:
>
> * git send-email needs to include parent SHA1s and generally all the
>   information needed to perfectly recreate the commit when applied so
>   that all the SHA1s remain the same
>
> * git am (or an alternative command) needs to recreate the commit
>   perfectly when applied, including applying it to the correct parent

You can record and convey the commit object name a series is meant
to be applied on top already, and it in general is a good way to
give a wider context in order to explain and justify the series.

On the other hand, "all the information needed to recreate..." is
not very useful.  If you want the commit object to be exactly what
you want to see at the tip of the end result, you are better off
asking your upstream to pull.  Using e-mail for that makes you and
project participants give up a lot of benefits the workflow based on
e-mail gives you, the biggest of which is the ease of giving
suggestions for improvements.  Once you insist "perfectly recreate
the commit", you are not willing to take any input from the
sidelines---worse yet, you are even dictating when the upstream
runs "git am" to turn them into commits, and do so without reading
the patches (there is no point reviewing as the person who runs "git
am" is not even allowed to fix typo or make obvious fixes to the
code, which will fail to perfectly recreate the commit).

In short, one should resist temptation to bring up "perfect
reproduction" when one talks about e-mail workflow.

> * Instead of describing a patchset in a separate introduction email, we
>   can create a merge commit between the parent of the first commit in
>   the series and the last and put the patchset description in the merge
>   commit [5]. This means the patchset description also gets to be part
>   of git history.

This has been done with tools around git-core, and merits a more
official support.  When merging a topic, it is a good idea to
explain in the merge commit that brings in the topic to the mainline
what the topic is about, and at least in the past few years Linus
and other maintainers both within and outside the kernel have been
doing so.  The cover-letter material in [PATCH 00/NN] obviously can
help those integrators when they write the merge message.

>   (This would require support for git send-email/am to be able to send
>   and apply merge commits -- at least those which have the same tree as
>   one of the parents. This is _not_ yet supported in my proposed git
>   patches.)

This does not require much from format-patch and am.  All you need
to do is to ensure that they can handle an empty commit.  What you
need more is a support in merge.  The outline for the workflow would
go like this:

 * The contributor prepares an N patch series 1/N..N/N on a single
   topic branch.

 * The summary of the series, the message that is meant to help the
   integrator, is recorded as (N+1)th commit at the tip of the topic
   branch, as an empty commit (i.e. a commit that records the same
   tree as its parent).

 * "git format-patch" is taught, when told to prepare the patch
   e-mails from such a topic branch, to notice the unusual "an empty
   commit at the tip" layout, and turn that into 0/N of the message.

 * "git am" is taught a new option to cap a topic branch made from
   patches 1/N..N/N from the incoming mbox with an extra empty
   commit, whose message is taken from the 0/N cover-letter
   material, to recreate what the contributor had in the second step
   above.

 * "git merge" is taught, when told to merge a topic branch, to
   notice the unusual "an empty commit at the tip" layout, and

   (1) merge topic~1 instead to excise the empty commit itself,

   (2) take the log message from the empty commit at the tip and use
       it to help prepare the log message of the merge.

