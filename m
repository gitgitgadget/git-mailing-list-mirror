Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E3FC433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 02:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiDHCcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 22:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiDHCck (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 22:32:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A9E234068
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 19:30:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 611491811A4;
        Thu,  7 Apr 2022 22:30:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Z+4+PBV8kjpU34LLhdG/YcpoW4Pkj7hdDqabtnz+M4s=; b=KGCp
        dGnXF+0bty7Kxm+l/kzEEtg2QLYXS6emX1v1ecYd/ao7rguoRkckG6q0RFQgwHNj
        vYCq/cycKvVH9e7UZVirDELFPH/+XFFXah9yGg97Bs1UtBvAjOkDHQt1V0V7RuFn
        jP8Ha1ESbI0hCn0DHrY63NWEciF6WV4tjiea/0A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A0D71811A3;
        Thu,  7 Apr 2022 22:30:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B73751811A2;
        Thu,  7 Apr 2022 22:30:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miklos Vajna <vmiklos@vmiklos.hu>
Cc:     git@vger.kernel.org
Subject: Re: git log --since to not stop after first old commit?
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu> <xmqq1qygy9nd.fsf@gitster.g>
        <Yk8Gvf/fjVca9hDB@vmiklos.hu>
Date:   Thu, 07 Apr 2022 19:30:33 -0700
Message-ID: <xmqqv8vkpara.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE7495FC-B6E3-11EC-BBD3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miklos Vajna <vmiklos@vmiklos.hu> writes:

> On Fri, Apr 01, 2022 at 10:51:34AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> We could add a --since-as-filter= option or something, but then the
>> user needs to be careful when to stop (and digging down to the root
>> of the history, i.e. "never stop", may be an acceptable answer to
>> some projects).
>
> I sent a patch to add such an option (which picks the "never stop"
> behavior) on 1st, did you see that?
>
> If the idea is OK in principle, but the patch needs tweaking, please let
> me know.

As a single-shot change, "--since-as-filter" is certainly an easy to
explain approach of least resistance.

But when viewed from a higher level as a general design problem, I
am unsure if it is a good direction to go in.

Giving "--since" the "as-filter" variant sets a precedent, and
closes the door for a better UI that we can extend more generally
without having to add "--X-as-filter" for each and every conceivable
"--X" that is a traversal stopper into a filtering kind.


