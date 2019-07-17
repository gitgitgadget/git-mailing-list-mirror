Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19421F461
	for <e@80x24.org>; Wed, 17 Jul 2019 18:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbfGQSHF (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 14:07:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54749 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfGQSHE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 14:07:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5840151FE4;
        Wed, 17 Jul 2019 14:07:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cLHpZL9UQyRQnMelVL9beJzNWcA=; b=l+LX+P
        EZl9LN3VrCTu7sDjw112krjnKCs1a8iZf5L4RujKMFiiVXbqLKYmeT3TTin2kpSb
        4LnPV/oJ/inVaw76vXFsaDkX9OsRRYuLgA86/+6+nrUhRFwP23vlBME+akGvYa7i
        rEnGeZsAu+FDN+TaplUGEwTQIUA/W6UywjBZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mYFHQgnocWo2wfeiQuE2z36Z6ydjeJIj
        BWHjCuGsPgtcK8JZJgfmepRtkCf900kC0yfAa9eJXBn8ap8w+AtlUl9nLMQLQC0D
        fXz3oNnArsQZcZ20+V3SDf48oIifUs8KvFvLn3DXrozOvfPALidi2BkBx1iBAj05
        BjOUWf0QmXs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E2CB151FE2;
        Wed, 17 Jul 2019 14:07:02 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12C3D151FE0;
        Wed, 17 Jul 2019 14:07:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] builtin/merge: allow --squash to commit if there are no conflicts
References: <20190713051804.12893-1-eantoranz@gmail.com>
        <CAOc6eta-jX93k6twcrJOeRt+JHtLk4mUs7YD_bG=Ggvw4thAZQ@mail.gmail.com>
Date:   Wed, 17 Jul 2019 11:07:00 -0700
In-Reply-To: <CAOc6eta-jX93k6twcrJOeRt+JHtLk4mUs7YD_bG=Ggvw4thAZQ@mail.gmail.com>
        (Edmundo Carmona Antoranz's message of "Sun, 14 Jul 2019 01:15:22
        -0600")
Message-ID: <xmqq5zo01qnv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD473124-A8BD-11E9-8052-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> On Fri, Jul 12, 2019 at 11:18 PM Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
>>
>> Option -m can be used to defined the message for the revision instead
>> of the default message that contains all squashed revisions info.
>>
>
> I have noticed that just adding the support for -m in squash is more
> complex than this patch is reaching so I think I will break this patch
> into two parts:
> - squash in a shot if there are no conflicts
> - support -m with squash
> Disregard this patch, please.

Sure.  I started skimming and then gave up after seeing that quite a
lot of code has been shuffled around without much explanation (e.g.
printing of "Squash commit -- not updating HEAD" is gone from the
callee and now it is a responsibility of the caller), making it
harder than necessary to see if there is any unintended behaviour
change when the new feature is not in use.  Whatever you are trying,
it does look like the change deserves to be split into a smaller
pieces to become more manageable.

Thanks.


