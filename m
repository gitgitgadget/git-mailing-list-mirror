Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C88920954
	for <e@80x24.org>; Tue,  5 Dec 2017 00:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbdLEA1r (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 19:27:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57731 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750995AbdLEA1q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 19:27:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89DBEB1EE2;
        Mon,  4 Dec 2017 19:27:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Ol3T8yDbxKyB3vgs+WTf8SMyx8=; b=c75yJC
        BREse+3vL4Pj+hCMUyGT6Vrw4/o7YmOk4F0DlCDrfxWEKzED4swkCIEdYJSxyLuM
        sfvEzPbN7Z4tmmfAcI00iCJ05t1Hsvj4y10jd3I+PSLieYZW9BOMoTPWuj6r5gmP
        /GVQc40QqKcAhVOuB7vjmbxEVSRP3iAPS/PYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SH/GkSZDkgbD9FhW4gnVcgE3ohPcDNQ3
        DLUj0/Ertg/26NjCvxfIaoxXsffivDITDJoUwTDEEf6V5ADWhRqswMFkwIckb6/H
        PYBkms1NRiVYrWST0ZprRpZiZjeaBTMeEXrb4xGvqcv36iIVyBb4K4NFnmLaUVU2
        c21Q55kungw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 823CDB1EE1;
        Mon,  4 Dec 2017 19:27:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB3F4B1EE0;
        Mon,  4 Dec 2017 19:27:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Abel <rabel@robertabel.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] git-prompt: make __git_eread intended use explicit
References: <alpine.DEB.2.21.1.1712011143320.98586@virtualbox>
        <20171201233133.30011-1-rabel@robertabel.eu>
        <xmqqindmml25.fsf@gitster.mtv.corp.google.com>
        <e8d35c35-ffd5-ef10-bc6a-0834c1703995@robertabel.eu>
Date:   Mon, 04 Dec 2017 16:27:43 -0800
In-Reply-To: <e8d35c35-ffd5-ef10-bc6a-0834c1703995@robertabel.eu> (Robert
        Abel's message of "Mon, 4 Dec 2017 23:57:36 +0100")
Message-ID: <xmqqd13ukohs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CFA5FA0-D953-11E7-A69F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Abel <rabel@robertabel.eu> writes:

> Hi Junio,
>
> On 04 Dec 2017 18:58, Junio C Hamano wrote:
>> Robert Abel <rabel@robertabel.eu> writes:
>>> __git_eread is used to read a single line of a given file (if it exists)
>>> into a variable without the EOL. All six current users of __git_eread
>>> use it that way and don't expect multi-line content.
>> 
>> Changing $@ to $2 does not change whether this is about "multi-line"
>> or not. 
>
> I'm aware of that. I was documenting current usage. The function is used
> to read file contents (which are expected to be a single line) into
> _a_ (i.e. single) variable.
>
> None of the current users of the function expect tokens to be split,
> which is why I removed it in preparation of patch 2/2, which would
> break tokenizing file contents.

I know all of the above, but I think you misunderstood the point I
wanted to raise, so let me try again.  The thing is, none of what
you just wrote changes the fact that lack of callers that want to do
"multi-line" is IRRELEVANT.  True, there is no caller that wants to
read multiple lines---it is a true statement, but it is irrelevant
statement.  On the other hand, it is true and relevant that no
caller expects to split a line into multiple variables.

By changing "$@" to "$2" there, you would have broken callers that
wanted the helper function to read into multiple variables (if there
were such callers).  Explaining the current usage that nobody does
so *IS* a valid justification for the change.  It is relevant.

With or without that change, a caller that wanted to read multiple
lines from the file would never have worked.  It was just doing a
single "read" built-in, so the only thing that would have been
worked on is the first line of the file.  Your change wouldn't have
changed that---if a caller wanted to peek into the second line, your
change wouldn't have helped such a caller.  And it is not like your
change would have broken such a caller that were happily reading the
second and subsequent line.  The original wouldn't allowed it to
read the second line anyway.

Contrasting this with the above obsesrvation about possible breakage
for multi-variable callers (if there were such callers---luckily
there wasn't any), I hope that you can see why the lack of
"multi-line" caller in the existing usage is totally irrelevant when
analyzing this change and explaining why this is a good change.

HTH.
