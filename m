Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C091FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 23:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbcLIXwb (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 18:52:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53824 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751639AbcLIXwa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 18:52:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7AC456DEB;
        Fri,  9 Dec 2016 18:52:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Aovr10RuzTd30c6BoHR9gQQVhCw=; b=gMIuKm
        FVq33u/bc7b0KlFeQpaGUUqSCj9Ff2I+P64It8aBxRQcjRytc8JLqsI9lqIkHlU1
        DQYBHD2xuzGWFz/bDyY+B//GR7oK8QszWkYA3g9JicmggI8rpO1nDCe0eoR8B/DV
        ZiAaeC3rmNYiOm728m8kBG482qVsUxLIqqpQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XODBQo8ZOu7ffrI/Jib7HzaGqA1Kui2S
        u/oajD5vK9Z32GVBYK6ueJdztARt3Idi8kXoucoiyrIvsOdb9TAj+zfTBnadn6sf
        oh+FGBS5wRt9aR6/IOa3PUnsAPMNvhyOKZfepKF3Z5rKsv88LlrKOnrlIPeozaEi
        BJTrir3t+6U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B024456DEA;
        Fri,  9 Dec 2016 18:52:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24CF256DE9;
        Fri,  9 Dec 2016 18:52:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH] send-email: allow a custom hook to prevent sending email
References: <20161209203449.17940-1-sbeller@google.com>
        <xmqqfulwraq2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaqw=XqrNF5+Ta8CwcD7FyA853UQUdMxHmBAaMHPMHrXg@mail.gmail.com>
Date:   Fri, 09 Dec 2016 15:52:27 -0800
In-Reply-To: <CAGZ79kaqw=XqrNF5+Ta8CwcD7FyA853UQUdMxHmBAaMHPMHrXg@mail.gmail.com>
        (Stefan Beller's message of "Fri, 9 Dec 2016 14:53:24 -0800")
Message-ID: <xmqqshpwpsn8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B253CB6-BE6A-11E6-9669-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So you are suggesting to
> * have the check later in the game (e.g. just after asking
>    "Send this email? ([y]es|[n]o|[q]uit|[a]ll): " as then other information
>   such as additional @to @cc are available.

Yeah, probably before the loop starts asking that question for each
message.  And hook does not necessarily need to cause the program to
die.  The question can be reworded to "Your hook says no, but do you
really want to send it?",
