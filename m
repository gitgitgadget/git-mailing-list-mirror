Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1E5C3F2CD
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 16:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7848521D56
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 16:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l7HllXII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCBQpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:45:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57784 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBQpb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 11:45:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E8A15F231;
        Mon,  2 Mar 2020 11:45:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lDa0PH6HvdJvmJ9wa79sAbm2Obg=; b=l7HllX
        IIJ7kcDn72MO3s45i+Qmy0Yu+r2YLmT6eEA/Inn0I+nMFERycIJUvaEf5CUkhxrx
        VPUlOszxz1jj5X4vTBfa505N5IQSYW74XfAsgbHHHsMQ2KWNkH+1fBlleiUCqN0K
        wPmQmG68MvNfOrAZ3yaNYKkcr2ZVOmxqPET2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oujn5NwRVXT1OrqifRfndgnGCuaWRxbX
        CUt2PWsAfboj+E3KjJWZpa8VrdvkbKTZhCuuW1Dr3Wd/1HHqf6oHvhjmn0cQT3Ib
        XCmgyDAHGYAaoVnzjgoWJql8g9D6KRQtbldfxrxfeXxQdSuxVvHgrSJfSmQHmIEQ
        Hiv0qjjTVEs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2612A5F230;
        Mon,  2 Mar 2020 11:45:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B5465F22F;
        Mon,  2 Mar 2020 11:45:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2020, #06; Fri, 28)
References: <xmqqimjqcoh0.fsf@gitster-ct.c.googlers.com>
        <CABPp-BEJiRyCznkrri-uTqggT60vkvqsU8dAvKz3B1PH6BB6tQ@mail.gmail.com>
Date:   Mon, 02 Mar 2020 08:45:27 -0800
In-Reply-To: <CABPp-BEJiRyCznkrri-uTqggT60vkvqsU8dAvKz3B1PH6BB6tQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 28 Feb 2020 15:07:08 -0800")
Message-ID: <xmqqsgiqbt94.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39142126-5CA5-11EA-81AD-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> configuration setting.  I'm not the best at wording these release
> notes, but something along the lines of:
>
> "git rebase" has learned to use the merge backend by default, while
> allowing "--apply" option to go back to the traditional apply backend,
> or allowing an alternate default to be set via the new rebase.backend
> configuration variable.  This series also renames the backends from
> "interactive" (or "sequencer") to "merge" and from "am" to "apply".

Thanks.  

 "git rebase" has learned to use the merge backend (i.e. the
 machinery that drives "rebase -i") by default, while allowing
 "--apply" option to use the "apply" backend (e.g. the moral
 equivalent of "format-patch piped to am").  The rebase.backend
 configuration variable can be set to customize.
