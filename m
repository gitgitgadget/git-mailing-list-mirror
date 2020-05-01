Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE94EC47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 18:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA2F208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 18:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UGLZXwlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgEASzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 14:55:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62161 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbgEASzA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 14:55:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 429E359E08;
        Fri,  1 May 2020 14:54:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zFdY0TSVbP/bC56EaocUGnIvIps=; b=UGLZXw
        lSa1i1fPypeEw6yVvdjqby3ogiTKQN32LvwSrsn9tlg8tZUA4wvNmwpsbq/9C4Mr
        pthiAO1kpoOhJSbnn2rBPfA7+vT9tRYDoQDP7gEG8QnGd8LH/Bn4fW3Fmny3aoF2
        7ThUMOsIsjg394j5eU02xDUEbAiSaFbHm7eqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ls23SVJNhqkcOBxwYArxlrAS8AmyAxMr
        mf3pZGzrtQYw0lHSMoZBqBzsWxyG0qOLhFyWyYnK4ZvlbY49jzRWEstyqWg3qyxq
        XrwU6KWjKjMfnSEL1xMrkEdDKuSvWUuOcT/3K0ptHLCRj+coKddLPt8/af4OZNKS
        +qTBHMSM39o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38B3059E07;
        Fri,  1 May 2020 14:54:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E5F659E06;
        Fri,  1 May 2020 14:54:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, peff@peff.net, heba.waly@gmail.com
Subject: Re: [PATCH v2] submodule: port subcommand 'set-url' from shell to C
References: <20200501073232.18409-1-shouryashukla.oo@gmail.com>
        <20200501100109.GA55820@generichostname>
Date:   Fri, 01 May 2020 11:54:57 -0700
In-Reply-To: <20200501100109.GA55820@generichostname> (Denton Liu's message of
        "Fri, 1 May 2020 06:01:09 -0400")
Message-ID: <xmqqwo5vlc3i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40A29852-8BDD-11EA-B948-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Fri, May 01, 2020 at 01:02:32PM +0530, Shourya Shukla wrote:
>> This aims to convert submodule subcommand 'set-url' to a builtin.
>> 'set-url' is ported to 'submodule--helper.c' and the latter is called
>> via 'git-submodule.sh'.
>
> Commit messages should be written in imperative mood. This could be
> rewritten as
>
> 	Convert submodule subcommand 'set-url' to a builtin. Port
> 	'set-url' to 'submodule--helper.c' and call the latter via
> 	'git-submodule.sh'.
> ...
>>  		esac
>> -		shift
>
> Hmmm, I don't understand why the above hunk and this line are necessary.
>
> ...
>
> This looks good, though :)

Thanks for giving a pretty good review.  I think we covered many
issues pretty much the same way.

