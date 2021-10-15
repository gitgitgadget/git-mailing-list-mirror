Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5006FC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231EB61056
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhJOTYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:24:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63564 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhJOTYl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 15:24:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2B9915FC77;
        Fri, 15 Oct 2021 15:22:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=33zQOk0MxkTF3WLiVaeSuookjwOdYQs2Krli6b
        U7ZBE=; b=Nkwe1PhiWA0GfO+M0rm/vHuF0LGHHeJNLbNlB8b9g7rE2FcN/n2lD2
        PHHRHqsZKFLGLGkh1BaVnZejib2QwoaYQ4OXLIKuS7JzZh7AZZWQb2lIt46d/UVB
        fjrmEaQGMwwgsiEyFfnqrOlDGjd+aewiKAyTSRN3Io4i/147VuByk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC54615FC76;
        Fri, 15 Oct 2021 15:22:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2659C15FC74;
        Fri, 15 Oct 2021 15:22:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] stash: implement '--staged' option for 'push' and
 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <87fst2gwia.fsf_-_@osv.gnss.ru> <xmqq5yty6uh1.fsf@gitster.g>
        <87pms6cdnk.fsf@osv.gnss.ru>
Date:   Fri, 15 Oct 2021 12:22:30 -0700
In-Reply-To: <87pms6cdnk.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        15 Oct 2021 22:05:03 +0300")
Message-ID: <xmqqsfx25c09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E8F8FBC-2DED-11EC-8CF2-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> but
>> unlike the "stash -p" that goes interactive to let the user pick
>> hunks, in which context "oh, no, you did not SELECT anything" makes
>> perfect sense as an error message, this message would be confusing
>> to users who weren't offered a chance to select.
>
> It seems to me that it makes sense to leave this warning as is, in case
> the user invoked "stash --staged" without anything staged. I'm OK to
> change this if you have something better in mind.

I am not questioning the presense of the warning.  It is just the
phrasing of the warning---"You have nothing staged" would make a
good message, but "You didn't select anything", when we do not offer
them a chance to select in the first place, would not work well.
