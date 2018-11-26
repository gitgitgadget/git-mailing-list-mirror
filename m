Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720091F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 12:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeKZXnn (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 18:43:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51907 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeKZXnn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 18:43:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5818A36959;
        Mon, 26 Nov 2018 07:49:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UZbAPInQ63uAmemz8zGSplvGjuE=; b=q+mULc
        POUpfcJtkPVAjoy8BF8QdNd+47CKo/pVCPbat+8KcH2ReD3YZnlMwhOecQUtDIr4
        BNkmud36NEOeszbQ+LEnoUupM2hhSl1SU8l9exHte83R81ZwjhGruBvozZWsKBmH
        j5wiRUpEOx6sqrpIbR8MHxlUfaAv1CHFWCC6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H1d0hc79pd76vXAAoANo+ZerusTH31rw
        ckvp/xcR04yLyY8kjuaLpISXZPIW/SYClMxP+Fwk44cmB2Np5JZZR6ShZtE5AfVW
        hgdrPMQzoRjzT0Gl5SplpavohbKSWdRdmpiOUPfzw/QsnhAcoHMNrkEeZ3zSodlt
        27QxVaE8UG0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47A0C36957;
        Mon, 26 Nov 2018 07:49:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 58AC336950;
        Mon, 26 Nov 2018 07:49:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Per Lundberg <per.lundberg@hibox.tv>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <20181111095254.30473-1-pclouds@gmail.com>
        <875zxa6xzp.fsf@evledraar.gmail.com>
        <871s7r4wuv.fsf@evledraar.gmail.com>
        <20181112232209.GK890086@genre.crustytoothpaste.net>
        <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
Date:   Mon, 26 Nov 2018 21:49:35 +0900
In-Reply-To: <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv> (Per Lundberg's
        message of "Mon, 26 Nov 2018 09:30:13 +0000")
Message-ID: <xmqqzhtwuhpc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB7F925A-F179-11E8-88B4-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per Lundberg <per.lundberg@hibox.tv> writes:

> How about something like this:
> ...
> Would this be a reasonable compromise for everybody?

I do not think you'd need to introduce such a deliberately breaking
change at all.  Just introduce a new "precious" class, perhaps mark
them with the atttribute mechanism, and that would be the endgame.
Early adopters would start marking ignored but not expendable paths
with the "precious" attribute and they won't be clobbered.  As the
mechanism becomes widely known and mature, more and more people use
it.  And even after that happens, early adopters do not have to change
any attribute setting, and late adopters would have plenty of examples
to imitate.  Those who do not need any "precious" class do not have
to do anything and you won't break any existing automation that way.



