Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5E1C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A78896109E
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhHSSwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 14:52:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51602 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhHSSwG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 14:52:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7633D0F32;
        Thu, 19 Aug 2021 14:51:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i3x9vF0tnhojRUt7VcCopBjTY2zEapyEQif4L4
        GlMPU=; b=NgSKWIb6D6z7KbOZFNFrkFyCYJp+5cxk17Cfg1jExtG2tzDduPosKD
        c7YjIXXNW1J6TrIs8NtFSn9fEH+aCF9un3jdHcd7UltVpFMuNNOstUP74C1tvcS5
        /qL7DWV6JkEGcUuNVF9wjXAx1mdISUtW3Iy3dU4KO5QkESkTVGinw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC236D0F31;
        Thu, 19 Aug 2021 14:51:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5336ED0F30;
        Thu, 19 Aug 2021 14:51:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210520214703.27323-1-sorganov@gmail.com>
        <20210520214703.27323-11-sorganov@gmail.com>
        <YQtYEftByY8cNMml@google.com> <YQyUM2uZdFBX8G0r@google.com>
        <xmqqh7g2ij5q.fsf@gitster.g> <xmqqczqqihkk.fsf@gitster.g>
        <YQ2UFmCxRKNMOtrD@google.com> <xmqqeeb3hlcq.fsf@gitster.g>
        <87a6lgl9gq.fsf@osv.gnss.ru> <xmqqczqb7mds.fsf@gitster.g>
        <87fsv7f7wx.fsf@osv.gnss.ru> <xmqqim011d6m.fsf@gitster.g>
Date:   Thu, 19 Aug 2021 11:51:27 -0700
In-Reply-To: <xmqqim011d6m.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        19 Aug 2021 11:50:41 -0700")
Message-ID: <xmqqeeap1d5c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76195FB8-011E-11EC-AB85-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Your repeating "minor" does not make it minor.  Anything you force
> existing users and scripts to change is "fixing the scripts", but

... is NOT "fixing the scripts", of course.
