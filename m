Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9813A1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 19:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfGKTey (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 15:34:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58398 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGKTey (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 15:34:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 684B3164502;
        Thu, 11 Jul 2019 15:34:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4XFdfF8+ZVi4HjXL2klzBhycFEM=; b=iwgqH/
        jrs32po5hU1YZ68CSejmHFg2/8WEn0XqQkNHEpTwJVSYKdYVdXLmZi5tepHpXHu8
        QC7kfD/p0SYuDBhLwt3R64XL5Kd+/nynGpccfvEcYPQqm5PEmiOFsOSsuBgE6ot/
        wTVG60zKttvnnFuoYpevA0smL3T97FGl1+9Io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A1DoeO7V1DWSSCbc43+gr/mNQADdJqie
        1zYqOGQJOwTawQNi/IIMzVFx8nptnEyLwtKWUT37MkNuCA/Br7rziDWcn39UN7+G
        6jgQnrpByFG7IK34fY+1WFQsEY7VCT3LcRvy5npMmUGEW0QvCEI1VW3scMblRMbV
        n+lgfOl6Znk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F39A164501;
        Thu, 11 Jul 2019 15:34:52 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B637E164500;
        Thu, 11 Jul 2019 15:34:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/3] use mailmap by default in git log
References: <20190711183727.8058-1-ariadne@dereferenced.org>
        <xmqqy314qsgp.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 11 Jul 2019 12:34:50 -0700
In-Reply-To: <xmqqy314qsgp.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 11 Jul 2019 12:30:46 -0700")
Message-ID: <xmqqtvbsqs9x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3C4578A-A412-11E9-94AF-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Even though I personally think it is an OK longer-term end goal, the
> execution looks too hasty.  The normal way we handle a big behaviour
> change like this is to do the following in steps, in different
> releases:
>
>  - In the first release, introduce an early adoptor option (say
>    log.usemailmap) that can be turned on by the user, but is off by
>    default.  IOW, the initial step is "no change in behaviour,
>    unless you ask for it".  This step also makes sure that the way
>    to disable it for those who opt into the option from the command
>    line (i.e.  the --no-use-mailmap option) works well.
>
>  - In the second release, when "git log" is run without command line
>    "--[no-]use-mailmap" and "log.usemailmap" is not set by the user,
>    give warning about an upcoming flipping of the default, with an
>    advice message that the user can squelch the warning by setting
>    the option.
>
>  - In the final release, flip the default and remove the warning.
>
> Usually there needs sufficient time between the second step and the
> third step, so that people will not miss the warning.

IIUC, we are between step 1 and step 2.  The configuration already
exists and uses the safe (i.e. the same as before) default.  Your
change combines the step 2 and step 3 into one, which will not work.

What we need at this point is the "second release" phase, i.e.
additional warnings without yet changing the default behaviour.
After it is given to the end users and sufficient time passes, we
can flip the default.
