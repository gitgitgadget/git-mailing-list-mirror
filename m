Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47819C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 00:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1010D239D4
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 00:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbhAVAGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 19:06:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58760 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbhAVAFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 19:05:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D979F10761E;
        Thu, 21 Jan 2021 19:05:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kdk2N/1Q9biPeYsjJ3LW50fkQjU=; b=tx2lMY
        wQ6Vzpvyxogdjk5zzsH8Y3KYmZ9T8zwSiv4rlCK4ANWXLG2KY1uWkcVaJuWfIU4R
        K880AlxZf29Mry7+Jhyr3SmjTShU5aICWEIQS5bUbnp5LxEz8e2kQU/BFr+kp3fE
        jReuo8OMG1TDz6yg8an4P8F6m+WsWshaoEph4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=awFpXtio2KItoc/64GRinNmqPog5IkOJ
        gnCj94MfciSY25AVgS2kndQt0UN8Pr84IUsWnyrDvNw560w7+EnFwDgApr8sAPnE
        NEBEdxWHO5J9/ydWi2rPKesJmdQkqBuQt+DwmPTSGt6Er129+83qsRMJfFLs7aBo
        q9ydZ6cPs9c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C57B010761D;
        Thu, 21 Jan 2021 19:05:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1803210761A;
        Thu, 21 Jan 2021 19:04:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] use delete_refs when deleting tags or branches
References: <20210121032332.658991-1-phil.hord@gmail.com>
Date:   Thu, 21 Jan 2021 16:04:56 -0800
In-Reply-To: <20210121032332.658991-1-phil.hord@gmail.com> (Phil Hord's
        message of "Wed, 20 Jan 2021 19:23:32 -0800")
Message-ID: <xmqqpn1xalav.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76D57366-5C45-11EB-8AAF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> diff --git builtin/branch.c builtin/branch.c
> index 8c0b428104..bcc00bcf18 100644
> --- builtin/branch.c
> +++ builtin/branch.c

You wasted 15 minutes of my life by choosing to deviate the list
norm of sending what "git apply -p1" (default) would accept.  I am
fairly trusting type and did not suspect anybody do such an evil
thing.  Why?
