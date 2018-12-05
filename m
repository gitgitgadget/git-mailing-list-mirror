Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A791F211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 03:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeLEDfP (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 22:35:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53006 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEDfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 22:35:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54F5730D2B;
        Tue,  4 Dec 2018 22:35:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pHQPpGxit4Gn
        loWhNU7cjWj6ILQ=; b=pQA2+TZYfeKQsLmBSt5VbSooMvtk5ZkEw2tWBXyyyCA2
        7UjlvICS/NPt+w9uePio3saeJjcjocsHHPCcc6BW6bkITWnMA9p0YuwUJdVMmwej
        /+IAYtDX0eVNwHFz3yw5lg6dc+bMrqyjZUxavMyq40AoEgDQcsUnpwSZeuN1OlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rucKUj
        RXMp2jXcyf2cbf4Yj7cICBHncDpFLWM6K2TPVbCuVkwJn/RoHEf8cowotXKaXOTS
        PlXWWj04GU9hVovDdq2zWEhwxYQ4xk5SbXEeXiP2NC1+kvGCJpQlMKc4oIPE74zN
        5fJINFOj6Bn4qbTe8uAw1nIvhF0FVcUJuns34=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D31E30D29;
        Tue,  4 Dec 2018 22:35:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D03430D27;
        Tue,  4 Dec 2018 22:35:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/3] sha1-file: emit error if an alternate looks like a repository
References: <87tvjtvah0.fsf@evledraar.gmail.com>
        <20181204132716.19208-3-avarab@gmail.com>
Date:   Wed, 05 Dec 2018 12:35:08 +0900
In-Reply-To: <20181204132716.19208-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 4 Dec 2018 14:27:15 +0100")
Message-ID: <xmqqzhtkd4sz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C495A084-F83E-11E8-8C15-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Since 26125f6b9b ("detect broken alternates.", 2006-02-22) we've
> emitted an error if the alternates directory doesn't exist, but not
> for the common misstep of adding a path to another git repository as
> an alternate, as opposed to its "objects" directory.
>
> Let's check for this, i.e. whether X/objects or X/.git/objects exists
> if the user supplies X and print an error (which as a commit leading
> up to this one shows doesn't change the exit code, just "warns").

I agree that "Let's check for this" is a good idea, but do not
necessarily agree with "i.e.".  Don't we have a helper that takes
the path to an existing directory and answers "Yup, it does look
like a Git repository"?  Using that is a lot more in line with what
you claimed to do in the title for this patch.

I haven't read 3/3 yet, but as I said, I suspect it is reasonable to
DWIM and use the object store associated with the directory we found
to be a repository.

