Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A45BC4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 17:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F223A24630
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 17:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jHPN+UmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902214AbgJVRFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 13:05:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51718 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439613AbgJVRFA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 13:05:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D73AED5A1;
        Thu, 22 Oct 2020 13:04:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wyf0tpik0sTb0mnMV2VHvC+uyIc=; b=jHPN+U
        mEwryhWDHs38Xm0xSvL4XJrs2PrlE/NVR/fgnWNpMZb/YGaHlDS6HsmAeSv93Xq1
        jp8fC43diwH6tWGuZFlj7L7UbbIexCAYS3VC6plHLGTx+54D3TZN3pYyPY5Y7fof
        28jI/bUkoaBmXnX+1wBkekPqdwXZ2KncRmspg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oABr/QsDTOEmxbb9FwxmogtDJzEpLZvI
        x2Ib+vhh2MKXaxLpKOYztpXc4ojPPV71+w2Th6oV8Z1Ijr/0GD4hACJUqU4Uw/sX
        W3EBPcWz0oJ7Ivc/tRlEX6BXDEqUh1lenZf7q8xz4GNmFWClSVVTwEb5ZwPr8VrU
        N57USvx50TA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F2C45ED5A0;
        Thu, 22 Oct 2020 13:04:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 424E5ED599;
        Thu, 22 Oct 2020 13:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk,
        Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sangeeta <sangunb09@gmail.com>
Subject: Re: [PATCH][OUTREACHY] bisect: allow `git bisect` to run from
 subdirectory
References: <pull.765.git.1603271344522.gitgitgadget@gmail.com>
        <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com>
        <nycvar.QRO.7.76.6.2010221042260.56@tvgsbejvaqbjf.bet>
        <46b208d8-3741-d528-c833-aea5770a502c@gmail.com>
Date:   Thu, 22 Oct 2020 10:04:54 -0700
In-Reply-To: <46b208d8-3741-d528-c833-aea5770a502c@gmail.com> (Phillip Wood's
        message of "Thu, 22 Oct 2020 10:52:33 +0100")
Message-ID: <xmqqzh4embt5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5C88BE4-1488-11EB-8DC7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> The relevance is this: _iff_ we want to prevent `git bisect` from
>> running
>> in a subdirectory under the premise that that subdirectory might need to
>> be removed, then why don't we prevent `git rebase` from running in a
>> subdirectory when that command is equally likely to remove that
>> subdirectory?
>
> That's a good point, I'd completely missed the analogy with `rebase --exec`

I concur.  Perhaps we should make rebase a bit more careful.
