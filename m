Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D8620281
	for <e@80x24.org>; Thu,  7 Sep 2017 00:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbdIGAyj (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 20:54:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59449 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751938AbdIGAyj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 20:54:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59D379CB4B;
        Wed,  6 Sep 2017 20:54:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dowuQdxWAXqJmkBJwSTpipDd2K0=; b=QgA9L4
        eu9r3WqtYQEgNc5aL3W1F1R6DMNtbSyxdrgpzohx93l7UsP2SreRImkQTnzFE3Cd
        EYrpGx877/fNQC/ccQxMv/yFkNGGqq/r2T8YDAyfqR6O+Yelu/qqrhkwvn8OQRty
        xo1TKwGM8yaArWBNr4atBNOtgCRH6DNIbJKHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UXrvQb2F4XaJAzWI8oGVDCh4iCV+iwSV
        NejHftmEX9Ws9Sp929SsIfSCj2HdUeuMndssfH9nbWHIT9hIWzfDIAQkXYGy4NPc
        vJ/GN630MziD36RrAMCI5CDNw2B/I3MFGCvs+HVggHV+fe7UHCK6o0B4D0UJZQ62
        AvDZxdxJmzE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51E699CB4A;
        Wed,  6 Sep 2017 20:54:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4DD89CB49;
        Wed,  6 Sep 2017 20:54:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
Subject: Re: [PATCHv2] pull: honor submodule.recurse config option
References: <40ecf559-0348-b838-72f7-0ad7746a7072@morey-chaisemartin.com>
        <xmqqvakwaan2.fsf@gitster.mtv.corp.google.com>
        <c3842980-22ef-5a8c-2895-90c48a97ed71@suse.de>
Date:   Thu, 07 Sep 2017 09:54:36 +0900
In-Reply-To: <c3842980-22ef-5a8c-2895-90c48a97ed71@suse.de> (Nicolas
        Morey-Chaisemartin's message of "Wed, 6 Sep 2017 08:25:06 +0200")
Message-ID: <xmqqbmmn2ur7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F811516-9367-11E7-BE51-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:

>> If it is not the latter, perhaps we may want to flip the order of
>> config parsing and option parsing around?  That will allow us to fix
>> the handling of autostash thing to use only one variable, and also
>> fix your patch to do the right thing.
>
> I see what you mean.

> It looks like switching the code around works but I think there
> still needs to be 2 variables for autstash for this piece of code:
>
>     if (!opt_rebase && opt_autostash != -1)
>         die(_("--[no-]autostash option is only valid with --rebase."));
>
> The config option should not cause git pull to die when not using
> --rebase, the CLI option should.

Ah, OK.  That is a worthwhile observation that needs to be recorded
in the log message of a commit that flips the order of option/config
parsing.

Thanks.
