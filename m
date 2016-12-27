Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C6B200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 21:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbcL0VS0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 16:18:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50103 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752978AbcL0VSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 16:18:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C76225B5E5;
        Tue, 27 Dec 2016 16:17:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=djIXYJPeBXpAzfwz6FmtGO9u+N8=; b=xIR2sR8hmZ9IVDWH8FlZ
        p2EHytW+q7vS1hkDBsVBsTVmmuwIYvOI4ySu4uiUI71as9b4RXbcdaBBy9Lnukaz
        ZIevfms9xngl9Rs+Jv6aylGfRKbyQ1ZreZgHO+yTX5K3YEx8AwJQY+M5mxkp9cdq
        REv6NcK6Mqy81lawWjMiF38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=vhEou4+TNemH5dI59Q/P8YfTWdIHq8IwQtgEKNNeBoZnWw
        rhWLNY34FklKbZSy5YPW6r+GyGvCINL9WBfw4aumJ9J8fHS76RGg6Sv4nPlEJ9/2
        AmJT0B3P+5FnREIALGFHrAhAPbNOgXoJPAvUTa6NQvYAWJO+fC7vXi6pR/hzg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDDF55B5E4;
        Tue, 27 Dec 2016 16:17:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FDB05B5E3;
        Tue, 27 Dec 2016 16:17:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v9 11/20] ref-filter: introduce refname_atom_parser()
Date:   Tue, 27 Dec 2016 13:04:49 -0800
References: <20161227162357.28212-1-Karthik.188@gmail.com>
        <20161227162357.28212-12-Karthik.188@gmail.com>
Message-ID: <xmqqtw9p6phx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E09B0AFA-CC79-11E6-A8BB-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> +symref::
> +	The ref which the given symbolic ref refers to. If not a
> +	symbolic ref, nothing is printed. Respects the `:short` and
> +	`:strip` options in the same way as `refname` above.
> +

I am slightly unhappy with this name.  If we had an atom that lets
you ask "Is this a symref?" and yields "" or "->", it could also be
called symref, and we would name it "is_symref" or something to
disambiguate it.  Then it is only fair to give this one that lets
you ask "What does this symref point at?" a bit more specific name,
like "symref_target" or something.

But probably I am worried too much.  "is_symref", if necessary, can
be written as "%(if:notequals=)%(symref)%(then)...%(else)...%(end)"
and it is not likely that it would be used often, so let's keep it
as-is.
