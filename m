Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1626A1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 01:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKMBLu (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 20:11:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59000 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfKMBLt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 20:11:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 444502A52E;
        Tue, 12 Nov 2019 20:11:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6SL8dzDhhcyFTFw7V/1+pPQd35w=; b=vRXL0r
        i512sGjurRZtC2UmQmEWrRxEpfYe3rqxtP9eheUekLDuDL/7WByGNtMIT/yTfhpc
        UlSQkIt7YtLbWdCtTcqPjDBk8dynEIuE57NcfpoXEU1RfTqw2wHh3AsspgRZsE4I
        IvmecmSRupiq3uRAuT92d1aovAq69Bl9Juvac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TJzsQx69TM6831w9AFQsS3pE66EcZA4P
        TbvagVAaLYvdadNmNtCYlDzSvRmJukPEVfcVUvbNuAk/yMz6ACQaKmKGqopitkFB
        mbB2A91I6skUM4BZ9w6zzUMxe58s90kRufmuD2Yb1xI+3ZMD39u403+dou4gMQa3
        vmDJgGPpqVk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AF102A52D;
        Tue, 12 Nov 2019 20:11:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EBB52A52B;
        Tue, 12 Nov 2019 20:11:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Paul Jolly <paul@myitcv.io>
Subject: Re: [PATCH] completion: learn to complete `git rebase --onto=`
References: <CACoUkn6D0cUmN1RbcpfERcOJsbGLdwj6oDeF2oRADV+rX2artQ@mail.gmail.com>
        <22e92546ee49d4502fd5a441741a380d62c834c7.1573507362.git.liu.denton@gmail.com>
        <xmqqpnhxg0ra.fsf@gitster-ct.c.googlers.com>
        <20191112180503.GB41101@generichostname>
Date:   Wed, 13 Nov 2019 10:11:47 +0900
In-Reply-To: <20191112180503.GB41101@generichostname> (Denton Liu's message of
        "Tue, 12 Nov 2019 10:05:03 -0800")
Message-ID: <xmqq7e44eg18.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91349CCC-05B2-11EA-BB44-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Tue, Nov 12, 2019 at 01:46:33PM +0900, Junio C Hamano wrote:
>> Denton Liu <liu.denton@gmail.com> writes:
>> 
>> > Before, when there was a space, we'd start a new word and, as a result,
>> > fallback to __git_complete_refs() and `--onto` would be completed this
>> > way. However, now we match the `--*` case which does not know how to
>> > offer completions for refs.
>> 
>> Very well explained.  Thanks, will queue.
>
> Could you please queue this on the tip of
> 'dl/complete-rebase-and-archive' since it fixes a regression introduced
> in that branch?

The topic dl/complete-rebase-onto, which has this patch, is built
directly on top of that topic.  Since we may need to rewrite the
patch when further review comments come in, I'd prefer to leave it
separate from the other topic (which must not be rewritten) at least
for now.

Thanks.

