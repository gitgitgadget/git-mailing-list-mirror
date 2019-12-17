Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B5FC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1D62072D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lsu7q5+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfLQSYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:24:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61177 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfLQSYS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 13:24:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6AD799AA70;
        Tue, 17 Dec 2019 13:24:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Whvt74oI+U1CkRheBBgQHKi7jvQ=; b=lsu7q5
        +lIyRK6EtWuaEXW2X1TzdxsrtC0+ighr8bXvOzkd+GcrPAELRyNw+XjserZrU0h4
        VuA5Be/5oUGo1jf3OFu+AIqK6NPhyYDdofMqLaXuRhC9v9uh/jrPh9ECeNUo2wWr
        TC8b+03Gobpj0dQk+pibYoEFyCfEC37C8v5TQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CaffXqOTI3enMHQd5OmPAtwPc4sSN/8y
        OIxIGOBGs2ZvHgey7igTIc9Aq3AYbflbNiKWRCKlQewIZTh2LMWD8plG1NicEJwd
        wrWRFZXVhqu+UZo5BtqExHMgDc5agXjH+6MI4wma58GqHT2HzQkGbYyrBrtaukfS
        xr4VioIL5Fw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 621D79AA6F;
        Tue, 17 Dec 2019 13:24:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9A2599AA6E;
        Tue, 17 Dec 2019 13:24:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, blees@dcon.de, kyle@kyleam.com,
        sxlijin@gmail.com
Subject: Re: [PATCH v3 0/3] Directory traversal bugs
References: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
        <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1912171217000.46@tvgsbejvaqbjf.bet>
Date:   Tue, 17 Dec 2019 10:24:10 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1912171217000.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 17 Dec 2019 12:18:12 +0100 (CET)")
Message-ID: <xmqq1rt2ized.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D55D740-20FA-11EA-8B60-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> As I said elsewhere, if Git for Windows' FSCache hack is the only thing
> that is broken by this patch series, in light of the bugs that it _does_
> fix I would rather adjust the FSCache patches to accommodate v2.

With "FSCache hack", do you refer to the "d_name is a pointer to
elsewhere" thing?  If so, I too very much appreciate the direction
you are suggesting.  Seeing that these three patches essentially are
the same as three (1/8, 3/8 and 4/8) from the v2, I'd keep all the 8
patches from v2 in my tree for now.

Thanks, both.
