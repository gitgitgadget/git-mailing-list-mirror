Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0901F404
	for <e@80x24.org>; Thu, 14 Dec 2017 18:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbdLNSYY (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 13:24:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55658 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754091AbdLNSYY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 13:24:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B6E9C7793;
        Thu, 14 Dec 2017 13:24:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=02vGuJv67kemoJV33mJ2DG45kXk=; b=s+5xk7
        cmcF/tbc6dqiPaMmQPmQuqfpHp38/uKxFVk8ytnvEPSYTHuR6jDxWvg3VnpoUPA5
        0Aa8CFW2z0ZDcB8sAPfVqcGrsb8EdOSwityS0DcLXrE6J1RpsWTfuK9+PTeH9BSS
        Cv2Tgm0wo2JK/3b6DXH9rIv2x5YBBrcFrn+Hs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eEWt84+IDYcnRv/LHQniVwzhM5cNHNbt
        ytU6d845TJAHugCud4pDixn1IwuVpNnaW/GwfTeBcE0+jp0FVNw0/9zPHXzSAGBf
        M2XHZ0kETlnOitwvGfu8xm0tu1ipagULpmgx2U8w6ta3f9wQm4/100SaiLFvOqHY
        G+lBVoGcehE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 730BBC7792;
        Thu, 14 Dec 2017 13:24:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDCA1C7790;
        Thu, 14 Dec 2017 13:24:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2] partial-clone: design doc
References: <20171214152404.35708-1-git@jeffhostetler.com>
        <20171214152404.35708-2-git@jeffhostetler.com>
Date:   Thu, 14 Dec 2017 10:24:21 -0800
In-Reply-To: <20171214152404.35708-2-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Thu, 14 Dec 2017 15:24:04 +0000")
Message-ID: <xmqq1sjxuq0a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 021229EC-E0FC-11E7-98D0-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> +- On the client these incomplete packfiles are marked as "promisor pacfiles"

s/pacfiles/packfiles/

> +  These "promisor packfiles" consist of a "<name>.promisor" file with
> +  arbitrary contents (like the "<name>.keep" files), in addition to
> +  their "<name>.pack" and "<name>.idx" files.
> +
> +  In the future, this ability may be extended to loose objects in case
> +  a promisor packfile is accidentally unpacked.

Hmph.

Because we cannot assume that such an "accidental" unpacking would
do anything extra to help us tell the loose objects created out of a
promisor pack from other loose objects, you would end up making any
and all loose objects to serve as if they came from a promisor
remote?  I am not sure if that makes much sense.

Do we really need to write this "in the future" down, before we have
thought things through enough to specify the design at a bit more
detailed level?
