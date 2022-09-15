Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6128ECAAD3
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 02:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiIOC1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 22:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiIOC1P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 22:27:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AC540554
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 19:27:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C8F1139370;
        Wed, 14 Sep 2022 22:27:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=4Hbc7H6omcWq2QH86L0zSzb00SmIPgKAOgGKhqyqdF8=; b=yFLO
        G16z6hMU5VsGw2/MYIroJXV+vp/lKggwEb11aE61fPbF5frgEdoxGnckU3ZZGHUw
        ovrEkITczsjtaFUqVFhA+HVq4ou3R5tWKsFdKodF+kH0BQA4qWu37GRbCEhEHSHu
        DU6fpe13TUWBae7wWL7aGf5UsOW0I0jod+3GQB4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2449513936F;
        Wed, 14 Sep 2022 22:27:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7CBC313936E;
        Wed, 14 Sep 2022 22:27:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Conners <business@elijahpepe.com>
Cc:     "git" <git@vger.kernel.org>, "hanwen" <hanwen@google.com>
Subject: Re: [PATCH] reftable: pass pq_entry by address
References: <183353220fe.d7826593472673.3445243727369286065@elijahpepe.com>
        <xmqqbkrjb75g.fsf@gitster.g>
        <18337ea407a.10c144c52599576.4708941661785569426@elijahpepe.com>
Date:   Wed, 14 Sep 2022 19:27:11 -0700
Message-ID: <xmqqsfktpe2o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8013642-349D-11ED-82A0-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Conners <business@elijahpepe.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>  > Do we have any hard guidance like "do not pass an data item whose
>  > size is larger than 64 bytes" in our coding guidelines?  If not,
>  > make sure that the reference to 64 bytes does not look like one.
> While we don't have hard guidance like that, putting an object that exceeds 64 bytes on the stack is dangerous.
>
>  > In any case, wouldn't it make sense to make the "we pass reference
>  > not because we want to let the callee modify the value, but because
>  > the callee deep in the callchain wants to copy the contents out of
>  > it" parameter a pointer to a constant? 
> Yes. I overlooked that making this change. Feel free to make that change, otherwise I'll do it myself.

OK, will wait for an updated patch that corrects the proposed log
message (i.e. not to say "size is larger than 64 bytes hence this is
bad") with a const pointer.

Note that this project tries to avoid piling "oops the previous one
was wrong, and this is a fix" patches on top of earlier patch that
are faulty or suboptimal.  Instead "v2" and later patches are
written as if an earlier iteration never happened, i.e. allowing the
author to pretend to be perfect human ;-).

Thanks.
