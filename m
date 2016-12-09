Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960B01FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 23:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbcLIXof (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 18:44:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52631 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751076AbcLIXoe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 18:44:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A52E5730F;
        Fri,  9 Dec 2016 18:44:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dhd+O9IZxBaYnwHa976CVRXCHds=; b=KS2BQO
        dCR9h55xweJxSK2BcWPopdAeXNigvGpZu5wg80AHN8TSW7QVY1OFh2Qpupv9VrWQ
        m76ONSW/1x5F8eBQu9APuWUavMZ+13ycE4mjxi8gskzWtcZIY7q2Kn+GXtZcovBy
        TyjAuBy2gXhBIWulSwr7m73bE81QkVl5vSGG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HYxBhuYcKwZjWOaC9sq+ylcOn5TDc4yR
        djgNmgA/VeqeHQ5O7zDKMOH46bV6qlOahgVTh0baDndTSJJyocCWv5p3scXefssM
        fCbj2fMsV0HUOsKPvLqbm1xSuksFKbraHK1c7+NWWGmqG6vV2F/PfEKxOg18SZrK
        zNIdNp5G23A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80EC95730D;
        Fri,  9 Dec 2016 18:44:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 037045730C;
        Fri,  9 Dec 2016 18:44:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 12/16] pathspec: create parse_long_magic function
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
        <1481223550-65277-1-git-send-email-bmwill@google.com>
        <1481223550-65277-13-git-send-email-bmwill@google.com>
Date:   Fri, 09 Dec 2016 15:44:31 -0800
In-Reply-To: <1481223550-65277-13-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Thu, 8 Dec 2016 10:59:06 -0800")
Message-ID: <xmqqwpf8pt0g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F58C9CC-BE69-11E6-98F9-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Factor out the logic responsible for parsing long magic into its own
> function.  As well as hoist the prefix check logic outside of the inner
> loop as there isn't anything that needs to be done after matching
> "prefix:".
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

These refactoring changes look like they are all going in the good
direction.  Stefan's :(attr:<attribute spec>)path" changes however
have severe conflicts (e.g. the topic already does something similar
to this step and calls the factored-out function eat_long_magic()).

My gut feeling is that we probably should ask Stefan's series to be
rebased on top of this series that cleans up pathspec implementation,
once it stabilizes.  We could probably go the other way around, but
logically it makes more sense to build "pathspec can also match
using attributes information" on top of a refactored codebase.

Thoughts?
