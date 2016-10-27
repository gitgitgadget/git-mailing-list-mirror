Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE96A2022A
	for <e@80x24.org>; Thu, 27 Oct 2016 06:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbcJ0GDT (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 02:03:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52372 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751870AbcJ0GDT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 02:03:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9ED0E49F50;
        Thu, 27 Oct 2016 02:02:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c+N4gJdI8yvbCwe/UrQSsJk6DRI=; b=pxTlEO
        jGB6K19om1TyO7QAwaAgMah3spW4xFbLDZait5+EON0nNYw5b/OsFoeptSjRtXkr
        2/fTgeM1tXdPJEdUUoCt1Rlzhy2HZoF79DVH3uQNodDpXsag4UxKmck2kgBjx3oz
        /WeWilJVMyEysiC9DMfp/Nx2E1GjymtwfglgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AOadYOU9CRkDV2KG2zojGfzBWHUOulou
        wX0IeHR13ob41B5X+jJFxthN+jvtZUOrRu1OkXtfkJFSfCr2M3PhYWZ8o5qYtqgL
        1q1N39hjgqUhlqZuVLD1oqccZPsfBnjJHmSYyHx+/s6n/qyYJ2szO8+HVBGUWxPI
        2rk2XnVFYNI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96ED649F4F;
        Thu, 27 Oct 2016 02:02:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F0FB49F4D;
        Thu, 27 Oct 2016 02:02:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org, simon@ruderich.org, peff@peff.net
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
References: <20161026215732.16411-1-sbeller@google.com>
        <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
Date:   Wed, 26 Oct 2016 23:02:33 -0700
In-Reply-To: <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org> (Johannes Sixt's
        message of "Thu, 27 Oct 2016 07:49:27 +0200")
Message-ID: <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4C373AE-9C0A-11E6-A71D-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 26.10.2016 um 23:57 schrieb Stefan Beller:
>> In Windows it is not possible to have a static initialized mutex as of
>> now, but that seems to be painful for the upcoming refactoring of the
>> attribute subsystem, as we have no good place to put the initialization
>> of the attr global lock.
>
> Please rewrite the attribute system such that it can have a dynamic
> initialization. If you find a global initialization in main() too
> gross (I would agree) then setup_git_directory() might be the right
> place.

As many codepaths may not even need access to the attributes, I
doubt that would be a very productive direction to go.

