Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A82C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2193520656
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pDLelwB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgHUQ2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:28:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63967 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgHUQ1z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 12:27:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A80E67A2F9;
        Fri, 21 Aug 2020 12:27:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WRqnn+4Tw6pV9gYrZv+WWKMhplA=; b=pDLelw
        B1gmIp+Pmn1DxzbACdB9l8auQrTDl56+CBYpC0PUQ+wD0EVQvZ3GMxSpGkf52bb6
        N389pP6GIOF1/rBG86UVcqaF8fa0R7wba9Mm4otZxK1OsQQNtf40uG5TxrZkhusG
        IwAuQRcZxuVURzrqZH8q38qy7Je0Lsm+JcHN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mmtuh2Ry535ZzdVheSNl9UwnkRxdGtxT
        mjShB4oyFSeoyB3rY9Svo7hDmq0ywmW5EPeOERKep0P1mHdMhYw57TPEw26ZzrIr
        fREFjJmGs2LqXIR7wR4nzi9dPfbaQREROFGV5WEnCUdfKtrWS5K/s3K6f6HTDjsv
        WOyw+FQhPQg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E5327A2F8;
        Fri, 21 Aug 2020 12:27:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20B3C7A2F7;
        Fri, 21 Aug 2020 12:27:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     "Thomas Sullivan" <tom@msbit.com.au>, <git@vger.kernel.org>,
        "Phillip Wood" <phillip.wood123@gmail.com>
Subject: Re: git add intent-to-add then git add patch no longer allows edit
References: <C52FB27V04G0.2ML0PLGDE71MG@ziyou.local>
Date:   Fri, 21 Aug 2020 09:27:48 -0700
In-Reply-To: <C52FB27V04G0.2ML0PLGDE71MG@ziyou.local> (Raymond E. Pasco's
        message of "Fri, 21 Aug 2020 01:25:41 -0400")
Message-ID: <xmqqmu2o9d6j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40B25422-E3CB-11EA-B0C4-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> I fixed half of this in a topic that's on master now (it errors out
> entirely if you try to stage it at all in 2.28.0), 

Yup, thanks for that one.

> but new file diffs
> still aren't splittable into hunks. Phillip Wood (on cc) is looking into
> that; the tricky part is that when split into hunks only the first hunk
> actually staged can be a "new file" patch.

Out of a change that adds a file with three parts A, B and C (in
this order), you could pick the parts A and C, while leaving the
change to further add B in the middle, and create a patch to add a
file that has A and C, and apply that to the index alone (i.e. "add
-p", pick A and C, and "add" that part by applying that "new file"
diff).  After that, the path is no longer i-t-a but has the real
contents (i.e. part A followed by part C), so further "add -p" would
see the difference between the index and the working tree as a
modification patch.

So as long as you could come up with a good UI to pick parts from a
single hunk "new file" diff, "the second and later application must
be done as modification" should fall out naturally, no?

