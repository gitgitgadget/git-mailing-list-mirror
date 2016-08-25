Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B7E11F859
	for <e@80x24.org>; Thu, 25 Aug 2016 22:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933166AbcHYWpd (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 18:45:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55906 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933045AbcHYWpR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 18:45:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87BA237F97;
        Thu, 25 Aug 2016 18:38:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zpIQB0IkUCMpFXWzhyNOD7dICN4=; b=a/bLYA
        1IrKY+AuustHWKB6m+EUA+PAO5NAKcpO7r+xHVhKvc/cTRQ5fCMzq8PKGTR+C+n4
        etbkpqG55evdlBliEH4w+0tpHIjxSVcn7LT9AkuzT98ujFRGpqaBBWIbqDI3xJUk
        sKfM86LMZMnsG0o3diVrL6cd6yRT/MCRnQP5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cqy3Y6YHloosw1lFprxbJbnCG6/J0klb
        Vj2EOdoETemlsSBQlOS4Zk4nZTbetKN4lRsE9CSAhtopG4Um5EUm+yoj52rXGWUS
        qZVz5j6AEIR8VF4YduZ5AqVxNasrec4wIxqlO5llVfWfVW59MpnWaPf1AWGS7JA3
        +6hdxfDe9q0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 801A737F96;
        Thu, 25 Aug 2016 18:38:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00E3337F95;
        Thu, 25 Aug 2016 18:38:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v10 0/9] submodule inline diff format
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
        <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com>
        <xmqqlgznwg6o.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbsq52Qh0Jtn5hpPPfHu_9r2CUHvAHOTh6Cgz8ODkzreg@mail.gmail.com>
        <CA+P7+xrQy33gt8bnsagLVPAHhZPZx-3s0E_Aj7tOwXnHjOoCBg@mail.gmail.com>
Date:   Thu, 25 Aug 2016 15:38:50 -0700
In-Reply-To: <CA+P7+xrQy33gt8bnsagLVPAHhZPZx-3s0E_Aj7tOwXnHjOoCBg@mail.gmail.com>
        (Jacob Keller's message of "Thu, 25 Aug 2016 13:39:18 -0700")
Message-ID: <xmqqr39cjwxx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B291B80A-6B14-11E6-BE73-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> So we should support the gitlink to a repository stored at <path>
> without stuff inside the .git/modules, and we should support submodule
> gitlinks with a proper .gitmodules setup. I don't think we should
> die() but we should error properly so I will introduce a _gently()
> variant of these functions, and die properly in the regular flow.

Because "git diff [--cached] [<tree-ish>]" in the top-level is
driven by a gitlink in the index, immediately after adding a new
submodule to the index but before describing it in .gitmodules you
might not have a name (and you know in that case the path will
become the name when adding it to .gitmodules).  Also a gitlink in
the index may correspond to a submodule the user of the top-level is
not interested in, so there may not be anything in .git/modules/
that corresponds to it.  In these cases, I suspect that you do not
want to die, but you can just tell the user "I do not have enough
information to tell you a useful story yet".

