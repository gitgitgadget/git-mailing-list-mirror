Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19423C4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 22:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA74A20739
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 22:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bmysytaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgJAWWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 18:22:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61089 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgJAWWC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 18:22:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7BFFADA36B;
        Thu,  1 Oct 2020 18:22:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2hbhN2Vxr/NQaD7j4i/+urpmuBQ=; b=bmysyt
        aqEQdwp0KsvuZJ4sKiIQjPhnVn4TLfXMCigBMklmZTMUuQpbubrph7oDIzosB2ZE
        Vwu+xRAidGSNai9RoVEnnpOKtj60TO9FN/JDaQFLh6P0gugSDM0ft61OLqwTDoTC
        OBWBh6E5eDxgi5QJdd7DdEPQHeQGzys9t9BCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uxcKHRdfuc2E3OTDb/BTAln0Nz024aeQ
        y7JHllAVsD20W9lMKs2IwKH65Qqk9+tw5uUDtHJ/OLxC1cCrlcBoJPu388+B3Av1
        RBkrA5rzTd55yvrf4MIt9M8DCOekTGZZ1tXWWPjcKOzonOidxYVctryK0OVfgvh8
        vmPyhnF4ia0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B93DDA36A;
        Thu,  1 Oct 2020 18:22:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B3E3DA369;
        Thu,  1 Oct 2020 18:21:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 0/1] teach format.useAutoBase "whenAble" option
References: <20201001214653.1609405-1-jacob.e.keller@intel.com>
Date:   Thu, 01 Oct 2020 15:21:56 -0700
In-Reply-To: <20201001214653.1609405-1-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Thu, 1 Oct 2020 14:46:52 -0700")
Message-ID: <xmqqft6xbn97.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84B9C18A-0434-11EB-B0E5-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> This is a v2 of [1] to address comments on the mailing list. Primarily the
> change is to remove the option for --base=if-able, since it is not as useful
> as the configuration option. If we think it is desirable, adding back a
> whenable or whenAble option is easy enough.

The simplification is a great thing to do, and I agree with the
rationale you wrote ...

>     +    This does mean that a user cannot request this optional base commit
>     +    generation from the command line. However, this is likely not too
>     +    valuable. If the user requests base information manually, they will be
>     +    immediately informed of the failure to acquire a suitable base commit.
>     +    This allows the user to make an informed choice about whether to
>     +    continue the format.

... which is sensible.

Thanks, will queue.
