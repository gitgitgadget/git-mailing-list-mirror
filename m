Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD5CC0018C
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E3A22C97
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgLDWp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 17:45:27 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53121 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgLDWp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 17:45:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BE5C11D094;
        Fri,  4 Dec 2020 17:44:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o3lsIUUwPVnHYUNOFsYN52bCR/8=; b=SKmsyL
        6YCi1zUXlUkZ74KcUI/q56RCRRHuSo/TBPe9v0aZVXo2Yd33CeSpQrDcjAeIrW8f
        Q3abLCPkPDlM4DrmlPWPW9JQcv34GSm89UTmZhc3bTLzHXT6zeTwWMzTld38cEdM
        ztIL/fP1Z+EsTaH8AEvT3KU/lQNGE33BBg1P4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jy8KWurJcgyxIsTs6yKmJQQRZZAp0rcl
        8sQ/bcQ66LGk902NrVshaRlRO0aS9dgX204jb+eXsdITbVrEYoCykLHJgSKeP9bg
        BcUteTinEGtqGxLDN3rNPd1Mpf8EGk6bk29HWSny19fXQWQRb+e2TUFPPPmFS1rr
        JkKkeJBENeg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8478511D093;
        Fri,  4 Dec 2020 17:44:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C6AB411D08C;
        Fri,  4 Dec 2020 17:44:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: check result of index_pack_lockfile
References: <20201204221457.2873935-1-samuel.thibault@ens-lyon.org>
Date:   Fri, 04 Dec 2020 14:44:39 -0800
In-Reply-To: <20201204221457.2873935-1-samuel.thibault@ens-lyon.org> (Samuel
        Thibault's message of "Fri, 4 Dec 2020 23:14:57 +0100")
Message-ID: <xmqqwnxxcht4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BAE10C8-3682-11EB-AE22-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Thibault <samuel.thibault@ens-lyon.org> writes:

> The fetch-pack command may fail (e.g. like in test 15 - fetch into corrupted
> repo with index-pack), in which case index_pack_lockfile will
> return ...

Thanks.

It sounds like the same as 6031af38 (fetch-pack: disregard invalid
pack lockfiles, 2020-11-30), which came from

    Message-Id: <c54233ce-ff72-ca29-68c2-1416169b8e42@web.de>

